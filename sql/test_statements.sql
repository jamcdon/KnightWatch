USE KnightWatch;

# proc frontendCall //
select player.name, player.number, export.aggregate3 as '3min', export.overall from export
INNER JOIN player ON export.playerID = player.ID;

SELECT streamData.score FROM streamData
INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
WHERE streamDataPlayer.playerID = 2
AND streamData.date_time >= NOW() - INTERVAL 3 MINUTE;

SELECT AVG(streamData.score) FROM streamData
	INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
	WHERE streamDataPlayer.playerID = 2
	AND streamData.date_time >= NOW() - INTERVAL 3 MINUTE;

CALL frontendCall();

CALL getPlayers();

CALL updateExport();