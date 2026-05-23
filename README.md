# Premier Zone

Full-stack project: **Spring Boot** REST API + **PostgreSQL** + **React** UI, plus an optional **Python** notebook-style script for match prediction experiments (from the original PLWebsite repo).

## Repository layout

| Folder | Role |
|--------|------|
| `premier-zone/` | Spring Boot backend (Maven). Exposes JSON at `/api/v1/player`. |
| `Frontend/` | Create React App UI: browse teams, nations, positions, search players, view stats tables. |

## Prerequisites

- **Java** and **Maven** (or use the included `mvnw` / `mvnw.cmd` in `premier-zone/`)
- **Node.js** (LTS) and npm
- **PostgreSQL** with a database (this project uses `prem_stats` in `application.properties` by default)

## Backend (Spring Boot)

1. Create a PostgreSQL database and align `premier-zone/src/main/resources/application.properties` (see `application.properties.example` for a template without secrets).
2. From the `premier-zone` folder:

```bash
./mvnw spring-boot:run
```

On Windows PowerShell:

```powershell
cd premier-zone
.\mvnw.cmd spring-boot:run
```

The API listens on **port 8080** by default.

### Database cleanup (spreadsheet “Squad Total” rows)

If your `player_stats` table came from a sheet that included one **Squad Total** row per team, those rows have **no nation or position** and are not real players. Remove them once with:

```powershell
psql -h localhost -U postgres -d prem_stats -f premier-zone/db/cleanup_squad_totals.sql
```

(Prompts for password, or set `PGPASSWORD` in your environment for a local dev machine only.)

The same script lives at `premier-zone/db/cleanup_squad_totals.sql` so you can re-run it after a bad re-import.

### CORS and local development

In development, the React app uses **same-origin** API URLs (see `Frontend/src/api.js`: base URL is empty unless you set `REACT_APP_API_URL`). **`package.json`** has `"proxy": "http://localhost:8080"`, so the Create React App dev server forwards `/api/...` to Spring. The browser only talks to **port 3000**, so **CORS does not apply** for those requests.

If you call the API by full URL (`http://localhost:8080/...`) from the browser, `CorsConfig` and `@CrossOrigin` on `PlayerController` allow local origins. For production, set `REACT_APP_API_URL` to your deployed API and configure `app.cors.allowed-origins` to match your frontend origin.

```properties
app.cors.allowed-origins=http://localhost:3000,http://127.0.0.1:3000,https://your-production-domain.com
```

## Frontend (React)

From the `Frontend` folder:

```bash
npm install
npm start
```

Optional: for a **production build** served from a different host than the API, set the API origin before `npm run build`:

```bash
set REACT_APP_API_URL=https://api.yourdomain.com
npm run build
```

(Without `REACT_APP_API_URL`, the built app still requests `/api/...` on whatever host serves the static files — only correct if the API is on the **same** host/path, e.g. behind one reverse proxy.)

On Unix: `export REACT_APP_API_URL=...`.

## Security note for portfolios

Do not commit real database passwords. Use `application.properties.example` as a template and keep secrets in local `application.properties` or environment-specific config that is gitignored.
