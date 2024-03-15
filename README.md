

# NBA Database Design

## 1. Introduction

The NBA Database is designed to store and manage data related to the National Basketball Association (NBA). It includes information about teams, players, games, and rankings. The database aims to provide a comprehensive solution for storing and analyzing NBA data.

## 2. Database Entities

### 2.1. Teams

The `teams` table stores information about the NBA teams. It includes details such as the team ID, abbreviation, nickname, year founded, city, arena, arena capacity, owner, general manager, and head coach.

### 2.2. Players

The `players` table stores data about individual players, including their player ID, name, team ID, and season.

### 2.3. Games

The `games` table contains information about NBA games, such as the game date, game ID, game status, home team ID, visitor team ID, season, points scored by each team, field goal percentages, free throw percentages, three-point percentages, assists, rebounds, and the winning team.

### 2.4. Games Details

The `games_details` table stores detailed statistics for each player in a particular game. It includes information like game ID, team ID, team abbreviation, team city, player ID, player name, nickname, starting position, playing time, field goals made and attempted, three-pointers made and attempted, free throws made and attempted, offensive and defensive rebounds, assists, steals, blocks, turnovers, personal fouls, points scored, and plus/minus.

### 2.5. Ranking

The `ranking` table stores team rankings for each season, including information like the team ID, league ID, season ID, standings date, conference, team name, games played, wins, losses, win percentage, home and road records, and return to play status.

## 3. Database Relationships

The database incorporates several foreign key relationships to maintain data integrity and establish connections between different entities.

- The `games_details` table has foreign key relationships with the `teams`, `games`, and `players` tables.
- The `players` table has a foreign key relationship with the `teams` table.
- The `games` table has foreign key relationships with the `teams` table for both the home team and visitor team.

## 4. Views

The database includes a view called `season_rankings` that provides a convenient way to retrieve the final rankings for each team in a given season. This view is created using a `WITH` clause and the `MAX` function to fetch the latest standings date for each team and season combination.

## 5. Indexing

To improve query performance, the following indexes have been created:

- `idx_players_player_id` on the `player_id` column of the `players` table
- `idx_games_details_player_game_team` on the `player_id`, `game_id`, and `team_id` columns of the `games_details` table
- `idx_games_game_season` on the `game_id` and `season` columns of the `games` table

## 6. Trigger

A trigger named `soft_delete_players_trigger` has been implemented on the `players` table. This trigger is executed before a row is deleted from the `players` table. Instead of permanently deleting the row, it sets the `is_deleted` column to 1, effectively marking the player as deleted without removing the data from the database. This approach allows for data retention and potential future reference or analysis.

## 7. Conclusion

The NBA Database design provides a comprehensive solution for storing and managing NBA-related data. It follows best practices for database design, including the use of normalized tables, foreign key relationships, views, indexes, and triggers. This design ensures data integrity, efficient querying, and flexibility for future enhancements or modifications.
