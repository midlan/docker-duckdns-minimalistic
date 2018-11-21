# docker-duckdns-minimalistic
Minimalistic docker image for dynamic DNS provided e.g. by [duckdns.org][duckdns]

## Brief
The goal of this repository is to create minimalistic docker image for updating DNS records of [duckdns.org][duckdns]. The `Dockerfile` is based on alpine without any other dependencies, so the result image should be about the same size as the alpine image.

## Usage

### Start container

    docker run -d --name duckdns \
		-e DUCKDNS_URL='https://www.duckdns.org/update?domains=exampledomain&token=a7c4d0ad-114e-40ef-ba1d-d217904a50f2' \
		-e DUCKDNS_INTERVAL=300 \
		-e DUCKDNS_TIMEOUT=10 \
		midlan6/duckdns-minimalistic
Put your's duckdns url to `DUCKDNS_URL` variable. Verbose version is also supported.

Variables `DUCKDNS_INTERVAL` and `DUCKDNS_TIMEOUT` are optional. Default values are same as shown in example above.

### Logs
This docker image uses standard docker logging. To view the logs use:

	docker logs <container>

## Additional Information
Dockerhub repository: [midlan6/duckdns-minimalistic](https://hub.docker.com/r/midlan6/duckdns-minimalistic/)

The image should be compatible with other dynamic DNS services. Feel free to let me know if you successfully use it with any.

[duckdns]: https://www.duckdns.org/
