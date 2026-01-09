#!/bin/bash
# mysql-backup.sh
# Periodic backup script for MariaDB in G-Shell

USER_HOME="${1:-$HOME}"
MYSQL_DIR="${USER_HOME}/.mysql_root"
BACKUP_DIR="${MYSQL_DIR}/backup"
PRIMARY_BACKUP="${BACKUP_DIR}/mysql-backup.tar.gz"
FAILSAFE_BACKUP="${BACKUP_DIR}/mysql-backup-failsafe.tar.gz"
MYSQL_DATA_DIR="/var/lib/mysql"

# Ensure backup directory exists
mkdir -p "${BACKUP_DIR}"

echo "[$(date)] Starting MySQL backup..."

# Load password from .env
if [ -f "${MYSQL_DIR}/.env" ]; then
    export $(grep -v '^#' "${MYSQL_DIR}/.env" | xargs)
fi

# We use physical backup (tar) because it captures everything and is faster for restore on boot.
# To do a clean physical backup, we should ideally flush tables or stop the service.
# However, for a simple dev environment, we'll try to stop it briefly.

if command -v systemctl >/dev/null; then
    sudo systemctl stop mariadb || sudo systemctl stop mysql
fi

# Rotate to failsafe
if [ -f "${PRIMARY_BACKUP}" ]; then
    echo "Rotating primary backup to failsafe..."
    cp "${PRIMARY_BACKUP}" "${FAILSAFE_BACKUP}"
fi

# Create new primary backup
echo "Creating new primary backup..."
sudo tar -czf "${PRIMARY_BACKUP}" -C / var/lib/mysql

if command -v systemctl >/dev/null; then
    sudo systemctl start mariadb || sudo systemctl start mysql
fi

echo "[$(date)] MySQL backup completed: ${PRIMARY_BACKUP}"
