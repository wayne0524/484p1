
-- User Information--
CREATE TABLE Users
   ( userid INTEGER NOT NULL, 
	 fname CHAR(20) NOT NULL, 
	 lname CHAR(20) NOT NULL,
	 yob INTEGER NOT NULL,
	 mob INTEGER NOT NULL,
	 dob INTEGER NOT NULL,
	 gender CHAR(10) NOT NULL,
	PRIMARY KEY(userid));

-- Create LLLLocation--
CREATE TABLE Location
	(locid INTEGER ,
	 country CHAR(30),
	 state CHAR(30),
	 city CHAR(30),
	 PRIMARY KEY(locid));
	 --FOREIGN KEY (userid) REFERENCES Users,
	 --PRIMARY KEY(locid, userid));
	
-- Create Table of hometown of Users--
CREATE TABLE Address
	(userid INTEGER,
 	homelocid INTEGER,
 	currentlocid INTEGER,
 	FOREIGN KEY(userid) REFERENCES Users);



-- Event --
CREATE TABLE Event
	(eventid INTEGER NOT NULL,
	 eventname CHAR(30),
	 tagline CHAR(30),
	 description CHAR(30),
	 host CHAR(20),
	 type CHAR(20),
	 subtype CHAR(20),
	 time_start TIMESTAMP,
	 time_end TIMESTAMP,
	 locid INTEGER,
	 location CHAR(30),
	 creator INTEGER,
	 FOREIGN KEY(locid) REFERENCES Location,
	 FOREIGN KEY(creator) REFERENCES Users(userid),
	 PRIMARY KEY(eventid));



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



-- Tags in photos--

CREATE TABLE Tags
	(albumid INTEGER,
	 userid INTEGER,
	 coo_x INTEGER,
	 coo_y INTEGER,
	 time_tag TIMESTAMP,
	 FOREIGN KEY(albumid) REFERENCES Album,
	 FOREIGN KEY(userid) REFERENCES Users,
	 PRIMARY KEY(albumid, userid));

-- Education  DO WE NEED A EDUCATION ID???????????????????????????????????????????--
CREATE TABLE Education
	(userid INTEGER,
	 inst_name CHAR(20),	
	 duration INTEGER,
	 degree CHAR(20),
	 concentration CHAR(20),	
	 FOREIGN KEY(userid) REFERENCES Users,
	 PRIMARY KEY(userid));



-- MEssage 
CREATE TABLE Messages
	( messageid INTEGER,
	  sender INTEGER,
	  content CHAR(30),
	  time TIMESTAMP,
	  FOREIGN KEY(sender) REFERENCES Users(userid),
	  PRIMARY KEY(messageid));	


CREATE TABLE Receiver
	(	messageid INTEGER,
		userid INTEGER,
		FOREIGN KEY(messageid) REFERENCES Messages,
		FOREIGN KEY(userid) REFERENCES Users,
		PRIMARY KEY(messageid));




ALTER TABLE Photo
	ADD (albumid INTEGER, 
		FOREIGN KEY(albumid) REFERENCES Album);


