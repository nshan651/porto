#!/bin/sh
set -e

echo "Enabling External Storage app..."

# Enable the external storage app
php /var/www/html/occ app:enable files_external

# Create the mount if it doesn't exist
if ! php /var/www/html/occ files_external:list | grep -q "/Pix"; then
    echo "Creating external storage mount..."
    php /var/www/html/occ files_external:create \
        "Pix" \
        "local" \
        "null::null" \
        -c datadir="/pix"
else
    echo "External storage mount already exists"
fi

echo "External storage configured successfully!"

# Install/enable the calendar app.
php /var/www/html/occ app:install calendar
