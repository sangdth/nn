#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./new-next.sh <app-name>"
  exit 1
fi

pnpm create next-app "$1" \
  --typescript \
  --eslint \
  --tailwind \
  --app \
  --turbopack \
  --no-import-alias \
  --no-react-compiler \
  --no-src-dir \
  --use-pnpm

cd "$1"

pnpm add -D concurrently prisma rimraf

pnpm add \
  @ai-sdk/react \
  @ai-sdk/openai \
  @better-fetch/fetch \
  @prisma/adapter-pg \
  @prisma/client \
  ai \
  date-fns \
  jotai \
  pg

# The default base color is neutral.
pnpm dlx shadcn@latest init --defaults
pnpm dlx shadcn@latest add --all

cat > env.example <<EOL
BETTER_AUTH_TELEMETRY=0
BETTER_AUTH_SECRET=topsecret
BETTER_AUTH_URL=http://localhost:3000

DATABASE_URL=postgresql://postgres:password@localhost:5432/postgres

# For mailpit
SMTP_USER="mailpit"
SMTP_PASS="topsecret"
SMTP_HOST="127.0.0.1"
SMTP_PORT="1025"
EOL

cp env.example .env

mkdir -p prisma
cat > prisma/schema.prisma <<EOL
generator client {
  provider   = "prisma-client"
  engineType = "client"
  output     = "./generated"
}
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}
EOL

# we need to generate the auth.ts config file first
pnpm dlx @better-auth/cli init \
  --framework nextjs \
  --database postgresql \
  --package-manager pnpm \
  --plugins two-factor, username, anonymous, email-otp, passkey, api-key, admin, organization
