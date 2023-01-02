ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/cgwalters/fedora-silverblue:${FEDORA_MAJOR_VERSION}
# See https://pagure.io/releng/issue/11047 for final location

COPY etc /etc

COPY ublue-firstboot /usr/bin

RUN rpm-ostree override remove firefox firefox-langpacks && \

# remove a lot of fonts - must be a better way to get a cleaned up image without a lot of fonts in it
rpm-ostree override remove \
google-noto-sans-thaana-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch \
google-noto-serif-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \

rpm-ostree override remove \
jomolhari-fonts-0.003-36.fc37.noarch \
khmer-os-system-fonts-5.0-36.fc37.noarch \
lohit-assamese-fonts-2.91.5-14.fc37.noarch \
lohit-bengali-fonts-2.91.5-14.fc37.noarch \
lohit-devanagari-fonts-2.95.5-4.fc37.noarch \
lohit-gujarati-fonts-2.92.4-14.fc37.noarch && \

    rpm-ostree install wireguard-tools fail2ban gnome-tweaks && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable flatpak-automatic.timer && \
    ostree container commit
