
-- User Information--
CREATE TABLE Users
   ( userid INTEGER, 
	 fname CHAR(20) NOT NULL, 
	 lname CHAR(20) NOT NULL,
	 yob INTEGER NOT NULL,
	 mob INTEGER NOT NULL,
	 dob INTEGER NOT NULL,
	 gender CHAR(10) NOT NULL,
	PRIMARY KEY(userid));

-- Create LLLLocation--
CREATE TABLE Location
	(locid INTEGER,
	 country CHAR(30),
	 state CHAR(30),
	 city CHAR(30),
	 PRIMARY KEY(locid));
	 --FOREIGN KEY (userid) REFERENCES Users,
	 --PRIMARY KEY(locid, userid));
	
-- Create Table of hometown of Users--
CREATE TABLE Currenthome
	(userid INTEGER,
 	 currentlocid INTEGER,
 	 FOREIGN KEY(userid) REFERENCES Users,
 	 FOREIGN KEY(currentlocid) REFERENCES Location(locid),
 	 PRIMARY KEY(userid));

CREATE TABLE Hometown
	(userid INTEGER,
 	 hometownlocid INTEGER,
 	FOREIGN KEY(userid) REFERENCES Users,
 	FOREIGN KEY(hometownlocid) REFERENCES Location(locid),
 	PRIMARY KEY(userid));


-- Event --
CREATE TABLE Event
	(eventid INTEGER,
	 eventname CHAR(30),
	 tagline CHAR(30),
	 description CHAR(30),
	 host CHAR(20),
	 type CHAR(20),
	 subtype CHAR(20),
	 time_start TIMESTAMP,
	 time_end TIMESTAMP,
	 --locid INTEGER,
	 location CHAR(30),
	 --FOREIGN KEY(locid) REFERENCES Location,
	 --FOREIGN KEY(creator) REFERENCES Users(userid),
	 PRIMARY KEY(eventid));

-- Event being helded at location
CREATE TABLE Holds
    	(locid INTEGER,
		 eventid INTEGER,
		FOREIGN KEY(locid) REFERENCES Location,
		FOREIGN KEY(eventid) REFERENCES Event,
	    PRIMARY KEY(locid, eventid));


CREATE TABLE Creator
    	(creatorid INTEGER,
		 eventid INTEGER,
		FOREIGN KEY(creatorid) REFERENCES Users(userid),
		FOREIGN KEY(eventid) REFERENCES Event,
	    PRIMARY KEY(creatorid, eventid));


-- Table list of all participants, including eventid AND staus --
CREATE TABLE Participants
    	(pptid INTEGER,
		 eventid INTEGER,
		 status CHAR(20),
		FOREIGN KEY(pptid) REFERENCES Users(userid),
		FOREIGN KEY(eventid) REFERENCES Event,
	    PRIMARY KEY(pptid, eventid));

-- Photo --
CREATE TABLE Photo
	(photoid INTEGER,
	 caption CHAR(20),
	 time_created TIMESTAMP,
	 time_modified TIMESTAMP,
	 photolink CHAR(20),
	 --albumid INTEGER,
	 --KEY(albumid) REFERENCES Album,  added back at end
	 PRIMARY KEY(photoid));



-- Album --
CREATE TABLE Album
	(albumid INTEGER,
	  userid INTEGER,
	  albumname CHAR(20),
	  coverphotoid INTEGER,
	  time_created INTEGER,
	  time_modified INTEGER,
	  albumlink CHAR(20),
	  visibility CHAR(20),
	  FOREIGN KEY(userid) REFERENCES Users,
	  FOREIGN KEY(coverphotoid) REFERENCES Photo(photoid),
	  PRIMARY KEY(albumid));


-- Relation: Tags in photos--
CREATE TABLE Tags
	(photoid INTEGER,
	 userid INTEGER,
	 coo_x INTEGER,
	 coo_y INTEGER,
	 time_tag TIMESTAMP,
	 FOREIGN KEY(photoid) REFERENCES Photo,
	 FOREIGN KEY(userid) REFERENCES Users,
	 PRIMARY KEY(photoid, userid));

-- Relation: between photo and Album ---
CREATE TABLE Belongs
	(photoid INTEGER,
	 albumid INTEGER,
	 FOREIGN KEY(photoid) REFERENCES Photo,
	 FOREIGN KEY(albumid) REFERENCES Album,
	 PRIMARY KEY(photoid, albumid));



-- Relation  : Album owned by one user --
CREATE TABLE Owns
	(albumid INTEGER,
	 userid INTEGER,
	 FOREIGN KEY(userid) REFERENCES Users,
	 FOREIGN KEY(albumid) REFERENCES Album,
	 PRIMARY KEY(userid, albumid));



-- Education  DO WE NEED A EDUCATION ID???????????????????????????????????????????--
CREATE TABLE Education
	(eduid INTEGER,
	 inst_name CHAR(20),	
	 duration INTEGER,
	 degree CHAR(20),
	 concentration CHAR(20),	
	 PRIMARY KEY(eduid));


CREATE TABLE Attend
	(eduid INTEGER,
	 --userid INTEGER,
	userid INTEGER,	
	FOREIGN KEY(userid) REFERENCES Users,
	PRIMARY KEY(eduid));

-- MEssage 
CREATE TABLE Messages
	(messageid INTEGER,
	 time TIMESTAMP,
	 --sender INTEGER,
	 content CHAR(30),
	 --FOREIGN KEY(sender) REFERENCES Users(userid),
	 PRIMARY KEY(messageid));	


CREATE TABLE Sender
	(messageid INTEGER,
	--timesend TIMESTAMP,
	userid INTEGER,
	--FOREIGN KEY(timesend) REFERENCES Messages(time),
	FOREIGN KEY(messageid) REFERENCES Messages,
	FOREIGN KEY(userid) REFERENCES Users,
	PRIMARY KEY(messageid,userid));

CREATE TABLE Receiver
	(messageid INTEGER,
	--timesend TIMESTAMP,
	userid INTEGER,
	--FOREIGN KEY(timesend) REFERENCES Messages(time),
	FOREIGN KEY(messageid) REFERENCES Messages,
	FOREIGN KEY(userid) REFERENCES Users,
	PRIMARY KEY(messageid,userid));
	
-- CREATE TABLE Receiver
-- 	(time TIMESTAMP,
-- 	 userid INTEGER,
-- 	FOREIGN KEY(time) REFERENCES Messages,
-- 	FOREIGN KEY(userid) REFERENCES Users,
-- 	PRIMARY KEY(time,userid));




ALTER TABLE Photo
	ADD (albumid INTEGER, 
		FOREIGN KEY(albumid) REFERENCES Album);

-- ALTER TABLE Messages
-- 	ADD (sender INTEGER, 
-- 		FOREIGN KEY(userid) REFERENCES Sender);

