# ベースイメージとして Node.js 20 を使用
FROM node:20-slim

# 必要な依存関係（Puppeteerが使うChromium関連のパッケージ）をインストール
RUN apt-get update && apt-get install -y \
  wget \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /usr/src/app

# パッケージ.jsonをコピー
COPY package*.json ./

# 必要なパッケージをインストール
RUN npm install

# アプリケーションコードをコピー
COPY . .

# ポートを開放
EXPOSE 3000

# アプリケーションを起動
CMD ["node", "server.js"]

