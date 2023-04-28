# Hortonworks Schema Registry deployment

Install a Hortonworks Schema Registry server using ansible

## Prerequisites
* 1 Ubuntu hosts (Tested with 18.04)
* A ssh key to connect to the host
* Make and Ansible binaries installed (Tested with 2.12.10)
```shell
apt-add-repository ppa:ansible/ansible
apt update
apt install make
apt install ansible
```

## Instructions
1. Edit `hosts` file to put the right ip address of your inventory.
2. Set the location of the ssh private key in env var `ANSIBLE_KEY_FILE`
3. Test connectivity with command
```shell
make ping-hosts
```
4. Install Zookeeper with command
```shell
make install
```
5. Test Zookeeper cluster status with command
```shell
make test
```

## Utils

To provision infra in azure first create a network like this
```shell
az network vnet create \
  --name your-vnet \
  --resource-group your-resource-group \
  --address-prefix 10.1.0.0/16
```

And then use this repo

https://github.com/ogomezso/tf-cp-cloud-infra-provision

I used the following settings to provision a basic set of machines
```shell
export TF_VAR_pub_key_path="~/.ssh/1682512529_1817129.pub"
export TF_VAR_resource_group_name="your-resource-group"
export TF_VAR_subnet_addres_prefix="10.1.0.0/24"
export TF_VAR_subnet_name="your-subnet"
export TF_VAR_user_name="kafka"
export TF_VAR_vnet_name="your-vnet"

export TF_VAR_sr_count=1
```