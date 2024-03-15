-- table creation

--games_details 

CREATE TABLE "temp"(
    "GAME_ID" INTEGER,
    "TEAM_ID" INTEGER,
    "TEAM_ABBREVIATION" TEXT,
    "TEAM_CITY" TEXT NOT NULL,
    "PLAYER_ID" INTEGER,
    "PLAYER_NAME" TEXT NOT NULL,
    "NICKNAME" TEXT NULL,
    "START_POSITION" TEXT NULL,
    "COMMENT" TEXT NULL,
    "MIN" TEXT NULL,
    "FGM" REAL NULL,
    "FGA" REAL NULL,
    "FG_PCT" REAL NULL,
    "FG3M" REAL NULL,
    "FG3A" REAL NULL,
    "FG3_PCT" REAL NULL,
    "FTM" REAL NULL,
    "FTA" REAL NULL,
    "FT_PCT" REAL NULL,
    "OREB" REAL NULL,
    "DREB" REAL NULL,
    "REB" REAL NULL,
    "AST" REAL NULL,
    "STL" REAL NULL,
    "BLK" REAL NULL,
    "TO" REAL NULL,
    "PF" REAL NULL,
    "PTS" REAL NULL,
    "PLUS_MINUS" REAL NULL
);

CREATE TABLE "games_details"(
    "game_id" INTEGER,
    "team_id" INTEGER,
    "team_abbreviation" TEXT,
    "team_city" TEXT NOT NULL,
    "player_id" INTEGER,
    "player_name" TEXT NOT NULL,
    "nickname" TEXT NULL,
    "start_position" TEXT NULL,
    "comment" TEXT NULL,
    "min" TEXT NULL,
    "fgm" REAL NULL,
    "fga" REAL NULL,
    "fg_pct" REAL NULL,
    "fg3m" REAL NULL,
    "fg3a" REAL NULL,
    "fg3_pct" REAL NULL,
    "ftm" REAL NULL,
    "fta" REAL NULL,
    "ft_pct" REAL NULL,
    "oreb" REAL NULL,
    "dreb" REAL NULL,
    "reb" REAL NULL,
    "ast" REAL NULL,
    "stl" REAL NULL,
    "blk" REAL NULL,
    "to" REAL NULL,
    "pf" REAL NULL,
    "pts" REAL NULL,
    "plus_minus" REAL NULL,
    FOREIGN KEY ("team_id") REFERENCES teams ("team_id"),
    FOREIGN KEY ("game_id") REFERENCES games ("game_id"),
    FOREIGN KEY ("player_id") REFERENCES teams ("player_id")
);


.import --csv --skip 1 "games_details.csv" temp

INSERT INTO "games_details" SELECT * FROM "temp";


UPDATE "games_details"
    SET "START_POSITION" = 'DNS'
    WHERE "START_POSITION" IS NULL OR "START_POSITION" = '';

DROP TABLE "temp";


-- games 

DROP TABLE IF EXISTS "games_temporary";

.mode csv
.import games.csv "games_temporary"

DROP TABLE IF EXISTS "games";


-- Create the games table with constraints
CREATE TABLE IF NOT EXISTS "games" (
    "game_date_est" TEXT NOT NULL,
    "game_id",
    "game_status_text" TEXT,
    "home_team_id" INTEGER NOT NULL,
    "visitor_team_id" INTEGER NOT NULL,
    "season" INTEGER NOT NULL,
    "pts_home" REAL,
    "fg_pct_home" REAL,
    "ft_pct_home" REAL,
    "fg3_pct_home" REAL,
    "ast_home" REAL,
    "reb_home" REAL,
    "pts_away" REAL,
    "fg_pct_away" REAL,
    "ft_pct_away" REAL,
    "fg3_pct_away" REAL,
    "ast_away" REAL,
    "reb_away" REAL,
    "home_team_wins" INTEGER,
    FOREIGN KEY ("home_team_id") REFERENCES teams ("team_id"),
    FOREIGN KEY ("visitor_team_id") REFERENCES teams ("team_id")
);

