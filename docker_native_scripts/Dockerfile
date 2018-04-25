FROM ubuntu:17.10

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        vim \
        curl \
        xz-utils \
        byacc \
        wget \ 
        g++ \ 
        python2.7 \
        pkg-config \
        cmake \
        maven \
        openjdk-8-jdk && \
    rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
WORKDIR /opt/

# =================  HTTPS Certificate =====================================================================

RUN wget https://www.amazontrust.com/repository/SFSRootCAG2.pem 
RUN cp  SFSRootCAG2.pem /etc/ssl/cert.pem

# ===== Git Checkout latest Kinesis Video Streams Producer SDK (CPP) =======================================

RUN git clone https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp.git

# ================ Build the Producer SDK (CPP) ============================================================

WORKDIR /opt/amazon-kinesis-video-streams-producer-sdk-cpp/kinesis-video-native-build/
RUN  chmod a+x ./install-script
RUN sed -i 's/^\([[:space:]]*\)make$/\1make -j$(nproc)/g' ./install-script
RUN ./install-script a 
COPY start_rtsp_in_docker.sh /opt/amazon-kinesis-video-streams-producer-sdk-cpp/kinesis-video-native-build/
RUN chmod a+x ./start_rtsp_in_docker.sh

ENV LD_LIBRARY_PATH /opt/amazon-kinesis-video-streams-producer-sdk-cpp/kinesis-video-native-build/downloads/local/lib:${LD_LIBRARY_PATH}

# comment the following step if you would like to customize the docker image build
ENTRYPOINT ["/opt/amazon-kinesis-video-streams-producer-sdk-cpp/kinesis-video-native-build/start_rtsp_in_docker.sh"]

# ====  How to build docker image and run the container once its built =====================================
# 
# ==== 1. build the docker image using the Dockerfile ======================================================
# ==== Make sure the Dockerfile and start_rtsp_in_docker.sh is present in the current working directory =====
#
# $ docker build -t rtspdockertest .
# 
# === List the docker images built ==================================================================================
#
# $ docker images
#  REPOSITORY          TAG                 IMAGE ID            CREATED                  SIZE
# rtspdockertest      latest              54f0d65f69b2        Less than a second ago   2.82GB
#
# === Start the container with credentials ===
# $ docker run -it -e AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID> -e AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY> -e AWS_SESSION_TOKEN=<AWS_SESSION_TOKEN> -e RTSP_URL=<RTSP_URL> -e KINESIS_STREAM_NAME=<KINESIS_STREAM_NAME> rtspdockertest
# 
#
#
