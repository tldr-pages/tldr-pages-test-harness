PATH_TO_TLDR_CLIENT ?= tldr

.PHONY: validate
validate:
	@PATH_TO_TLDR_CLIENT="$(PATH_TO_TLDR_CLIENT)" ./main.bats
