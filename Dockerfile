FROM node:20-alpine
RUN apk add --no-cache curl jq bash
WORKDIR /app
COPY . .
CMD ["npm", "start"]
