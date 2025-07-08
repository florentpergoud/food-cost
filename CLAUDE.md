# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- `pnpm dev` - Start development server on port 3000
- `pnpm build` - Build the application and run TypeScript checks
- `pnpm start` - Start the production server

## Architecture Overview

This is a TanStack Start application (full-stack React framework) with the following key architectural components:

### Core Structure
- **Router**: File-based routing using TanStack Router with automatic route tree generation (`src/routeTree.gen.ts`)
- **Root Layout**: Centralized layout in `src/routes/__root.tsx` with navigation and global error boundaries
- **API Routes**: Server-side API endpoints in `src/routes/api/` (users endpoints available)
- **Components**: Reusable UI components in `src/components/` including error boundaries and 404 handling

### Key Files
- `src/router.tsx` - Router configuration with default preloading and error handling
- `src/routes/__root.tsx` - Root layout with HTML structure, navigation, and meta tags
- `vite.config.ts` - Vite configuration with TanStack Start plugin and custom server port (3000)

### Routing Patterns
- Standard routes: `/posts`, `/users` with nested index and detail routes
- Pathless layouts: `_pathlessLayout` for shared UI without URL segments
- API routes: Server-side endpoints with TypeScript support
- Deep linking: Support for deep nested routes like `posts_.$postId.deep.tsx`

### Error Handling
- Global error boundaries via `DefaultCatchBoundary`
- Custom 404 pages with `NotFound` component
- Separate error components for different error types (PostError, UserError)

The app uses TypeScript throughout, Tailwind CSS for styling, and includes development tools like React Router DevTools.