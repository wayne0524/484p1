CREATE VIEW VIEW_USER_INFORMATION 
   (USER_ID,
   	FIRST_NAME,
   	LAST_NAME,
   	YEAR_OF_BIRTH,
   	MONTH_OF_BIRTH,
   	DAY_OF_BIRTH,
   	GENDER,
    CURRENT_CITY,
    CURRENT_STATE,
    CURRENT_COUNTRY,
    HOMETOWN_CITY,
    HOMETOWN_STATE,
    HOMETOWN_COUNTRY,
    INSTITUTION_NAME,
    PROGRAM_YEAR,
    PROGRAM_CONCENTRATION,
    PROGRAM_DEGREE)
  AS SELECT  U.userid, U.fname, U.lname, U.yob, U.mob, U.dob,
              U.gender, LL.city, LL.state, LL.country, 
                        L.city, L.state, L.country,
                        E.inst_name, E.duration, E.concentration, E.degree
  FROM Users U
  LEFT JOIN Hometown H
  ON U.userid = H.userid
  LEFT JOIN Location L
  ON H.hometownlocid = L.locid
  LEFT JOIN Currenthome C
  ON  U.userid = C.userid
  LEFT JOIN Location LL
  ON C.currentlocid = LL.locid
  LEFT JOIN Attend A
  ON U.userid = A.userid
  LEFT JOIN Education E
  ON A.eduid = E.eduid;




CREATE VIEW VIEW_ARE_FRIENDS(USER1_ID, USER2_ID)
AS SELECT F.user1,
          F.user2
FROM friendship F;




CREATE VIEW VIEW_PHOTO_INFORMATION
(ALBUM_ID,
  OWNER_ID,
  COVER_PHOTO_ID,
  ALBUM_NAME,
  ALBUM_CREATED_TIME,
  ALBUM_MODIFIED_TIME,
  ALBUM_LINK,
  ALBUM_VISIBILITY,
  PHOTO_ID,
  PHOTO_CAPTION,
  PHOTO_CREATED_TIME,
  PHOTO_MODIFIED_TIME,
  PHOTO_LINK)
 AS SELECT A.albumid, 
            O.userid,
            A.coverphotoid,
            A.albumname,
            A.time_created,
            A.time_modified,
            A.albumlink,
            A.visibility,
            P.photoid,
            P.caption,
            P.time_created,
            P.time_modified,
            P.photolink
 FROM Photo P
 LEFT JOIN Belongs B
 ON P.photoid = B.photoid
 LEFT JOIN Album A
 ON B.albumid = A.albumid
 LEFT JOIN Owns O
 ON O.albumid = A.albumid;


CREATE VIEW VIEW_TAG_INFORMATION
  (PHOTO_ID,
   TAG_SUBJECT_ID,
   TAG_CREATED_TIME,
   TAG_X_COORDINATE,
   TAG_Y_COORDINATE)
  AS SELECT T.photoid, 
            T.userid,
            T.time_tag,
            T.coo_x,
            T.coo_y
  FROM Tags T;


CREATE VIEW VIEW_EVENT_INFORMATION
    (EVENT_ID,
      EVENT_CREATOR_ID,
      EVENT_NAME,
      EVENT_TAGLINE,
      EVENT_DESCRIPTION,
      EVENT_HOST,
      EVENT_TYPE,
      EVENT_SUBTYPE,
      EVENT_LOCATION,
      EVENT_CITY,
      EVENT_STATE,
      EVENT_COUNTRY,
      EVENT_START_TIME,
      EVENT_END_TIME)
  AS SELECT E.eventid,
            C.creatorid,
            E.eventname,
            E.tagline,
            E.description,
            E.host,
            E.type,
            E.subtype,
            E.location,
            L.city,
            L.state,
            L.country,
            E.time_start,
            E.time_end
  FROM Event E
  LEFT JOIN  Creator C
  ON E.eventid = C.eventid
  LEFT JOIN Holds H
  ON H.eventid = E.eventid
  LEFT JOIN Location L
  ON L.locid = H.locid;











    

















-- CREATE VIEW VIEW_ARE_FRIENDS

-- CREATE VIEW VIEW_PHOTO_INFORMATION



-- CREATE VIEW VIEW_TAG_INFORMATION



-- CREATE VIEW VIEW_EVENT_INFORMATION