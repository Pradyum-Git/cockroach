-- Transaction 1 --
SELECT o_id, o_entry_d, o_carrier_id FROM "order" WHERE ((o_w_id = $1) AND (o_d_id = $2)) AND (o_c_id = $3) ORDER BY o_id DESC LIMIT 16;
  Placeholders:
    $1: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=WHERE

SELECT c_balance, c_first, c_middle, c_last FROM customer WHERE ((c_w_id = $4) AND (c_d_id = $5)) AND (c_id = $6);
  Placeholders:
    $4: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_delivery_d FROM order_line WHERE ((ol_w_id = $7) AND (ol_d_id = $8)) AND (ol_o_id = $9);
  Placeholders:
    $7: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 2 --
SELECT o_id, o_entry_d, o_carrier_id FROM "order" WHERE ((o_w_id = $1) AND (o_d_id = $2)) AND (o_c_id = $3) ORDER BY o_id DESC LIMIT 17;
  Placeholders:
    $1: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=WHERE

SELECT c_id, c_balance, c_first, c_middle FROM customer WHERE ((c_w_id = $4) AND (c_d_id = $5)) AND (c_last = $6) ORDER BY c_first ASC;
  Placeholders:
    $4: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: c_last (VARCHAR(16)), nullable=false, pk=false, unique=false, clause=WHERE

