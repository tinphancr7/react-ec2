# Stage 1
FROM node:18 as build-stage

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .



RUN npm run build


# Stage 2
FROM nginx:1.17.0-alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf 
COPY --from=build-stage /app/dist /usr/share/nginx/html/website1

CMD ["nginx", "-g", "daemon off;"]