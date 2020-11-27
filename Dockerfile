FROM debian:buster
MAINTAINER hyperrealgopher, https://github.com/hyperrealgopher

# ngircd
RUN apt-get update && apt-get -y install ngircd vim build-essential libssl-dev python-setuptools python-pip supervisor
ADD ./supervise-ngircd.conf /etc/supervisor/conf.d/supervise-ngircd.conf
ADD ./rsyslog.conf /etc/rsyslog.conf

# ZNC
RUN apt-get install -y znc sudo
RUN useradd znc

EXPOSE 6667

ADD ./launch.sh /launch.sh
RUN chmod +x /launch.sh
ENTRYPOINT ["/launch.sh"]
CMD        [""]
