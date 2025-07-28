-------Begin Transaction------
BEGIN;
SELECT t5_c1, t5_c5, t5_c6 FROM t5 WHERE ((t5_c3 = ":-:|'t5_c3','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t5'|:-:") AND (t5_c2 = ":-:|'t5_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t5'|:-:")) AND (t5_c4 = ":-:|'t5_c4','INT8','NULL','','','','','','WHERE','t5'|:-:") ORDER BY t5_c1 DESC LIMIT 45;
SELECT t3_c17, t3_c4, t3_c5, t3_c6 FROM t3 WHERE ((t3_c3 = ":-:|'t3_c3','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t3'|:-:") AND (t3_c2 = ":-:|'t3_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t3'|:-:")) AND (t3_c1 = ":-:|'t3_c1','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t3'|:-:");
SELECT t9_c5, t9_c6, t9_c8, t9_c9, t9_c7 FROM t9 WHERE ((t9_c3 = ":-:|'t9_c3','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t9'|:-:") AND (t9_c2 = ":-:|'t9_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t9'|:-:")) AND (t9_c1 = ":-:|'t9_c1','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t9'|:-:");
COMMIT;
-------End Transaction-------
-------Begin Transaction------
BEGIN;
SELECT t5_c1, t5_c5, t5_c6 FROM t5 WHERE ((t5_c3 = ":-:|'t5_c3','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t5'|:-:") AND (t5_c2 = ":-:|'t5_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t5'|:-:")) AND (t5_c4 = ":-:|'t5_c4','INT8','NULL','','','','','','WHERE','t5'|:-:") ORDER BY t5_c1 DESC LIMIT 41;
SELECT t3_c1, t3_c17, t3_c4, t3_c5 FROM t3 WHERE ((t3_c3 = ":-:|'t3_c3','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t3'|:-:") AND (t3_c2 = ":-:|'t3_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t3'|:-:")) AND (t3_c6 = ":-:|'t3_c6','VARCHAR(16)','NOT NULL','','','','','','WHERE','t3'|:-:") ORDER BY t3_c4 ASC;
SELECT t9_c5, t9_c6, t9_c8, t9_c9, t9_c7 FROM t9 WHERE ((t9_c3 = ":-:|'t9_c3','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t9'|:-:") AND (t9_c2 = ":-:|'t9_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t9'|:-:")) AND (t9_c1 = ":-:|'t9_c1','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t9'|:-:");
COMMIT;
-------End Transaction-------
-------Begin Transaction------
BEGIN;
SELECT t2_c11 FROM t2 WHERE (t2_c2 = ":-:|'t2_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t2'|:-:") AND (t2_c1 = ":-:|'t2_c1','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE','t2'|:-:");
SELECT count(DISTINCT t8_c1) FROM t9 JOIN t8 ON (t8_c2 = ":-:|'t8_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE',''|:-:") AND (t8_c1 = t9_c5) WHERE (((t9_c3 = ":-:|'t9_c3','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE',''|:-:") AND (t9_c2 = ":-:|'t9_c2','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE',''|:-:")) AND (t9_c1 BETWEEN (":-:|'t9_c1','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE',''|:-:") AND (":-:|'t9_c1','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE',''|:-:"))) AND (t8_c3 < ":-:|'t8_c3','INT8','NULL','','','','','','WHERE',''|:-:");
COMMIT;
-------End Transaction-------
