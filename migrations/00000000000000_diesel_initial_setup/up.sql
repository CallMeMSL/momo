CREATE OR REPLACE FUNCTION diesel_manage_updated_at(_tbl regclass) RETURNS VOID AS
$$
BEGIN
    EXECUTE format('CREATE TRIGGER set_updated_at BEFORE UPDATE ON %s
                    FOR EACH ROW EXECUTE PROCEDURE diesel_set_updated_at()', _tbl);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION diesel_set_updated_at() RETURNS trigger AS
$$
BEGIN
    IF (
        NEW IS DISTINCT FROM OLD AND
        NEW.updated_at IS NOT DISTINCT FROM OLD.updated_at
        ) THEN
        NEW.updated_at := current_timestamp;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create table users
(
    id         serial primary key,
    discord_id text not null
);

create table shows
(
    id          serial primary key,
    name        text    not null,
    image_url   text    not null,
    description text    not null,
    mal_id      integer not null
);

create table subscriptions
(
    id      serial primary key,
    user_id integer not null,
    show_id integer not null,
    foreign key (user_id) references users (id),
    foreign key (show_id) references shows (id)
);

create table kv
(
    key   text primary key,
    value text not null
);


