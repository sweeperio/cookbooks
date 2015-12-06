DO
$$
BEGIN
  IF NOT EXISTS (SELECT rolname FROM pg_roles WHERE rolname='vagrant') THEN
    CREATE ROLE vagrant WITH CREATEDB CREATEDB LOGIN PASSWORD 'developerPassword1'
  END IF;
END
$$
