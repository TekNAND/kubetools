FROM alpine:3.18 AS base

RUN apk add --no-cache curl

WORKDIR /tmp

RUN curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl" && \
    chmod 755 kubectl

RUN wget https://get.helm.sh/helm-v3.13.2-linux-amd64.tar.gz && \
    tar -xf helm-v3.13.2-linux-amd64.tar.gz

RUN mkdir ./.kube && \
    echo -e "apiVersion: v1\nclusters: null\ncontexts: null\ncurrent-context: \"\"\nkind: Config\npreferences: {}\nusers: null" > ./.kube/config && \
    chown 1000:1000 ./.kube/config && \
    chmod 600 ./.kube/config

FROM alpine:3.18 AS final

RUN apk add --no-cache curl

COPY --from=base --chown=root:root /tmp/kubectl /usr/local/bin

COPY --from=base --chown=root:root /tmp/linux-amd64/helm /usr/local/bin

RUN addgroup -g 1000 alpine && \
    adduser -u 1000 -G alpine -s /bin/sh -D alpine

USER alpine

COPY --from=base --chown=alpine:alpine /tmp/.kube/* /home/alpine/.kube/

WORKDIR /home/alpine

CMD [ "/bin/sh" ]