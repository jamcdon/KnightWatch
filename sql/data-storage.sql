CREATE DATABASE KnightWatch;

CREATE TABLE `streamPlayer` (
    `ID` int  NOT NULL ,
    `streamID` int  NOT NULL ,
    `playerID` int  NOT NULL ,
    PRIMARY KEY (
        `ID`
    )
);

CREATE TABLE `stream` (
    `ID` int  NOT NULL ,
    `data` float  NOT NULL ,
    PRIMARY KEY (
        `ID`
    )
);

CREATE TABLE `player` (
    `ID` int  NOT NULL ,
    `name` varchar(128) NOT NULL ,
    `number` int  NOT NULL ,
    `baseline` float  NOT NULL ,
    PRIMARY KEY (
        `ID`
    )
);

CREATE TABLE `export` (
    `ID` int  NOT NULL ,
    `playerID` int  NOT NULL ,
    `aggregate3` float  NOT NULL ,
    `overall` float  NOT NULL ,
    PRIMARY KEY (
        `ID`
    )
);

ALTER TABLE `streamPlayer` ADD CONSTRAINT `fk_streamPlayer_streamID` FOREIGN KEY(`streamID`)
REFERENCES `stream` (`ID`);

ALTER TABLE `streamPlayer` ADD CONSTRAINT `fk_streamPlayer_playerID` FOREIGN KEY(`playerID`)
REFERENCES `player` (`ID`);

ALTER TABLE `export` ADD CONSTRAINT `fk_export_playerID` FOREIGN KEY(`playerID`)
REFERENCES `player` (`ID`);

