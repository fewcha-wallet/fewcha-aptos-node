# Deploy Aptos blockchain testnet nodes to AWS

## The requirements

Your PC must be have:

- Aptos CLI: https://github.com/aptos-labs/aptos-core/blob/main/crates/aptos/README.md
- Terraform CLI: https://www.terraform.io/downloads.html
- Kubernetes CLI: https://kubernetes.io/docs/tasks/tools/
- AWS CLI: https://aws.amazon.com/cli/

An AWS account with `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

## Deployment

### 1. Prepare

 Clone this repo and pull it to your PC.

### 2. Configuration

Change content of the file `0-config.sh` at `./testnet` with your config:

```bash
export AWS_ACCESS_KEY_ID="<required>"
export AWS_SECRET_ACCESS_KEY="<required>"
export AWS_REGION="<required>"             # example: us-east-1
export CODENAME="<required>"               # example: aptos-testnet-1 (Should choose unique name or random string like: my-node-5ad612)
export VALIDATOR_NAME="<required>"         # example: Fewcha Wallet Validator Node
```

### 3. Deploy

`cd` to `./testnet`

First, run `sh setup.sh` to setup your nodes.

That command with do anything to setup a `validator node` and a `full node` and it take about ~30 minutes onn the setup.

After that, you should store a backup copy of `./keys/<your codename>` at a safe place.

Keep check status of nodes:

```bash
kubectl get pod
```

All done if you have a result that look like the example result:

```
NAME                                          READY   STATUS    RESTARTS   AGE
testnet-aptos-node-fullnode-e1-0              1/1     Running   0          17h
testnet-aptos-node-haproxy-64754fff88-r7bpn   1/1     Running   0          15h
testnet-aptos-node-validator-0                1/1     Running   0          17h
```

If all status is running, your nodes are running fine.

### 4. Addresses

After finish, you can get `addresses` of your `nodes` by run at `./testnet`:

```bash
sh get-address.sh
```

Example result:

```bash
Validator node address: xxx.elb.ap-southeast-1.amazonaws.com
Fullnode node address: xxx.elb.ap-southeast-1.amazonaws.com
```

### 5. Ports

Use that `addresses` at step 5. with ports

- Validator: `80`, `6080`, `9101`
- Fullnode: `80`, `6082`, `9101`

*can check by using: `kubectl get svc` (`LoadBalancer`), example:*

```bash
NAME                              TYPE           CLUSTER-IP   EXTERNAL-IP                            PORT(S)                                      AGE
kubernetes                        ClusterIP      10.100.0.1   <none>                                 443/TCP                                      11h
testnet-aptos-node-fullnode       ClusterIP      10.100.x.x   <none>                                 6182/TCP,9101/TCP,8080/TCP                   11h
testnet-aptos-node-fullnode-lb    LoadBalancer   10.100.x.x   xxx.elb.ap-southeast-1.amazonaws.com   6182:30277/TCP,9101:31312/TCP,80:31317/TCP   11h
testnet-aptos-node-validator      ClusterIP      10.100.x.x   <none>                                 6180/TCP,6181/TCP,9101/TCP                   11h
testnet-aptos-node-validator-lb   LoadBalancer   10.100.x.x   xxx.elb.ap-southeast-1.amazonaws.com   6180:32538/TCP,9101:32082/TCP,80:31101/TCP   11h
```

### 6. Data

- You can get your Public keys at `./keys/<codename>/<codename>.yaml`, example:

```bash
---
account_address: 834ea0ccb8703b256e55c27a9772606ef04af1ee2e7f819ca8d0f13d2a6508cf
consensus_key: "0x0bd9b5b6c155c4403af5136e80e65077b01a806afeee418863c266e877a83892"
account_key: "0xb4eb324c8a95c23a34972e417a656bd0b69389117398612b5df87271e57f2607"
validator_network_key: "0x38f903cf09f0e704b5ca70161fe220672152e8befc839f93ddb5cd2eca253465"
validator_host:
  host: ac0c51d27e3fd47f595adcced42e1d65-b1a3027fd0338799.elb.us-east-1.amazonaws.com
  port: 6180
full_node_network_key: "0x1f5881332b39d01600988c988cc20c510203e73e8679558570af9b27bdd70a7b"
full_node_host:
  host: ad16e9cbec2a64a6fa9aca10df614075-d8a7afd8ec62fe89.elb.us-east-1.amazonaws.com
  port: 6182
stake_amount: 1
```

- Your Private keys at `./keys/<codename>/private-keys.yaml`

## Attention! danger!

- Don't forget backup a copy of your `.keys` to a safe place.
- **IMPORTANT!**: to run more, don't just change the config and run the same dir testnet, please duplicate this repo again.

## Origin

- Learn more, and origin: https://aptos.dev/tutorials/validator-node/run-validator-node-using-aws/

## Issue

If you don't see port `80:xxxxx/TCP` of `...-aptos-node-validator-lb` when run `kubectl get svc`

You should run a change:

```bash
kubectl edit svc <your codename>-aptos-node-validator-lb
```

and add (`vim` editor):

```diff
  ports:
  - name: validator
    nodePort: 30910
    port: 6180
    protocol: TCP
    targetPort: 6180
  - name: metrics
    nodePort: 30011
    port: 9101
    protocol: TCP
    targetPort: 9102
+ - name: api
+   port: 80
+   protocol: TCP
+   targetPort: 8180
```

Then save it with `esc` and `:wq`