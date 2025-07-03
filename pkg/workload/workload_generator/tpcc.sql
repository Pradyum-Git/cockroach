-------Begin Transaction------
BEGIN;
INSERT INTO history(h_c_id, h_c_d_id, h_c_w_id, h_d_id, h_w_id, h_amount, h_date, h_data) VALUES (:-:|'h_c_id','INT8','NOT NULL','','','','','','INSERT'|:-:, :-:|'h_c_d_id','INT8','NOT NULL','','','','','','INSERT'|:-:, :-:|'h_c_w_id','INT8','NOT NULL','','','','','','INSERT'|:-:, :-:|'h_d_id','INT8','NOT NULL','','','','','','INSERT'|:-:, :-:|'h_w_id','INT8','NOT NULL','PRIMARY KEY','','','','','INSERT'|:-:, :-:|'h_amount','DECIMAL(6,2)','NULL','','','','','','INSERT'|:-:, :-:|'h_date','TIMESTAMP','NULL','','','','','','INSERT'|:-:, :-:|'h_data','VARCHAR(24)','NULL','','','','','','INSERT'|:-:);
UPDATE warehouse SET w_ytd = w_ytd + :-:|'w_ytd','DECIMAL(12,2)','NOT NULL','','','','','','UPDATE'|:-: WHERE w_id = :-:|'w_id','INT8','NOT NULL','PRIMARY KEY','','UNIQUE','','','WHERE'|:-: RETURNING w_name, w_street_1, w_street_2, w_city, w_state, w_zip;
UPDATE district SET d_ytd = d_ytd + :-:|'d_ytd','DECIMAL(12,2)','NOT NULL','','','','','','UPDATE'|:-: WHERE (d_w_id = :-:|'d_w_id','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE'|:-:) AND (d_id = :-:|'d_id','INT8','NOT NULL','PRIMARY KEY','','','','','WHERE'|:-:) RETURNING d_name, d_street_1, d_street_2, d_city, d_state, d_zip;
COMMIT;
-------End Transaction-------
