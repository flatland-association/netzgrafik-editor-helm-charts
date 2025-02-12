# Netzgrafik Editor Helm Charts

This repository provides all-in-one [Helm Charts](https://helm.sh/docs/topics/charts/) for deployment on a [Kubernetes](https://kubernetes.io/) (k8s) cluster
of [Netzgrafik Editor](https://github.com/SchweizerischeBundesbahnen/netzgrafik-editor-frontend) (frontend, backend, DB for backend).

It is based on the published images from the ghcr (GitHub container registry) at
[SchweizerischeBundesbahnen](https://github.com/orgs/SchweizerischeBundesbahnen/packages).
No local dev setup (`mvn`, `npm` etc.) beyond `docker` and `docker-compose` are required.

If you just want to spin up on a local machine (without a Kubernetes cluster), then you can use the docker compose setup at

* https://github.com/flatland-association/netzgrafik-editor-docker-compose

For local dev setup, please refer to:

* [netzgrafik-editor-frontend](https://github.com/SchweizerischeBundesbahnen/netzgrafik-editor-frontend)
* [netzgrafik-editor-backend](https://github.com/SchweizerischeBundesbahnen/netzgrafik-editor-backend)

### TL;DR;

1. Edit config to your needs:

```shell
cp values.yaml.template values.yaml
cp secret-values.yaml.template secret-values.yaml
vi values.yaml
vi secret-values.yaml
```

2. Install Helm Release in default namespace:

```shell
helm install nge -f values.yaml -f secret-values.yaml .
```

3. Update Release in default namespace:

```shell
helm upgrade nge -f values.yaml -f secret-values.yaml .
```

> [!WARNING]   
> A container using a ConfigMap as a subPath volume mount will not receive ConfigMap updates.
> https://kubernetes.io/docs/concepts/storage/volumes/#secret

