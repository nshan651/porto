
up:
	docker compose -f compose.yml -f compose.internal.yml up -d --remove-orphans

# Note: removes all named/anon volumes.
# We use bind mounts on everything important, so --volumes minimizes clutter.
down:
	docker compose -f compose.yml -f compose.internal.yml down --volumes

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

# WARNING: removes the following:
# - all stopped containers
# - all networks not used by at least one container
# - all anonymous volumes not used by at least one container
# - all images without at least one container associated to them
# - all build cache
prune:
	docker system prune --all --volumes
