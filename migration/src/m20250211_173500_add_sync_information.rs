use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .table(Misc::Table)
                    .if_not_exists()
                    .col(pk_auto(Misc::Id))
                    .col(string(Misc::Key))
                    .col(string(Misc::Value))
                    .to_owned(),
            )
            .await?;
        manager.alter_table(
            Table::alter()
                .table(Show::Table)
                .add_column(integer(Show::MalId))
                .to_owned(),
        ).await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(Misc::Table).to_owned())
            .await?;
        manager.alter_table(
            Table::alter()
                .table(Show::Table)
                .drop_column(Show::MalId)
                .to_owned(),
        ).await
    }
}

#[derive(DeriveIden)]
enum Misc {
    Table,
    Id,
    Key,
    Value,
}

#[derive(DeriveIden)]
enum Show {
    Table,
    MalId,
}
