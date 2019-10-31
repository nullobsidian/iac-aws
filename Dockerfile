FROM alpine:latest

ARG USER=dev
ENV HOME /home/$USER
ENV ANSIBLE_VERSION "2.8.6"
ENV TERRAFORM_VERSION "0.12.12"

RUN apk add --update \
    sudo \
    git \
    openssh-client openssh-keygen \
    openssl \
    ca-certificates \
    wget \
    python \
    py-pip && \
    apk add --update --virtual build-dependencies \
    python-dev libffi-dev openssl-dev build-base && \
    pip install cffi --upgrade && \
    pip install awscli --upgrade && \
    pip install ansible==${ANSIBLE_VERSION} --upgrade && \
    wget -P /tmp/ https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    apk --purge del build-dependencies && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/* && \
    adduser -D $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0400 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME

VOLUME ["/home/$USER"]
