FROM alpine:3.13 AS base

RUN apk add --no-cache curl

WORKDIR /tmp

RUN curl -LO "https://dl.k8s.io/release/v1.19.3/bin/linux/amd64/kubectl"

RUN apk del --no-cache curl 

RUN chmod 755 kubectl

RUN mv kubectl /usr/local/bin

RUN wget https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz

RUN tar -xf helm-v3.5.2-linux-amd64.tar.gz

RUN mv linux-amd64/helm /usr/local/bin

RUN rm -rf linux-amd64 helm-v3.5.2-linux-amd64.tar.gz

WORKDIR /

RUN mkdir /.kube && echo -e "apiVersion: v1\nclusters: null\ncontexts: null\ncurrent-context: \"\"\nkind: Config\npreferences: {}\nusers: null" > /.kube/config

ENV KUBECONFIG=/.kube/config

RUN chown 1000:1000 /.kube/config && chmod 600 /.kube/config

USER 1000:1000

CMD [ "/bin/sh" ]