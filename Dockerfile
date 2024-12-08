FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget curl gnupg2 ca-certificates mstflint pciutils ethtool \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN export DOCA_URL="https://linux.mellanox.com/public/repo/doca/2.9.0/ubuntu24.04/x86_64/" && \
    curl -s https://linux.mellanox.com/public/repo/doca/GPG-KEY-Mellanox.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/GPG-KEY-Mellanox.pub && \
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/GPG-KEY-Mellanox.pub] $DOCA_URL ./" > /etc/apt/sources.list.d/doca.list

RUN apt-get update

RUN apt-get install -y doca-all-userspace && apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]