FROM alpine:3.11.3

RUN apk update && apk upgrade && apk add g++

WORKDIR /root/work

# bazel
ENV BAZEL_VERSION 2.2.0
RUN wget -O bazel.sh https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel.sh && ./bazel.sh
RUN ln -sf /usr/local/lib/bazel/bin/bazel-complete.bash /etc/bash_completion.d/


