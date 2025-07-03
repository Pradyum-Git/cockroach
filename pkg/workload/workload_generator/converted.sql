-- Transaction 1 --
SELECT o_id, o_entry_d, o_carrier_id FROM "order" WHERE ((o_w_id = $1) AND (o_d_id = $2)) AND (o_c_id = $3) ORDER BY o_id DESC LIMIT 16;
  Placeholders:
    $1: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=WHERE

SELECT c_balance, c_first, c_middle, c_last FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_delivery_d FROM order_line WHERE ((ol_w_id = $1) AND (ol_d_id = $2)) AND (ol_o_id = $3);
  Placeholders:
    $1: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 2 --
SELECT o_id, o_entry_d, o_carrier_id FROM "order" WHERE ((o_w_id = $1) AND (o_d_id = $2)) AND (o_c_id = $3) ORDER BY o_id DESC LIMIT 17;
  Placeholders:
    $1: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=WHERE

SELECT c_id, c_balance, c_first, c_middle FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_last = $3) ORDER BY c_first ASC;
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_last (VARCHAR(16)), nullable=false, pk=false, unique=false, clause=WHERE

SELECT ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_delivery_d FROM order_line WHERE ((ol_w_id = $1) AND (ol_d_id = $2)) AND (ol_o_id = $3);
  Placeholders:
    $1: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 3 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 4 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 5 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 6 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 7 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 8 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 9 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 10 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 11 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 12 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 13 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 14 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 15 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 16 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 17 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 18 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 19 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 20 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 21 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 22 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 23 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 24 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 25 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 26 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 27 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 28 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 29 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 30 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 31 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 32 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 33 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 34 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 35 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 36 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 37 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 38 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 39 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 40 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 41 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 42 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 43 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 44 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 45 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 46 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 47 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 48 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 49 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 50 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 51 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 52 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 53 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 54 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 55 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 56 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 57 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 58 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 59 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 60 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 61 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 62 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 63 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 64 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 65 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 66 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 67 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 68 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 69 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 70 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 71 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 72 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 73 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 74 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 75 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 76 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 77 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 78 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 79 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 80 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 81 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 82 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 83 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 84 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 85 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 86 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 87 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 88 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 89 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 90 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 91 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 92 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 93 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 94 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 95 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 96 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 97 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 98 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 99 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 100 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 101 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 102 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 103 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($1, $2), ($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1, $2, $3, $4, $5, $6, $7);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9), ($10, $11, $12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $1: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $6: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $9: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $1;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_id = $3);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1, $2, $3);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 104 --
INSERT INTO history(h_c_id, h_c_d_id, h_c_w_id, h_d_id, h_w_id, h_amount, h_date, h_data) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);
  Placeholders:
    $1: h_c_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $2: h_c_d_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $3: h_c_w_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $4: h_d_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $5: h_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: h_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $7: h_date (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: h_data (VARCHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

UPDATE warehouse SET w_ytd = w_ytd + $1 WHERE w_id = $2 RETURNING w_name, w_street_1, w_street_2, w_city, w_state, w_zip;
  Placeholders:
    $1: w_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT c_id FROM customer WHERE ((c_w_id = $1) AND (c_d_id = $2)) AND (c_last = $3) ORDER BY c_first ASC;
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_last (VARCHAR(16)), nullable=false, pk=false, unique=false, clause=WHERE

UPDATE district SET d_ytd = d_ytd + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_name, d_street_1, d_street_2, d_city, d_state, d_zip;
  Placeholders:
    $1: d_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 105 --
INSERT INTO history(h_c_id, h_c_d_id, h_c_w_id, h_d_id, h_w_id, h_amount, h_date, h_data) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);
  Placeholders:
    $1: h_c_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $2: h_c_d_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $3: h_c_w_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $4: h_d_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $5: h_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: h_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $7: h_date (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: h_data (VARCHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

UPDATE warehouse SET w_ytd = w_ytd + $1 WHERE w_id = $2 RETURNING w_name, w_street_1, w_street_2, w_city, w_state, w_zip;
  Placeholders:
    $1: w_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_ytd = d_ytd + $1 WHERE (d_w_id = $2) AND (d_id = $3) RETURNING d_name, d_street_1, d_street_2, d_city, d_state, d_zip;
  Placeholders:
    $1: d_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 106 --
SELECT d_next_o_id FROM district WHERE (d_w_id = $1) AND (d_id = $2);
  Placeholders:
    $1: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT count(DISTINCT s_i_id) FROM order_line JOIN stock ON (s_w_id = $1) AND (s_i_id = ol_i_id) WHERE (((ol_w_id = $2) AND (ol_d_id = $3)) AND (ol_o_id BETWEEN ($4) AND ($5))) AND (s_quantity < $6);
  Placeholders:
    $1: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=WHERE

COMMIT;

-- Transaction 107 --
SELECT sum(ol_amount) FROM order_line WHERE ((ol_w_id = $1) AND (ol_d_id = $2)) AND (ol_o_id = $3);
  Placeholders:
    $1: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

DELETE FROM new_order WHERE (no_w_id = $1) AND ((no_d_id, no_o_id) IN (($2, $3), ($4, $5), ($6, $7)));
  Placeholders:
    $1: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE "order" SET o_carrier_id = $1 WHERE (o_w_id = $2) AND ((o_d_id, o_id) IN (($3, $4), ($5, $6), ($7, $8))) RETURNING o_d_id, o_c_id;
  Placeholders:
    $1: o_carrier_id (INT8), nullable=true, pk=false, unique=false, clause=UPDATE
    $2: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE order_line SET ol_delivery_d = $1 WHERE (ol_w_id = $2) AND ((ol_d_id, ol_o_id) IN (($3, $4), ($5, $6), ($7, $8), ($9, $10), ($11, $12)));
  Placeholders:
    $1: ol_delivery_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=UPDATE
    $2: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT no_o_id FROM new_order WHERE (no_w_id = $1) AND (no_d_id = $2) ORDER BY no_o_id ASC LIMIT 39 FOR UPDATE;
  Placeholders:
    $1: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

