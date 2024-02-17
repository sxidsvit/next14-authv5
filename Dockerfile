# Этап 1: Сборка зависимостей
FROM node:20 AS builder

WORKDIR /usr/app

COPY package*.json ./

# Установка зависимостей
RUN npm install

# Скопировать все файлы проекта
COPY . .

# Генерация Prisma Client
RUN npx prisma generate --schema=./prisma/schema.docker.prisma

# Этап 2: Создание минимального образа для запуска
FROM node:20-alpine

WORKDIR /usr/app

COPY --from=builder /usr/app .

# Откройте порт, который Next.js будет слушать в режиме разработки
EXPOSE 3000

# Запустите приложение в режиме разработки
CMD ["npm", "run", "dev"]