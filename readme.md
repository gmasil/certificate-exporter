# Certificate-Exporter

This is a simple prometheus exporter to provide metrics when TLS certificates will expire.

It is based on netcat for serving web request and openssl to download and read certificates.

# Build

Build simply with docker:

```bash
docker build .
```

Build with Compose:

```bash
docker-compose build
```

**Note:** this will build an image called `registry.gmasil.de/docker/cert-exporter`, this is my own docker registry.

# Usage

You can use the image I uploaded to my docker registry, if you want to use your own build just replace the image name accordingly.

The certificate-exporter will **listen** on **port 80** and exposes it by default.

You can specify which domains you want to monitor by providing a **comma separated list of domains** in the environment variable `DOMAINS`.

Usage with docker:

```bash
docker run -p 80:80 -e "DOMAINS=google.com,example.com" --sysctl net.ipv6.conf.all.disable_ipv6=1 registry.gmasil.de/docker/cert-exporter:1.0
```

Example docker-compose file:

```bash
version: '3'

services:
  certexporter:
    image: registry.gmasil.de/docker/cert-exporter:1.0
    sysctls:
      - "net.ipv6.conf.all.disable_ipv6=1"
    environment:
      - "DOMAINS=google.com,example.com"
```

**Note:** Due to a bug in netcat you might have to disable ipv6 in your docker container as provided in both examples.

## License

[GNU GPL v3 License](LICENSE.md)

Certificate-Exporter is free software: you can redistribute it and/or modify  
it under the terms of the GNU General Public License as published by  
the Free Software Foundation, either version 3 of the License, or  
(at your option) any later version.

Certificate-Exporter is distributed in the hope that it will be useful,  
but WITHOUT ANY WARRANTY; without even the implied warranty of  
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the  
GNU General Public License for more details.