-- Insert data into the games table from the temporary table
INSERT INTO "games" (
    "game_date_est", "game_id", "game_status_text",
    "home_team_id", "visitor_team_id", "season", "pts_home",
    "fg_pct_home", "ft_pct_home", "fg3_pct_home", "ast_home",
    "reb_home", "pts_away", "fg_pct_away", "ft_pct_away", "fg3_pct_away",
    "ast_away", "reb_away", "home_team_wins"
)
SELECT
    "game_date_est", CAST("game_id" AS INTEGER), "game_status_text",
    CAST("home_team_id" AS INTEGER), CAST("visitor_team_id" AS INTEGER), CAST("season" AS INTEGER), CAST("pts_home" AS REAL),
    CAST("fg_pct_home" AS REAL), CAST("ft_pct_home" AS REAL), CAST("fg3_pct_home" AS REAL), CAST("ast_home" AS REAL),
    CAST("reb_home" AS REAL), CAST("pts_away" AS REAL), CAST("fg_pct_away" AS REAL), CAST("ft_pct_away" AS REAL), CAST("fg3_pct_away" AS REAL),
    CAST("ast_away" AS REAL), CAST("reb_away" AS REAL), CAST("home_team_wins" AS INTEGER)
FROM "games_temporary";




-- players

DROP TABLE IF EXISTS "players_temp";

.mode csv
.import players.csv players_temp

CREATE TABLE IF NOT EXISTS "players" (
    "player_id" INTEGER,
    "player_name" TEXT,
    "team_id" INTEGER,
    "season" INTEGER,
    FOREIGN KEY ("team_id") REFERENCES "teams"("team_id")
);

INSERT INTO "players" (
    "player_id", "player_name",
    "team_id", "season"
)
SELECT "player_id", "player_name",
    "team_id", "season"
FROM "players_temp";

DROP TABLE IF EXISTS "players_temp";


-- teams 


CREATE TABLE temp(
    "LEAGUE_ID" INTEGER,
    "TEAM_ID" INTEGER PRIMARY KEY,
    "MIN_YEAR" INTEGER,
    "MAX_YEAR" INTEGER,
    "ABBREVIATION" TEXT,
    "NICKNAME" TEXT,
    "YEARFOUNDED" INTEGER,
    "CITY" TEXT NOT NULL,
    "ARENA" TEXT NOT NULL,
    "ARENA_CAPACITY" REAL NULL,
    "OWNER" TEXT,
    "GENERALMANAGER" TEXT,
    "HEADCOACH" TEXT,
    "DLEAGUEAFFILIATION" TEXT,
    CONSTRAINT abbreviation_length CHECK (LENGTH(abbreviation) = 3)
);

.import --csv --skip 1 "teams.csv" temp

CREATE TABLE teams(
    "team_id" INTEGER PRIMARY KEY,
    "abbreviation" TEXT,
    "nickname" TEXT,
    "yearfounded" INTEGER,
    "city" TEXT NOT NULL,
    "arena" TEXT NOT NULL,
    "arena_capacity" TEXT,
    "owner" TEXT,
    "general_manager" TEXT,
    "head_coach" TEXT,
    CONSTRAINT abbreviation_length CHECK (LENGTH(abbreviation) = 3)
);

INSERT INTO "teams"("team_id","abbreviation","nickname","yearfounded","city","arena","arena_capacity","owner","general_manager","head_coach")
SELECT "TEAM_ID","ABBREVIATION","NICKNAME","YEARFOUNDED","CITY","ARENA","ARENA_CAPACITY","OWNER","GENERALMANAGER","HEADCOACH"
FROM "temp";

DROP TABLE "temp";

-- ranking

.mode csv
.import ranking.csv ranking

-- Change data types for G, W, and L columns to INTEGER
CREATE TABLE ranking_temp AS
SELECT
  TEAM_ID, LEAGUE_ID, SEASON_ID, STANDINGSDATE, CONFERENCE,
  TEAM, CAST(G AS INTEGER) AS G, CAST(W AS INTEGER) AS W,
  CAST(L AS INTEGER) AS L, CAST(W_PCT AS REAL) AS W_PCT,
  HOME_RECORD, ROAD_RECORD, RETURNTOPLAY
