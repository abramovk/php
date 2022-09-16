build-81-fpm:
	@echo "Building PHP-FPM 8.1 Docker images (linux/amd64)..."
	@docker buildx build -t abramovk/php:8.1-fpm -t abramovk/php:8.1.10-fpm --platform linux/amd64 --compress --no-cache -f 8.1/fpm/Dockerfile . --push
.PHONY: build-81-fpm

build-81-cli:
	@echo "Building PHP-CLI 8.1 Docker images (linux/amd64)..."
	@docker buildx build -t abramovk/php:8.1-cli -t abramovk/php:8.1.10-cli --platform linux/amd64 --compress --no-cache -f 8.1/cli/Dockerfile . --push
.PHONY: build-81-cli

build-82-fpm:
	@echo "Building PHP-FPM 8.2 Docker images (linux/amd64)..."
	@docker buildx build -t abramovk/php:8.2-fpm --platform linux/amd64 --compress --no-cache -f 8.2/fpm/Dockerfile . --push
.PHONY: build-82-fpm

build-82-cli:
	@echo "Building PHP-CLI 8.2 Docker images (linux/amd64)..."
	@docker buildx build -t abramovk/php:8.2-cli --platform linux/amd64 --compress --no-cache -f 8.2/cli/Dockerfile . --push
.PHONY: build-82-cli

build-lkkk-fpm:
	@echo "Building PHP-FPM Docker image for LK KK"
	@docker buildx build -t abramovk/php:lkkk-fpm --platform linux/amd64 --compress --no-cache -f system/lkkk/fpm/Dockerfile . --push
.PHONY: build-lkkk-fpm

build-lkkk-cli:
	@echo "Building PHP-CLI Docker image for LK KK"
	@docker buildx build -t abramovk/php:lkkk-cli --platform linux/amd64 --compress --no-cache -f system/lkkk/cli/Dockerfile . --push
.PHONY: build-lkkk-cli

build-lka-fpm:
	@echo "Building PHP-FPM Docker image for LKA"
	@docker buildx build -t abramovk/php:lka-fpm --platform linux/amd64 --compress --no-cache -f system/lka/fpm/Dockerfile . --push
.PHONY: build-lka-fpm

build-lka-cli:
	@echo "Building PHP-CLI Docker image for LKA"
	@docker buildx build -t abramovk/php:lka-cli --platform linux/amd64 --compress --no-cache -f system/lka/cli/Dockerfile . --push
.PHONY: build-lka-cli

build-lkp-fpm:
	@echo "Building PHP-FPM Docker image for LKP"
	@docker buildx build -t abramovk/php:lkp-fpm --platform linux/amd64 --compress --no-cache -f system/lkp/fpm/Dockerfile . --push
.PHONY: build-lkp-fpm

build-lkp-cli:
	@echo "Building PHP-CLI Docker image for LKP"
	@docker buildx build -t abramovk/php:lkp-cli --platform linux/amd64 --compress --no-cache -f system/lkp/cli/Dockerfile . --push
.PHONY: build-lkp-cli
