#this is the build pahse and lets call it builder
#base image
FROM node:alpine as builder

#install some dependencies
WORKDIR /usr/app
COPY ./package.json ./
RUN npm install
COPY ./ ./

#build npm command
RUN npm run build


#run phase, base image is nginx
FROM nginx
#this will not add any changes for the developer, but is an indication for the aws instance to expose port 80
EXPOSE 80
#copy from the builder phase to the location in nginx container as mentioned below
COPY --from=builder /usr/app/build /usr/share/nginx/html
