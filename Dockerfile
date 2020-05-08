FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y curl bash && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.3/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && chmod +x /usr/bin/kubectl && \
    curl -LO https://github.com/tsl0922/ttyd/releases/download/1.6.0/ttyd_linux.x86_64 && \
    mv ttyd_linux.x86_64 /usr/bin/ttyd && chmod +x /usr/bin/ttyd && \
    curl -LO https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 && \
    mv stern_linux_amd64 /usr/bin/stern && chmod +x /usr/bin/stern && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD bootstrap.sh /usr/bin/bootstrap.sh

# Note that staroid will override uid to random uid to large one. like 10000000.
# In that case, gid becomes 0 and home directory access permission need to allow the group.
RUN useradd system --uid 2100 --gid 0 --shell /bin/bash --home-dir /home/system --create-home && \    
    chmod -R 775 ~/system

USER 2100
