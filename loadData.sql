
-- Update all Users -------
INSERT INTO Users(userid,  fname,      lname,     yob,           mob,            dob,          gender)
SELECT DISTINCT USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER FROM
keykholt.PUBLIC_USER_INFORMATION;

CREATE SEQUENCE loc_1_sequence
START WITH 1
INCREMENT BY 1;


CREATE TRIGGER loc_1_trigger
BEFORE INSERT ON Location
FOR EACH ROW
BEGIN
SELECT loc_1_sequence.nextval into :new.locid from dual;
END;
.
RUN;



--  Upload all locations ---------
INSERT INTO Location(city, state, country)
SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY FROM
keykholt.PUBLIC_USER_INFORMATION
UNION 
SELECT DISTINCT CURRENT_CITY,  CURRENT_STATE, CURRENT_COUNTRY  FROM
keykholt.PUBLIC_USER_INFORMATION
UNION 
SELECT DISTINCT EVENT_CITY,  EVENT_STATE, EVENT_COUNTRY  FROM
keykholt.PUBLIC_EVENT_INFORMATION;




CREATE TRIGGER loc_2_trigger
BEFORE INSERT ON Education
FOR EACH ROW
BEGIN
SELECT loc_1_sequence.nextval into :new.eduid from dual;
END;
.
RUN;



-- Education ---
INSERT INTO Education(inst_name, duration, degree, concentration)
SELECT DISTINCT INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_DEGREE, PROGRAM_CONCENTRATION FROM
keykholt.PUBLIC_USER_INFORMATION;



-- Friendship
INSERT INTO Friendship(user1, user2)
SELECT DISTINCT USER1_ID, USER2_ID FROM
keykholt.PUBLIC_ARE_FRIENDS;


-- Photo --

INSERT INTO Photo(photoid,  caption,       time_created,        time_modified,        photolink)
SELECT DISTINCT PHOTO_ID,   PHOTO_CAPTION, PHOTO_CREATED_TIME,   PHOTO_MODIFIED_TIME, PHOTO_LINK FROM
keykholt.PUBLIC_PHOTO_INFORMATION;




-- Album --
INSERT INTO Album(albumid, userid,   coverphotoid,    albumname, time_created,       time_modified,       albumlink,   visibility)
SELECT DISTINCT ALBUM_ID,  OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY FROM
keykholt.PUBLIC_PHOTO_INFORMATION;


--Tag --
INSERT INTO Tags(photoid,  userid,          time_tag,        coo_x ,            coo_y)
SELECT DISTINCT PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME , TAG_X_COORDINATE, TAG_Y_COORDINATE FROM
keykholt.PUBLIC_TAG_INFORMATION;




--Event ---
INSERT INTO Event(eventid,  eventname,  tagline,        description,       host,       type,       subtype,         time_start,         time_end,      location )
SELECT DISTINCT  EVENT_ID,  EVENT_NAME, EVENT_TAGLINE , EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE,   EVENT_START_TIME,   EVENT_END_TIME, EVENT_LOCATION FROM
keykholt.PUBLIC_EVENT_INFORMATION;



-- Creator --
INSERT INTO Creator(creatorid, eventid)
SELECT DISTINCT EVENT_CREATOR_ID, EVENT_ID FROM 
keykholt.PUBLIC_EVENT_INFORMATION;




-- Holds ------
-- CREATE TRIGGER loc_3_trigger
-- BEFORE INSERT ON Location
-- FOR EACH ROW
-- BEGIN
-- SELECT loc_1_sequence.nextval into :new.locid from dual;
-- END;
-- .
-- RUN;

-- INSERT INTO Location(city, state, country)
-- SELECT DISTINCT EVENT_CITY, EVENT_STATE, EVENT_COUNTRY FROM
-- keykholt.PUBLIC_EVENT_INFORMATION;
-- Get rid of duplicates -----------------!!!!!!!!!!!!!!!!

INSERT INTO Holds(country, state, city, eventid)
SELECT DISTINCT  EVENT_COUNTRY ,EVENT_STATE, EVENT_CITY, EVENT_ID FROM 
keykholt.PUBLIC_EVENT_INFORMATION;









DROP TRIGGER loc_1_trigger;
DROP TRIGGER loc_2_trigger;








