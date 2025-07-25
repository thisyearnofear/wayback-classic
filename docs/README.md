# Social-Commerce Platform Monorepo

This monorepo contains the four main packages for the next-generation retro-styled social commerce platform:

- **frontend/** – React + Vite web app with preserved retro/Wayback Machine-inspired aesthetics.
- **backend/** – Node.js + Express API (TypeScript) for business logic, user management, and integration with both onchain and AI agents.
- **onchain/** – Hardhat project for Solidity smart contracts powering onchain primitives (escrow, reviews, agent delegation).
- **agents/** – Python FastAPI service implementing user-configurable AI agents that learn preferences and automate purchases or recommendations.

Shared tools, scripts, and docs are organized at the repo root for consistency and DRYness.

See individual package READMEs for getting started.