DROP DATABASE IF EXISTS KnightWatch;
CREATE DATABASE IF NOT EXISTS KnightWatch;
USE KnightWatch;

CREATE TABLE streamDataPlayer (
    ID 			INTEGER AUTO_INCREMENT NOT NULL ,
    streamID 	INTEGER NOT NULL REFERENCES streamData(ID),
    playerID 	INTEGER NOT NULL REFERENCES player(ID),
    PRIMARY KEY (ID)
);

CREATE TABLE streamData (
    ID 			INTEGER AUTO_INCREMENT NOT NULL ,
    score 		DECIMAL NOT NULL ,
    date_time	DATETIME DEFAULT NOW(),
    PRIMARY KEY (ID)
);

CREATE TABLE player (
    ID 			INTEGER AUTO_INCREMENT NOT NULL ,
    name 		VARCHAR(128) NOT NULL ,
    number 		INTEGER NOT NULL ,
    baseline 	DECIMAL  NOT NULL ,
    PRIMARY KEY (ID)
);

CREATE TABLE export (
    ID 			INTEGER AUTO_INCREMENT NOT NULL ,
    playerID 	INTEGER NOT NULL REFERENCES player(ID),
    aggregate3 	DECIMAL NOT NULL ,
    overall 	DECIMAL NOT NULL ,
    score      DECIMAL NOT NULL,  #===========================================
    PRIMARY KEY (ID)
);

SET SQL_SAFE_UPDATES=0;


DROP PROCEDURE IF EXISTS frontendCall;
DROP PROCEDURE IF EXISTS getPlayers;
DROP PROCEDURE IF EXISTS updateExport;
DROP PROCEDURE IF EXISTS appendStream;

DELIMITER $$
CREATE PROCEDURE frontEndCall()

BEGIN
	SELECT player.name, player.number, export.aggregate3 as '3min', export.overall
    , export.score #======================================================
     from export
	INNER JOIN player ON export.playerID = player.ID;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getPlayers()

BEGIN
	SELECT player.ID, player.name from player;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE updateExport(IN inPlayerID INT)

BEGIN
	# 3 min
	SET @temp_three:=
	(SELECT AVG(streamData.score) FROM streamData
	INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
	WHERE streamDataPlayer.playerID = inPlayerID
	AND streamData.date_time >= NOW() - INTERVAL 3 MINUTE);

	#overall
	SET @temp_overall:=
	(SELECT AVG(streamData.score) FROM streamData
	INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
	WHERE streamDataPlayer.playerID = inPlayerID);

    #score ==========================================================
    SET @temp_score:=
    (SELECT streamData.score FROM streamData
    INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
    WHERE streamDataPlayer.playerID = inPlayerID
    ORDER BY streamData.ID DESC LIMIT 1);

	UPDATE export 
	SET 
		export.aggregate3 = @temp_three,
		export.overall = @temp_overall
        , export.score = @temp_score
	WHERE
		playerID = inPlayerID;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE appendStream(IN temp_playerID INT, IN temp_score INT)
BEGIN
    INSERT INTO streamData(score) VALUES (temp_score);
    SET @streamID_out:=
        (SELECT streamData.ID FROM streamData
        ORDER BY ID DESC LIMIT 1);
    INSERT INTO streamDataPlayer(streamID, playerID) VALUES(@streamID_out, temp_playerID);
END$$
DELIMITER ;


INSERT INTO player VALUES (1,'TY Hilton',13,40),(2,'Eric Fisher',79,61),(3,'Chris Reed',62,89),(4,'Ryan Kelly',78,48),(5,'Mark Glowinski',64,85),(6,'Braden Smith',72,48),(7,'Jack Doyle',84,26),(8,'Mo Alie-Cox',81,15),(9,'Zach Pascal',14,11),(10,'Michael Pittman Jr.',11,55),(11,'Carson Wentz',2,52),(12,'Colts Blue',00,40);

INSERT INTO export(playerID, aggregate3, overall,score) VALUES (1,0,0,0),(2,0,0,0),(3,0,0,0),(4,0,0,0),(5,0,0,0),(6,0,0,0),(7,0,0,0),(8,0,0,0),(9,0,0,0),(10,0,0,0),(11,0,0,0),(12,0,0,0);