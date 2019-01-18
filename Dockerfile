FROM alpine:latest
LABEL Author="m-ko.de"

ENV TARGET_TYPE middle

ENV RELAY_PORT 9001
ENV RELAY_BANDWIDTH_RATE 400000 KBytes
ENV RELAY_BANDWIDTH_BURST 1000000 KBytes

ENV CONTACT_NAME m-ko
ENV CONTACT_EMAIL dev@m-ko.de

RUN apk --no-cache add \
	bash \
	tor

EXPOSE 9001

COPY types/torrc.bridge /etc/tor/torrc.bridge
COPY types/torrc.middle /etc/tor/torrc.middle
COPY types/torrc.exit /etc/tor/torrc.exit

COPY prepare.sh /prepare.sh
RUN chmod ugo+rx /prepare.sh

RUN chown -R tor /etc/tor

USER tor

ENTRYPOINT [ "tor", "-f", "/etc/tor/torrc.middle" ]