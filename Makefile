CLI=./cli.sh

.PHONY: \
	all \
	dev \
	build \
	magic-build \
	nginx-build \
	run \
	debug \
	logs \
	rm \
	stop \
	ip \
	clean \
	help


# TASKS

all: help

dev: run logs

build:
	@${CLI} $@

magic-build:
	@${CLI} $@

nginx-build:
	@${CLI} $@

run:
	@${CLI} $@

debug:
	@${CLI} $@

logs:
	@${CLI} $@

rm:
	@${CLI} $@

stop:
	@${CLI} $@

ip:
	@${CLI} $@

clean:
	@${CLI} $@

update:
	@${CLI} $@

status:
	@${CLI} $@

# help output
help:
	@${CLI} $@
