/*
	qWat - QGIS Water Module

	SQL file :: installation pressure control auxiliary tables
*/

/* CREATE */
DROP TABLE IF EXISTS qwat_vl.pressurecontrol_type CASCADE;
CREATE TABLE qwat_vl.pressurecontrol_type (id integer not null, CONSTRAINT "pressurecontrol_type_pk" PRIMARY KEY (id) );

/* COLUMNS */
ALTER TABLE qwat_vl.pressurecontrol_type ADD COLUMN vl_active boolean default true;
ALTER TABLE qwat_vl.pressurecontrol_type ADD COLUMN value_en varchar(30) default '' ;
ALTER TABLE qwat_vl.pressurecontrol_type ADD COLUMN value_fr varchar(30) default '' ;
ALTER TABLE qwat_vl.pressurecontrol_type ADD COLUMN value_ro varchar(30) default '' ;

/* VALUES */
INSERT INTO qwat_vl.pressurecontrol_type (id,value_en,value_fr,value_ro) VALUES (2801,'reducer'     ,'réducteur'	,'reductor');
INSERT INTO qwat_vl.pressurecontrol_type (id,value_en,value_fr,value_ro) VALUES (2802,'pressure cut','coupe-pression','tăiere presiune');
INSERT INTO qwat_vl.pressurecontrol_type (id,value_en,value_fr,value_ro) VALUES (2803,'gathering'   ,'rassemblement'	,'colectare/captare');
 
