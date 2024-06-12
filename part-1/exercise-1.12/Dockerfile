FROM node:16

WORKDIR /usr/src/app

EXPOSE 5000

RUN apt-get update && apt-get install -y nodejs curl npm

COPY . .

COPY package*.json ./

RUN npm install && npm run build

RUN npm install -g serve

ENTRYPOINT ["npx", "serve", "-s", "-l", "5000", "build"]
