# Google Cloud SDK

The standard container that we use to run the `gcloud` and `kubectl` clients.
Much of the code is heavily inspired by
[blacklabelops/gcloud](https://github.com/blacklabelops/gcloud).

## Usage

```
$ docker run -it --rm \
  -e "GCLOUD_ACCOUNT=$(base64 auth.json)" \
  -e "GCLOUD_ACCOUNT_EMAIL=useraccount@developer.gserviceaccount.com" \
  -e "CLOUDSDK_CORE_PROJECT=example-project \
  -e "CLOUDSDK_COMPUTE_ZONE=us-central1-b \
  -e "CLOUDSDK_COMPUTE_REGION=us-central1 \
  -e "KUBE_CLUSTER=my-kube-cluster" \
  cagedata/gcloud \
  kubectl get pods
```
