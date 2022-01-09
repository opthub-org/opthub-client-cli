TAG ?= opthub-client-cli

.PHONY: all start image install build stage deploy clean
all: image start

start: image
	docker run --rm -it --entrypoint=bash $(TAG)

image:
	docker build -t $(TAG) .

install:
	. .venv/bin/activate && \
	pip install -e .

build:
	. .venv/bin/activate && \
	python setup.py sdist && \
	python setup.py bdist_wheel

stage:
	. .venv/bin/activate && \
	twine upload --repository testpypi dist/*

deploy:
	. .venv/bin/activate && \
	twine upload dist/*

clean:
	$(RM) dist/*
