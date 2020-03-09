# ubuntu 18.04
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y expect g++ git openjdk-8-jdk unzip vim wget zip 


# bazel
ENV BAZEL_VERSION 2.2.0
RUN wget -O bazel.sh https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel.sh  
RUN ./bazel.sh #&& ln -sf /usr/local/lib/bazel/bin/bazel-complete.bash /etc/bash-completion.d/

# android
# 参考 https://github.com/appunite/docker/tree/master/android-java8-r24-4-1

# Copy install tools
COPY tools /opt/tools
RUN cd /opt && wget --output-document=android-sdk.tgz http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
  tar xzf android-sdk.tgz && \
  rm -f android-sdk.tgz && \
  chown -R root.root android-sdk-linux && \
  /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter platform-tools,tools" && \
    /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter \
        build-tools-24.0.2,build-tools-29.0.3"


# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:/opt/tools:${ANDROID_HOME}/tools:$ANDROID_HOME/tools/bin:${ANDROID_HOME}/platform-tools

# install platforms
RUN android-accept-licenses.sh "android update sdk --all --no-ui --filter android-29"

RUN which adb
RUN which android

# Create emulator

# Cleaning
#RUN apt-get clean

WORKDIR /root/work

