#!/bin/sh
set -e

cd /var/www/wordpress

if [ -f "wp-config.php" ]; then
    echo "WordPress already exists - skipping installation"
else
    ###############################################################
    # 1. Download WordPress core files (only on first run)
    ###############################################################
    echo "Downloading WordPress..."
    wp core download --allow-root
 	###############################################################
    # 2. Generate wp-config.php using environment variables
    ###############################################################
    echo "Configuring wp-config.php..."
    wp core config \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER_NAME" \
        --dbpass="$DB_USER_PW" \
        --dbhost="$DB_HOST:$DB_PORT" \
        --dbprefix='wp_' \
        --allow-root
	###############################################################
    # 3. Install WordPress (site + admin account)
    ###############################################################
    echo "Installing WordPress..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Inception Project" \
        --admin_user="$WP_ADMIN_NAME" \
        --admin_password="$WP_ADMIN_PW" \
        --admin_email="$WP_ADMIN_MAIL" \
        --allow-root
	###############################################################
    # 4. Create an additional non-admin user
    ###############################################################
    if [ -n "$WP_USER_NAME" ] && [ -n "$WP_USER_MAIL" ] && [ -n "$WP_USER_PW" ]; then
        echo "Creating extra user $WP_USER_NAME..."
        wp user create "$WP_USER_NAME" "$WP_USER_MAIL" \
            --role='subscriber' \
            --user_pass="$WP_USER_PW" \
            --allow-root
    fi

    echo "WordPress installation finished."
fi

exec "$@"
