FROM ubuntu:latest

# environment variables
ARG SOLUTION_DIR="/src"
ENV SOLUTION_DIR=${SOLUTION_DIR}

# copy installation scripts
COPY build .

# copy scripts
COPY bin /usr/bin

# copy buildtools into container
COPY vs_buildtools /opt/vs_buildtools
RUN ls -al /opt/vs_buildtools

# fix winsdk script
# this if-statement condition ALWAYS fails under wine, seems to be a wine bug?
RUN sed -i 's/\"!result:~0,3!\"==\"10.\"/\"1\"==\"1\"/g' /opt/vs_buildtools/Common7/Tools/vsdevcmd/core/winsdk.bat

# install available updates, add the wine repository and install the required packages
RUN apt-get update && \
    apt-get full-upgrade --yes && \
    apt-get install --yes wget software-properties-common xvfb && \
    dpkg --add-architecture i386 && \
    wget -qO- https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
    apt-add-repository "deb http://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install --install-recommends --yes winehq-stable winbind cabextract && \
    wget -q https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/bin/winetricks && \
    chmod +x /usr/bin/winetricks && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set script permissions
RUN chmod +x install_sdks.sh

# install required packages
RUN apt update
RUN apt install wget software-properties-common xvfb -y

# install dotnet
RUN xvfb-run ./install_sdks.sh
RUN rm install_sdks.sh

# set vs_cmd as entrypoint
ENTRYPOINT ["vs_cmd"]

# spawn cmd by default
CMD ["cmd"]
