# base nginx image
FROM nginx:alpine

# an arbitrary directory to build our site in
WORKDIR /build

# copy the project into the container
COPY . .

# download hugo and make it available in PATH
ENV HUGO_VERSION  0.54.0
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN set -x && \
  apk add --update wget ca-certificates && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
  tar xzf ${HUGO_BINARY} && \
  mv hugo /usr/bin

# build the project and copy the result to the nginx folder
RUN /usr/bin/hugo && ls -l
RUN cp -fR /build/public/* /usr/share/nginx/html