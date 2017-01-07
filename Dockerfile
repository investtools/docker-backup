FROM alpine:edge

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk add --update build-base ruby ruby-dev libxml2-dev libxslt-dev mongodb-tools redis gpgme tzdata
RUN gem install nokogiri -v 1.6.8 --no-document
RUN gem install backup whenever --no-document
ADD run /
ADD schedule.rb /config/schedule.rb
ADD config.rb /root/Backup/config.rb
RUN chmod u+x /run

CMD /run
