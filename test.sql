-- -- CREATE TAG TABLE ---------
-- CREATE TABLE Tags
-- 	(photoid VARCHAR2(100),
-- 	 userid VARCHAR2(100),
-- 	 time_tag TIMESTAMP(6),
-- 	 coo_x INTEGER,
-- 	 coo_y INTEGER,
-- 	 --FOREIGN KEY(photoid) REFERENCES Photo ON DELETE CASCADE,
-- 	 --FOREIGN KEY(userid) REFERENCES Users ON DELETE CASCADE,
-- 	 PRIMARY KEY(photoid, userid));

-- ------- Load DATA -------
-- INSERT INTO Tags(photoid,  userid,          time_tag,          coo_x ,            coo_y)
-- SELECT           PHOTO_ID, TAG_SUBJECT_ID,  TAG_CREATED_TIME , TAG_X_COORDINATE,  TAG_Y_COORDINATE FROM
-- keykholt.PUBLIC_TAG_INFORMATION;



-- ------ CREATE TAG VIEW -------
-- CREATE VIEW VIEW_TAG_INFORMATION
--   (PHOTO_ID,
--    TAG_SUBJECT_ID,
--    TAG_CREATED_TIME,
--    TAG_X_COORDINATE,
--    TAG_Y_COORDINATE)
--   AS SELECT T.photoid, 
--             T.userid,
--             T.time_tag,
--             T.coo_x,
--             T.coo_y
--   FROM Tags T;




-- SELECT count(*) FROM(
-- SELECT * FROM keykholt.PUBLIC_TAG_INFORMATION
-- MINUS
-- SELECT * FROM VIEW_TAG_INFORMATION
-- );

-----------------------------------------------------------------
----------------------Test for Friendship-------------------------------------------
---------------------------------------------------------------
(SELECT user1_ID, user2_ID FROM keykholt.PUBLIC_ARE_FRIENDS WHERE user1_ID <> user2_ID
    UNION
   SELECT user2_ID, user1_ID FROM keykholt.PUBLIC_ARE_FRIENDS WHERE user1_ID <> user2_ID
)
MINUS
(SELECT user1_ID, user2_ID FROM VIEW_ARE_FRIENDS
  UNION
 SELECT user2_ID, user1_ID FROM VIEW_ARE_FRIENDS
);


(SELECT user1_ID, user2_ID FROM VIEW_ARE_FRIENDS
UNION
SELECT user2_ID, user1_ID FROM VIEW_ARE_FRIENDS)
MINUS
(
      SELECT user1_ID, user2_ID FROM keykholt.PUBLIC_ARE_FRIENDS WHERE user1_ID <> user2_ID
       UNION 
      SELECT user2_ID, user1_ID FROM keykholt.PUBLIC_ARE_FRIENDS WHERE user1_ID <> user2_ID
);


-- Check that VIEW_ARE_FRIENDS does not contain duplicate pairs or reversed pairs.
SELECT (
          (SELECT 2 * COUNT(*) AS C1 FROM VIEW_ARE_FRIENDS)
        - 
           (SELECT COUNT(*) AS C1 FROM 
            (SELECT user1_ID, user2_ID FROM VIEW_ARE_FRIENDS
             UNION 
             SELECT user2_ID, user1_ID FROM VIEW_ARE_FRIENDS))
      ) AS diff FROM dual;


------------------------------Check for all commands-----------------------------------
-- START createTables.sql
-- START loadData.sql
-- START createViews.sql
-- -- add in the sql files for any tests to check views here.
-- START dropViews.sql
-- START dropTables.sql







