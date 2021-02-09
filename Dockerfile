FROM alpine:3.13 AS base

RUN apk add --no-cache curl

WORKDIR /tmp

RUN curl -LO "https://dl.k8s.io/release/v1.19.3/bin/linux/amd64/kubectl" && \
    apk del --no-cache curl && \
    chmod 755 kubectl && \
    mv kubectl /usr/local/bin

RUN wget https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz && \
    tar -xf helm-v3.5.2-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin && \
    rm -rf linux-amd64 helm-v3.5.2-linux-amd64.tar.gz

WORKDIR /

RUN mkdir /.kube && \
    echo -e "apiVersion: v1\nclusters: null\ncontexts: null\ncurrent-context: \"\"\nkind: Config\npreferences: {}\nusers: null" > /.kube/config && \
    chown 1000:1000 /.kube/config && \
    chmod 600 /.kube/config

ENV KUBECONFIG=/.kube/config

USER 1000:1000

CMD [ "/bin/sh" ]