SELECT ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_delivery_d FROM order_line WHERE ((ol_w_id = $7) AND (ol_d_id = $8)) AND (ol_o_id = $9);
  Placeholders:
    $7: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 3 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($40, $41), ($42, $43), ($44, $45), ($46, $47), ($48, $49)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $50 WHERE (d_w_id = $51) AND (d_id = $52) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $50: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $51: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $53) AND (c_d_id = $54)) AND (c_id = $55);
  Placeholders:
    $53: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $54: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $55: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($56, $57, $58);
  Placeholders:
    $56: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $57: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $58: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 4 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $28;
  Placeholders:
    $28: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 5 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $41;
  Placeholders:
    $41: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $42 WHERE (d_w_id = $43) AND (d_id = $44) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $42: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $43: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 6 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 7 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $28;
  Placeholders:
    $28: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $29 WHERE (d_w_id = $30) AND (d_id = $31) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $29: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $30: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($32, $33), ($34, $35), ($36, $37), ($38, $39), ($40, $41)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 8 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10), ($11, $12)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($13, $14, $15, $16, $17, $18, $19);
  Placeholders:
    $13: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($20, $21, $22, $23, $24, $25, $26, $27, $28), ($29, $30, $31, $32, $33, $34, $35, $36, $37);
  Placeholders:
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $34: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $38;
  Placeholders:
    $38: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 9 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 10 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 11 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 12 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($9, $10, $11, $12, $13, $14, $15);
  Placeholders:
    $9: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $10: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $13: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $14: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $15: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($16, $17, $18, $19, $20, $21, $22, $23, $24), ($25, $26, $27, $28, $29, $30, $31, $32, $33);
  Placeholders:
    $16: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $18: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $21: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $23: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $24: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $27: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $30: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $31: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $32: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $33: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $34;
  Placeholders:
    $34: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 13 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 14 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($40, $41), ($42, $43), ($44, $45), ($46, $47), ($48, $49)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $50;
  Placeholders:
    $50: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $51 WHERE (d_w_id = $52) AND (d_id = $53) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $51: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $52: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $54) AND (c_d_id = $55)) AND (c_id = $56);
  Placeholders:
    $54: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $55: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $56: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($57, $58, $59);
  Placeholders:
    $57: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $58: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $59: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 15 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $32 WHERE (d_w_id = $33) AND (d_id = $34) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $32: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $33: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 16 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($36, $37), ($38, $39), ($40, $41), ($42, $43)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $44;
  Placeholders:
    $44: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $45 WHERE (d_w_id = $46) AND (d_id = $47) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $45: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $46: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $48) AND (c_d_id = $49)) AND (c_id = $50);
  Placeholders:
    $48: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($51, $52, $53);
  Placeholders:
    $51: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $52: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 17 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $41;
  Placeholders:
    $41: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $42 WHERE (d_w_id = $43) AND (d_id = $44) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $42: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $43: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 18 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($3, $4), ($5, $6), ($7, $8), ($9, $10), ($11, $12)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($13, $14), ($15, $16), ($17, $18), ($19, $20)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $13: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $15: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $16: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $17: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $18: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $19: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $20: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $21: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $26: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($28, $29, $30, $31, $32, $33, $34, $35, $36), ($37, $38, $39, $40, $41, $42, $43, $44, $45);
  Placeholders:
    $28: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $33: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $34: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $38: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $39: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $40: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $41: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $42: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $43: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $44: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $45: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $46;
  Placeholders:
    $46: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $47 WHERE (d_w_id = $48) AND (d_id = $49) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $47: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $48: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $50) AND (c_d_id = $51)) AND (c_id = $52);
  Placeholders:
    $50: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($53, $54, $55);
  Placeholders:
    $53: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 19 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 20 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($4, $5), ($6, $7), ($8, $9), ($10, $11), ($12, $13)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $4: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($14, $15, $16, $17, $18, $19, $20);
  Placeholders:
    $14: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $19: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($21, $22, $23, $24, $25, $26, $27, $28, $29), ($30, $31, $32, $33, $34, $35, $36, $37, $38);
  Placeholders:
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $35: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 21 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($4, $5), ($6, $7), ($8, $9)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $4: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($10, $11, $12, $13, $14, $15, $16);
  Placeholders:
    $10: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $14: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $15: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($17, $18, $19, $20, $21, $22, $23, $24, $25), ($26, $27, $28, $29, $30, $31, $32, $33, $34);
  Placeholders:
    $17: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $18: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $22: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $23: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $24: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $27: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $31: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $32: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $33: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $34: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $35;
  Placeholders:
    $35: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $36 WHERE (d_w_id = $37) AND (d_id = $38) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $36: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $37: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $39) AND (c_d_id = $40)) AND (c_id = $41);
  Placeholders:
    $39: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($42, $43, $44);
  Placeholders:
    $42: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 22 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($28, $29), ($30, $31), ($32, $33)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $34;
  Placeholders:
    $34: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 23 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 24 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $32 WHERE (d_w_id = $33) AND (d_id = $34) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $32: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $33: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($35, $36), ($37, $38), ($39, $40), ($41, $42)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($43, $44), ($45, $46), ($47, $48), ($49, $50)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $51) AND (c_d_id = $52)) AND (c_id = $53);
  Placeholders:
    $51: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($54, $55, $56);
  Placeholders:
    $54: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 25 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 26 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($28, $29), ($30, $31), ($32, $33), ($34, $35)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $36;
  Placeholders:
    $36: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 27 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($6, $7), ($8, $9), ($10, $11)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $12: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($19, $20, $21, $22, $23, $24, $25, $26, $27), ($28, $29, $30, $31, $32, $33, $34, $35, $36);
  Placeholders:
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $33: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $34: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 28 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($4, $5), ($6, $7), ($8, $9), ($10, $11), ($12, $13)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $4: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($14, $15, $16, $17, $18, $19, $20);
  Placeholders:
    $14: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $19: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($21, $22, $23, $24, $25, $26, $27, $28, $29), ($30, $31, $32, $33, $34, $35, $36, $37, $38);
  Placeholders:
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $35: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 29 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 30 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 31 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $28;
  Placeholders:
    $28: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $29 WHERE (d_w_id = $30) AND (d_id = $31) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $29: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $30: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 32 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($3, $4), ($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($11, $12, $13, $14, $15, $16, $17);
  Placeholders:
    $11: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $15: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $16: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($18, $19, $20, $21, $22, $23, $24, $25, $26), ($27, $28, $29, $30, $31, $32, $33, $34, $35);
  Placeholders:
    $18: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $23: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $24: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $32: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $33: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $34: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $36;
  Placeholders:
    $36: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 33 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $40;
  Placeholders:
    $40: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 34 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $41;
  Placeholders:
    $41: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $42 WHERE (d_w_id = $43) AND (d_id = $44) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $42: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $43: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 35 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $40;
  Placeholders:
    $40: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 36 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $41;
  Placeholders:
    $41: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $42 WHERE (d_w_id = $43) AND (d_id = $44) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $42: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $43: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 37 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $4;
  Placeholders:
    $4: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $5 WHERE (d_w_id = $6) AND (d_id = $7) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $5: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $6: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $8) AND (c_d_id = $9)) AND (c_id = $10);
  Placeholders:
    $8: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 38 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($38, $39), ($40, $41), ($42, $43)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $44;
  Placeholders:
    $44: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $45 WHERE (d_w_id = $46) AND (d_id = $47) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $45: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $46: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $48) AND (c_d_id = $49)) AND (c_id = $50);
  Placeholders:
    $48: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($51, $52, $53);
  Placeholders:
    $51: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $52: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 39 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10), ($11, $12), ($13, $14)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($15, $16, $17, $18, $19, $20, $21);
  Placeholders:
    $15: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $18: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $20: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $21: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($22, $23, $24, $25, $26, $27, $28, $29, $30), ($31, $32, $33, $34, $35, $36, $37, $38, $39);
  Placeholders:
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $31: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $35: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $36: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $39: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $40;
  Placeholders:
    $40: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 40 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($38, $39), ($40, $41), ($42, $43), ($44, $45), ($46, $47)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $48 WHERE (d_w_id = $49) AND (d_id = $50) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $48: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $49: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $51) AND (c_d_id = $52)) AND (c_id = $53);
  Placeholders:
    $51: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($54, $55, $56);
  Placeholders:
    $54: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 41 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($38, $39), ($40, $41), ($42, $43)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $44;
  Placeholders:
    $44: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $45 WHERE (d_w_id = $46) AND (d_id = $47) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $45: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $46: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $48) AND (c_d_id = $49)) AND (c_id = $50);
  Placeholders:
    $48: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($51, $52, $53);
  Placeholders:
    $51: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $52: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 42 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $30 WHERE (d_w_id = $31) AND (d_id = $32) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $30: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $31: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $39) AND (c_d_id = $40)) AND (c_id = $41);
  Placeholders:
    $39: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($42, $43, $44);
  Placeholders:
    $42: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 43 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 44 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($11, $12, $13, $14, $15, $16, $17);
  Placeholders:
    $11: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $15: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $16: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($18, $19, $20, $21, $22, $23, $24, $25, $26), ($27, $28, $29, $30, $31, $32, $33, $34, $35);
  Placeholders:
    $18: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $23: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $24: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $32: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $33: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $34: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $36;
  Placeholders:
    $36: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 45 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $36;
  Placeholders:
    $36: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 46 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $40;
  Placeholders:
    $40: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 47 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 48 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($41, $42), ($43, $44), ($45, $46)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $47;
  Placeholders:
    $47: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $48 WHERE (d_w_id = $49) AND (d_id = $50) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $48: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $49: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $51) AND (c_d_id = $52)) AND (c_id = $53);
  Placeholders:
    $51: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($54, $55, $56);
  Placeholders:
    $54: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 49 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 50 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $32 WHERE (d_w_id = $33) AND (d_id = $34) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $32: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $33: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($35, $36), ($37, $38), ($39, $40), ($41, $42), ($43, $44)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 51 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($35, $36), ($37, $38), ($39, $40), ($41, $42), ($43, $44)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $45;
  Placeholders:
    $45: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $46 WHERE (d_w_id = $47) AND (d_id = $48) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $46: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $47: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $49) AND (c_d_id = $50)) AND (c_id = $51);
  Placeholders:
    $49: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($52, $53, $54);
  Placeholders:
    $52: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 52 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($37, $38), ($39, $40), ($41, $42)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $43;
  Placeholders:
    $43: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $44 WHERE (d_w_id = $45) AND (d_id = $46) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $44: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $45: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $47) AND (c_d_id = $48)) AND (c_id = $49);
  Placeholders:
    $47: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($50, $51, $52);
  Placeholders:
    $50: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $51: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $52: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 53 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 54 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 55 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 56 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($37, $38), ($39, $40), ($41, $42), ($43, $44), ($45, $46)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $47;
  Placeholders:
    $47: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $48 WHERE (d_w_id = $49) AND (d_id = $50) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $48: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $49: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $51) AND (c_d_id = $52)) AND (c_id = $53);
  Placeholders:
    $51: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($54, $55, $56);
  Placeholders:
    $54: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 57 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($39, $40), ($41, $42), ($43, $44), ($45, $46)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $47;
  Placeholders:
    $47: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $48 WHERE (d_w_id = $49) AND (d_id = $50) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $48: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $49: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $51) AND (c_d_id = $52)) AND (c_id = $53);
  Placeholders:
    $51: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($54, $55, $56);
  Placeholders:
    $54: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 58 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($6, $7), ($8, $9), ($10, $11)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($12, $13, $14, $15, $16, $17, $18);
  Placeholders:
    $12: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($19, $20, $21, $22, $23, $24, $25, $26, $27), ($28, $29, $30, $31, $32, $33, $34, $35, $36);
  Placeholders:
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $33: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $34: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 59 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $30 WHERE (d_w_id = $31) AND (d_id = $32) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $30: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $31: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($39, $40), ($41, $42), ($43, $44), ($45, $46), ($47, $48)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $49) AND (c_d_id = $50)) AND (c_id = $51);
  Placeholders:
    $49: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($52, $53, $54);
  Placeholders:
    $52: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 60 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($38, $39), ($40, $41), ($42, $43), ($44, $45), ($46, $47)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $48;
  Placeholders:
    $48: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $49 WHERE (d_w_id = $50) AND (d_id = $51) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $49: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $50: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $52) AND (c_d_id = $53)) AND (c_id = $54);
  Placeholders:
    $52: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $54: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($55, $56, $57);
  Placeholders:
    $55: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $57: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 61 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $41;
  Placeholders:
    $41: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $42 WHERE (d_w_id = $43) AND (d_id = $44) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $42: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $43: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 62 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($11, $12, $13, $14, $15, $16, $17);
  Placeholders:
    $11: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $15: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $16: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($18, $19, $20, $21, $22, $23, $24, $25, $26), ($27, $28, $29, $30, $31, $32, $33, $34, $35);
  Placeholders:
    $18: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $23: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $24: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $32: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $33: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $34: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $36;
  Placeholders:
    $36: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 63 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $31;
  Placeholders:
    $31: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 64 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($28, $29), ($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $38;
  Placeholders:
    $38: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 65 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $40;
  Placeholders:
    $40: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 66 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 67 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($28, $29), ($30, $31), ($32, $33), ($34, $35)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $36;
  Placeholders:
    $36: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $37 WHERE (d_w_id = $38) AND (d_id = $39) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $37: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $38: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 68 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10), ($11, $12)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($13, $14, $15, $16, $17, $18, $19);
  Placeholders:
    $13: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($20, $21, $22, $23, $24, $25, $26, $27, $28), ($29, $30, $31, $32, $33, $34, $35, $36, $37);
  Placeholders:
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $34: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $38;
  Placeholders:
    $38: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 69 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 70 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($6, $7), ($8, $9), ($10, $11), ($12, $13), ($14, $15)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $15: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($16, $17, $18, $19, $20, $21, $22);
  Placeholders:
    $16: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $18: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $21: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $22: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($23, $24, $25, $26, $27, $28, $29, $30, $31), ($32, $33, $34, $35, $36, $37, $38, $39, $40);
  Placeholders:
    $23: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $27: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $28: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $31: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $32: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $35: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $36: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $37: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $39: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $40: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $41;
  Placeholders:
    $41: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $42 WHERE (d_w_id = $43) AND (d_id = $44) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $42: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $43: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 71 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 72 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 73 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10), ($11, $12), ($13, $14)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($15, $16), ($17, $18), ($19, $20), ($21, $22), ($23, $24)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $15: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $16: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $17: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $18: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $19: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $20: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $21: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $22: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $23: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $24: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($25, $26, $27, $28, $29, $30, $31);
  Placeholders:
    $25: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $27: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $30: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $31: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($32, $33, $34, $35, $36, $37, $38, $39, $40), ($41, $42, $43, $44, $45, $46, $47, $48, $49);
  Placeholders:
    $32: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $35: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $36: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $37: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $39: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $40: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $41: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $46: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $47: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $48: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $49: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $50;
  Placeholders:
    $50: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $51 WHERE (d_w_id = $52) AND (d_id = $53) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $51: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $52: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $54) AND (c_d_id = $55)) AND (c_id = $56);
  Placeholders:
    $54: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $55: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $56: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($57, $58, $59);
  Placeholders:
    $57: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $58: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $59: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 74 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($40, $41), ($42, $43), ($44, $45)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $46 WHERE (d_w_id = $47) AND (d_id = $48) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $46: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $47: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $49) AND (c_d_id = $50)) AND (c_id = $51);
  Placeholders:
    $49: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($52, $53, $54);
  Placeholders:
    $52: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 75 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $37;
  Placeholders:
    $37: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $38 WHERE (d_w_id = $39) AND (d_id = $40) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $38: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $39: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $41) AND (c_d_id = $42)) AND (c_id = $43);
  Placeholders:
    $41: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($44, $45, $46);
  Placeholders:
    $44: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 76 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $28;
  Placeholders:
    $28: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 77 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($28, $29), ($30, $31), ($32, $33)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $34;
  Placeholders:
    $34: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 78 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10), ($11, $12), ($13, $14)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($15, $16), ($17, $18), ($19, $20), ($21, $22)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $15: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $16: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $17: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $18: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $19: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $20: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $21: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $22: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $23: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $28: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($30, $31, $32, $33, $34, $35, $36, $37, $38), ($39, $40, $41, $42, $43, $44, $45, $46, $47);
  Placeholders:
    $30: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $35: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $39: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $40: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $41: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $44: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $45: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $46: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $47: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $48;
  Placeholders:
    $48: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $49 WHERE (d_w_id = $50) AND (d_id = $51) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $49: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $50: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $52) AND (c_d_id = $53)) AND (c_id = $54);
  Placeholders:
    $52: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $54: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($55, $56, $57);
  Placeholders:
    $55: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $57: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 79 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $41 WHERE (d_w_id = $42) AND (d_id = $43) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $41: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $42: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $44) AND (c_d_id = $45)) AND (c_id = $46);
  Placeholders:
    $44: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($47, $48, $49);
  Placeholders:
    $47: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 80 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 81 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($4, $5), ($6, $7), ($8, $9)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $4: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($10, $11), ($12, $13), ($14, $15)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $15: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($16, $17, $18, $19, $20, $21, $22);
  Placeholders:
    $16: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $18: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $21: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $22: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($23, $24, $25, $26, $27, $28, $29, $30, $31), ($32, $33, $34, $35, $36, $37, $38, $39, $40);
  Placeholders:
    $23: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $27: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $28: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $31: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $32: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $35: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $36: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $37: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $39: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $40: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $41;
  Placeholders:
    $41: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $42 WHERE (d_w_id = $43) AND (d_id = $44) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $42: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $43: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $45) AND (c_d_id = $46)) AND (c_id = $47);
  Placeholders:
    $45: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($48, $49, $50);
  Placeholders:
    $48: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $49: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 82 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($9, $10, $11, $12, $13, $14, $15);
  Placeholders:
    $9: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $10: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $13: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $14: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $15: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($16, $17, $18, $19, $20, $21, $22, $23, $24), ($25, $26, $27, $28, $29, $30, $31, $32, $33);
  Placeholders:
    $16: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $18: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $21: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $23: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $24: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $27: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $30: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $31: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $32: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $33: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $34;
  Placeholders:
    $34: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 83 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($39, $40), ($41, $42), ($43, $44)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $45;
  Placeholders:
    $45: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $46 WHERE (d_w_id = $47) AND (d_id = $48) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $46: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $47: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $49) AND (c_d_id = $50)) AND (c_id = $51);
  Placeholders:
    $49: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($52, $53, $54);
  Placeholders:
    $52: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 84 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN (($37, $38), ($39, $40), ($41, $42), ($43, $44)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $45;
  Placeholders:
    $45: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $46 WHERE (d_w_id = $47) AND (d_id = $48) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $46: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $47: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $49) AND (c_d_id = $50)) AND (c_id = $51);
  Placeholders:
    $49: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($52, $53, $54);
  Placeholders:
    $52: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 85 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($3, $4), ($5, $6), ($7, $8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($9, $10, $11, $12, $13, $14, $15);
  Placeholders:
    $9: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $10: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $13: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $14: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $15: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($16, $17, $18, $19, $20, $21, $22, $23, $24), ($25, $26, $27, $28, $29, $30, $31, $32, $33);
  Placeholders:
    $16: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $18: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $21: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $23: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $24: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $27: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $28: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $29: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $30: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $31: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $32: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $33: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $34;
  Placeholders:
    $34: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 86 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $31 WHERE (d_w_id = $32) AND (d_id = $33) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $31: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $32: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $40) AND (c_d_id = $41)) AND (c_id = $42);
  Placeholders:
    $40: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($43, $44, $45);
  Placeholders:
    $43: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $45: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 87 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $38;
  Placeholders:
    $38: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 88 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($4, $5), ($6, $7), ($8, $9), ($10, $11), ($12, $13)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $4: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($14, $15, $16, $17, $18, $19, $20);
  Placeholders:
    $14: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $19: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($21, $22, $23, $24, $25, $26, $27, $28, $29), ($30, $31, $32, $33, $34, $35, $36, $37, $38);
  Placeholders:
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $35: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 89 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $39;
  Placeholders:
    $39: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 90 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($5, $6), ($7, $8), ($9, $10), ($11, $12), ($13, $14)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN (($15, $16), ($17, $18), ($19, $20), ($21, $22)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $15: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $16: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $17: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $18: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $19: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $20: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $21: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $22: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $23: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $28: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($30, $31, $32, $33, $34, $35, $36, $37, $38), ($39, $40, $41, $42, $43, $44, $45, $46, $47);
  Placeholders:
    $30: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $34: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $35: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $38: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $39: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $40: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $41: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $44: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $45: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $46: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $47: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $48;
  Placeholders:
    $48: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $49 WHERE (d_w_id = $50) AND (d_id = $51) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $49: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $50: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $52) AND (c_d_id = $53)) AND (c_id = $54);
  Placeholders:
    $52: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $54: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($55, $56, $57);
  Placeholders:
    $55: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $57: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 91 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $38;
  Placeholders:
    $38: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 92 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $28;
  Placeholders:
    $28: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $35 WHERE (d_w_id = $36) AND (d_id = $37) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $35: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $36: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $38) AND (c_d_id = $39)) AND (c_id = $40);
  Placeholders:
    $38: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($41, $42, $43);
  Placeholders:
    $41: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $42: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 93 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36), ($37, $38), ($39, $40)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($41, $42), ($43, $44), ($45, $46)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $47;
  Placeholders:
    $47: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $48 WHERE (d_w_id = $49) AND (d_id = $50) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $48: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $49: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $51) AND (c_d_id = $52)) AND (c_id = $53);
  Placeholders:
    $51: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($54, $55, $56);
  Placeholders:
    $54: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 94 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($29, $30), ($31, $32), ($33, $34)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $29: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN (($35, $36), ($37, $38), ($39, $40), ($41, $42), ($43, $44)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $45;
  Placeholders:
    $45: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $46 WHERE (d_w_id = $47) AND (d_id = $48) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $46: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $47: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $49) AND (c_d_id = $50)) AND (c_id = $51);
  Placeholders:
    $49: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($52, $53, $54);
  Placeholders:
    $52: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 95 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $30 WHERE (d_w_id = $31) AND (d_id = $32) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $30: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $31: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($33, $34), ($35, $36), ($37, $38)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($39, $40), ($41, $42), ($43, $44), ($45, $46), ($47, $48)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $49) AND (c_d_id = $50)) AND (c_id = $51);
  Placeholders:
    $49: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($52, $53, $54);
  Placeholders:
    $52: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $53: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $54: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 96 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $36 WHERE (d_w_id = $37) AND (d_id = $38) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $36: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $37: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $39) AND (c_d_id = $40)) AND (c_id = $41);
  Placeholders:
    $39: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($42, $43, $44);
  Placeholders:
    $42: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $43: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $44: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 97 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($4, $5, $6, $7, $8, $9, $10);
  Placeholders:
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($11, $12, $13, $14, $15, $16, $17, $18, $19), ($20, $21, $22, $23, $24, $25, $26, $27, $28);
  Placeholders:
    $11: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $16: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $29;
  Placeholders:
    $29: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35), ($36, $37), ($38, $39)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $40 WHERE (d_w_id = $41) AND (d_id = $42) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $40: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $41: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $43) AND (c_d_id = $44)) AND (c_id = $45);
  Placeholders:
    $43: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($46, $47, $48);
  Placeholders:
    $46: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $48: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 98 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($28, $29), ($30, $31), ($32, $33)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN (($34, $35), ($36, $37), ($38, $39), ($40, $41)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $42;
  Placeholders:
    $42: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $43 WHERE (d_w_id = $44) AND (d_id = $45) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $43: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $44: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $46) AND (c_d_id = $47)) AND (c_id = $48);
  Placeholders:
    $46: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($49, $50, $51);
  Placeholders:
    $49: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $51: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 99 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($3, $4, $5, $6, $7, $8, $9);
  Placeholders:
    $3: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $8: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($10, $11, $12, $13, $14, $15, $16, $17, $18), ($19, $20, $21, $22, $23, $24, $25, $26, $27);
  Placeholders:
    $10: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $12: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $15: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $20: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $24: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN (($28, $29), ($30, $31), ($32, $33), ($34, $35), ($36, $37)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $38;
  Placeholders:
    $38: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 100 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $30;
  Placeholders:
    $30: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $31 WHERE (d_w_id = $32) AND (d_id = $33) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $31: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $32: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($34, $35), ($36, $37), ($38, $39), ($40, $41), ($42, $43)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN (($44, $45), ($46, $47), ($48, $49), ($50, $51)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $44: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $52) AND (c_d_id = $53)) AND (c_id = $54);
  Placeholders:
    $52: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $54: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($55, $56, $57);
  Placeholders:
    $55: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $57: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 101 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4, $5) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $5: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($6, $7, $8, $9, $10, $11, $12);
  Placeholders:
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $12: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($13, $14, $15, $16, $17, $18, $19, $20, $21), ($22, $23, $24, $25, $26, $27, $28, $29, $30);
  Placeholders:
    $13: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $18: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $26: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $27: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $30: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($31, $32), ($33, $34), ($35, $36)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($37, $38), ($39, $40), ($41, $42), ($43, $44), ($45, $46)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $47;
  Placeholders:
    $47: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $48 WHERE (d_w_id = $49) AND (d_id = $50) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $48: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $49: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $50: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $51) AND (c_d_id = $52)) AND (c_id = $53);
  Placeholders:
    $51: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $53: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($54, $55, $56);
  Placeholders:
    $54: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $55: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $56: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 102 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2, $3, $4) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($5, $6, $7, $8, $9, $10, $11);
  Placeholders:
    $5: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $6: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $8: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $9: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $10: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $11: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($12, $13, $14, $15, $16, $17, $18, $19, $20), ($21, $22, $23, $24, $25, $26, $27, $28, $29);
  Placeholders:
    $12: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $17: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $18: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $20: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $21: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $25: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $26: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($30, $31), ($32, $33), ($34, $35)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $30: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $31: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN (($36, $37), ($38, $39), ($40, $41)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $36: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $37: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $40: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $42;
  Placeholders:
    $42: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $43 WHERE (d_w_id = $44) AND (d_id = $45) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $43: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $44: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $46) AND (c_d_id = $47)) AND (c_id = $48);
  Placeholders:
    $46: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $47: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($49, $50, $51);
  Placeholders:
    $49: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $50: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $51: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

