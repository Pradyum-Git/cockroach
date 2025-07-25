-- Transaction 1 --
SELECT i_price, i_name, i_data FROM item WHERE i_id IN ($1::INT8, $2::INT8, $3::INT8, $4::INT8) ORDER BY i_id;
  Placeholders:
    $1: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $2: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $3: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE
    $4: i_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

INSERT INTO "order"(o_id, o_d_id, o_w_id, o_c_id, o_entry_d, o_ol_cnt, o_all_local) VALUES ($1::INT8, $2::INT8, $3::INT8, $4::INT8, $5::TIMESTAMP, $6::INT8, $7::INT8);
  Placeholders:
    $1: o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: o_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: o_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $4: o_c_id (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $5: o_entry_d (TIMESTAMP), nullable=true, pk=false, unique=false, clause=INSERT
    $6: o_ol_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: o_all_local (INT8), nullable=true, pk=false, unique=false, clause=INSERT

INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES ($1::INT8, $2::INT8, $3::INT8, $4::INT8, $5::INT8, $6::INT8, $7::INT8, $8::DECIMAL(6,2), $9::CHAR(24)), ($10::INT8, $11::INT8, $12::INT8, $13::INT8, $14::INT8, $15::INT8, $16::INT8, $17::DECIMAL(6,2), $18::CHAR(24));
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

UPDATE stock SET s_quantity = CASE (s_i_id, s_w_id) WHEN ($1::INT8, $2::INT8) THEN $3::INT8 WHEN ($4::INT8, $5::INT8) THEN $6::INT8 WHEN ($7::INT8, $8::INT8) THEN $9::INT8 WHEN ($10::INT8, $11::INT8) THEN $12::INT8 WHEN ($13::INT8, $14::INT8) THEN $15::INT8 WHEN ($16::INT8, $17::INT8) THEN $18::INT8 WHEN ($19::INT8, $20::INT8) THEN $21::INT8 WHEN ($22::INT8, $23::INT8) THEN $24::INT8 WHEN ($25::INT8, $26::INT8) THEN $27::INT8 WHEN ($28::INT8, $29::INT8) THEN $30::INT8 WHEN ($31::INT8, $32::INT8) THEN $33::INT8 WHEN ($34::INT8, $35::INT8) THEN $36::INT8 WHEN ($37::INT8, $38::INT8) THEN $39::INT8 ELSE $40::INT8 END, s_ytd = CASE (s_i_id, s_w_id) WHEN ($41::INT8, $42::INT8) THEN $43::INT8 WHEN ($44::INT8, $45::INT8) THEN $46::INT8 WHEN ($47::INT8, $48::INT8) THEN $49::INT8 WHEN ($50::INT8, $51::INT8) THEN $52::INT8 WHEN ($53::INT8, $54::INT8) THEN $55::INT8 WHEN ($56::INT8, $57::INT8) THEN $58::INT8 WHEN ($59::INT8, $60::INT8) THEN $61::INT8 WHEN ($62::INT8, $63::INT8) THEN $64::INT8 WHEN ($65::INT8, $66::INT8) THEN $67::INT8 WHEN ($68::INT8, $69::INT8) THEN $70::INT8 WHEN ($71::INT8, $72::INT8) THEN $73::INT8 WHEN ($74::INT8, $75::INT8) THEN $76::INT8 WHEN ($77::INT8, $78::INT8) THEN $79::INT8 END, s_order_cnt = CASE (s_i_id, s_w_id) WHEN ($80::INT8, $81::INT8) THEN $82::INT8 WHEN ($83::INT8, $84::INT8) THEN $85::INT8 WHEN ($86::INT8, $87::INT8) THEN $88::INT8 WHEN ($89::INT8, $90::INT8) THEN $91::INT8 WHEN ($92::INT8, $93::INT8) THEN $94::INT8 WHEN ($95::INT8, $96::INT8) THEN $97::INT8 WHEN ($98::INT8, $99::INT8) THEN $100::INT8 WHEN ($101::INT8, $102::INT8) THEN $103::INT8 WHEN ($104::INT8, $105::INT8) THEN $106::INT8 WHEN ($107::INT8, $108::INT8) THEN $109::INT8 WHEN ($110::INT8, $111::INT8) THEN $112::INT8 WHEN ($113::INT8, $114::INT8) THEN $115::INT8 WHEN ($116::INT8, $117::INT8) THEN $118::INT8 END, s_remote_cnt = CASE (s_i_id, s_w_id) WHEN ($119::INT8, $120::INT8) THEN $121::INT8 WHEN ($122::INT8, $123::INT8) THEN $124::INT8 WHEN ($125::INT8, $126::INT8) THEN $127::INT8 WHEN ($128::INT8, $129::INT8) THEN $130::INT8 WHEN ($131::INT8, $132::INT8) THEN $133::INT8 WHEN ($134::INT8, $135::INT8) THEN $136::INT8 WHEN ($137::INT8, $138::INT8) THEN $139::INT8 WHEN ($140::INT8, $141::INT8) THEN $142::INT8 WHEN ($143::INT8, $144::INT8) THEN $145::INT8 WHEN ($146::INT8, $147::INT8) THEN $148::INT8 WHEN ($149::INT8, $150::INT8) THEN $151::INT8 WHEN ($152::INT8, $153::INT8) THEN $154::INT8 WHEN ($155::INT8, $156::INT8) THEN $157::INT8 END WHERE (s_i_id, s_w_id) IN (($158::INT8, $159::INT8),);
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $4: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $9: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $10: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $11: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $12: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $13: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $14: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $15: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $16: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $17: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $18: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $19: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $20: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $21: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $22: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $23: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $24: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $25: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $26: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $27: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $28: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $29: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $30: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $31: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $32: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $33: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $34: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $35: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $36: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $37: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $38: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $39: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $40: s_quantity (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $41: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $42: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $43: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $44: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $45: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $46: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $47: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $48: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $49: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $50: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $51: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $52: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $53: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $54: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $55: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $56: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $57: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $58: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $59: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $60: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $61: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $62: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $63: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $64: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $65: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $66: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $67: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $68: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $69: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $70: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $71: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $72: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $73: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $74: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $75: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $76: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $77: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $78: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $79: s_ytd (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $80: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $81: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $82: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $83: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $84: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $85: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $86: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $87: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $88: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $89: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $90: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $91: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $92: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $93: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $94: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $95: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $96: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $97: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $98: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $99: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $100: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $101: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $102: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $103: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $104: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $105: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $106: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $107: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $108: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $109: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $110: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $111: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $112: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $113: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $114: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $115: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $116: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $117: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $118: s_order_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $119: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $120: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $121: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $122: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $123: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $124: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $125: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $126: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $127: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $128: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $129: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $130: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $131: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $132: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $133: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $134: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $135: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $136: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $137: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $138: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $139: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $140: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $141: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $142: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $143: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $144: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $145: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $146: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $147: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $148: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $149: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $150: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $151: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $152: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $153: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $154: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $155: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $156: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $157: s_remote_cnt (INT8), nullable=true, pk=false, unique=false, clause=INSERT
    $158: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $159: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT w_tax FROM warehouse WHERE w_id = $1::INT8;
  Placeholders:
    $1: w_id (INT8), nullable=false, pk=true, unique=true, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1::INT8, $2::INT8), ($3::INT8, $4::INT8), ($5::INT8, $6::INT8), ($7::INT8, $8::INT8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $5: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $6: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $7: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $8: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_06 FROM stock WHERE (s_i_id, s_w_id) IN (($1::INT8, $2::INT8), ($3::INT8, $4::INT8)) ORDER BY s_i_id FOR UPDATE;
  Placeholders:
    $1: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: s_i_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $4: s_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

UPDATE district SET d_next_o_id = d_next_o_id + $1::INT8 WHERE (d_w_id = $2::INT8) AND (d_id = $3::INT8) RETURNING d_tax, d_next_o_id;
  Placeholders:
    $1: d_next_o_id (INT8), nullable=false, pk=false, unique=false, clause=UPDATE
    $2: d_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

SELECT c_discount, c_last, c_credit FROM customer WHERE ((c_w_id = $1::INT8) AND (c_d_id = $2::INT8)) AND (c_id = $3::INT8);
  Placeholders:
    $1: c_w_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $2: c_d_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE
    $3: c_id (INT8), nullable=false, pk=true, unique=false, clause=WHERE

INSERT INTO new_order(no_o_id, no_d_id, no_w_id) VALUES ($1::INT8, $2::INT8, $3::INT8);
  Placeholders:
    $1: no_o_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $2: no_d_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT
    $3: no_w_id (INT8), nullable=false, pk=true, unique=false, clause=INSERT

COMMIT;

