FROM node:14.14.0-alpine
WORKDIR '/app'

copy ./package.json ./

RUN npm install

copy . .

CMD ["npm", "run", "start"]
