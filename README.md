# NBA Database Design

## 1. Introduction

The NBA Database is designed to store and manage data related to the National Basketball Association (NBA). It includes information about teams, players, games, and rankings. The database aims to provide a comprehensive solution for storing and analyzing NBA data.

## 2. Scope

The database scope includes the following entities:

- Teams
- Players
- Games
- Rankings
- Games_details

Out of scope are elements like contracts, media rights, and other non-core attributes.

## 3. Functional Requirements

This database will support:

- CRUD operations for teams, players, games, and rankings
- Tracking player statistics for each game
- Providing season rankings based on team performance

## 4. Entity Description

### 4.1. Teams

The teams table stores essential information about NBA teams, including their unique team ID, abbreviation, nickname, year founded, city, arena details, owner, general manager, and head coach.

### 4.2. Players

The players table contains detailed data about individual NBA players, including their player ID, name, associated team ID, and the season they are active in.

### 4.3. Games

The games table captures data about NBA games, including the game date, unique game ID, game status, participating home and visitor team IDs, season information, points scored by each team, shooting percentages, assists, rebounds, and the winning team.

### 4.4. Games Details

The games_details table provides comprehensive statistics for each player involved in a specific NBA game. It includes data such as player ID, player name, team details, starting position, playing time, field goals made and attempted, three-pointers made and attempted, free throws made and attempted, rebounds, assists, steals, blocks, turnovers, personal fouls, points scored, and plus/minus rating.

### 4.5. Ranking

The ranking table maintains historical rankings of NBA teams for each season. It includes information such as team ID, league ID, season ID, standings date, conference, team name, games played, wins, losses, win percentage, home and road records, and return to play status.

## 5. Entity Relationship Diagram (ERD)

