
-- User Information--
CREATE TABLE Users
   (userid VARCHAR(100),
	 fname VARCHAR(100), 
	 lname VARCHAR(100),
	 yob INTEGER,
	 mob INTEGER,
	 dob INTEGER,
	 gender VARCHAR(100),
	PRIMARY KEY(userid));


CREATE TABLE friendship
	(user1 VARCHAR(100),
	 user2 VARCHAR(100),
	 PRIMARY KEY(user1,user2));

-- Create LLLLocation--
CREATE TABLE Location
	(locid INTEGER,
	 country VARCHAR(100),
	 state VARCHAR(100),
	 city VARCHAR(100),
	 PRIMARY KEY(locid));
	 --FOREIGN KEY (userid) REFERENCES Users,
	 --PRIMARY KEY(locid, userid));
	
-- Create Table of hometown of Users--
CREATE TABLE Currenthome
	(userid VARCHAR(100),
 	 currentlocid INTEGER,
 	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
 	 FOREIGN KEY(currentlocid) REFERENCES Location(locid) ON DELETE CASCADE,
 	 PRIMARY KEY(userid));

CREATE TABLE Hometown
	(userid VARCHAR(100),
 	 hometownlocid INTEGER,
 	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
 	FOREIGN KEY(hometownlocid) REFERENCES Location(locid) ON DELETE CASCADE,
 	PRIMARY KEY(userid));


-- Event --
CREATE TABLE Event
	(eventid VARCHAR(100),
	 eventname VARCHAR(100),
	 tagline VARCHAR(100),
	 description VARCHAR(100),
	 host VARCHAR(100),
	 type VARCHAR(100),
	 subtype VARCHAR(100),
	 time_start TIMESTAMP(6),
	 time_end TIMESTAMP(6),
	 --locid INTEGER,
	 location VARCHAR(100),
	 --FOREIGN KEY(locid) REFERENCES Location,
	 --FOREIGN KEY(creator) REFERENCES Users(userid),
	 PRIMARY KEY(eventid));

-- Event being helded at location
CREATE TABLE Holds
    	(locid INTEGER,
		 eventid VARCHAR(100),
		--FOREIGN KEY(locid) REFERENCES Location ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    FOREIGN KEY(locid) REFERENCES Location ON DELETE CASCADE,
	    PRIMARY KEY(locid, eventid));


CREATE TABLE Creator
    	(creatorid VARCHAR(100),
		 eventid VARCHAR(100),
		FOREIGN KEY(creatorid) REFERENCES Users(userid) ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    PRIMARY KEY(creatorid, eventid));


-- Table list of all participants, including eventid AND staus --
CREATE TABLE Participants
    	(pptid VARCHAR(100),
		 eventid VARCHAR(100),
		 status VARCHAR(100),
		FOREIGN KEY(pptid) REFERENCES Users(userid) ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    PRIMARY KEY(pptid, eventid));

-- Photo --
CREATE TABLE Photo
	(photoid VARCHAR(100),
	 caption VARCHAR(100),
	 time_created TIMESTAMP(6),
	 time_modified TIMESTAMP(6),
	 photolink VARCHAR(100),
	 --albumid INTEGER,
	 --KEY(albumid) REFERENCES Album,  added back at end
	 PRIMARY KEY(photoid));



-- Album --
CREATE TABLE Album
	(albumid VARCHAR(100),
	  userid VARCHAR(100),
	  coverphotoid VARCHAR(100),
	  albumname VARCHAR(100),
	  time_created TIMESTAMP(6),
	  time_modified TIMESTAMP(6),
	  albumlink VARCHAR(100),
	  visibility VARCHAR(100),
	  FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	  FOREIGN KEY(coverphotoid) REFERENCES Photo(photoid) ON DELETE CASCADE,
	  PRIMARY KEY(albumid));


-- Relation: Tags in photos--
CREATE TABLE Tags
	(photoid VARCHAR2(100),
	 userid VARCHAR2(100),
	 time_tag TIMESTAMP(6),
	 coo_x INTEGER,
	 coo_y INTEGER,
	 FOREIGN KEY(photoid) REFERENCES Photo ON DELETE CASCADE,
	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	 PRIMARY KEY(photoid, userid));

-- Relation: between photo and Album ---
CREATE TABLE Belongs
	(photoid VARCHAR(100),
	 albumid VARCHAR(100),
	 FOREIGN KEY(photoid) REFERENCES Photo ON DELETE CASCADE,
	 FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE,
	 PRIMARY KEY(photoid, albumid));


-- Relation  : Album owned by one user --
CREATE TABLE Owns
	(albumid VARCHAR(100),
	 userid VARCHAR(100),
	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	 FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE,
	 PRIMARY KEY(userid, albumid));



-- Education  DO WE NEED A EDUCATION ID???????????????????????????????????????????--
CREATE TABLE Education
	(eduid INTEGER,
	 inst_name VARCHAR(100),	
	 duration INTEGER,
	 degree VARCHAR(100),
	 concentration VARCHAR(100),	
	 PRIMARY KEY(eduid));


CREATE TABLE Attend
	(eduid INTEGER,
	userid VARCHAR(100),	
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(eduid, userid));


-- MEssage 
CREATE TABLE Messages
	(messageid INTEGER,
	 time TIMESTAMP(6),
	 --sender INTEGER,
	 content VARCHAR(100),
	 --FOREIGN KEY(sender) REFERENCES Users(userid),
	 PRIMARY KEY(messageid));	


CREATE TABLE Sender
	(messageid INTEGER,
	--timesend TIMESTAMP(6),
	userid VARCHAR(100),
	--FOREIGN KEY(timesend) REFERENCES Messages(time),
	FOREIGN KEY(messageid) REFERENCES Messages ON DELETE CASCADE,
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(messageid,userid));

CREATE TABLE Receiver
	(messageid INTEGER,
	--timesend TIMESTAMP(6),
	userid VARCHAR(100),
	--FOREIGN KEY(timesend) REFERENCES Messages(time),
	FOREIGN KEY(messageid) REFERENCES Messages ON DELETE CASCADE,
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(messageid,userid));

-- CREATE TABLE Receiver
-- 	(time TIMESTAMP(6),
-- 	 userid INTEGER,
-- 	FOREIGN KEY(time) REFERENCES Messages,
-- 	FOREIGN KEY(userid) REFERENCES Users,
-- 	PRIMARY KEY(time,userid));




ALTER TABLE Photo
	ADD (albumid VARCHAR(100), 
		FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE);

-- ALTER TABLE Photo ADD CONSTRAINT PHOTO_REFERS_ALBUM  FOREIGN KEY (albumid) REFERENCES Album INITIALLY DEFERRED DEFERRABLE;
-- ALTER TABLE Album ADD CONSTRAINT Album_REFERS_PHOTO  FOREIGN KEY (coverphotoid) REFERENCES Photo INITIALLY DEFERRED DEFERRABLE;




-- ALTER TABLE Messages
-- 	ADD (sender INTEGER, 
-- 		FOREIGN KEY(userid) REFERENCES Sender);

