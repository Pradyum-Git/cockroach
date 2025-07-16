-------Begin Transaction------
BEGIN;
SELECT o_id, o_entry_d, o_carrier_id FROM "order" WHERE ((o_w_id = ":-:'o_w_id','WHERE':-:") AND (o_d_id = ":-:'o_d_id','WHERE':-:")) AND (o_c_id = ":-:'o_c_id','WHERE':-:") ORDER BY o_id DESC LIMIT 80;
SELECT c_balance, c_first, c_middle, c_last FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
SELECT ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_delivery_d FROM order_line WHERE ((ol_w_id = ":-:'ol_w_id','WHERE':-:") AND (ol_d_id = ":-:'ol_d_id','WHERE':-:")) AND (ol_o_id = ":-:'ol_o_id','WHERE':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT o_id, o_entry_d, o_carrier_id FROM "order" WHERE ((o_w_id = ":-:'o_w_id','WHERE':-:") AND (o_d_id = ":-:'o_d_id','WHERE':-:")) AND (o_c_id = ":-:'o_c_id','WHERE':-:") ORDER BY o_id DESC LIMIT 81;
SELECT c_id, c_balance, c_first, c_middle FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_last = ":-:'c_last','WHERE':-:") ORDER BY c_first ASC;
SELECT ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_delivery_d FROM order_line WHERE ((ol_w_id = ":-:'ol_w_id','WHERE':-:") AND (ol_d_id = ":-:'ol_d_id','WHERE':-:")) AND (ol_o_id = ":-:'ol_o_id','WHERE':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_04 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_09 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_07 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_03 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_08 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_10 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_01 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_05 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT i_price, i_name, i_data FROM item WHERE i_id IN (":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:", ":-:'i_id','WHERE':-:") ORDER BY i_id;
SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:"), (":-:'s_i_id','WHERE':-:", ":-:'s_w_id','WHERE':-:")) ORDER BY s_i_id FOR UPDATE;
INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES (":-:'o_id','INSERT':-:", ":-:'o_d_id','INSERT':-:", ":-:'o_w_id','INSERT':-:", ":-:'o_c_id','INSERT':-:", ":-:'o_entry_d','INSERT':-:", ":-:'o_ol_cnt','INSERT':-:", ":-:'o_all_local','INSERT':-:");
INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:"), (":-:'ol_o_id','INSERT':-:", ":-:'ol_d_id','INSERT':-:", ":-:'ol_w_id','INSERT':-:", ":-:'ol_number','INSERT':-:", ":-:'ol_i_id','INSERT':-:", ":-:'ol_supply_w_id','INSERT':-:", ":-:'ol_quantity','INSERT':-:", ":-:'ol_amount','INSERT':-:", ":-:'ol_dist_info','INSERT':-:");
SELECT w_tax FROM warehouse WHERE w_id = ":-:'w_id','WHERE':-:";
UPDATE district SET d_next_o_id = d_next_o_id + ":-:'d_next_o_id','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_tax, d_next_o_id;
SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_id = ":-:'c_id','WHERE':-:");
INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES (":-:'no_o_id','INSERT':-:", ":-:'no_d_id','INSERT':-:", ":-:'no_w_id','INSERT':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
INSERT INTO history(h_c_id, h_c_d_id, h_c_w_id, h_d_id, h_w_id, h_amount, h_date, h_data) VALUES (":-:'h_c_id','INSERT':-:", ":-:'h_c_d_id','INSERT':-:", ":-:'h_c_w_id','INSERT':-:", ":-:'h_d_id','INSERT':-:", ":-:'h_w_id','INSERT':-:", ":-:'h_amount','INSERT':-:", ":-:'h_date','INSERT':-:", ":-:'h_data','INSERT':-:");
UPDATE warehouse SET w_ytd = w_ytd + ":-:'w_ytd','UPDATE':-:" WHERE w_id = ":-:'w_id','WHERE':-:" RETURNING w_name, w_street_1, w_street_2, w_city, w_state, w_zip;
SELECT c_id FROM customer WHERE ((c_w_id = ":-:'c_w_id','WHERE':-:") AND (c_d_id = ":-:'c_d_id','WHERE':-:")) AND (c_last = ":-:'c_last','WHERE':-:") ORDER BY c_first ASC;
UPDATE district SET d_ytd = d_ytd + ":-:'d_ytd','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_name, d_street_1, d_street_2, d_city, d_state, d_zip;
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
INSERT INTO history(h_c_id, h_c_d_id, h_c_w_id, h_d_id, h_w_id, h_amount, h_date, h_data) VALUES (":-:'h_c_id','INSERT':-:", ":-:'h_c_d_id','INSERT':-:", ":-:'h_c_w_id','INSERT':-:", ":-:'h_d_id','INSERT':-:", ":-:'h_w_id','INSERT':-:", ":-:'h_amount','INSERT':-:", ":-:'h_date','INSERT':-:", ":-:'h_data','INSERT':-:");
UPDATE warehouse SET w_ytd = w_ytd + ":-:'w_ytd','UPDATE':-:" WHERE w_id = ":-:'w_id','WHERE':-:" RETURNING w_name, w_street_1, w_street_2, w_city, w_state, w_zip;
UPDATE district SET d_ytd = d_ytd + ":-:'d_ytd','UPDATE':-:" WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:") RETURNING d_name, d_street_1, d_street_2, d_city, d_state, d_zip;
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT d_next_o_id FROM district WHERE (d_w_id = ":-:'d_w_id','WHERE':-:") AND (d_id = ":-:'d_id','WHERE':-:");
SELECT count(DISTINCT s_i_id) FROM order_line JOIN stock ON (s_w_id = ":-:'s_w_id','WHERE':-:") AND (s_i_id = ol_i_id) WHERE (((ol_w_id = ":-:'ol_w_id','WHERE':-:") AND (ol_d_id = ":-:'ol_d_id','WHERE':-:")) AND (ol_o_id BETWEEN (":-:'ol_o_id','WHERE':-:" - ":-:'ol_o_id','WHERE':-:") AND (":-:'ol_o_id','WHERE':-:" - ":-:'ol_o_id','WHERE':-:"))) AND (s_quantity < ":-:'s_quantity','WHERE':-:");
COMMIT;
-------Begin Transaction------
-------Begin Transaction------
BEGIN;
SELECT sum(ol_amount) FROM order_line WHERE ((ol_w_id = ":-:'ol_w_id','WHERE':-:") AND (ol_d_id = ":-:'ol_d_id','WHERE':-:")) AND (ol_o_id = ":-:'ol_o_id','WHERE':-:");
DELETE FROM new_order WHERE (no_w_id = ":-:'no_w_id','WHERE':-:") AND ((no_d_id, no_o_id) IN ((":-:'no_d_id','WHERE':-:", ":-:'no_o_id','WHERE':-:"), (":-:'no_d_id','WHERE':-:", ":-:'no_o_id','WHERE':-:"), (":-:'no_d_id','WHERE':-:", ":-:'no_o_id','WHERE':-:")));
UPDATE "order" SET o_carrier_id = ":-:'o_carrier_id','UPDATE':-:" WHERE (o_w_id = ":-:'o_w_id','WHERE':-:") AND ((o_d_id, o_id) IN ((":-:'o_d_id','WHERE':-:", ":-:'o_id','WHERE':-:"), (":-:'o_d_id','WHERE':-:", ":-:'o_id','WHERE':-:"), (":-:'o_d_id','WHERE':-:", ":-:'o_id','WHERE':-:"), (":-:'o_d_id','WHERE':-:", ":-:'o_id','WHERE':-:"), (":-:'o_d_id','WHERE':-:", ":-:'o_id','WHERE':-:"), (":-:'o_d_id','WHERE':-:", ":-:'o_id','WHERE':-:"))) RETURNING o_d_id, o_c_id;
UPDATE order_line SET ol_delivery_d = ":-:'ol_delivery_d','UPDATE':-:" WHERE (ol_w_id = ":-:'ol_w_id','WHERE':-:") AND ((ol_d_id, ol_o_id) IN ((":-:'ol_d_id','WHERE':-:", ":-:'ol_o_id','WHERE':-:"), (":-:'ol_d_id','WHERE':-:", ":-:'ol_o_id','WHERE':-:"), (":-:'ol_d_id','WHERE':-:", ":-:'ol_o_id','WHERE':-:"), (":-:'ol_d_id','WHERE':-:", ":-:'ol_o_id','WHERE':-:")));
SELECT no_o_id FROM new_order WHERE (no_w_id = ":-:'no_w_id','WHERE':-:") AND (no_d_id = ":-:'no_d_id','WHERE':-:") ORDER BY no_o_id ASC LIMIT 38 FOR UPDATE;
COMMIT;
-------Begin Transaction------