-- Transaction 103 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1, $2) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN (($3, $4), ($5, $6), ($7, $8), ($9, $10), ($11, $12)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($13, $14, $15, $16, $17, $18, $19);
  Placeholders:
    $13: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $14: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $16: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $17: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $18: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($20, $21, $22, $23, $24, $25, $26, $27, $28), ($29, $30, $31, $32, $33, $34, $35, $36, $37);
  Placeholders:
    $20: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $22: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $23: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $24: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $25: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $26: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $27: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $28: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT
    $29: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $30: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $31: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $32: ol_number (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $33: ol_i_id (INT8), nullable=false, pk=false, unique=false, clause=INSERT
    $34: ol_supply_w_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $35: ol_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $36: ol_amount (DECIMAL(6,2)), nullable=true, pk=false, unique=false, clause=INSERT
    $37: ol_dist_info (CHAR(24)), nullable=true, pk=false, unique=false, clause=INSERT

SELECT w_tax FROM warehouse WHERE w_id = $38;
  Placeholders:
    $38: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $39 WHERE (d_w_id = $40) AND (d_id = $41) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $39: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $40: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $41: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $42) AND (c_d_id = $43)) AND (c_id = $44);
  Placeholders:
    $42: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $44: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($45, $46, $47);
  Placeholders:
    $45: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $46: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $47: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

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

