FROM node:22-alpine
WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci   # предпочтительнее, чем npm install для CI/докера

COPY . .

# Сгенерировать Prisma Client и собрать TS
RUN npx prisma generate
RUN npm run build

ENV NODE_ENV=production
EXPOSE 3000
CMD ["node", "dist/server.js"]
