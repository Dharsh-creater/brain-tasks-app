# Stage 1: Build React App
FROM public.ecr.aws/docker/library/node:18-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN chmod +x node_modules/.bin/react-scripts
RUN npm run build

# Stage 2: Serve with nginx
FROM public.ecr.aws/docker/library/nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

