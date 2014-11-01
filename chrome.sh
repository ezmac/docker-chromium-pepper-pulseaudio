docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /home/$USER/.pulse-cookie:/home/chrome/.pulse-cookie:rw\
       chrome --no-sandbox