FROM ranking;

-- Drop the original table
DROP TABLE ranking;

-- Rename the temporary table to the original table name
ALTER TABLE ranking_temp RENAME TO ranking;


-- Rename columns to lowercase
ALTER TABLE ranking
RENAME COLUMN "TEAM_ID" TO team_id;
ALTER TABLE ranking
RENAME COLUMN "LEAGUE_ID" TO league_id;
ALTER TABLE ranking
RENAME COLUMN "SEASON_ID" TO season_id;
ALTER TABLE ranking
RENAME COLUMN "STANDINGSDATE" TO standingsdate;
ALTER TABLE ranking
RENAME COLUMN "CONFERENCE" TO conference;
ALTER TABLE ranking
RENAME COLUMN "TEAM" TO team;
ALTER TABLE ranking
RENAME COLUMN "G" TO g;
ALTER TABLE ranking
RENAME COLUMN "W" TO w;
ALTER TABLE ranking
RENAME COLUMN "L" TO l;
ALTER TABLE ranking
RENAME COLUMN "W_PCT" TO w_pct;
ALTER TABLE ranking
RENAME COLUMN "HOME_RECORD" TO home_record;
ALTER TABLE ranking
RENAME COLUMN "ROAD_RECORD" TO road_record;
ALTER TABLE ranking
RENAME COLUMN "RETURNTOPLAY" TO returntoplay;



CREATE TABLE IF NOT EXISTS "ranking_temp"(
  team_id TEXT,
  league_id TEXT,
  season_id TEXT,
  standingsdate TEXT,
  conference TEXT,
  team TEXT,
  g INT,
  w INT,
  l INT,
  w_pct REAL,
  home_record TEXT,
  road_record TEXT,
  returntoplay TEXT,
  FOREIGN KEY (team_id) REFERENCES teams(id)
);

INSERT INTO "ranking_temp"
SELECT * FROM "ranking";

DROP TABLE "ranking";
-- Rename the temporary table to the original table name
ALTER TABLE ranking_temp RENAME TO ranking;


-- QUERYING

 SELECT * FROM "games" WHERE "home_team_wins" = 1;
 SELECT * FROM "games" WHERE "home_team_wins" = 0;
 SELECT COUNT(*) FROM "games" WHERE "season" = 2004;
 SELECT AVG("pts_home") FROM "games";
 SELECT * FROM "games" ORDER BY ("pts_home" + "pts_away") DESC LIMIT 1;
 SELECT "home_team_id", COUNT(*) AS "games_played" FROM "games" GROUP BY "home_team_id" ORDER BY "games_played" DESC LIMIT 1;
 SELECT "home_team_id", AVG("fg_pct_home") AS "avg_fg_pct_home" FROM "games" GROUP BY "home_team_id" ORDER BY "avg_fg_pct_home" DESC LIMIT 1;
 SELECT * FROM "games" WHERE "pts_home" > 100 AND "pts_away" > 100;

SELECT t."team_id", t."nickname", AVG("pts") AS average_points
FROM "games_details"
JOIN "teams" t ON "games_details"."team_id" = "t"."team_id"
WHERE "player_name" = 'James Harden'
GROUP BY t."team_id";






-- VIEWS


CREATE VIEW season_rankings AS
WITH LastStandings AS (
  SELECT
    team_id,
    season_id,
    MAX(standingsdate) AS LastStandingsDate
  FROM ranking
  GROUP BY team_id, season_id
)

SELECT
  r.conference,
  r.season_id,
  r.standingsdate,
  r.team,
  r.g,
  r.w,
  r.l,
  r.w_pct
FROM ranking r
JOIN LastStandings ls ON r.team_id = ls.team_id AND r.season_id = ls.season_id AND r.standingsdate = ls.LastStandingsDate
ORDER BY r.conference, r.w_pct DESC;



-- Example query to retrieve rankings for a specific season
SELECT *
FROM season_rankings
WHERE season_id = 'your_desired_season';




-- INDEXING 

.mode columns
.headers on

.timer on

