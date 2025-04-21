test:
	./tests/cram.sh tests/test.t

shellcheck:
	shellcheck file-uri

.PHONY: test shellcheck
