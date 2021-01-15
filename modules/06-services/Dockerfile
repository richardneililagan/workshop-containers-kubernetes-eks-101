FROM node:14.15

WORKDIR app

ENV HOST="0.0.0.0"
ENV PORT="8080"

COPY . .
RUN npm install

ENTRYPOINT ["node"]
CMD ["index"]
