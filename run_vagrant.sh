#!/usr/bin/env bash

set -euo pipefail

export ANSIBLE_CALLBACK_WHITELIST='timer,profile_tasks'
export ANSIBLE_STDOUT_CALLBACK='yaml'

pipenv run ansible-playbook --diff -i ./inventory/ site.yml $@
