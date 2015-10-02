-- SELECT UNIQUE K.USER_ID, L.locid 
-- FROM  keykholt.PUBLIC_USER_INFORMATION K, Location L
--    WHERE K.CURRENT_COUNTRY  = 'Middle Earth'
--    	AND K.CURRENT_STATE = 'Rivendell'
--    	AND	K.CURRENT_CITY = 'Rivendell'
--    	AND  L.COUNTRY  = 'Middle Earth'
--    	AND L.STATE = 'Rivendell'
--    	AND	L.CITY = 'Rivendell';


 SELECT COUNT(*)
 FROM  keykholt.PUBLIC_USER_INFORMATION K, Location L
    WHERE K.CURRENT_COUNTRY  = L.country
   	AND K.CURRENT_STATE = L.state
   	AND	K.CURRENT_CITY = L.city;