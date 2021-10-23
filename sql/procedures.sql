USE KnightWatch;

DROP PROCEDURE IF EXISTS frontendCall;
DROP PROCEDURE IF EXISTS getPlayers;
DROP PROCEDURE IF EXISTS updateExport;

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
CREATE PROCEDURE updateExport
(IN inplayerID)

BEGIN
	# 3 min
	SELECT AVG(streamData.score) FROM streamData
	INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
	WHERE streamDataPlayer.playerID = inPlayerID
	AND streamData.date_time >= NOW() - INTERVAL 3 MINUTE;

	#overall
	SELECT AVG(streamData.score) FROM streamData
	INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
	WHERE streamDataPlayer.playerID = inPlayerID;
END$$
DELIMITER ;