
-- Author: Shengwei Ge, Date 10/02/2015 -----------
---------------------------------------------------------------------------
-- Create Tables for Fakebook.
-- There are two there types of Tables: Identity, relationship and attributes
-- They represent the whole ER diagran
---------------------------------------------------------------------------

------  # of Tables Created: 19------------

-------------- User Information---------------
CREATE TABLE Users
   (userid VARCHAR(100),
	 fname VARCHAR(100), 
	 lname VARCHAR(100),
	 yob INTEGER,
	 mob INTEGER,
	 dob INTEGER,
	 gender VARCHAR(100),
	PRIMARY KEY(userid));



-- Relationship: create friendship -----------
CREATE TABLE friendship
	(user1 VARCHAR(100),
	 user2 VARCHAR(100),
	 PRIMARY KEY(user1,user2));

----------Identity : Create Location-------------------
CREATE TABLE Location
	(locid INTEGER,
	 country VARCHAR(100),
	 state VARCHAR(100),
	 city VARCHAR(100),
	 PRIMARY KEY(locid));
	
--  Relationship: Create Table of currenthome of Users--
CREATE TABLE Currenthome
	(userid VARCHAR(100),
 	 currentlocid INTEGER,
 	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
 	 FOREIGN KEY(currentlocid) REFERENCES Location(locid) ON DELETE CASCADE,
 	 PRIMARY KEY(userid));

--  Relationship: Create Table of hometown of Users--
CREATE TABLE Hometown
	(userid VARCHAR(100),
 	 hometownlocid INTEGER,
 	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
 	FOREIGN KEY(hometownlocid) REFERENCES Location(locid) ON DELETE CASCADE,
 	PRIMARY KEY(userid));


-- Identity:   Event -------------------------------
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
	 location VARCHAR(100),
	 PRIMARY KEY(eventid));

-- Relationship:    Event being helded at location ----------
CREATE TABLE Holds
    	(locid INTEGER,
		 eventid VARCHAR(100),
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    FOREIGN KEY(locid) REFERENCES Location ON DELETE CASCADE,
	    PRIMARY KEY(locid, eventid));

-- Relationship:    Event being helded at location ----------
CREATE TABLE Creator
    	(creatorid VARCHAR(100),
		 eventid   VARCHAR(100),
		FOREIGN KEY(creatorid) REFERENCES Users(userid) ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    PRIMARY KEY(creatorid, eventid));


-- Relationship:  Table list of all participants, including eventid AND staus --
CREATE TABLE Participants
    	(pptid VARCHAR(100),
		 eventid VARCHAR(100),
		 status VARCHAR(100),
		FOREIGN KEY(pptid) REFERENCES Users(userid) ON DELETE CASCADE,
		FOREIGN KEY(eventid) REFERENCES Event ON DELETE CASCADE,
	    PRIMARY KEY(pptid, eventid));

-- Identity : Photo --
CREATE TABLE Photo
	(photoid VARCHAR(100),
	 caption VARCHAR(100),
	 time_created TIMESTAMP(6),
	 time_modified TIMESTAMP(6),
	 photolink VARCHAR(100),
	 PRIMARY KEY(photoid));

-- Identity:   Album --
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


-- Relation: Person -> photos---------------
CREATE TABLE Tags
	(photoid VARCHAR2(100),
	 userid VARCHAR2(100),
	 time_tag TIMESTAMP(6),
	 coo_x NUMBER,
	 coo_y NUMBER,
	 FOREIGN KEY(photoid) REFERENCES Photo ON DELETE CASCADE,
	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	 PRIMARY KEY(photoid, userid));

-- Relationship:  photo Belongs to Album ---
CREATE TABLE Belongs
	(photoid VARCHAR(100),
	 albumid VARCHAR(100),
	 FOREIGN KEY(photoid) REFERENCES Photo ON DELETE CASCADE,
	 FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE,
	 PRIMARY KEY(photoid, albumid));


-- Relationship  : Album owned by one user --
CREATE TABLE Owns
	(albumid VARCHAR(100),
	 userid VARCHAR(100),
	 FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	 FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE,
	 PRIMARY KEY(userid, albumid));



--- Identity: Education  ----------------------
CREATE TABLE Education
	(eduid INTEGER,
	 inst_name VARCHAR(100),	
	 duration INTEGER,
	 degree VARCHAR(100),
	 concentration VARCHAR(100),	
	 PRIMARY KEY(eduid));

--Relationship:    Attend --------------------
CREATE TABLE Attend
	(eduid INTEGER,
	userid VARCHAR(100),	
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(eduid, userid));


-- Identity: Messages-------------------------
CREATE TABLE Messages
	(messageid INTEGER,
	 time TIMESTAMP(6),
	 content VARCHAR(100),
	 PRIMARY KEY(messageid));	

-- Relationship:   User ->  Message ------------------------
CREATE TABLE Sender
	(messageid INTEGER,
	userid VARCHAR(100),
	FOREIGN KEY(messageid) REFERENCES Messages ON DELETE CASCADE,
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(messageid,userid));


-- Relationship:   User ->  Message ------------------------
CREATE TABLE Receiver
	(messageid INTEGER,
	userid VARCHAR(100),
	FOREIGN KEY(messageid) REFERENCES Messages ON DELETE CASCADE,
	FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
	PRIMARY KEY(messageid,userid));


----- Alter photo Attribute to include albumid since circular 
----- constraint ---------------------------------------------
ALTER TABLE Photo
	ADD (albumid VARCHAR(100), 
		FOREIGN KEY(albumid) REFERENCES Album ON DELETE CASCADE);


