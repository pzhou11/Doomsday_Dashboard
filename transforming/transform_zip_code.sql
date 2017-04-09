DROP TABLE zip_code_reference_ca;

CREATE TABLE zip_code_reference_ca as
SELECT *
FROM zip_code_reference
WHERE state='CA'
;


