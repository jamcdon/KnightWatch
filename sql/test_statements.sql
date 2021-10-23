USE KnightWatch;

# proc frontendCall //
select player.name, player.number, export.aggregate3 as '3min', export.overall from export
INNER JOIN player ON export.playerID = player.ID;

SELECT streamData.score FROM streamData
INNER JOIN streamDataPlayer ON streamDataPlayer.streamID = streamData.ID
WHERE streamDataPlayer.playerID = 2
AND streamData.date_time >= NOW() - INTERVAL 3 MINUTE;



# this is the api's only call - gets all necesary data for SPA JSON
CALL frontendCall();

# for use on the backend so mason and adam can get player IDs and names
CALL getPlayers();

# pass in playerID and scrape and update stream data for export table
CALL updateExport(2);

# update streamData and streamDataPlayer with only playerID and score
CALL appendStream(2,52);
select * from streamData;

INSERT INTO streamData(score) VALUES (50);
    SET @streamID_out:=
        (SELECT * FROM streamData
        ORDER BY ID DESC LIMIT 1);
    INSERT INTO streamDataPlayer(streamID, playerID) VALUES(@streamID_out, temp_playerID);


select * from export;