FROM node:12-slim  as build

ARG PORT
ARG REACT_APP_API_URL
ARG SKIP_PREFLIGHT_CHECK

ENV PORT=$PORT
ENV REACT_APP_API_URL=$REACT_APP_API_URL
ENV SKIP_PREFLIGHT_CHECK=true
ENV NODE_OPTIONS=--max_old_space_size=4096

WORKDIR /app

COPY ./package.json ./

RUN npm install

RUN npm audit fix

COPY . .

RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
# new
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
