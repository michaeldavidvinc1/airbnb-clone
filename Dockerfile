# Gunakan Node.js sebagai base image
FROM node:22.14-alpine

# Atur working directory
WORKDIR /app

# Copy package.json dan package-lock.json (jika ada)
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy semua file proyek ke dalam container
COPY . .

# Build Next.js (opsional jika ingin build di container)
RUN npm run build

# Jalankan aplikasi di port 3000
EXPOSE 3001

# Jalankan perintah start
CMD ["npm", "run", "start"]
