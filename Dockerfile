# ubuntu 18.04
FROM ubuntu:18.04

RUN apt update && apt install -y g++ git openjdk-11-jdk unzip vim wget zip 

WORKDIR /root/work

# bazel
ENV BAZEL_VERSION 2.2.0
RUN wget -O bazel.sh https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel.sh  
RUN ./bazel.sh #&& ln -sf /usr/local/lib/bazel/bin/bazel-complete.bash /etc/bash-completion.d/


