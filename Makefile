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

test-clients:
	mkdir /tmp/dist
	for DIR in dockerfiles/*; \
	do \
		CLIENT=$$(basename $${DIR}); \
		docker build -t tldr-test:$${CLIENT} -f dockerfiles/$${CLIENT}/Dockerfile .; \
		if docker run tldr-test:$${CLIENT} make validate; then \
			cp assets/pass.png /tmp/dist/$${CLIENT}.png; \
		else \
			cp assets/fail.png /tmp/dist/$${CLIENT}.png; \
		fi; \
	done;
