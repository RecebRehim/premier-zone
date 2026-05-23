-- Imported spreadsheets often include a per-team "Squad Total" row with no nation/position.
-- Those rows are not individual players and break filters that expect real player data.
-- Run against database prem_stats (see application.properties).

BEGIN;

DELETE FROM player_stats
WHERE player_name = 'Squad Total';

-- Optional: verify no remaining null nation/pos for normal browsing
-- SELECT COUNT(*) FILTER (WHERE nation IS NULL OR pos IS NULL) FROM player_stats;

COMMIT;
