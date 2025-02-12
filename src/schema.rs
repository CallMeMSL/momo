// @generated automatically by Diesel CLI.

diesel::table! {
    kv (key) {
        key -> Text,
        value -> Text,
    }
}

diesel::table! {
    shows (id) {
        id -> Int4,
        name -> Text,
        image_url -> Text,
        description -> Text,
        mal_id -> Int4,
    }
}

diesel::table! {
    subscriptions (id) {
        id -> Int4,
        user_id -> Int4,
        show_id -> Int4,
    }
}

diesel::table! {
    users (id) {
        id -> Int4,
        discord_id -> Text,
    }
}

diesel::joinable!(subscriptions -> shows (show_id));
diesel::joinable!(subscriptions -> users (user_id));

diesel::allow_tables_to_appear_in_same_query!(
    kv,
    shows,
    subscriptions,
    users,
);
