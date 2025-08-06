
FROM node:20-alpine

# Install jq and bash
RUN apk add --no-cache curl bash jq

WORKDIR /app
COPY . .

CMD ["npm", "start"]
