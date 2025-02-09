use anyhow::{anyhow, Result};
use migration::{Migrator, MigratorTrait};
use sea_orm::{Database, DatabaseConnection};
use std::path::PathBuf;

pub async  fn init_sqlite(path: impl Into<PathBuf>) -> Result<DatabaseConnection> {
    let path = path.into();
    let path_string = path.to_str().ok_or(anyhow!("Invalid db path"))?;
    let db = if path.exists() {
        Database::connect(path_string).await?
    } else {
        let path_with_permissions = format!("{}?mode=rwc", path_string);
        Database::connect(&path_with_permissions).await?
    };
    Migrator::up(&db, None).await?;
    Ok(db)
}

