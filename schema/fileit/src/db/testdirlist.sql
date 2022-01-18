/*

 Source Server         : filemedb
 Source Server Type    : PostgreSQL
 Source Server Version : 100001
 Source Host           : localhost:5432
 Source Catalog        : filemedb
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 100001
 File Encoding         : 65001

 Date: 06/01/2022
*/

-- Database: filemedb
DROP DATABASE IF EXISTS testdirlist;

-- DROP DATABASE filemedb;
--
-- TOC entry 2977 (class 1262 OID 24578)
-- Name: filemedb; Type: DATABASE; Schema: -; Owner: david
--

CREATE DATABASE testdirlist
	WITH OWNER = david
		ENCODING = 'UTF8'
		TABLESPACE = pg_default
		LC_COLLATE = 'en_US.UTF-8'
		LC_CTYPE = 'en_US.UTF-8'
		CONNECTION LIMIT = -1;
COMMENT ON DATABASE testdirlist
	IS 'Database for davids testdirlist  db';
