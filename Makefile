.PHONY: \
	all \
	dev \
	build \
	run \
	debug \
	logs \
	rm \
	stop \
	backup \
	help \
	clean


# TASKS

all: help

dev: run logs

build:
	@./cli.sh build

magic-build:
	@./cli.sh magic-build

nginx-build:
	@./cli.sh nginx-build

run:
	@./cli.sh run

debug:
	@./cli.sh debug

logs:
	@./cli.sh logs

rm:
	@./cli.sh remove

stop:
	@./cli.sh stop

ip:
	@./cli.sh ip

clean:
	@./cli.sh clean

# help output
help:
	@./cli.sh help
