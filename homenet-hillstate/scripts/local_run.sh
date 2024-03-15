if [ -n "${BASH_SOURCE-}" ]; then
    script_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]; then
    script_path="${(%):-%x}"
else
    script_path=$0
fi
script_dir=$(dirname $(dirname $(realpath $script_path)))

docker run \
  -it \
  --privileged \
  -v ${script_dir}:/data \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  local/my-test-addon