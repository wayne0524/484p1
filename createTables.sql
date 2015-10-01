
-- User Information--
CREATE TABLE Users
   (userid INTEGER, 
	 fname CHAR(20) NOT NULL, 
	 lname CHAR(20) NOT NULL,
	 yob INTEGER NOT NULL,
	 mob INTEGER NOT NULL,
	 dob INTEGER NOT NULL,
	 gender CHAR(10) NOT NULL,
	PRIMARY KEY(userid));


CREATE TABLE friendship
	(user1 INTEGER,
	 user2 INTEGER,
	 PRIMARY KEY(user1,user2));

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
 	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
 	 FOREIGN KEY(currentlocid) REFERENCES Location(locid) ON DELETE CASCADE,
 	 PRIMARY KEY(userid));

CREATE TABLE Hometown
	(userid INTEGER,
 	 hometownlocid INTEGER,
 	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
 	FOREIGN KEY(hometownlocid) REFERENCES Location(locid) ON DELETE CASCADE,
 	PRIMARY KEY(userid));


-- Event --
CREATE TABLE Event
	(eventid INTEGER,
	 eventname CHAR(40),
	 tagline CHAR(40),
	 description CHAR(40),
	 host CHAR(40),
	 type CHAR(40),
	 subtype CHAR(40),
	 time_start TIMESTAMP,
	 time_end TIMESTAMP,
	 --locid INTEGER,
	 location CHAR(40),
	 --FOREIGN KEY(locid) REFERENCES Location,
	 --FOREIGN KEY(creator) REFERENCES Users(userid),
	 PRIMARY KEY(eventid));

-- Event being helded at location
CREATE TABLE Holds
    	(country CHAR(30),
	     state CHAR(30),
	     city CHAR(30),
		 eventid INTEGER,
		--FOREIGN KEY(locid) REFERENCES Location ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    --FOREIGN KEY(city) REFERENCES Location ON DELETE CASCADE,
	    --FOREIGN KEY(state) REFERENCES Location ON DELETE CASCADE,
	    --FOREIGN KEY(country) REFERENCES Location ON DELETE CASCADE,
	    PRIMARY KEY(eventid));


CREATE TABLE Creator
    	(creatorid INTEGER,
		 eventid INTEGER,
		FOREIGN KEY(creatorid) REFERENCES Users(userid) ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    PRIMARY KEY(creatorid, eventid));


-- Table list of all participants, including eventid AND staus --
CREATE TABLE Participants
    	(pptid INTEGER,
		 eventid INTEGER,
		 status CHAR(20),
		FOREIGN KEY(pptid) REFERENCES Users(userid) ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
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
	  coverphotoid INTEGER,
	  albumname CHAR(20),
	  time_created TIMESTAMP,
	  time_modified TIMESTAMP,
	  albumlink CHAR(20),
	  visibility CHAR(20),
	  FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	  FOREIGN KEY(coverphotoid) REFERENCES Photo(photoid) ON DELETE CASCADE,
	  PRIMARY KEY(albumid));


-- Relation: Tags in photos--
CREATE TABLE Tags
	(photoid INTEGER,
	 userid INTEGER,
	 time_tag TIMESTAMP,
	 coo_x INTEGER,
	 coo_y INTEGER,
	 FOREIGN KEY(photoid) REFERENCES Photo ON DELETE CASCADE,
	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	 PRIMARY KEY(photoid, userid));

-- Relation: between photo and Album ---
CREATE TABLE Belongs
	(photoid INTEGER,
	 albumid INTEGER,
	 FOREIGN KEY(photoid) REFERENCES Photo ON DELETE CASCADE,
	 FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE,
	 PRIMARY KEY(photoid, albumid));



-- Relation  : Album owned by one user --
CREATE TABLE Owns
	(albumid INTEGER,
	 userid INTEGER,
	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	 FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE,
	 PRIMARY KEY(userid, albumid));



-- Education  DO WE NEED A EDUCATION ID???????????????????????????????????????????--
CREATE TABLE Education
	(eduid INTEGER,
	 inst_name CHAR(100),	
	 duration INTEGER,
	 degree CHAR(100),
	 concentration CHAR(100),	
	 PRIMARY KEY(eduid));


CREATE TABLE Attend
	(eduid INTEGER,
	 --userid INTEGER,
	userid INTEGER,	
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
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
	FOREIGN KEY(messageid) REFERENCES Messages ON DELETE CASCADE,
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(messageid,userid));

CREATE TABLE Receiver
	(messageid INTEGER,
	--timesend TIMESTAMP,
	userid INTEGER,
	--FOREIGN KEY(timesend) REFERENCES Messages(time),
	FOREIGN KEY(messageid) REFERENCES Messages ON DELETE CASCADE,
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(messageid,userid));

-- CREATE TABLE Receiver
-- 	(time TIMESTAMP,
-- 	 userid INTEGER,
-- 	FOREIGN KEY(time) REFERENCES Messages,
-- 	FOREIGN KEY(userid) REFERENCES Users,
-- 	PRIMARY KEY(time,userid));




ALTER TABLE Photo
	ADD (albumid INTEGER, 
		FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE);

-- ALTER TABLE Messages
-- 	ADD (sender INTEGER, 
-- 		FOREIGN KEY(userid) REFERENCES Sender);

