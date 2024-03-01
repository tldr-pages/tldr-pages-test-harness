PATH_TO_TLDR_CLIENT ?= tldr

.PHONY: validate
validate:
	@PATH_TO_TLDR_CLIENT="$(PATH_TO_TLDR_CLIENT)" bats --filter-tags required ./tldr.bats

.PHONY: validate-level-2
validate-level-2:
	@PATH_TO_TLDR_CLIENT="$(PATH_TO_TLDR_CLIENT)" bats --filter-tags required --filter-tags optional ./tldr.bats

.PHONY: validate-level-3
validate-level-3:
	@PATH_TO_TLDR_CLIENT="$(PATH_TO_TLDR_CLIENT)" ./tldr.bats

.PHONY: docker-validate
docker-validate: is-client-defined
	docker build -t tldr-test:$$CLIENT -f dockerfiles/$$CLIENT/Dockerfile .
	docker run tldr-test:$$CLIENT make validate

.PHONY: docker-validate-level-2
docker-validate-level-2: is-client-defined
	docker build -t tldr-test:$$CLIENT -f dockerfiles/$$CLIENT/Dockerfile .
	docker run tldr-test:$$CLIENT make validate-level-2

.PHONY: docker-validate-level-3
docker-validate-level-3: is-client-defined
	docker build -t tldr-test:$$CLIENT -f dockerfiles/$$CLIENT/Dockerfile .
	docker run tldr-test:$$CLIENT make validate-level-3

test-clients:
	@mkdir -p /tmp/dist
	@for DIR in dockerfiles/*; \
	do \
		CLIENT=$$(basename $${DIR}); \
		if CLIENT=$$CLIENT make docker-validate; then \
			cp assets/pass.png /tmp/dist/$${CLIENT}.png; \
		else \
			cp assets/fail.png /tmp/dist/$${CLIENT}.png; \
		fi; \
	done;

is-client-defined:
ifndef CLIENT
	@echo "CLIENT environment variable must be set to the name of a tldr-pages client";
	@exit 1;
endif
