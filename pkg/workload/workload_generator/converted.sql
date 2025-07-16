-- Transaction 1 --
SELECT d_next_o_id FROM district WHERE (d_w_id = $1) AND (d_id = $2);
  Placeholders:
    $1: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT count(DISTINCT s_i_id) FROM order_line JOIN stock ON (s_w_id = $1) AND (s_i_id = ol_i_id) WHERE (((ol_w_id = $2) AND (ol_d_id = $3)) AND (ol_o_id BETWEEN ($4 - $5) AND ($6 - $7))) AND (s_quantity < $8);
  Placeholders:
    $1: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=WHERE

COMMIT;

