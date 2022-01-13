(
    rec_id          integer default nextval('tbl_storage_rec_id_seq'::regclass) not null
        constraint tbl_storage_pkey
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
