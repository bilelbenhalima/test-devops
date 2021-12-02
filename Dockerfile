# pull the base image
FROM node:14.16.1-buster

# Create app directory
WORKDIR /usr/src/main

COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]

