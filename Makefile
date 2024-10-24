
up:
	docker compose up -d --remove-orphans

down:
	docker compose down

# Reload the photos in nextcloud.
rescan:
	docker exec -u www-data porto_nextcloud php occ files:scan --all
