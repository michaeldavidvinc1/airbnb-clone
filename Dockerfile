# Gunakan Node.js Alpine sebagai base image
FROM node:22.14-alpine

# Install libssl 1.1 agar Prisma bisa jalan
RUN apk add --no-cache openssl1.1-compat

# Atur working directory
WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy semua file proyek ke dalam container
COPY . .

# Generate Prisma Client
RUN npx prisma generate

# Build Next.js
RUN npm run build

# Ekspos port 3001
EXPOSE 3001

# Jalankan aplikasi
CMD ["npm", "run", "start"]
