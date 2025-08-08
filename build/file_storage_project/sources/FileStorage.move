module MyModule::FileStorage {

    use aptos_framework::signer;

    /// Struct to hold the IPFS hash for a user's file.
    struct FileRecord has key {
        ipfs_hash: vector<u8>,
    }

    /// Function to store the IPFS hash.
    public fun store_file_hash(account: &signer, hash: vector<u8>) {
        assert!(!exists<FileRecord>(signer::address_of(account)), 1);
        let record = FileRecord { ipfs_hash: hash };
        move_to(account, record);
    }

    /// Function to get the stored IPFS hash.
    public fun get_file_hash(owner: address): vector<u8> acquires FileRecord {
        let record = borrow_global<FileRecord>(owner);
        record.ipfs_hash
    }
}
