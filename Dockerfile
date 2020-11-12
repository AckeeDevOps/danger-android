FROM ruby:2.6.4

ENV ANDROID_HOME /opt/android-sdk-linux

RUN gem install danger-gitlab && \
  gem install danger-android_lint && \
  gem install danger-commit_lint && \
  gem install danger-ktlint && \
  gem install danger-prose && \
  gem install danger-junit && \
  gem install danger-kotlin_detekt

RUN echo 'deb http://security.debian.org/debian-security stretch/updates main' >> '/etc/apt/sources.list' && \
    apt-get update && apt-get install -y openjdk-8-jdk-headless wget unzip && \
    cd /usr/local/bin && curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.34.2/ktlint && chmod +x ktlint

# Download Android SDK tools into $ANDROID_HOME
RUN cd /opt && wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android-sdk-tools.zip && \
    unzip -q android-sdk-tools.zip && mkdir -p "$ANDROID_HOME" && mv tools/ "$ANDROID_HOME"/tools/ && \
    rm android-sdk-tools.zip

RUN yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
RUN $ANDROID_HOME/tools/bin/sdkmanager $($ANDROID_HOME/tools/bin/sdkmanager --list 2> /dev/null | grep build-tools | awk -F' ' '{print $1}' | sort -nr -k2 -t \; | head -2)

VOLUME /root/.gradle
