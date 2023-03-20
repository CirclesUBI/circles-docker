Simulates a blockchain user and is only required to create transactions that can be indexed by the blockchain-indexer.  
This is necessary because the blockchain-indexer only emits events when it indexed a transaction.  
If this container is not running, then some processes like the pathfinder-updater will report an unhealthy status.
