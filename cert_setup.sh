# OLD!!!! DO NOT USE


mkdir -p tmp/
mkdir -p tmp/certs/
mkdir -p tmp/my-safe-directory/


#----------------------
# ca
#----------------------
cockroach cert create-ca \
--certs-dir=./tmp/certs/ \
--ca-key=./tmp/my-safe-directory/ca.key

exit 0

#for last in {1..3}; do
for last in 1; do
    #----------------------
    # node cert
    #----------------------
    cockroach cert create-node "roach0${last}" 192.168.116.10"$last" localhost 127.0.0.1 --certs-dir=./tmp/certs/ --ca-key=./tmp/my-safe-directory/ca.key

    #ssh vagrant@192.168.116."10${last}" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -i ../.vagrant/machines/roach0"$last"/virtualbox/private_key 'echo
    #pipenv run ansible  "roach0${last}" -i inventory/ -m raw -a 'echo
    #    mkdir -p certs
    #'
    pipenv run ansible  "roach0${last}" -i inventory/ -m file -a 'name=certs state=directory'

    exit 0

    #----------------------
    # xfer node cert
    #----------------------
    scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -i ../.vagrant/machines/roach0"$last"/virtualbox/private_key tmp/certs/ca.crt tmp/certs/node.crt tmp/certs/node.key vagrant@192.168.116.10"$last":'$HOME/certs'

    #----------------------
    # remove local copy of node cert
    #----------------------
    ssh vagrant@192.168.116.10"$last" -i ../.vagrant/machines/roach0"$last"/virtualbox/private_key 'echo
        rm certs/node.crt certs/node.key
    '


done
