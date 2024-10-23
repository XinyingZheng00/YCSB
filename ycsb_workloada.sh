#!/bin/bash
for i in 10000 20000 50000 100000 200000 500000 1000000 
do 
    for j in 1KB
    do
        cd /users/Xinying/ozonedb/build && make clean-db && cd /users/Xinying/YCSB
        python3 /users/Xinying/YCSB/bin/ycsb load ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i > /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadA-$i.result
        python3 /users/Xinying/YCSB/bin/ycsb run ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadA-$i.result
        python3 /users/Xinying/YCSB/bin/ycsb load rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i > /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadA-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        python3 /users/Xinying/YCSB/bin/ycsb run rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadA-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        # for k in 1 2 3 4 
        # do
        #     cd /users/Xinying/ozonedb/build && make clean-db && cd /users/Xinying/YCSB
        #     python3 /users/Xinying/YCSB/bin/ycsb load ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadA-$i.result
        #     python3 /users/Xinying/YCSB/bin/ycsb run ozonedb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/ozonedb$j-workloadA-$i.result
        #     python3 /users/Xinying/YCSB/bin/ycsb load rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadA-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        #     python3 /users/Xinying/YCSB/bin/ycsb run rocksdb -s -P /users/Xinying/ozonedb/bench/ycsb/workload/workloada/$j/workloada_$i >> /users/Xinying/ozonedb/bench/ycsb/ycsb2graph/rocksdb$j-workloadA-$i.result -p rocksdb.dir=/tank/ycsb-rocksdb-data -p rocksdb.optionsfile=/tank/option
        # done
    done
done
