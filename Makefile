
up:
	docker compose up -d --remove-orphans

down:
	docker compose down

nodes:
	docker exec headscale headscale nodes list

secret:
	@[ -n "$(PASSWORD)" ] && \
		docker run --rm authelia/authelia:latest authelia crypto hash generate argon2 --password '$(PASSWORD)' \
		|| echo "Usage: make secret PASSWORD=<your_password>"

# Reload photos in nextcloud.
rescan:
	docker exec -u abc nextcloud php /app/www/public/occ files:scan --all
