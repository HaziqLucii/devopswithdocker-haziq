FROM node:16

WORKDIR /usr/src/app

ENV REACT_APP_BACKEND_URL=http://127.0.0.1:8080

EXPOSE 5000

RUN apt-get update && apt-get install -y nodejs curl npm

COPY . .

COPY package*.json ./

RUN npm install && npm run build

RUN npm install -g serve

ENTRYPOINT ["npx", "serve", "-s", "-l", "5000", "build"]