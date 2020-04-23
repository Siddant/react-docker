
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
COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=0 /app/build /usr/share/nginx/html
CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'

