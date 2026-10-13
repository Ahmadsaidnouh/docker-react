FROM node:20-alpine as build
WORKDIR '/app'
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
# Expose port 80. Not strictly necessary, but helps with documentation and linking containers. But sometimes it's essential for production environments because for example deploying on AWS beanstalk requires the port to be explicitly exposed.
EXPOSE 80
COPY --from=build /app/build /usr/share/nginx/html
# Start Nginx server to serve the built React app. This is the default command for the Nginx container. It is not needed in development environments where you might use a different server or setup. But i found it is needed when deploying to production environments like AWS Beanstalk.
CMD ["nginx", "-g", "daemon off;"]