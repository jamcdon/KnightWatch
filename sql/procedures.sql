USE KnightWatch;

DROP PROCEDURE IF EXISTS frontendCall;
DROP PROCEDURE IF EXISTS getPlayers;
DROP PROCEDURE IF EXISTS updateExport;
DROP PROCEDURE IF EXISTS appendStream;

DELIMITER $$
CREATE PROCEDURE frontEndCall()

BEGIN
	SELECT player.name, player.number, export.aggregate3 as '3min', export.overall from export
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

	UPDATE export 
	SET 
		export.aggregate3 = @temp_three,
		export.overall = @temp_overall
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