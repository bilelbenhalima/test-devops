# pull the base image
FROM node:14.16.1-buster

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json ./

RUN npm install
RUN npm install react-scripts@3.4.1 -g --silent
COPY . ./
RUN npm start

