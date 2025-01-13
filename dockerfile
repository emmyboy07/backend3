FROM ghcr.io/puppeteer/puppeteer:23.11.1

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable


COPY package*.json ./
RUN npm ci


COPY . .


EXPOSE 3000


CMD ["node", "server.js"]