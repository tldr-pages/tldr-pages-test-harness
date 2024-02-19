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
