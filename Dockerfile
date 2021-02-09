FROM alpine:3.13 AS base

RUN apk add --no-cache curl

WORKDIR /tmp

RUN curl -LO "https://dl.k8s.io/release/v1.19.3/bin/linux/amd64/kubectl" && \
    chmod 755 kubectl

RUN wget https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz && \
    tar -xf helm-v3.5.2-linux-amd64.tar.gz

RUN mkdir ./.kube && \
    echo -e "apiVersion: v1\nclusters: null\ncontexts: null\ncurrent-context: \"\"\nkind: Config\npreferences: {}\nusers: null" > ./.kube/config && \
    chown 1000:1000 ./.kube/config && \
    chmod 600 ./.kube/config

FROM alpine:3.13 AS final

COPY --from=base --chown=root:root /tmp/kubectl /usr/local/bin

COPY --from=base --chown=root:root /tmp/linux-amd64/helm /usr/local/bin

COPY --from=base /tmp/.kube/* /.kube/

ENV KUBECONFIG=/.kube/config

USER 1000:1000

CMD [ "/bin/sh" ]