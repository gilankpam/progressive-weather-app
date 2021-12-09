FROM node:latest as base
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY ./ .

FROM base as testrunner
ENTRYPOINT [ "npm", "run", "test" ]

FROM base as build
RUN npm run build

FROM nginx:latest
RUN mkdir /app
COPY --from=build /app/dist /app
COPY deploy/nginx.conf /etc/nginx/nginx.conf
