#!/bin/sh

set -e

sea-orm-cli migrate up
sea-orm-cli generate entity -o entity/src -l
