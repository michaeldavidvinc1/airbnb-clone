# Gunakan Node.js Alpine sebagai base image
FROM node:18-alpine

# Tambahkan dependencies yang diperlukan
RUN apk add --no-cache openssl

# Atur working directory
WORKDIR /app

# Copy package.json dan package-lock.json terlebih dahulu
COPY package*.json ./

# Install dependencies dengan Prisma
RUN npm install --legacy-peer-deps

ENV NODE_ENV=production
ENV PRISMA_GENERATE=true
COPY .env .env

# Copy semua file proyek ke dalam container
COPY . .

# Generate Prisma Client
RUN npx prisma generate

# Build Next.js
RUN npm run build

# Ekspos port aplikasi
EXPOSE 3000

# Jalankan Prisma Migrate dan Start aplikasi
CMD ["sh", "-c", "npx prisma migrate deploy && npm run start"]
