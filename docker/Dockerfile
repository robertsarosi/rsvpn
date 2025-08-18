ARG base
FROM golang:1.19-alpine as builder
RUN apk add make git curl
ADD . /rsvpn
WORKDIR /rsvpn
ARG build_args
RUN make $build_args

FROM ${base}alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /rsvpn/nknd /rsvpn/
COPY --from=builder /rsvpn/nknc /rsvpn/
COPY --from=builder /rsvpn/config.mainnet.json /rsvpn/
COPY --from=builder /rsvpn/web /rsvpn/web
COPY --from=builder /rsvpn/docker/entrypoint.sh /rsvpn/
RUN ln -s /rsvpn/nknd /rsvpn/nknc /usr/local/bin/
WORKDIR /rsvpn/data
ENTRYPOINT ["/rsvpn/entrypoint.sh"]
CMD ["nknd", "--password-file", "wallet.pswd", "--web-gui-listen-address", "0.0.0.0"]
