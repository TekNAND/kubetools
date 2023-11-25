# kubetools

Kubetools is a simple Alpine Docker image created with kubectl and helm installed.

## Tool Versions

| Image Version  | Tool Versions |
| -------------- | ------------- |
| 1.28.4, latest | kubectl v1.28.4<br>helm v3.13.2 |
| 1.19.3 | kubectl v1.19.3<br>helm v3.5.2 |

## Kubectl Configuration

To run the image with your own kube config run the following command:

```bash
docker run --rm --name kubetools -v /path/to/kube/config:/.kube/config teknand/kubetools:latest
```

## Running Tools

### kubectl

```bash
docker run --rm --name kubetools -v /path/to/kube/config:/.kube/config teknand/kubetools:latest kubectl version
```

### Helm

```bash
docker run --rm --name kubetools -v /path/to/kube/config:/.kube/config teknand/kubetools:latest helm version
```

## Tools Used in Image

[kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)<br>
[Helm](https://helm.sh/)
