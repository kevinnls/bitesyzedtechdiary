CONTAINER_ARGS =  --rm -d --name=bitesyzedtechdiary \
	--publish 4000:4000 --publish 35942:35942 \
	--env JEKYLL_LOG_LEVEL=debug \
	--env TZ=Asia/Kolkata \

IMAGE = ghcr.io/kevinnls/pages-gem:latest-alpine

JEKYLL_CMD = jekyll serve
JEKYLL_ARGS = --host 0.0.0.0 --port 4000 --livereload-port 35942 \
	      --livereload \
	      --future --drafts --baseurl '/'

CONTAINER_CMD = $(IMAGE) $(JEKYLL_CMD) $(JEKYLL_ARGS)

pod:
	podman run $(CONTAINER_ARGS) -v ./:/src/site:U,Z $(CONTAINER_CMD)

docker:
	docker run $(CONTAINER_ARGS) -u 1000 -v $(shell realpath .):/src/site $(CONTAINER_CMD)
