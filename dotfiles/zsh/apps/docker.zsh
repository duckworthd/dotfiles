export DOCKER_HOST=tcp://localhost:4243

# docker is running inside a VirtualBox VM, so we need to remap local ports
# 49k-49.9k to the VM's. This will only worker if docker isn't running.
function docker_expose {
  boot2docker ssh -L "$1":localhost:"$1";
}
