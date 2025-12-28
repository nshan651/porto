help:
	@echo 'Usage: make [target]	'
	@echo
	@echo 'Docker compose targets:'
	@echo '  up                Spin up the public and private compose stacks.'
	@echo '  down              Tear down the public and private compose stacks, removing dangling volumes.'
	@echo '  pull              Pull service images.'
	@echo
	@echo 'Tailscale targets:'
	@echo '  nodes             List existing nodes in the tailnet.'
	@echo '  preauth           Generate a new preauth key.'
	@echo '  pull              Pull service images.'
	@echo
	@echo 'Authentication:'
	@echo '  secret            Generate a new argon2 hashed password.'
	@echo
	@echo 'Nextcloud:'
	@echo '  rescan            Reload photos in nextcloud.'
	@echo
	@echo 'Default target:'
	@echo '  help              Show this help message.'

up:
	docker compose -f compose.yml -f compose.internal.yml up -d --remove-orphans

# Note: removes all named/anon volumes.
# We use bind mounts on everything important, so --volumes minimizes clutter.
down:
	docker compose -f compose.yml -f compose.internal.yml down --volumes

pull:
	docker compose -f compose.yml -f compose.internal.yml pull

# WARNING: removes the following:
# - all stopped containers
# - all networks not used by at least one container
# - all anonymous volumes not used by at least one container
# - all images without at least one container associated to them
# - all build cache
prune:
	docker system prune --all --volumes

nodes:
	docker exec headscale headscale nodes list

preauth:
	docker exec headscale headscale preauthkeys create \
		-u 1 \
		--reusable \
		--expiration 24h

secret:
	@[ -n "$(PASS)" ] && \
	docker run --rm authelia/authelia:latest \
		authelia crypto hash generate argon2 --password '$(PASS)' \
		|| echo "Usage: make secret PASS=<your_password>"

# Reload photos in nextcloud.
rescan:
	docker exec -u www-data nextcloud php occ files:scan --all
