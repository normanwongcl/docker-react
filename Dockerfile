FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build 

FROM nginx
# Accept incoming traffic from port 80
EXPOSE 80
# /app/build is the folder that we only care about in production
COPY --from=builder /app/build /usr/share/nginx/html

# by default, nginx image will start itself without running a start command