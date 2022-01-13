/*

 Source Server         : fileitdb
 Source Server Type    : PostgreSQL
 Source Server Version : 100014
 Source Host           : localhost:5432
 Source Catalog        : fileitdb
 Source Schema         : fileit

 Target Server Type    : PostgreSQL
 Target Server Version : 100014
 File Encoding         : 65001

 Date: 06/01/2022
*/
-- ----------------------------
-- Table structure for tstorage
-- ----------------------------
DROP TABLE IF EXISTS tbl_storage_tmp;

CREATE TABLE tbl_storage_tmp
(
    rec_id  serial not null
            primary key,
    drive_id        varchar,
    manufacturer    varchar,
    model           varchar,
    form_factor     varchar,
    size_b          integer,
    serial_no       varchar,
    part_type       varchar,
    status          varchar,
    deployed_date   varchar,
    last_check_date varchar,
    location        varchar,
    username        varchar,
    "Firmware"      varchar
);

