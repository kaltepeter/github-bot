FROM node:10-slim

ARG SMEE_URL
EXPOSE 3000

USER node

COPY . /home/node/app

WORKDIR /home/node/app

RUN npm install

ENTRYPOINT [ "bash", "-c", "npm run start" ]