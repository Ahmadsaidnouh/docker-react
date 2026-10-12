FROM node:16-alpine as build
WORKDIR '/app'
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
# Expose port 80. Not strictly necessary, but helps with documentation and linking containers. But sometimes it's essential for production environments because for example deploying on AWS beanstalk requires the port to be explicitly exposed.
EXPOSE 80
COPY --from=build /app/build /usr/share/nginx/html