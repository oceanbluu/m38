ARG FEDORA_MAJOR_VERSION=37

FROM ghcr.io/cgwalters/fedora-silverblue:${FEDORA_MAJOR_VERSION}
# See https://pagure.io/releng/issue/11047 for final location

COPY etc /etc

COPY ublue-firstboot /usr/bin

RUN rpm-ostree override remove firefox firefox-langpacks && \
    rpm-ostree install wireguard-tools fail2ban gnome-tweaks && \

#   UFW qemu-kvm fails to build because it leaves some files in /var

    rpm-ostree install libvirt && \
    rpm-ostree install virt-install bridge-utils && \
#    rpm-ostree install virt-manager && \
#    rpm-ostree install virt-top guestfs-tools && \

    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable flatpak-automatic.timer && \
    ostree container commit
