# catapult-peernode-health-checker

Let's check your node with `catapult.tools.health` !!!

## version

**catapult-peernode-health-checker**
-v 0.1.0

**docker image**  
techbureau/catapult-tools:gcc-keccak-0.9.1.1

## Usage

### 1. edit peers-p2p.json

edit `userconfig/resources/peers-p2p.json`.

`sample`

| node name | boot publicKey                   | node address                 |
| --------- | -------------------------------- | ---------------------------- |
| my-node-A | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX | AAA.AAA.AA.AA                |
| my-node-B | YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY | sample-sample.sample.network |


```json
{
  "_info": "this file contains a list of peer_node peers",
  "knownPeers": [
    {
      "publicKey": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      "endpoint": {
        "host": "AAA.AAA.AA.AA",
        "port": 7900
      },
      "metadata": {
        "name": "my-node-A",
        "roles": "Peer"
      }
    },
    {
      "publicKey": "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
      "endpoint": {
        "host": "sample-sample.sample.network",
        "port": 7900
      },
      "metadata": {
        "name": "my-node-B",
        "roles": "Peer"
      }
    }
  ]
}
```

### 2. exec

```sh
~$ cd catapult-peernode-health-checker

catapult-peernode-health-checker$ docker-compose up
```

## 3. check log

check summary

The summary is output at the bottom of the output log. If communication with all nodes is completed successfully, "exited with code 0" is displayed at the end of the log.
サマリーは出力ログの一番下に出力されます。もし、全てのノードとの通信が正常に終了ると、ログの最後に "exited with code 0" と表示されます。

```
check-peer-nodes_1  | 2020-01-23 11:44:21.850837 0x00007f0823c55700: <info> (health::main.cpp@174) --- COUNTERS for known peers ---
check-peer-nodes_1  | 2020-01-23 11:44:21.850936 0x00007f0823c55700: <info> (health::main.cpp@170) my-node-A @ AAA.AAA.AA.AA:7900
check-peer-nodes_1  |  
check-peer-nodes_1  | 2020-01-23 11:44:21.851012 0x00007f0823c55700: <info> (health::main.cpp@178) --- SUMMARY for known peers ---
check-peer-nodes_1  | 2020-01-23 11:44:21.851100 0x00007f0823c55700: <info> (health::main.cpp@137)    my-node-A @ AAA.AAA.AA.AA:7900 [P2P] at height 221594 with score 2217868825965992094
check-peer-nodes_1  | 2020-01-23 11:44:21.851346 0x00007f08259e9140: <debug> (thread::IoThreadPool.cpp@111) waiting for 1 thread pool threads to exit
check-peer-nodes_1  | 2020-01-23 11:44:21.851553 0x00007f0823c55700: <debug> (ionet::PacketSocket.cpp@373) socket close triggered by destruction (0000000000000001), 1879ms elapsed
check-peer-nodes_1  | 2020-01-23 11:44:21.852382 0x00007f08259e9140: <info> (thread::IoThreadPool.cpp@113) all thread pool threads exited    
catapult-node-remote-checker_check-peer-nodes_1 exited with code 0
```

line 5.

```
check-peer-nodes_1  | 2020-01-23 11:44:21.851100 0x00007f0823c55700: <info> (health::main.cpp@137)    my-node-A @ AAA.AAA.AA.AA:7900 [P2P] at height 221594 with score 2217868825965992094
```

`my-node-A @ AAA.AAA.AA.AA:7900 [P2P] at height 221594 with score 2217868825965992094`

you can know node height (221594) & score (2217868825965992094).
