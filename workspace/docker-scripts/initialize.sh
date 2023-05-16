bundler install | grep kitchen
# docker build --tag=ubuntu1404_salt_minion -f ./ubuntu-14.04/Dockerfile .
# docker build --tag=ubuntu1804_salt_minion -f ./ubuntu-18.04/Dockerfile .
# docker build --tag=ubuntu2004_salt_minion -f ./ubuntu-20.04/Dockerfile .
docker build --tag=ubuntu2204_salt_minion -f ./ubuntu-22.04/Dockerfile .