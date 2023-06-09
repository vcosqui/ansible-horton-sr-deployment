.PHONY: *
SHELL := /bin/bash
.DEFAULT_GOAL := help

ANSIBLE_KEY_FILE ?= $(ANSIBLE_KEY_FILE) ## Location of hosts private key for ssh connection

list-inventory: ## Lists the ansible inventory
	@ansible-inventory --list -y -i hosts

ping-hosts: check-env ## Pings all hosts in inventory to verify connectivity
	@ansible all -m ping -i hosts

install: check-env ## Installs Hortonworks Schema Registry
	@ansible-playbook schema-registry.yaml -i hosts

test: ## Tests install by http interaction with the service
	@ansible schema_registry -m shell -a 'curl -sS localhost:9090/api/v1/confluent/subjects' -i hosts

check-env:
ifndef ANSIBLE_KEY_FILE
	$(error ANSIBLE_KEY_FILE is undefined, please set it to the path where the host priv key is present)
endif

help: ## show this help
	@sed -ne "s/^##\(.*\)/\1/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 2` Make Commands `tput sgr0`────────────────────────────────\n"
	@sed -ne "/@sed/!s/\(^[^#?=]*:\).*##\(.*\)/`tput setaf 2``tput bold`\1`tput sgr0`\2/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 4` Make Variables `tput sgr0`───────────────────────────────\n"
	@sed -ne "/@sed/!s/\(.*\)?=\(.*\)##\(.*\)/`tput setaf 4``tput bold`\1:`tput setaf 5`\2`tput sgr0`\3/p" $(MAKEFILE_LIST)
	@printf "───────────────────────────────────────────────────────────────────────\n"