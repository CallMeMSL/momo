use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .table(User::Table)
                    .if_not_exists()
                    .col(pk_auto(User::Id))
                    .col(string(User::DiscordToken))
                    .to_owned(),
            )
            .await?;
        manager
            .create_table(
                Table::create()
                    .table(Show::Table)
                    .if_not_exists()
                    .col(pk_auto(Show::Id))
                    .col(string(Show::Name))
                    .col(string(Show::ImageUrl))
                    .col(string(Show::Description))
                    .to_owned(),
            )
            .await?;
        manager
            .create_table(
                Table::create()
                    .table(Subscription::Table)
                    .if_not_exists()
                    .col(pk_auto(Subscription::Id))
                    .col(integer(Subscription::UserId))
                    .foreign_key(
                        ForeignKey::create()
                            .name("FK_subscription_user_id")
                            .from(Subscription::Table, Subscription::UserId)
                            .to(User::Table, User::Id),
                    )
                    .col(integer(Subscription::ShowId))
                    .foreign_key(
                        ForeignKey::create()
                            .name("FK_subscription_show_id")
                            .from(Subscription::Table, Subscription::ShowId)
                            .to(Show::Table, Show::Id),
                    )
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(User::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum User {
    Table,
    Id,
    DiscordToken,
}

#[derive(DeriveIden)]
enum Show {
    Table,
    Id,
    Name,
    ImageUrl,
    Description,
}

#[derive(DeriveIden)]
enum Subscription {
    Table,
    Id,
    UserId,
    ShowId,
}
