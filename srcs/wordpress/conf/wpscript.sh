until mysql -hmariadb -u$DB_USER -p$DB_USER_PASSWORD -e "show databases;" > /dev/null 2>&1; do
	sleep 10;
done

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=mariadb:3306 --path=$WP_PATH --allow-root
	wp-cli.phar core install --url=$WP_URL --title=$WP_TITTLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_MAIL --path=$WP_PATH --allow-root
	wp-cli.phar user create $WP_USER $WP_USER_MAIL --user_pass=$WP_USER_PASS --role=administrator --path=$WP_PATH --allow-root
fi

if pgrep -x "php-fpm8.2" > /dev/null; then
	exit 1
else
	exec php-fpm8.2 -F
fi
