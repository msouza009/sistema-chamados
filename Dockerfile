# Usa a última versão do Node.js
FROM node:latest AS build

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos de dependências
COPY package*.json ./

# Instala as dependências
RUN npm install

# Copia o restante do código para o contêiner
COPY . .

# Compila a aplicação para produção
RUN npm run build

# Usa Nginx para servir a aplicação em produção
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expõe a porta padrão do Nginx
EXPOSE 80

# Inicia o Nginx
CMD ["nginx", "-g", "daemon off;"]
