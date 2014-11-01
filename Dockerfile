FROM ubuntu:latest
MAINTAINER Joshua Lund

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Make sure the repository information is up to date
RUN apt-get update

# Install Chrome
ADD sources.list /etc/apt/
RUN apt-get -y update
RUN apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository ppa:saiarcot895/chromium-beta 
RUN apt-get update 
RUN apt-get install -y chromium-browser pepperflashplugin-nonfree


# Install OpenSSH
RUN apt-get install -y openssh-server

# Create OpenSSH privilege separation directory
RUN mkdir /var/run/sshd

# Install Pulseaudio
RUN apt-get install -y pulseaudio 


# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
  mkdir -p /home/chrome && \
  echo "chrome:x:${uid}:${gid}:chrome,,,:/home/chrome:/bin/bash" >> /etc/passwd && \
  echo "chrome:x:${uid}:" >> /etc/group && \
  echo "chrome ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/chrome && \
  chmod 0441 /etc/sudoers.d/chrome && \
  chown ${uid}:${gid} -R /home/chrome &&\
  adduser chrome audio

RUN chown -R chrome:chrome /home/chrome/

RUN echo "load-module module-native-protocol-tcp">>/etc/pulse/default.pa

USER chrome
ENV HOME /home/chrome
ENV PULSE_SERVER 172.17.42.1
ENTRYPOINT ["/usr/bin/chromium-browser"]
#http://grooveshark.com/#!/emmagician/broadcast
# Expose the SSH port
EXPOSE 22
ADD asoundrc /home/chrome/.asoundrc
