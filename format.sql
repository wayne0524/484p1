set colsep','
set pagesize 0;
set trimspool on;
set headsep off;
set linesize 1000;
spool userinfo.csv
	--SELECT PHOTO_ID, TAG_SUBJECT_ID FROM keykholt.PUBLIC_TAG_INFORMATION;
	SELECT PHOTO_ID, TAG_SUBJECT_ID FROM VIEW_TAG_INFORMATION;
spool off;