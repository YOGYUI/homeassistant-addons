if [ -n "${BASH_SOURCE-}" ]; then
    script_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]; then
    script_path="${(%):-%x}"
else
    script_path=$0
fi
script_dir=$(dirname $(realpath $script_path))
addon_path=$(dirname $script_dir)

docker run \
  -it \
  --privileged \
  -v ${addon_path}:/data \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  local/my-test-addon