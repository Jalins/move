module 0x2::Collection {
    use std::vector;
	struct Item has store, drop {}
    
    
    struct Collection has key {
        items: vector<Item>
    }

    public fun start_collection (account: &signer){
        move_to<Collection>(account, Collection{
            items: vector::empty<Item>()
        })
    }

    public fun exist_collection (at: address):bool {
        exists<Collection>(at)
    }
}
