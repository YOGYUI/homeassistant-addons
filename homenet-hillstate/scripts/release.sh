if [ -n "${BASH_SOURCE-}" ]; then
    script_path="${BASH_SOURCE}"
elif [ -n "${ZSH_VERSION-}" ]; then
    script_path="${(%):-%x}"
else
    script_path=$0
fi
script_dir=$(dirname $(dirname $(realpath $script_path)))

## docker permission denied 해결법 
# sudo chown -R $(whoami) ~/.docker

## for crosscompile multi architecture
# docker run --privileged --rm tonistiigi/binfmt --install all

## buildx driver가 docker-container면 제대로 푸시되지 않는다?
## > default driver로 빌드하게 변경해줘야 한다
# docker buildx use default 

docker run \
  --rm \
  --privileged \
  --name hassio-builder \
  -v ~/.docker:/root/.docker \
  -v ${script_dir}:/data \
  homeassistant/amd64-builder \
  --all \
  -t /data