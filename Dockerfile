
FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN yarn 
COPY ./ ./
RUN yarn build
# the from symbloises the start of the new step
# a single block onyl has 1 from stage
FROM nginx
# EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html

