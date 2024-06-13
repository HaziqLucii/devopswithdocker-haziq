FROM node:16

WORKDIR /usr/src/app

EXPOSE 3000

RUN apt-get update && apt-get -y install npm nodejs

COPY . .

RUN npm install

CMD ["npm", "start"]