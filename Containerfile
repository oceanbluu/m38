ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/cgwalters/fedora-silverblue:${FEDORA_MAJOR_VERSION}
# See https://pagure.io/releng/issue/11047 for final location

COPY etc /etc

COPY ublue-firstboot /usr/bin

RUN rpm-ostree override remove firefox firefox-langpacks && \

# remove a lot of fonts - must be a better way to get a cleaned up image without a lot of fonts in it
rpm-ostree override remove gdouros-symbola-fonts-10.24-11.fc37.noarch julietaula-montserrat-fonts-7.222-3.fc37.noarch google-noto-naskh-arabic-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \
rpm-ostree override remove google-noto-cjk-fonts-common-20201206-5.fc37.noarch google-noto-sans-cjk-ttc-fonts-20201206-5.fc37.noarch && \
rpm-ostree override remove thai-scalable-waree-fonts-0.7.3-3.fc37.noarch thai-scalable-fonts-common-0.7.3-3.fc37.noarch && \
rpm-ostree override remove google-noto-sans-arabic-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch google-noto-sans-armenian-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \
rpm-ostree override remove google-noto-sans-canadian-aboriginal-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \ 
rpm-ostree override remove google-noto-sans-cherokee-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \
rpm-ostree override remove google-noto-sans-ethiopic-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch google-noto-sans-georgian-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \
rpm-ostree override remove google-noto-sans-gurmukhi-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch google-noto-sans-hebrew-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \
rpm-ostree override remove google-noto-sans-lao-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch google-noto-sans-math-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \
rpm-ostree override remove google-noto-sans-mono-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch google-noto-sans-sinhala-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch && \
rpm-ostree override remove google-noto-sans-thaana-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch google-noto-serif-vf-fonts-20201206^1.git0c78c8329-7.fc37.noarch  && \
rpm-ostree override remove jomolhari-fonts-0.003-36.fc37.noarch khmer-os-system-fonts-5.0-36.fc37.noarch && \
rpm-ostree override remove lohit-assamese-fonts-2.91.5-14.fc37.noarch lohit-bengali-fonts-2.91.5-14.fc37.noarch && \
rpm-ostree override remove lohit-devanagari-fonts-2.95.5-4.fc37.noarch lohit-gujarati-fonts-2.92.4-14.fc37.noarch && \
rpm-ostree override remove lohit-kannada-fonts-2.5.4-13.fc37.noarch lohit-marathi-fonts-2.94.2-15.fc37.noarch && \
rpm-ostree override remove lohit-odia-fonts-2.91.2-14.fc37.noarch lohit-tamil-fonts-2.91.3-14.fc37.noarch && \
rpm-ostree override remove lohit-telugu-fonts-2.5.5-13.fc37.noarch paktype-naskh-basic-fonts-6.0-4.fc37.noarch && \
rpm-ostree override remove sil-mingzat-fonts-1.100-2.fc37.noarch sil-nuosu-fonts-2.200-6.fc37.noarch && \
rpm-ostree override remove sil-padauk-fonts-3.003-10.fc37.noarch stix-fonts-2.13b171-2.fc37.noarch && \
rpm-ostree override remove vazirmatn-vf-fonts-33.003-2.fc37.noarch rit-meera-new-fonts-1.4.1-1.fc37.noarch && \

    rpm-ostree install wireguard-tools fail2ban gnome-tweaks && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable flatpak-automatic.timer && \
    ostree container commit
