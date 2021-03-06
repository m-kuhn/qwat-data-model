/*
	qWat - QGIS Water Module
	
	SQL file :: watertype table
*/

/* CREATE */
CREATE TABLE qwat_vl.watertype () INHERITS (qwat_vl.value_list_base);
ALTER TABLE qwat_vl.watertype ADD CONSTRAINT vl_watertype_pk PRIMARY KEY (id);
COMMENT ON TABLE qwat_vl.watertype IS 'Water type table, with SIRE code.';

/* COLUMNS */
ALTER TABLE qwat_vl.watertype ADD COLUMN code_sire smallint;

/* VALUES */
INSERT INTO qwat_vl.watertype (id, value_en, value_fr, value_ro ) VALUES (101, 'other', 'autre', 'alta');
INSERT INTO qwat_vl.watertype (id, value_en, value_fr, value_ro ) VALUES (102, 'unknown', 'inconnu', 'necunoscută');
INSERT INTO qwat_vl.watertype (id, value_en, value_fr, value_ro ) VALUES (103, 'to be determined', 'à déterminer', 'de determinat');

INSERT INTO qwat_vl.watertype (id, value_en, value_fr, value_ro, code_sire) VALUES (1501, 'raw'      , 'brute'       , 'brută', 	0 );
INSERT INTO qwat_vl.watertype (id, value_en, value_fr, value_ro, code_sire) VALUES (1502, 'drinkable', 'potable'     , 'potabilă', 	1 );
INSERT INTO qwat_vl.watertype (id, value_en, value_fr, value_ro, code_sire) VALUES (1503, 'industrial', 'industrielle','industrială',	2 );
