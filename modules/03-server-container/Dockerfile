FROM node:14.15

LABEL maintainer="Richard Neil Ilagan <me@richardneililagan.com>"
WORKDIR app

ENV HOST="0.0.0.0"
ENV PORT="8080"

COPY . .
RUN npm install

ENTRYPOINT ["node"]
CMD ["index"]
