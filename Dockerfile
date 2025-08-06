FROM node:20-alpine

# Install curl and jq for GitHub API interactions
RUN apk add --no-cache curl jq

WORKDIR /app
COPY . .

CMD ["npm", "start"]
