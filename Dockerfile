FROM debian
MAINTAINER Massimo Musumeci <massimo@denali.london>

COPY sources.list /etc/apt/sources.list

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential ssmtp

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip vim vim-nox

# Copy the application folder inside the container
ADD /my_application /my_application

# Get pip to download and install requirements:
RUN pip install -r /my_application/requirements.txt

# Install SSHD
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen supervisor
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY run.sh /run.sh
RUN chmod +x /run.sh

# Initial root pass, to be set when container launched
ENV CONTAINER_ROOT_PASS "abc123"

# Password ssmtp
ENV SSMTP_AUTHUSER test@test.com
ENV SSMTP_AUTHPASS 123456
ENV SSMTP_MAILHUB gw@example.com

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8070 22

CMD ["/run.sh"]
