
up:
	docker compose up -d --remove-orphans

down:
	docker compose down

secret:
	@[ -n "$(PASSWORD)" ] && \
		docker run --rm authelia/authelia:latest authelia crypto hash generate argon2 --password '$(PASSWORD)' \
		|| echo "Usage: make secret PASSWORD=<your_password>"

# Reload photos in nextcloud.
rescan:
	docker exec -u abc nextcloud php /app/www/public/occ files:scan --all
