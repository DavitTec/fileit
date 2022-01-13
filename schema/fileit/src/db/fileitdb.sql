/*
 Source Server         : fileirdb
 Source Server Type    : PostgreSQL
 Source Server Version : 100001
 Source Host           : localhost:5432
 Source Catalog        : fileitdb
 Source Schema         : fileit

 Target Server Type    : PostgreSQL
 Target Server Version : 100001
 File Encoding         : 65001

 Date: 06/01/2022
*/

-- Database: fileirdb
DROP DATABASE IF EXISTS fileirdb;

-- DROP DATABASE fileirdb;
--
-- TOC entry 2977 (class 1262 OID 24578)
-- Name: fileirdb; Type: DATABASE; Schema: -; Owner: david
--

CREATE DATABASE fileirdb
	WITH OWNER = user
		ENCODING = 'UTF8'
		TABLESPACE = pg_default
		LC_COLLATE = 'en_US.UTF-8'
		LC_CTYPE = 'en_US.UTF-8'
		CONNECTION LIMIT = -1;

COMMENT ON DATABASE fileirdb IS 'Database for fileit db';
