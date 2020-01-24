# catapult-peernode-health-checker

Let's check your node with `catapult.tools.health` !!!

Requirements: docker-compose  
docker-composeが必要になります。

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

### 2. check node setting

check trasted hosts on node.

`config-node.properties (node setting)`

```
[node]

...

# all hosts are trusted when list is empty
trustedHosts = 127.0.0.1
localNetworks = 127.0.0.1
```

`sample`

two trasted host `127.0.0.1 (localhost)`, `XXX.XXX.XX.XXX`.

```
# all hosts are trusted when list is empty
# ( split with comma )
trustedHosts = 127.0.0.1,XXX.XXX.XX.XXX
localNetworks = 127.0.0.1
```

### 3. exec

```sh
~$ cd catapult-peernode-health-checker

catapult-peernode-health-checker$ docker-compose up
```

### 4. check log

**check summary**

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

**check DiagnosticCounter**

you can know server status.

```
check-peer-nodes_1  | 2020-01-24 04:49:28.569563 0x00007f62dc9af700: <info> (health::main.cpp@174) --- COUNTERS for known peers ---
check-peer-nodes_1  | 2020-01-24 04:49:28.570300 0x00007f62dc9af700: <info> (health::main.cpp@170) my-node @ XXX.XX.XXX.XX:7900
check-peer-nodes_1  |    ACCTREST C : 1      |      ACNTST C : 1'488  |  ACNTST C HVA : 111    |  ACTIVE PINGS : 0      |
check-peer-nodes_1  |       BAN ACT : 0      |       BAN ALL : 0      |  BLK ELEM ACT : 0      |  BLK ELEM TOT : 2      |
check-peer-nodes_1  |      BLKDIF C : 786    |        HASH C : 603    |    HASHLOCK C : 10     |   MEM CUR RSS : 54     |
check-peer-nodes_1  |  MEM CUR VIRT : 1'075  |   MEM MAX RSS : 54     |   MEM SHR RSS : 32     |    METADATA C : 16     |
check-peer-nodes_1  |      MOSAIC C : 289    |  MOSAICREST C : 5      |    MULTISIG C : 626    |         NODES : 5      |
check-peer-nodes_1  |          NS C : 487    |       NS C AS : 581    |       NS C DS : 594    | RB COMMIT ALL : 0      |
check-peer-nodes_1  | RB COMMIT RCT : 0      | RB IGNORE ALL : 0      | RB IGNORE RCT : 0      |       READERS : 1      |
check-peer-nodes_1  |  SECRETLOCK C : 0      | SUCCESS PINGS : 0      |         TASKS : 11     | TOT CONF TXES : 22'615 |
check-peer-nodes_1  |   TOTAL PINGS : 0      |   TS NODE AGE : 0      | TS OFFSET ABS : 0      | TS OFFSET DIR : 0      |
check-peer-nodes_1  |  TS TOTAL REQ : 0      |   TX ELEM ACT : 0      |   TX ELEM TOT : 1      |  UNLKED ACCTS : 1      |
check-peer-nodes_1  |      UT CACHE : 0      |       WRITERS : 3      |  
```

### NOTE

If you get the following error ...

```
check-peer-nodes_1  | 2020-01-24 04:48:43.709967 0x00007f516388b700: <error> (api::RemoteRequestDispatcher.h@49) read from remote node failed for diagnostic counters request
check-peer-nodes_1  | 2020-01-24 04:48:43.710566 0x00007f516388b700: <warning> (tools::ToolThreadUtils.h@38) unhandled exception while querying diagnostic counters!
```

Either:

1. `extension.diagnostics` is not enabled as server extension
2. the node being requested is remote and the requesting node is not in list of trustedHosts

どちらか:

1. `extension.diagnostics`がサーバー側で有効になっていない
2. `trustedHosts`のリスト外からリクエストを送っている
