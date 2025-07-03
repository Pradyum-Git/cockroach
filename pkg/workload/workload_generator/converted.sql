-- Transaction 1 --
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