SELECT
    p.player_name,
    ROUND(AVG(gd.min), 2) AS avg_min,
    ROUND(AVG(gd.fgm), 2) AS avg_fgm,
    ROUND(AVG(gd.fga), 2) AS avg_fga,
    ROUND(AVG(gd.fg_pct), 2) AS avg_fg_pct,
    ROUND(AVG(gd.fg3m), 2) AS avg_fg3m,
    ROUND(AVG(gd.fg3a), 2) AS avg_fg3a,
    ROUND(AVG(gd.fg3_pct), 2) AS avg_fg3_pct,
    ROUND(AVG(gd.ftm), 2) AS avg_ftm,
    ROUND(AVG(gd.fta), 2) AS avg_fta,
    ROUND(AVG(gd.ft_pct), 2) AS avg_ft_pct,
    ROUND(AVG(gd.oreb), 2) AS avg_oreb,
    ROUND(AVG(gd.dreb), 2) AS avg_dreb,
    ROUND(AVG(gd.reb), 2) AS avg_reb,
    ROUND(AVG(gd.ast), 2) AS avg_ast,
    ROUND(AVG(gd.stl), 2) AS avg_stl,
    ROUND(AVG(gd.blk), 2) AS avg_blk,
    ROUND(AVG(gd."to"), 2) AS avg_to,
    ROUND(AVG(gd.pf), 2) AS avg_pf,
    ROUND(AVG(gd.pts), 2) AS avg_pts,
    ROUND(AVG(gd.plus_minus), 2) AS avg_plus_minus
FROM
    games_details gd
JOIN
    players p ON gd.player_id = p.player_id
JOIN
    games g ON gd.game_id = g.game_id
WHERE
    p.player_name = 'Stephen Curry'
    AND g.season = 2021
GROUP BY
    p.player_name;


EXPLAIN QUERY PLAN
SELECT
    p.player_name,
    ROUND(AVG(gd.min), 2) AS avg_min,
    ROUND(AVG(gd.fgm), 2) AS avg_fgm,
    ROUND(AVG(gd.fga), 2) AS avg_fga,
    ROUND(AVG(gd.fg_pct), 2) AS avg_fg_pct,
    ROUND(AVG(gd.fg3m), 2) AS avg_fg3m,
    ROUND(AVG(gd.fg3a), 2) AS avg_fg3a,
    ROUND(AVG(gd.fg3_pct), 2) AS avg_fg3_pct,
    ROUND(AVG(gd.ftm), 2) AS avg_ftm,
    ROUND(AVG(gd.fta), 2) AS avg_fta,
    ROUND(AVG(gd.ft_pct), 2) AS avg_ft_pct,
    ROUND(AVG(gd.oreb), 2) AS avg_oreb,
    ROUND(AVG(gd.dreb), 2) AS avg_dreb,
    ROUND(AVG(gd.reb), 2) AS avg_reb,
    ROUND(AVG(gd.ast), 2) AS avg_ast,
    ROUND(AVG(gd.stl), 2) AS avg_stl,
    ROUND(AVG(gd.blk), 2) AS avg_blk,
    ROUND(AVG(gd."to"), 2) AS avg_to,
    ROUND(AVG(gd.pf), 2) AS avg_pf,
    ROUND(AVG(gd.pts), 2) AS avg_pts,
    ROUND(AVG(gd.plus_minus), 2) AS avg_plus_minus
FROM
    games_details gd
JOIN
    players p ON gd.player_id = p.player_id
JOIN
    games g ON gd.game_id = g.game_id
WHERE
    p.player_name = 'Stephen Curry'
    AND g.season = 2021
GROUP BY
    p.player_name;

-- Index for the players table on the player_id column
CREATE INDEX idx_players_player_id ON players(player_id);

-- Index for the games_details table on the player_id, game_id, and team_id columns
CREATE INDEX idx_games_details_player_game_team ON games_details(player_id, game_id, team_id);

-- Index for the games table on the game_id and season columns
CREATE INDEX idx_games_game_season ON games(game_id, season);

