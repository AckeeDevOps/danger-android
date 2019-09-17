FROM ruby:2.6.4

RUN gem install danger && \
  gem install danger-android_lint && \
  gem install danger-commit_lint && \
  gem install danger-prose

ENTRYPOINT danger