UPDATE warehouse SET w_ytd = w_ytd + $9 WHERE w_id = $10 RETURNING w_name, w_street_1, w_street_2, w_city, w_state, w_zip;
  Placeholders:
    $9: w_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $10: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT c_id FROM customer WHERE ((c_w_id = $11) AND (c_d_id = $12)) AND (c_last = $13) ORDER BY c_first ASC;
  Placeholders:
    $11: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: c_last (VARCHAR(16)), nullable=false, pk=false, unique=false, clause=WHERE

UPDATE district SET d_ytd = d_ytd + $14 WHERE (d_w_id = $15) AND (d_id = $16) RETURNING d_name, d_street_1, d_street_2, d_city, d_state, d_zip;
  Placeholders:
    $14: d_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $15: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $16: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

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

UPDATE warehouse SET w_ytd = w_ytd + $9 WHERE w_id = $10 RETURNING w_name, w_street_1, w_street_2, w_city, w_state, w_zip;
  Placeholders:
    $9: w_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $10: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

UPDATE district SET d_ytd = d_ytd + $11 WHERE (d_w_id = $12) AND (d_id = $13) RETURNING d_name, d_street_1, d_street_2, d_city, d_state, d_zip;
  Placeholders:
    $11: d_ytd (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=UPDATE
    $12: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

-- Transaction 106 --
SELECT d_next_o_id FROM district WHERE (d_w_id = $1) AND (d_id = $2);
  Placeholders:
    $1: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT count(DISTINCT s_i_id) FROM order_line JOIN stock ON (s_w_id = $3) AND (s_i_id = ol_i_id) WHERE (((ol_w_id = $4) AND (ol_d_id = $5)) AND (ol_o_id BETWEEN ($6) AND ($7))) AND (s_quantity < $8);
  Placeholders:
    $3: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=WHERE

COMMIT;

-- Transaction 107 --
SELECT sum(ol_amount) FROM order_line WHERE ((ol_w_id = $1) AND (ol_d_id = $2)) AND (ol_o_id = $3);
  Placeholders:
    $1: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

DELETE FROM new_order WHERE (no_w_id = $4) AND ((no_d_id, no_o_id) IN (($5, $6), ($7, $8), ($9, $10)));
  Placeholders:
    $4: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE "order" SET o_carrier_id = $11 WHERE (o_w_id = $12) AND ((o_d_id, o_id) IN (($13, $14), ($15, $16), ($17, $18))) RETURNING o_d_id, o_c_id;
  Placeholders:
    $11: o_carrier_id (INT8), nullable=true, pk=false, unique=false, clause=UPDATE
    $12: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $13: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $15: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $16: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $17: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $18: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE order_line SET ol_delivery_d = $19 WHERE (ol_w_id = $20) AND ((ol_d_id, ol_o_id) IN (($21, $22), ($23, $24), ($25, $26), ($27, $28), ($29, $30)));
  Placeholders:
    $19: ol_delivery_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=UPDATE
    $20: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $21: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $22: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $23: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $24: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $25: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $26: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $27: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $28: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT no_o_id FROM new_order WHERE (no_w_id = $31) AND (no_d_id = $32) ORDER BY no_o_id ASC LIMIT 39 FOR UPDATE;
  Placeholders:
    $31: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

