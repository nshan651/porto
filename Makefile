
up:
	docker compose up -d --remove-orphans

down:
	docker compose down

secret:
	@[ -n "$(PASSWORD)" ] && \
		docker run --rm authelia/authelia:latest authelia crypto hash generate argon2 --password '$(PASSWORD)' \
		|| echo "Usage: make secret PASSWORD=<your_password>"

# Reload the photos in nextcloud.
rescan:
	docker exec -u www-data nextcloud php occ files:scan --all