The following diagram illustrates the relationships among the entities in the database:![Untitled diagram-2024-03-11-102138](https://github.com/RahulKumar-007/NBA-Games-Analysis-DBMS/assets/117337265/8aba79e7-e967-4b8e-9813-248e3b34cb94)



## 6. Database Design

The database design includes normalized tables with appropriate data types and constraints to ensure data integrity and efficient querying.

Sure, here are the table names and column names for each entity in the NBA database:

### 1. Teams Table (`teams`)

- **team_id** (INTEGER, Primary Key): Unique identifier for each team.
- **abbreviation** (TEXT): Abbreviation representing the team.
- **nickname** (TEXT): Nickname of the team.
- **yearfounded** (INTEGER): Year the team was founded.
- **city** (TEXT): City where the team is based.
- **arena** (TEXT): Name of the team's arena.
- **arena_capacity** (TEXT): Capacity of the arena.
- **owner** (TEXT): Owner of the team.
- **general_manager** (TEXT): General manager of the team.
- **head_coach** (TEXT): Head coach of the team.

### 2. Players Table (`players`)

- **player_id** (INTEGER, Primary Key): Unique identifier for each player.
- **player_name** (TEXT): Name of the player.
- **team_id** (INTEGER, Foreign Key): Identifier of the team the player belongs to.
- **season** (INTEGER): Season the player is active in.
- **is_deleted** (INTEGER, Default 0): Flag indicating if the player is deleted (soft deletion).

### 3. Games Table (`games`)

- **game_id** (INTEGER, Primary Key): Unique identifier for each game.
- **game_date_est** (TEXT): Date of the game in Eastern Standard Time.
- **game_status_text** (TEXT): Status of the game.
- **home_team_id** (INTEGER, Foreign Key): Identifier of the home team.
- **visitor_team_id** (INTEGER, Foreign Key): Identifier of the visitor team.
- **season** (INTEGER): Season in which the game took place.
- **pts_home** (REAL): Points scored by the home team.
- **fg_pct_home** (REAL): Field goal percentage of the home team.
- **ft_pct_home** (REAL): Free throw percentage of the home team.
- **fg3_pct_home** (REAL): Three-point percentage of the home team.
- **ast_home** (REAL): Assists by the home team.
- **reb_home** (REAL): Rebounds by the home team.
- **pts_away** (REAL): Points scored by the visitor team.
- **fg_pct_away** (REAL): Field goal percentage of the visitor team.
- **ft_pct_away** (REAL): Free throw percentage of the visitor team.
- **fg3_pct_away** (REAL): Three-point percentage of the visitor team.
- **ast_away** (REAL): Assists by the visitor team.
- **reb_away** (REAL): Rebounds by the visitor team.
- **home_team_wins** (INTEGER): Indicates if the home team won (1) or lost (0).

### 4. Games Details Table (`games_details`)

- **game_id** (INTEGER, Foreign Key): Identifier of the game.
- **team_id** (INTEGER, Foreign Key): Identifier of the team.
- **team_abbreviation** (TEXT): Abbreviation of the team.
- **team_city** (TEXT): City of the team.
- **player_id** (INTEGER, Foreign Key): Identifier of the player.
- **player_name** (TEXT): Name of the player.
- **nickname** (TEXT): Nickname of the player.
- **start_position** (TEXT): Starting position of the player.
- **comment** (TEXT): Additional comments.
- **min** (TEXT): Minutes played.
- **fgm** (REAL): Field goals made.
- **fga** (REAL): Field goals attempted.
- **fg_pct** (REAL): Field goal percentage.
- **fg3m** (REAL): Three-pointers made.
- **fg3a** (REAL): Three-pointers attempted.
- **fg3_pct** (REAL): Three-point percentage.
- **ftm** (REAL): Free throws made.
- **fta** (REAL): Free throws attempted.
- **ft_pct** (REAL): Free throw percentage.
- **oreb** (REAL): Offensive rebounds.
- **dreb** (REAL): Defensive rebounds.
- **reb** (REAL): Total rebounds.
- **ast** (REAL): Assists.
- **stl** (REAL): Steals.
- **blk** (REAL): Blocks.
- **to** (REAL): Turnovers.
- **pf** (REAL): Personal fouls.
- **pts** (REAL): Points scored.
- **plus_minus** (REAL): Plus/minus rating.

### 5. Ranking Table (`ranking`)

- **team_id** (TEXT, Foreign Key): Identifier of the team.
- **league_id** (TEXT): Identifier of the league.
- **season_id** (TEXT): Identifier of the season.
- **standingsdate** (TEXT): Date of the standings.
- **conference** (TEXT): Conference of the team.
- **team** (TEXT): Name of the team.
- **g** (INTEGER): Games played.
- **w** (INTEGER): Games won.
- **l** (INTEGER): Games lost.
- **w_pct** (REAL): Win percentage.
- **home_record** (TEXT): Home game record.
- **road_record** (TEXT): Road game record.
- **returntoplay** (TEXT): Return to play status.

These tables and columns form the backbone of the NBA database, capturing crucial data related to teams, players, games, rankings, and detailed game statistics.

## 7. Indexing and Optimization

### Indexes on Key Columns

Indexes are crucial for improving query performance, especially on key columns that are frequently used in search and join operations. In this database, indexes are created on the following key columns:

- **Primary Key Indexes:** Each primary key column in tables such as `teams`, `players`, `games`, and `games_details` has an associated index. For example, `team_id` in `teams` and `player_id` in `players` are primary key indexes.

- **Foreign Key Indexes:** Columns like `team_id` and `game_id`, which are foreign keys in various tables, have indexes to optimize join operations and enforce referential integrity.

### Composite Indexes

Composite indexes are used where necessary to improve the efficiency of queries involving multiple columns. For instance, in the `games_details` table, a composite index on `(player_id, game_id, team_id)` helps optimize queries related to player-game-team combinations.

### Indexing for Reporting

Indexes are strategically designed to support reporting functionalities. For example:

- An index on `(game_id, season)` in the `games` table enhances performance when retrieving game data for a specific season.
- Indexes on columns like `pts_home`, `pts_away`, `fg_pct_home`, `fg_pct_away`, etc., in the `games` table optimize queries related to game statistics analysis.

### Query Optimization

The database schema and indexing strategy are optimized for CRUD (Create, Read, Update, Delete) operations and complex reporting queries commonly used in NBA analytics. Optimization techniques include:

- **Efficient Joins:** Utilizing foreign key indexes for efficient joins between tables such as `games` and `teams`, `games_details` and `players`, etc.
- **Aggregation Performance:** Indexes on columns used in aggregation functions (`AVG`, `SUM`, `COUNT`, etc.) optimize reporting queries for player/team performance analysis.
- **Where Clause Optimization:** Indexes on columns frequently used in `WHERE` clauses, such as `season`, `player_name`, `home_team_id`, etc., speed up data retrieval based on specific criteria.

## 8. Conclusion

The NBA Database design provides a robust solution for storing and managing NBA-related data. It follows best practices for database design, including normalization, foreign key relationships, and indexing. This design ensures data integrity, efficient querying, and scalability for future enhancements.
