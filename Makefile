#----------------------------------------
# Makefile for multiple databases using Diesel
#----------------------------------------

# Load environment variables from .env file if present
ifneq (,$(wildcard .env))
    include .env
    export
endif


# Directories for migrations
MIGRATIONS_REMOTE = migrations/remote
MIGRATIONS_LOCAL  = migrations/local
SQLITE_DB_DIR     = $(dir $(LOCAL_DB_URL))  # Extracts directory from the database path

# Schema output files
SCHEMA_REMOTE = src/schema_remote.rs
SCHEMA_LOCAL  = src/schema_local.rs

.PHONY: help \
        migrate-remote migrate-local \
        schema-remote schema-local \
        migrate-all schema-all \
        init-migration-remote init-migration-local init-migration-all

help:
	@echo "Make targets for Diesel with two databases:"
	@echo "  migrate-remote        : Run migrations for Remote DB (uses .env or exported REMOTE_DB_URL)"
	@echo "  migrate-local         : Run migrations for Local DB"
	@echo "  schema-remote         : Generate Diesel schema for Remote DB"
	@echo "  schema-local          : Generate Diesel schema for Local DB"
	@echo "  migrate-all           : Run migrations for both Remote and Local"
	@echo "  schema-all            : Generate schema files for both Remote and Local"
	@echo "  init-migration-remote : Initialize a new migration for Remote DB (NAME=your_migration)"
	@echo "  init-migration-local  : Initialize a new migration for Local DB (NAME=your_migration)"
	@echo "  init-migration-all    : Initialize a new migration for both Remote and Local (NAME=your_migration)"

#----------------------------------------
# Remote Database (PostgreSQL) targets
#----------------------------------------
migrate-remote:
	@echo "Running Remote (PostgreSQL) migrations using REMOTE_DB_URL: $$REMOTE_DB_URL..."
	DATABASE_URL=$$REMOTE_DB_URL \
		diesel migration run \
		--migration-dir=$(MIGRATIONS_REMOTE)

schema-remote:
	@echo "Generating Remote (PostgreSQL) schema using REMOTE_DB_URL: $$REMOTE_DB_URL..."
	DATABASE_URL=$$REMOTE_DB_URL \
		diesel print-schema > $(SCHEMA_REMOTE)

init-migration-remote:
	@if [ -z "$(NAME)" ]; then echo "Error: Please specify NAME=your_migration"; exit 1; fi
	@mkdir -p $(MIGRATIONS_REMOTE)  # Ensures the directory exists
	@echo "Initializing new Remote (PostgreSQL) migration: $(NAME)"
	DATABASE_URL=$$REMOTE_DB_URL \
		diesel migration generate $(NAME) --migration-dir=$(MIGRATIONS_REMOTE)

#----------------------------------------
# Local Database (SQLite) targets
#----------------------------------------
migrate-local:
	@echo "Running Local (SQLite) migrations using LOCAL_DB_URL: $$LOCAL_DB_URL..."
	@mkdir -p $(SQLITE_DB_DIR)  # Ensure the directory exists before running Diesel
	@echo "Running Local (SQLite) migrations using LOCAL_DB_URL: $$LOCAL_DB_URL..."
	DATABASE_URL=$$LOCAL_DB_URL \
		diesel migration run \
		--migration-dir=$(MIGRATIONS_LOCAL)

schema-local:
	@echo "Generating Local (SQLite) schema using LOCAL_DB_URL: $$LOCAL_DB_URL..."
	DATABASE_URL=$$LOCAL_DB_URL \
		diesel print-schema > $(SCHEMA_LOCAL)

init-migration-local:
	@if [ -z "$(NAME)" ]; then echo "Error: Please specify NAME=your_migration"; exit 1; fi
	@mkdir -p $(MIGRATIONS_LOCAL)  # Ensures the directory exists
	@echo "Initializing new Local (SQLite) migration: $(NAME)"
	DATABASE_URL=$$LOCAL_DB_URL \
		diesel migration generate $(NAME) --migration-dir=$(MIGRATIONS_LOCAL)

#----------------------------------------
# Combined targets
#----------------------------------------
migrate-all: migrate-remote migrate-local

schema-all: schema-remote schema-local

init-migration-all:
	@if [ -z "$(NAME)" ]; then echo "Error: Please specify NAME=your_migration"; exit 1; fi
	@make init-migration-remote NAME=$(NAME)
	@make init-migration-local NAME=$(NAME)
