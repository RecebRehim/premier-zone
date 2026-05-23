/**
 * API base URL.
 *
 * - Local dev (npm start): leave unset so requests use the same origin as the React dev server
 *   (e.g. /api/...). package.json "proxy" forwards those to Spring on port 8080 — no CORS.
 * - Production: set REACT_APP_API_URL to your real API origin (https://...).
 */
export const API_BASE_URL = process.env.REACT_APP_API_URL ?? "";