SELECT
    p.player_name,
    ROUND(AVG(gd.min), 2) AS avg_min,
    ROUND(AVG(gd.fgm), 2) AS avg_fgm,
    ROUND(AVG(gd.fga), 2) AS avg_fga,
    ROUND(AVG(gd.fg_pct), 2) AS avg_fg_pct,
    ROUND(AVG(gd.fg3m), 2) AS avg_fg3m,
    ROUND(AVG(gd.fg3a), 2) AS avg_fg3a,
    ROUND(AVG(gd.fg3_pct), 2) AS avg_fg3_pct,
    ROUND(AVG(gd.ftm), 2) AS avg_ftm,
    ROUND(AVG(gd.fta), 2) AS avg_fta,
    ROUND(AVG(gd.ft_pct), 2) AS avg_ft_pct,
    ROUND(AVG(gd.oreb), 2) AS avg_oreb,
    ROUND(AVG(gd.dreb), 2) AS avg_dreb,
    ROUND(AVG(gd.reb), 2) AS avg_reb,
    ROUND(AVG(gd.ast), 2) AS avg_ast,
    ROUND(AVG(gd.stl), 2) AS avg_stl,
    ROUND(AVG(gd.blk), 2) AS avg_blk,
    ROUND(AVG(gd."to"), 2) AS avg_to,
    ROUND(AVG(gd.pf), 2) AS avg_pf,
    ROUND(AVG(gd.pts), 2) AS avg_pts,
    ROUND(AVG(gd.plus_minus), 2) AS avg_plus_minus
FROM
    games_details gd
JOIN
    players p ON gd.player_id = p.player_id
JOIN
    games g ON gd.game_id = g.game_id
WHERE
    p.player_name = 'Stephen Curry'
    AND g.season = 2021
GROUP BY
    p.player_name;

EXPLAIN QUERY PLAN
SELECT
    p.player_name,
    ROUND(AVG(gd.min), 2) AS avg_min,
    ROUND(AVG(gd.fgm), 2) AS avg_fgm,
    ROUND(AVG(gd.fga), 2) AS avg_fga,
    ROUND(AVG(gd.fg_pct), 2) AS avg_fg_pct,
    ROUND(AVG(gd.fg3m), 2) AS avg_fg3m,
    ROUND(AVG(gd.fg3a), 2) AS avg_fg3a,
    ROUND(AVG(gd.fg3_pct), 2) AS avg_fg3_pct,
    ROUND(AVG(gd.ftm), 2) AS avg_ftm,
    ROUND(AVG(gd.fta), 2) AS avg_fta,
    ROUND(AVG(gd.ft_pct), 2) AS avg_ft_pct,
    ROUND(AVG(gd.oreb), 2) AS avg_oreb,
    ROUND(AVG(gd.dreb), 2) AS avg_dreb,
    ROUND(AVG(gd.reb), 2) AS avg_reb,
    ROUND(AVG(gd.ast), 2) AS avg_ast,
    ROUND(AVG(gd.stl), 2) AS avg_stl,
    ROUND(AVG(gd.blk), 2) AS avg_blk,
    ROUND(AVG(gd."to"), 2) AS avg_to,
    ROUND(AVG(gd.pf), 2) AS avg_pf,
    ROUND(AVG(gd.pts), 2) AS avg_pts,
    ROUND(AVG(gd.plus_minus), 2) AS avg_plus_minus
FROM
    games_details gd
JOIN
    players p ON gd.player_id = p.player_id
JOIN
    games g ON gd.game_id = g.game_id
WHERE
    p.player_name = 'Stephen Curry'
    AND g.season = 2021
GROUP BY
    p.player_name;


-- TRIGGER 


ALTER TABLE players
ADD COLUMN is_deleted INTEGER DEFAULT 0 CHECK (is_deleted IN (0, 1));


CREATE TRIGGER soft_delete_players_trigger
BEFORE DELETE ON players
FOR EACH ROW
BEGIN
UPDATE players
SET is_deleted = 1
WHERE player_id = OLD.player_id;
-- Ignore the actual deletion by raising an IGNORE exception
SELECT RAISE(IGNORE);
END;

-- Assuming player_id = 123 is the player you want to delete
DELETE FROM players
WHERE player_id = 1626220;


