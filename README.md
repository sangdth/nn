# new-next.sh Usage Guide

A convenience script to quickly scaffold a new Next.js project with common dependencies and configurations.

## Prerequisites

- Node.js installed
- pnpm installed globally (`npm install -g pnpm`)

## Installation

1. **Download or create the script**

   Save the `new-next.sh` script to your desired location (e.g., `~/Projects/` or `~/scripts/`)

2. **Make the script executable**

   ```bash
   chmod +x new-next.sh
   ```

3. **(Optional) Add to PATH for global access**

   ```bash
   # Move to a directory in your PATH
   sudo mv new-next.sh /usr/local/bin/new-next
   
   # Now you can run it from anywhere
   new-next my-app
   ```

   Or add an alias in your shell config (`~/.zshrc` or `~/.bashrc`):

   ```bash
   alias new-next="~/Projects/new-next.sh"
   ```

## Usage

```bash
./new-next.sh <app-name>
```

### Example

```bash
./new-next.sh my-awesome-app
```

## What It Does

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

### 2. Installs Core Dependencies

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

### 4. Installs Dev Dependencies

```bash
concurrently  # Run multiple commands concurrently
prisma        # Prisma CLI
rimraf        # Cross-platform rm -rf
```

## Post-Setup Steps

After the script completes, you'll need to:

1. **Configure Better Auth**

   ```bash
   cd <app-name>
   pnpm dlx @better-auth/cli generate
   ```

2. **Set up Prisma**
   - Create `prisma/schema.prisma`
   - Configure PostgreSQL connection in `.env`
   - Run `pnpm prisma migrate dev`

3. **Configure environment variables**
   - Create `.env.local` file
   - Add necessary API keys (OpenAI, database URL, etc.)

## Customization

To modify the default setup, edit the script:

- **Change shadcn base color**: Modify line 25 to add `--base-color` flag
- **Skip specific shadcn components**: Replace `--all` with specific component names on line 27
- **Add/remove dependencies**: Modify lines 22 and 29

## Troubleshooting

- **Permission denied**: Run `chmod +x new-next.sh` to make the script executable
- **pnpm not found**: Install pnpm globally with `npm install -g pnpm`
- **Script fails mid-way**: Check error messages and manually run remaining commands
