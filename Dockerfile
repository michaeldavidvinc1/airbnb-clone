# Gunakan Node.js Alpine sebagai base image
FROM node:22.14-alpine

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

# Ekspos port 3000
EXPOSE 3000

# Jalankan aplikasi
CMD ["npm", "run", "start"]
