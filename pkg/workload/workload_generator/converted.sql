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

-- Transaction 4 --
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

-- Transaction 5 --
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

-- Transaction 6 --
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

