create table users
(
    id         integer primary key,
    discord_id bigint not null
);

create table shows
(
    id          integer primary key,
    name        text    not null,
    image_url   text    not null,
    description text    not null,
    mal_id      integer not null
);

create table subscriptions
(
    id      integer primary key,
    user_id integer not null,
    show_id integer not null,
    foreign key (user_id) references users (id),
    foreign key (show_id) references shows (id)
);

create table misc
(
    id               serial primary key,
    oai              text not null ,
    last_show_update timestamp not null
);

insert into misc (id, oai, last_show_update)
values (1, 'not-set', NOW());

alter table misc
    add constraint one_row_only
        check (id = 1);