if [ -n "${BASH_SOURCE-}" ]; then
    script_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]; then
    script_path="${(%):-%x}"
else
    script_path=$0
fi
script_dir=$(dirname $(realpath $script_path))
addon_path=$(dirname $script_dir)

#docker run \
#  --rm \
#  -it \
#  --name builder \
#  --privileged \
#  -v ${addon_path}:/data \
#  -v /var/run/docker.sock:/var/run/docker.sock:ro \
#  homeassistant/amd64-builder \
#  -t /data \
#  --all \
#  --test \
#  -i ha-addon-homenet-hillstate-{arch} \
#  -d local

docker build \
  --build-arg BUILD_FROM="homeassistant/amd64-base:latest" \
  -t local/my-test-addon \
  ${addon_path}
