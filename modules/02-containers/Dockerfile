# FROM node:14.15

# LABEL maintainer="Richard Neil Ilagan <me@richardneililagan.com>"
# LABEL company="AWS"
# LABEL country="Philippines"

# WORKDIR app

# COPY . .

# ENTRYPOINT ["node", "./index.js"]
# CMD ["1", "2"]

# :: ---

FROM node:14.15

WORKDIR app

COPY . .
RUN npm install

ENTRYPOINT ["node", "./index.js"]
CMD ["1", "2"]
