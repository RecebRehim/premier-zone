# Premier Zone

Web app to browse and filter Premier League–style player statistics (teams, nations, positions, search). **Spring Boot** API, **PostgreSQL**, **React** UI.

## Stack

- **Backend:** Java, Spring Boot, JPA, Maven  
- **Database:** PostgreSQL  
- **Frontend:** React (Create React App), SCSS, React Router  

## Repository layout

| Path | Purpose |
|------|---------|
| `premier-zone/` | REST API (`/api/v1/player`) |
| `Frontend/` | Single-page UI |

## Run locally

1. **Database** — Create a PostgreSQL database and copy `premier-zone/src/main/resources/application.properties.example` to `application.properties`. Set URL, username, and password. Do not commit secrets.

2. **API** — From `premier-zone/`:

   ```bash
   ./mvnw spring-boot:run
   ```

   Windows: `.\mvnw.cmd spring-boot:run` — listens on **http://localhost:8080**.

3. **UI** — From `Frontend/`:

   ```bash
   npm install && npm start
   ```

   Opens **http://localhost:3000**. Dev requests to `/api` are proxied to port 8080 (see `Frontend/package.json`).

## Production build

Set the public API URL, then build static assets:

```bash
export REACT_APP_API_URL=https://your-api.example.com   # Unix/macOS
npm run build
```

Configure `app.cors.allowed-origins` in `application.properties` to include your deployed frontend origin.