CREATE DATABASE IF NOT EXISTS `aion_ls` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `aion_gs` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `aion_cs` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `aion_ls`;
SOURCE /aion-sql/login-server/aion_ls.sql;

USE `aion_gs`;
SOURCE /aion-sql/game-server/aion_gs.sql;

USE `aion_cs`;
SOURCE /aion-sql/chat-server/aion_cs.sql;
