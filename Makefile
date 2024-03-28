test:
	cram test.t

shellcheck:
	shellcheck file-uri

.PHONY: test shellcheck
