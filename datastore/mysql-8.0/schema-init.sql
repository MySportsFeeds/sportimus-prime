create database sportimus_prime;

use sportimus_prime;

CREATE TABLE sport (
  id tinyint(3) unsigned NOT NULL AUTO_INCREMENT,

  name varchar(50) NOT NULL,
  abbreviation varchar(10) NOT NULL,

  PRIMARY KEY (ID)
) ENGINE=InnoDB;

CREATE TABLE league (
  id tinyint(3) unsigned NOT NULL AUTO_INCREMENT,

  sport_id tinyint(3) unsigned NOT NULL,

  name varchar(50) NOT NULL,
  abbreviation varchar(10) NOT NULL,
  logo_url varchar(100),

  PRIMARY KEY (id),
  FOREIGN KEY (sport_id) REFERENCES sport (id)
) ENGINE=InnoDB;

CREATE TABLE venue (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  name varchar(30) NOT NULL,
  name_searchable varchar(30) NOT NULL,
  image_url varchar(100),
  city varchar(30),
  country varchar(20),
  latitude decimal(9,7),
  longitude decimal(10,7),
  playing_surface varchar(100),
  baseball_dimensions varchar(1000),
  event_capacities varchar(1000),
  has_roof bit(1),
  has_retractable_roof bit(1),
  is_active bit(1),

  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE division (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  league_id tinyint(3) unsigned NOT NULL,

  division_type tinyint(3) unsigned NOT NULL,
  name varchar(25) NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (league_id) REFERENCES league (id)
) ENGINE=InnoDB;

CREATE TABLE team (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  league_id tinyint(3) unsigned NOT NULL,
  home_venue_id smallint(5) unsigned NOT NULL,
  division_id smallint(5) unsigned NOT NULL,

  city varchar(30) NOT NULL,
  name varchar(30) NOT NULL,
  abbreviation varchar(3) NOT NULL,
  TeamColoursHex varchar(100),
  OfficialLogoUrl varchar(255),
  SocialMediaAccounts varchar(1000),
  is_active bit(1) NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (league_id) REFERENCES league (id),
  FOREIGN KEY (home_venue_id) REFERENCES venue (id),
  FOREIGN KEY (division_id) REFERENCES division (id)
) ENGINE=InnoDB;

CREATE TABLE draft (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  league_id tinyint(20) unsigned NOT NULL,

  occurred_on datetime NOT NULL,
  city varchar(100),
  name varchar(45) NOT NULL,
  total_rounds tinyint(3) unsigned NOT NULL,
  year smallint(5) NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (league_id) REFERENCES league (id)
) ENGINE=InnoDB;

CREATE TABLE person (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,

  league_id tinyint(3) unsigned,
  team_id smallint(5) unsigned,

  role tinyint(3) unsigned NOT NULL,
  first_name varchar(30) NOT NULL,
  first_name_searchable varchar(30) NOT NULL,
  last_name varchar(30) NOT NULL,
  last_name_searchable varchar(30) NOT NULL,
  birth_city varchar(30),
  birth_country varchar(40),
  birth_date datetime,
  high_school varchar(100),
  college varchar(100),
  image_url varchar(255),
  social_media varchar(1000),

  PRIMARY KEY (id),
  FOREIGN KEY (league_id) REFERENCES league (id),
  FOREIGN KEY (team_id) REFERENCES team (id),
  KEY role (role),
  KEY first_name_searchable (first_name_searchable),
  KEY last_name_searchable (last_name_searchable)
) ENGINE=InnoDB;

CREATE TABLE player_position (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  sport_id tinyint(3) unsigned NOT NULL,

  name varchar(20) NOT NULL,
  abbreviation varchar(10) NOT NULL,

  PRIMARY KEY (id),
  KEY sport_id (sport_id),
  FOREIGN KEY (sport_id) REFERENCES sport (id)
) ENGINE=InnoDB;

CREATE TABLE roster_status (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  league_id tinyint(3) unsigned NOT NULL,

  sequence tinyint(3) unsigned NOT NULL,
  name varchar(100) NOT NULL,
  is_team_applicable bit(1) NOT NULL,
  is_team_required bit(1) NOT NULL,
  is_unassigned bit(1) NOT NULL,
  is_free_agent bit(1) NOT NULL,
  is_main_roster bit(1) NOT NULL,
  is_injury_list bit(1) NOT NULL,
  is_minor_league bit(1) NOT NULL,
  is_other_league bit(1) NOT NULL,
  is_waivers bit(1) NOT NULL,
  is_retired bit(1) NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (league_id) REFERENCES league (id)
) ENGINE=InnoDB;

CREATE TABLE player (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,

  person_id mediumint(8) unsigned NOT NULL,
  player_position_id smallint(5) unsigned NOT NULL,
  -- player_contract_year_id smallint(5) unsigned,
  eligible_draft_id smallint(5) unsigned,
  -- player_draft_id smallint(5) unsigned,
  roster_status_id smallint(5) unsigned NOT NULL,

  is_undrafted bit(1) NOT NULL,
  handedness_shoots char(1) DEFAULT NULL,
  handedness_catches char(1) DEFAULT NULL,
  handedness_bats char(1) DEFAULT NULL,
  handedness_throws char(1) DEFAULT NULL,
  headshot_url varchar(255) DEFAULT NULL,
  height tinyint(3) unsigned DEFAULT NULL,
  weight smallint(5) unsigned DEFAULT NULL,
  jersey_number varchar(5) DEFAULT NULL,
  is_rookie bit(1) NOT NULL,
  injury varchar(100) DEFAULT NULL,
  injury_playing_probability char(1) DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (person_id) REFERENCES person (id),
  FOREIGN KEY (player_position_id) REFERENCES player_position (id),
  -- FOREIGN KEY (player_contract_year_id) REFERENCES player_contract_year (id),
  FOREIGN KEY (eligible_draft_id) REFERENCES draft (id),
  -- FOREIGN KEY (player_draft_id) REFERENCES player_draft (id),
  FOREIGN KEY (roster_status_id) REFERENCES roster_status (id)
) ENGINE=InnoDB;

CREATE TABLE player_draft (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,

  draft_id smallint(5) unsigned NOT NULL,
  drafted_by_team_id smallint(5) unsigned NOT NULL,
  pick_belonged_to_team_id smallint(5) unsigned NOT NULL,
  player_id mediumint(8) unsigned NOT NULL,

  round tinyint(3) unsigned NOT NULL,
  round_pick tinyint(3) unsigned NOT NULL,
  overall_pick smallint(5) unsigned NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (draft_id) REFERENCES draft (id),
  FOREIGN KEY (drafted_by_team_id) REFERENCES team (id),
  FOREIGN KEY (pick_Belonged_to_team_id) REFERENCES team (id),
  FOREIGN KEY (player_id) REFERENCES player (id)
) ENGINE=InnoDB;

CREATE TABLE season (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  league_id tinyint(3) unsigned NOT NULL,

  name varchar(40) NOT NULL,
  division_type tinyint(3) unsigned NOT NULL,
  status tinyint(3) unsigned NOT NULL,
  start_date datetime,
  end_date datetime,

  PRIMARY KEY (id),
  FOREIGN KEY (league_id) REFERENCES league (id)
) ENGINE=InnoDB;

CREATE TABLE season_interval (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,

  season_id smallint(5) unsigned NOT NULL,

  interval_type tinyint(3) unsigned NOT NULL,
  status tinyint(3) unsigned NOT NULL,
  start_date datetime,
  end_date datetime,

  PRIMARY KEY (id),
  FOREIGN KEY (season_id) REFERENCES season (id)
) ENGINE=InnoDB;

CREATE TABLE game (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,

  season_interval_id smallint(5) unsigned NOT NULL,
  away_team_id smallint(5) unsigned NOT NULL,
  home_team_id smallint(5) unsigned NOT NULL,
  venue_id smallint(5) unsigned NOT NULL,
  -- playoff_series_id smallint(5) unsigned,

  status tinyint(3) unsigned NOT NULL,
  away_score tinyint(3) unsigned,
  home_score tinyint(3) unsigned,
  periods_complete tinyint(3) unsigned NOT NULL,
  attendance mediumint(8) unsigned,
  start_datetime datetime NOT NULL,
  end_datetime datetime NOT NULL,
  is_home_venue bit(1) NOT NULL,
  broadcasters varchar(255),
  weather_type varchar(25),
  weather_description varchar(100),
  weather_wind_speed_mph smallint(5) unsigned,
  weather_wind_direction_degrees smallint(5) unsigned,
  weather_temperature_fahrenheit tinyint(3),
  weather_precipitation_percent tinyint(3) unsigned,
  weather_precipitation_type varchar(20),
  weather_precipitation_amount smallint(5) unsigned,
  weather_precipitation_amount_units varchar(5),
  weather_humidity_percent tinyint(3) unsigned,

  PRIMARY KEY (id),
  FOREIGN KEY (season_interval_id) REFERENCES season_interval (id),
  FOREIGN KEY (away_team_id) REFERENCES team (id),
  FOREIGN KEY (home_team_id) REFERENCES team (id),
  FOREIGN KEY (venue_id) REFERENCES venue (id),
  -- FOREIGN KEY (playoff_series_id) REFERENCES playoff_series (id),
  KEY start_datetime (start_datetime),
  KEY end_datetime (end_datetime)
) ENGINE=InnoDB;
