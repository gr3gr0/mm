FROM node:latest

ENV NODE_ENV production
ENV MM_PORT 8080

WORKDIR /opt/magic_mirror

RUN git clone --depth 1 -b master https://github.com/MichMich/MagicMirror.git .

RUN cp -R modules /opt/magic_mirror/unmount_modules
RUN cp -R config /opt/magic_mirror/unmount_config
RUN npm install --unsafe-perm

COPY entrypoint.sh /opt/magic_mirror
RUN apt-get update \
  && apt-get -qy install dos2unix \
  && dos2unix entrypoint.sh \
  && chmod +x entrypoint.sh

EXPOSE $MM_PORT
CMD ["node serveronly"]
ENTRYPOINT ["/opt/magic_mirror/entrypoint.sh"]
