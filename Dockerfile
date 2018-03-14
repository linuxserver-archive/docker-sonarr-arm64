FROM lsiobase/ubuntu.armhf:xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# set environment variables
ENV XDG_CONFIG_HOME="/config/xdg"

# package versions
ARG SONARR_BRANCH="master"

RUN \
 echo "**** install sonarr ****" && \
 mkdir -p \
	/opt/NzbDrone && \
 curl -o \
 /tmp/sonarr.tar.gz -L \
	"http://update.sonarr.tv/v2/${SONARR_BRANCH}/mono/NzbDrone.${SONARR_BRANCH}.tar.gz" && \
 tar xf \
 /tmp/sonarr.tar.gz -C \
	/opt/NzbDrone --strip-components=1 && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8989
VOLUME /config /downloads /tv
