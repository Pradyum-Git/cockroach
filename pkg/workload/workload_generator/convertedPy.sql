-- Transaction 1 --
UPDATE customer SET c_delivery_cnt = c_delivery_cnt + $1::INT8, c_balance = c_balance + CASE c_d_id WHEN $2::INT8 THEN $3::DECIMAL(12,2) WHEN $4::INT8 THEN $5::DECIMAL(12,2) WHEN $6::INT8 THEN $7::DECIMAL(12,2) WHEN $8::INT8 THEN $9::DECIMAL(12,2) WHEN $10::INT8 THEN $11::DECIMAL(12,2) WHEN $12::INT8 THEN $13::DECIMAL(12,2) WHEN $14::INT8 THEN $15::DECIMAL(12,2) WHEN $16::INT8 THEN $17::DECIMAL(12,2) WHEN $18::INT8 THEN $19::DECIMAL(12,2) WHEN $20::INT8 THEN $21::DECIMAL(12,2) END WHERE (c_w_id = $22::INT8) AND ((c_d_id, c_id) IN (($23::INT8, $24::INT8), ($25::INT8, $26::INT8), ($27::INT8, $28::INT8)));
  Placeholders:
    $1: c_delivery_cnt (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $4: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $5: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $6: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $7: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $8: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $9: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $10: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $11: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $12: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $13: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $14: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $15: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $16: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $17: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $18: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $19: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $20: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $21: c_balance (DECIMAL(12,2)), nullable=false, pk=false, unique=false, clause=INSERT
    $22: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $23: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $24: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $25: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $26: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $27: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $28: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT sum(ol_amount) FROM order_line WHERE ((ol_w_id = $1::INT8) AND (ol_d_id = $2::INT8)) AND (ol_o_id = $3::INT8);
  Placeholders:
    $1: ol_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: ol_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: ol_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

DELETE FROM new_order WHERE (no_w_id = $1::INT8) AND ((no_d_id, no_o_id) IN (($2::INT8, $3::INT8), ($4::INT8, $5::INT8), ($6::INT8, $7::INT8)));
  Placeholders:
    $1: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE "order" SET o_carrier_id = $1::INT8 WHERE (o_w_id = $2::INT8) AND ((o_d_id, o_id) IN (($3::INT8, $4::INT8), ($5::INT8, $6::INT8), ($7::INT8, $8::INT8), ($9::INT8, $10::INT8))) RETURNING o_d_id, o_c_id;
  Placeholders:
    $1: o_carrier_id (INT8), nullable=true, pk=false, unique=false, clause=UPDATE
    $2: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $10: o_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE order_line SET ol_delivery_d = $1::TIMESTAMP WHERE (ol_w_id = $2::INT8) AND ((ol_d_id, ol_o_id) IN (($3::INT8, $4::INT8), ($5::INT8, $6::INT8), ($7::INT8, $8::INT8), ($9::INT8, $10::INT8)));
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

SELECT no_o_id FROM new_order WHERE (no_w_id = $1::INT8) AND (no_d_id = $2::INT8) ORDER BY no_o_id ASC LIMIT 25 FOR UPDATE;
  Placeholders:
    $1: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

COMMIT;

