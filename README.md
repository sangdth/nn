# nn.sh

A convenience script to quickly scaffold a **n**ew **N**ext.js project with common dependencies and configurations.

## Prerequisites

- Node.js installed
- pnpm installed
- openssl (optional, for generating a random Better Auth secret)

## Installation

1. **Download or create the script**

   Save the `nn.sh` script to your desired location (e.g., `~/Projects/` or `~/scripts/`)

2. **Make the script executable**

   ```bash
   chmod +x nn.sh
   ```

3. **(Optional) Add to PATH for global access**

   ```bash
   # Move to a directory in your PATH
   sudo mv nn.sh /usr/local/bin/nn
   
   # Now you can run it from anywhere
   nn my-app
   ```

## Usage

```bash
./nn.sh <app-name>
```

### Example

```bash
./nn.sh my-awesome-app
```

## What This Script Does

The script automates the following setup process:

### 1. Creates Next.js App

Scaffolds a new Next.js project with:

- TypeScript enabled
- ESLint configured
- Tailwind CSS included
- App Router (not Pages Router)
- Turbopack enabled
- No import alias
- No React Compiler
- No src directory
- Uses pnpm as package manager

### 2. Installs Dependencies

**Dev Dependencies:**

```bash
concurrently  # Run multiple commands concurrently
prisma        # Prisma CLI
rimraf        # Cross-platform rm -rf
```

**Core Dependencies:**

```bash
@ai-sdk/react         # AI SDK for React
@ai-sdk/openai        # OpenAI provider for AI SDK
@better-fetch/fetch   # Enhanced fetch utility
@prisma/adapter-pg    # PostgreSQL adapter for Prisma
@prisma/client        # Prisma ORM client
ai                    # Vercel AI SDK
better-auth           # Authentication library
date-fns              # Date utility library
jotai                 # State management
pg                    # PostgreSQL client
```

### 3. Initializes shadcn/ui

- Runs `shadcn init` with default configuration (neutral base color)
- Installs **all** available shadcn/ui components

### 4. Sets Up Project Structure

Creates necessary directories:

- `api/auth/[...all]/`
- `prisma/`
- `lib/`

### 5. Configures Environment Variables

Creates `env.example` and `.env` with:

- Better Auth configuration (secret, URL, telemetry settings)
- PostgreSQL database URL
- SMTP settings for Mailpit (local email testing)

### 6. Configures Prisma

Creates `prisma/schema.prisma` with:

- PostgreSQL datasource
- Prisma client generator with custom output path

Creates `lib/prisma.ts` with:

- PrismaPg adapter setup
- Global Prisma client (development-optimized)
- Connection string validation

### 7. Configures Better Auth

Creates `lib/auth-client.ts` with:

- Client-side auth hooks (signIn, signUp, signOut, etc.)
- Admin, API key, and anonymous plugins enabled

Creates `auth.ts` with:

- Server-side auth configuration
- Prisma adapter integration
- Email/password authentication enabled
- Auto sign-in after registration
- Admin, API key, and anonymous plugins

Creates `api/auth/[...all]/route.ts`:

- Next.js API route handler for Better Auth

### 8. Generates Code

- Runs `pnpm prisma generate` to generate Prisma client
- Runs `pnpm dlx @better-auth/cli@latest generate --yes` to generate Better Auth schema

## Post-Setup Steps

After the script completes, you're almost ready to go! You just need to:

1. **Run Prisma migrations**

   ```bash
   cd <app-name>
   pnpm prisma migrate dev --name init
   ```

2. **Update environment variables** (if needed)

   - Modify `.env` for your specific setup
   - Add OpenAI API key if using AI features
   - Update database credentials if not using default

3. **Start the development server**

   ```bash
   pnpm dev
   ```

## Complete Feature List

After running the script, your project includes:

### Core Framework

- ✅ **Next.js** (latest) - React framework with App Router
- ✅ **TypeScript** - Type-safe development
- ✅ **Turbopack** - Fast bundler
- ✅ **ESLint** - Code linting

### Styling & UI

- ✅ **Tailwind CSS** - Utility-first CSS framework
- ✅ **shadcn/ui** - All components pre-installed
  - Accordion, Alert, Avatar, Badge, Button, Calendar, Card, Checkbox, Collapsible, Command, Context Menu, Dialog, Drawer, Dropdown Menu, Form, Input, Label, Menubar, Navigation Menu, Pagination, Popover, Progress, Radio Group, Scroll Area, Select, Separator, Sheet, Skeleton, Slider, Switch, Table, Tabs, Textarea, Toast, Toggle, Tooltip, and more

### Database & ORM

- ✅ **Prisma** - Type-safe ORM with PostgreSQL adapter
- ✅ **PostgreSQL** - Database client (pg)
- ✅ **@prisma/adapter-pg** - Direct PostgreSQL connection
- ✅ Pre-configured Prisma client with custom output path
- ✅ Development-optimized global instance

### Authentication

- ✅ **Better Auth** - Complete auth solution
  - Email/password authentication
  - Admin plugin (role-based access)
  - API key authentication
  - Anonymous authentication
  - Auto sign-in after registration
- ✅ Pre-configured client and server setup
- ✅ Next.js API routes ready

### AI & LLM

- ✅ **Vercel AI SDK** - AI/LLM integration
- ✅ **@ai-sdk/react** - React hooks for AI
- ✅ **@ai-sdk/openai** - OpenAI provider

### State Management & Utilities

- ✅ **Jotai** - Atomic state management
- ✅ **date-fns** - Date manipulation
- ✅ **@better-fetch/fetch** - Enhanced fetch utility

### Developer Tools

- ✅ **concurrently** - Run multiple scripts
- ✅ **rimraf** - Cross-platform file deletion
- ✅ Pre-configured environment variables
- ✅ SMTP config for local email testing (Mailpit)

### Project Structure

```text
<app-name>/
├── api/
│   └── auth/
│       └── [...all]/
│           └── route.ts       # Auth API handler
├── lib/
│   ├── prisma.ts              # Prisma client
│   └── auth-client.ts         # Auth client hooks
├── prisma/
│   ├── schema.prisma          # Database schema
│   └── generated/             # Generated Prisma client
├── auth.ts                    # Auth server config
├── .env                       # Environment variables
└── env.example                # Environment template
```

## Customization

To modify the default setup, edit the script:

- **Change shadcn base color**: Modify line 36 to add `--base-color` flag (e.g., `--base-color zinc`)
- **Skip specific shadcn components**: Replace `--all` with specific component names on line 37
- **Add/remove dependencies**: Modify lines 21-33
- **Customize Better Auth**: Edit the generated `auth.ts` and `lib/auth-client.ts` files
- **Modify Prisma schema**: Edit `prisma/schema.prisma` after generation

## Troubleshooting

- **Permission denied**: Run `chmod +x nn.sh` to make the script executable
- **pnpm not found**: Install pnpm globally with `npm install -g pnpm`
- **Script fails mid-way**: Check error messages and manually run remaining commands
