# PLUGINS

Demonstrate how to build an image with plugins.  

## Bake

```bash
# use bake to build all the images
docker buildx bake -f docker-bake.hcl --metadata-file ./bake-metadata.json  
docker buildx bake -f docker-bake.hcl --metadata-file ./bake-metadata.json --no-cache 

# start verdaccio
docker run -it -p 8080:4873 verdaccio.prometheus 

# test metrics endpoint (try an npm install in simple-express)
curl http://localhost:8080/custom/path/metrics

# push image over to kind 
kind load docker-image --name kind-1-24 verdaccio.prometheus 

# while IFS=, read -r imagesha
# do
#     echo "IMAGE:$imagesha"
#     docker run --rm -t "$imagesha"
# done < <(jq -r '. | keys[] as $key | .[$key]."containerimage.digest"' ./bake-metadata.json)
```

## Resources

* https://github.com/verdaccio/verdaccio/blob/master/docker-examples/v5/plugins/docker-build-install-plugin/Dockerfile
* xlts-dev/verdaccio-prometheus-middleware repo [here](https://github.com/xlts-dev/verdaccio-prometheus-middleware)