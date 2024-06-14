# stage 1
FROM node:16 as build-stage

WORKDIR /usr/src/app

ENV REACT_APP_BACKEND_URL=http://127.0.0.1:8080


COPY package*.json ./

RUN apt-get update && apt-get install -y nodejs npm && \
npm install && \ 
npm install -g serve && \
useradd -m appuser && \
chown appuser .

USER appuser

COPY . .

RUN npm run build

# stage 2
FROM nginx:1.19-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]