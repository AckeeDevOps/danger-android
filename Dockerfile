FROM ruby:2.6.4

RUN gem install danger-gitlab && \
  gem install danger-android_lint && \
  gem install danger-commit_lint && \
  gem install danger-ktlint && \
  gem install danger-prose && \
  gem install danger-junit
  

RUN apt-get update && \
  apt-get install -y openjdk-11-jre-headless && \
  cd /usr/local/bin && curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.34.2/ktlint && chmod +x ktlint

ENTRYPOINT ["danger", "--fail-on-errors=true"]
