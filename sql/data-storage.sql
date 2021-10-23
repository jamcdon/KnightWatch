DROP DATABASE IF EXISTS KnightWatch;
CREATE DATABASE IF NOT EXISTS KnightWatch;
USE KnightWatch;

CREATE TABLE streamDataPlayer (
    ID 			INTEGER NOT NULL ,
    streamID 	INTEGER NOT NULL REFERENCES streamData(ID),
    playerID 	INTEGER NOT NULL REFERENCES player(ID),
    PRIMARY KEY (ID)
);

CREATE TABLE streamData (
    ID 			INTEGER NOT NULL ,
    score 		DECIMAL NOT NULL ,
    PRIMARY KEY (ID)
);

CREATE TABLE player (
    ID 			INTEGER NOT NULL ,
    name 		VARCHAR(128) NOT NULL ,
    number 		INTEGER NOT NULL ,
    baseline 	DECIMAL  NOT NULL ,
    PRIMARY KEY (ID)
);

CREATE TABLE export (
    ID 			INTEGER NOT NULL ,
    playerID 	INTEGER NOT NULL REFERENCES player(ID),
    aggregate3 	DECIMAL NOT NULL ,
    overall 	DECIMAL NOT NULL ,
    PRIMARY KEY (ID)
);