/*

 Source Server         : fileitdb
 Source Server Type    : PostgreSQL
 Source Server Version : 100001
 Source Host           : localhost:5432
 Source Catalog        : fileitdb;
 Source Schema         : fileit

 Target Server Type    : PostgreSQL
 Target Server Version : 100001
 File Encoding         : 65001

 Date: 06/01/2022

This sql script assumes a Temporary Database Table called

tbl_storage_tmp

This must be created first 

*/


-- Database: fileitdb;



/* Drop tables
*/
DROP TABLE IF EXISTS tbl_users CASCADE;
DROP TABLE IF EXISTS tbl_locations CASCADE;
DROP TABLE IF EXISTS tbl_formfactor CASCADE;
DROP TABLE IF EXISTS tbl_manufacturers CASCADE;
DROP TABLE IF EXISTS tbl_products CASCADE;
DROP TABLE IF EXISTS tbl_drives CASCADE;
DROP TABLE IF EXISTS tbl_storage CASCADE;

-- =================USERS======================
-- CREATE TABLE USERS
CREATE TABLE tbl_users
(
    id        serial
        constraint tbl_users_pk
            primary key,
    username varchar(20) NOT NULL DEFAULT 'admin',
    firstname varchar,
    lastname  varchar
);
comment on table tbl_users is 'Database users';
comment on column tbl_users.lastname is 'Lastname or Surname of User';
comment on column tbl_users.username is 'assigned username';
comment on column tbl_users.firstname is 'Enter First Name';
comment on column tbl_users.lastname is 'Enter Last Name or Surname';
-- Get list of usernames from tmp
INSERT INTO tbl_users (username)
SELECT DISTINCT s.username
FROM tbl_storage_tmp AS s
WHERE s.username IS NOT NULL
ORDER BY s.username;

-- =================LOCATIONS======================
-- Create locations TABLE
CREATE TABLE tbl_locations
(
    id    serial
            primary key,
    location varchar(20) not null
);
comment on table tbl_locations is 'Location ID or place where Drive is located';
-- Get location data from tmp
INSERT INTO tbl_locations (location)
SELECT DISTINCT s.location
FROM tbl_storage_tmp s
WHERE s.location IS NOT NULL
ORDER BY s.location;

-- =================FORMFACTOR======================
-- Create formfactor TABLE
CREATE TABLE tbl_formfactor
(
    id    serial
            primary key,
    formfactor varchar(5) not null
);
comment on table tbl_formfactor is 'Storage drive Form Factor size';
-- Get formfactor data from tmp
INSERT INTO tbl_formfactor (formfactor)
SELECT DISTINCT tbl_storage_tmp.form_factor
FROM tbl_storage_tmp
ORDER BY tbl_storage_tmp.form_factor;

-- =================MANUFACTURERS===================
-- Create Manufactureres TABLE
CREATE TABLE tbl_manufacturers
(
    id    serial
            primary key,
    manufacturer varchar(30) not null
);
comment on table tbl_manufacturers is 'Drive Manufacturers';
-- Get data for Manufactures
INSERT INTO tbl_manufacturers (manufacturer)
SELECT DISTINCT tbl_storage_tmp.manufacturer
FROM tbl_storage_tmp
ORDER BY tbl_storage_tmp.manufacturer;

-- =================PRODUCTS======================
-- Create Products table
CREATE TABLE tbl_products
(
    id              serial
        constraint tbl_products_pk
            primary key,
    model           varchar,
    size            integer,
    formfactor_id   integer
        constraint tbl_products_tbl_formfactor_id_fk
            references tbl_formfactor,
    manufacturer_id integer
        constraint tbl_products_tbl_maker_id_fk
            references tbl_manufacturers,
    firmware varchar
);
comment on table tbl_products is 'Drive Products';

-- Get Products data from tmp
INSERT INTO tbl_products (model, size, formfactor_id, manufacturer_id, firmware)
SELECT DISTINCT s.model,s.size_b, ff.id AS formfactor_id, tm.id AS manufacturer_id, s."Firmware"
FROM tbl_storage_tmp AS s
JOIN tbl_formfactor ff ON s.form_factor::text = ff.formfactor::text
JOIN tbl_manufacturers tm ON s.manufacturer::text = tm.manufacturer::text
ORDER BY s.model
;

-- =================DRIVES======================
-- Create Drives TABLE
CREATE TABLE tbl_drives
(
    id          serial
        primary key,
    drive_label varchar(5) not null,
    status      varchar,
    product_id  integer
      constraint tbl_storage_tbl_products_id_fk
            references tbl_products,
    serial_no   varchar(20),
    purchase_date timestamp
);
comment on table tbl_drives is 'List of active storage drives';
create unique index tbl_drives_drive_id_uindex
    on tbl_drives (drive_label);

-- Get data for drives
INSERT INTO tbl_drives (drive_label,status,product_id,serial_no)
SELECT DISTINCT
            tmp.drive_id AS drive_label,
            tmp.status AS status,
            pp.id AS product_id,
            tmp.serial_no as serial_no
FROM tbl_storage_tmp AS tmp
JOIN tbl_products  AS pp ON concat(tmp.model::text,tmp.size_b::text,tmp."Firmware") = concat(pp.model::text,pp.size::text,pp.firmware)
;

-- =================STORAGE======================
-- Create STORAGE TABLE
CREATE TABLE tbl_storage
(
    rec_id   serial
            primary key,
    drive_id        integer
        constraint tbl_storage_tbl_drives_id_fk
            references tbl_drives,
    partition_format  varchar,
    location_id       integer
        constraint tbl_storage_tbl_locations_id_fk
            references tbl_locations,
    deployed_date     varchar,
    last_check_date   varchar,
    user_id           integer
    constraint tbl_storage_tbl_user_id_fk
            references tbl_users
);
comment on table tbl_storage is 'List of Active drives and status';
comment on column tbl_storage.partition_format is 'Drive assigned Partition format';
;
-- Get data for Storage Media
INSERT INTO tbl_storage (drive_id,partition_format,location_id,deployed_date,last_check_date,user_id)
SELECT
       dd.id AS drive_id,
       s.part_type AS partition_format,
       ll.id AS location_id,
       s.deployed_date,
       s.last_check_date,
       uu.id AS user_id
FROM tbl_storage_tmp as s
JOIN tbl_locations AS ll ON s.location::text = ll.location::text
JOIN tbl_users AS uu on s.username = uu.username
JOIN tbl_drives AS dd on s.drive_id = dd.drive_label
;
