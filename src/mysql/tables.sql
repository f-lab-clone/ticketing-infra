-- auto-generated definition
create table user
(
    id           int auto_increment
        primary key,
    name         varchar(255) not null,
    email        varchar(255) not null,
    pw           varchar(255) not null,
    phone_number varchar(25)  null,
    created_at   datetime     not null,
    updated_at   datetime     not null
);

create index email_index on user (email);

-- auto-generated definition
create table event
(
    id                     int auto_increment
        primary key,
    name                   varchar(255) not null,
    max_attendees          int          not null,
    total_attendees        int          not null,
    start_date             datetime     not null,
    end_date               datetime     null,
    reservation_start_time datetime     not null,
    reservation_end_time   datetime     not null,
    created_at             datetime     not null,
    updated_at             datetime     not null
);

-- auto-generated definition
create table reservation
(
    id           int auto_increment
        primary key,
    event_id     int          not null,
    user_id      int          not null,
    name         varchar(255) null,
    phone_number varchar(25)  null,
    post_code    int          null,
    address      varchar(255) null,
    created_at   datetime     not null,
    updated_at   datetime     not null,
    constraint fk_reservation_to_event
        foreign key (event_id) references event (id)
            on delete cascade,
    constraint fk_reservation_to_user
        foreign key (user_id) references user (id)
            on delete cascade
);

-- auto-generated definition
create table bookmark
(
    id         int auto_increment
        primary key,
    event_id   int      not null,
    user_id    int      not null,
    created_at datetime not null,
    updated_at datetime not null,
    constraint fk_bookmark_to_event
        foreign key (event_id) references event (id)
            on delete cascade,
    constraint fk_bookmark_to_user
        foreign key (user_id) references user (id)
            on delete cascade
);

