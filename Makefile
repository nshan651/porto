
up:
	docker compose -f compose.yml -f compose.internal.yml up -d --remove-orphans

down:
	docker compose -f compose.yml -f compose.internal.yml down

nodes:
	docker exec headscale headscale nodes list

pull:
	docker compose -f compose.yml -f compose.internal.yml pull

preauth:
	docker exec headscale headscale preauthkeys create \
		-u 1 \
		--reusable \
		--expiration 24h

secret:
	@[ -n "$(PASSWORD)" ] && \
		docker run --rm authelia/authelia:latest authelia crypto hash generate argon2 --password '$(PASSWORD)' \
		|| echo "Usage: make secret PASSWORD=<your_password>"

# Reload photos in nextcloud.
rescan:
	docker exec -u www-data nextcloud php occ files:scan --all
