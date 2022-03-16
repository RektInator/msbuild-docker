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

# set script permissions
RUN chmod +x install_wine.sh
RUN chmod +x install_sdks.sh

# install required packages
RUN apt update
RUN apt install wget software-properties-common xvfb -y

# install wine
RUN ./install_wine.sh
RUN rm install_wine.sh

# install dotnet
RUN xvfb-run ./install_sdks.sh
RUN rm install_sdks.sh

# set vs_cmd as entrypoint
ENTRYPOINT ["vs_cmd"]

# spawn cmd by default
CMD ["cmd"]
