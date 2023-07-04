# m38

[![build-my38](https://github.com/oceanbluu/m38/actions/workflows/build.yml/badge.svg)](https://github.com/oceanbluu/m38/actions/workflows/build.yml)

=====================================
## Usage

Warning: This is an experimental feature and should not be used in production, try it in a VM for a while, you have been warned!

    sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/oceanbluu/base38:latest
    
Might work with build date tags as well, have not tested:
  
    sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/oceanbluu/base38:20221217 

The `latest` tag will automatically point to the latest build. 

## Features

- Start with a base Fedora Silverblue 38 image
- Removes Firefox from the base image
- Adds the packages necessary for qemu/kvm running Win10 to the base image
- Sets automatic staging of updates for the system
- Sets flatpaks to update twice a day

## Applications

- Applications installed per user instead of system wide, similar to openSUSE MicroOS, they are not on the base image.
  
## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/oceanbluu/base38
    
If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions. 
