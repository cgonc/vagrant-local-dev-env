#! /bin/sh

export MYSQL_USER_NAME="root"
export MYSQL_PASSWORD="localapppasswd"
export MYSQL_DUMP_TARGET_SCHEMAS="local"
export MYSQL_DUMP_FILE_PREFIX="local"
export BACKUP_DIR="/var/lib/mysql/backups"
export BACKUP_KEEP_DAYS="7"
export BACKUP_KEEP_WEEKS="4"
export BACKUP_KEEP_MONTHS="6"

set -e

KEEP_DAYS=${BACKUP_KEEP_DAYS}
KEEP_WEEKS=$(expr $(((${BACKUP_KEEP_WEEKS} * 7) + 1)))
KEEP_MONTHS=$(expr $(((${BACKUP_KEEP_MONTHS} * 31) + 1)))

#Initialize dirs
mkdir -p "${BACKUP_DIR}/daily/" "${BACKUP_DIR}/weekly/" "${BACKUP_DIR}/monthly/"

#Initialize filename vers
DFILE="${BACKUP_DIR}/daily/${MYSQL_DUMP_FILE_PREFIX}-$(date +%Y%m%d-%H%M%S).sql.gz"
WFILE="${BACKUP_DIR}/weekly/${MYSQL_DUMP_FILE_PREFIX}-$(date +%G%V).sql.gz"
MFILE="${BACKUP_DIR}/monthly/${MYSQL_DUMP_FILE_PREFIX}-$(date +%Y%m).sql.gz"
#Create dump
echo "Creating dump of ${MYSQL_DUMP_TARGET_SCHEMAS} ..."
/usr/bin/mysqldump -u ${MYSQL_USER_NAME} --password=${MYSQL_PASSWORD} --databases ${MYSQL_DUMP_TARGET_SCHEMAS} | gzip -c > ${DFILE}

#Copy (hardlink) for each entry
ln -vf "${DFILE}" "${WFILE}"
ln -vf "${DFILE}" "${MFILE}"
#Clean old files
echo "Cleaning files older than ${KEEP_DAYS} days ..."
find "${BACKUP_DIR}/daily" -maxdepth 1 -mtime +${KEEP_DAYS} -name "${MYSQL_DUMP_FILE_PREFIX}-*.sql*" -exec rm -rf '{}' ';'
find "${BACKUP_DIR}/weekly" -maxdepth 1 -mtime +${KEEP_WEEKS} -name "${MYSQL_DUMP_FILE_PREFIX}-*.sql*" -exec rm -rf '{}' ';'
find "${BACKUP_DIR}/monthly" -maxdepth 1 -mtime +${KEEP_MONTHS} -name "${MYSQL_DUMP_FILE_PREFIX}-*.sql*" -exec rm -rf '{}' ';'

echo "SQL backup uploaded successfully"
