INSERT INTO aion_ls.gameservers (id, mask, password)
VALUES (1, '*', '1234')
ON DUPLICATE KEY UPDATE
  mask = '*',
  password = '1234';
