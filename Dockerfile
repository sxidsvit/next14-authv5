FROM node:20

WORKDIR /usr/app

COPY package*.json ./

RUN npm ci 

COPY . .

# RUN npm install prisma

# RUN npx prisma generate 

EXPOSE 3000

CMD npm run dev && npx prisma generate
