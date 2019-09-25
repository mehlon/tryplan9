FROM mehlon/vx32

RUN apt-get update
RUN apt-get install -y xvfb x11vnc novnc
RUN apt-get install -y p7zip-full curl

COPY . /app/9front
WORKDIR /tmp
RUN curl http://r-36.net/9front/9front.iso.gz -o 9front.iso.gz
RUN curl http://r-36.net/9front/9front.iso.gz.sha512sum -o 9front.iso.gz.sha512sum
# r-36's latest shasum has the full name, rather than 'simply 9front.iso.gz'
# so we fix this
RUN sed -r -i 's/9front.+/9front.iso.gz/' 9front.iso.gz.sha512sum
RUN sha512sum -c 9front.iso.gz.sha512sum
RUN gunzip 9front.iso.gz
RUN mkdir /app/9front; 7z x 9front.iso -y -o/app/9front/; exit 0 # ignore error

#RUN mkdir 9front; cd 9front; cat ../9front.iso.gz | gunzip | 7z x -si -y
WORKDIR /app

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=600 \
    PORT=8080

ENV EMU="-c1 -g${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}"

# docker run -p8080:8080 -it ivnc
CMD ["/app/9front/init.sh"]

