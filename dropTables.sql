DROP TABLE Receiver;
DROP TABLE Sender;

-- ALTER TABLE Messages
-- 	DROP COLUMN sender;

DROP TABLE Messages;
DROP TABLE Attend;
DROP TABLE Education;
DROP TABLE Belongs;
DROP TABLE Owns;
DROP TABLE Tags;

ALTER TABLE Photo
	DROP COLUMN Albumid;

DROP TABLE Album;
DROP TABLE Photo;
DROP TABLE Participants;
DROP TABLE Creator;
DROP TABLE Holds;
DROP TABLE Event;
DROP TABLE Hometown;
DROP TABLE Currenthome;
DROP TABLE Location;
DROP TABLE Users;