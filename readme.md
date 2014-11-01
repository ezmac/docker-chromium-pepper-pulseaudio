# Chromium with pepper flash and pulseaudio

runs chromium-beta from ppa:saiarcot895/chromium-beta and pepperflash from ubuntu trusty.

uses pulseaudio network streaming and cookie for authentication

Install requires adding "load-module module-native-protocol-tcp" to /etc/pulse/default.pa and restarting pulse `sudo service pulseaudio restart`.  Assumes docker host (pulse host) is running on 172.17.42.1. Should be overridable with -e PULSE_SERVER=hostip.

Built on debian wheezy, docker version 1.3.1

## Install script

```bash
sudo su -c 'echo "load-module module-native-protocol-tcp">>/etc/pulse/default.pa'

git clone https://github.com/ezmac/docker-chromium-pepper-pulseaudio.git .

docker build --rm -t chrome .
docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /home/$USER/.pulse-cookie:/home/chrome/.pulse-cookie:rw\
       chrome --no-sandbox
```

