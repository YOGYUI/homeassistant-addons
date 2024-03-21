ARG BUILD_FROM
FROM $BUILD_FROM
LABEL maintainer="YOGYUI lee2002w@gmail.com"

# install required packages
RUN apk add --update --no-cache \
    bash curl nano vim wget git openrc \
    gcc openssl-dev libffi-dev musl-dev linux-headers cargo pkgconfig nginx \
    python3 python3-dev py3-pip

# clone repository from GitHub
RUN mkdir -p /repos/yogyui
RUN git clone https://github.com/YOGYUI/HomeNetwork.git /repos/yogyui/HomeNetwork
WORKDIR /repos/yogyui/HomeNetwork/Hillstate-Gwanggyosan
RUN git config pull.rebase true

# create & activate python virtual environment, install python requirements
RUN /bin/bash -c "source ./bootstrap.sh"
RUN python3 clean.py

# expose default web server port (todo: dynamic expose?)
EXPOSE 7929

# RUN mkdir -p /run/nginx
COPY ingress.conf /etc/nginx/http.d/
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/bin/bash", "-c", "/run.sh"]
# CMD /bin/bash -c "/run.sh; /bin/bash"  # for debugging