FROM debian
COPY app/pubkey_6224F9941A8AA6D1.gpg /pubkey_6224F9941A8AA6D1.gpg
RUN apt-get update -y && \
    apt-get install -y gnupg && \
    apt-key add /pubkey_6224F9941A8AA6D1.gpg && \
    echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list && \
    sed -i 's/ main/ main contrib non-free security/g' /etc/apt/sources.list.d/* && \
    apt-get update -y && \
    apt-get install -y tigervnc-standalone-server openbox gstreamer1.0-plugins-good pulseaudio avahi-daemon spotify-client firefox-esr && \
    rm -rf /var/lib/apt/lists
COPY app/ /app/
COPY root/.config/openbox/ /root/.config/openbox/
COPY root/.config/ /root/.config/
ENV VNC_DESKTOP_NAME "Xtigervnc"
ENV VNC_GEOMETRY 1280x800
ENV RTP_TARGET 172.17.0.1
ENV RTP_PORT 40000
CMD /app/main.sh
