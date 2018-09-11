FROM alpine:edge

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --update build-base ruby ruby-dev libxml2-dev mongodb-tools redis gpgme tzdata && \
    gem install nokogiri -v 1.8.4 --no-document && \
    gem install backup -v 5.0.0.beta.2 --no-document && \
    gem install whenever etc --no-document && \
    apk del build-base ruby-dev libxml2-dev
ADD start /
ADD schedule.rb /config/schedule.rb
ADD config.rb /root/Backup/config.rb
ADD mongodump /usr/local/bin
RUN chmod u+x /start /usr/local/bin/mongodump

CMD /start
