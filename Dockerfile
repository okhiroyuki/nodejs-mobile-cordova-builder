FROM ubuntu:18.04

## ENV settings
ENV SDK_TOOL_VERSION=sdk-tools-linux-4333796
ENV ANDROID_HOME=/usr/local/android-sdk-linux
ENV BUILD_TOOLS_VERSION=28.0.3
ENV PLATFORMS_VERSION=android-26
ENV ANDROID_NDK_HOME=/usr/local/ndk
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
ENV NDK_VERSION=android-ndk-r12b
ENV NDK_FILENAME=$NDK_VERSION\-linux-x86_64.zip
ENV NDK_URL=https://dl.google.com/android/repository/$NDK_FILENAME

CMD ["/bin/bash"]

USER root
WORKDIR /root

## install package
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get -y install openjdk-8-jre-headless wget nodejs npm vim git p7zip-full openjdk-8-jdk gradle

# install android sdk tools
RUN mkdir $ANDROID_HOME && \
  wget "https://dl.google.com/android/repository/${SDK_TOOL_VERSION}.zip" && \
  7z x -o$ANDROID_HOME $SDK_TOOL_VERSION.zip && \
  rm -rf $SDK_TOOL_VERSION.zip

# agree sdkmanager licenses
RUN mkdir ~/.android && \
    touch ~/.android/repositories.cfg
RUN yes | sdkmanager --licenses

# install android tools and more
RUN sdkmanager "tools" "cmake;3.6.4111459" "build-tools;${BUILD_TOOLS_VERSION}" "platforms;${PLATFORMS_VERSION}" "platform-tools" "extras;android;m2repository"

# install android ndk
RUN echo "Downloading NDK" >&2 && \
    wget $NDK_URL && \
    echo "Decompressing NDK" >&2 && \
    bash -c "7z x $NDK_FILENAME | grep -vE '^Extracting|^$'; exit \${PIPESTATUS[0]}" && \
    rm $NDK_FILENAME && \
    mv $NDK_VERSION $ANDROID_NDK_HOME

RUN npm install n -g
RUN n 10.13.0
RUN apt-get --purge remove -y nodejs npm

RUN npm install -g cordova@8.1.2
