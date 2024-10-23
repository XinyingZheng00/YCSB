#!/bin/bash
for i in 20000 30000 40000 50000
do  
    for j in 1KB 100KB 1MB
    do
        cd /users/Xinying/ozonedb/build && make clean-db && cd /users/Xinying/YCSB
        python3 /users/Xinying/YCSB/bin/ycsb load ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i > /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadF-$i.result
        python3 /users/Xinying/YCSB/bin/ycsb run ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadF-$i.result
        python3 /users/Xinying/YCSB/bin/ycsb load rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i > /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadF-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        python3 /users/Xinying/YCSB/bin/ycsb run rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadF-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        # for k in 1 2
        # do
        #     cd /users/Xinying/ozonedb/build && make clean-db && cd /users/Xinying/YCSB
        #     python3 /users/Xinying/YCSB/bin/ycsb load ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadF-$i.result
        #     python3 /users/Xinying/YCSB/bin/ycsb run ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadF-$i.result
        #     python3 /users/Xinying/YCSB/bin/ycsb load rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadF-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        #     python3 /users/Xinying/YCSB/bin/ycsb run rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloadf/$j/workloadf_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadF-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        # done
    done
done