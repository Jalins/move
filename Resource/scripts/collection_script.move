script {
    use std::Collection as coll;
    use std::debug;
    use std::signer;

    fun collection_script(account: signer){
        debug::print(&account);
        coll::start_collection(&account);
         

        let addr = signer::address_of(&account);
        // let isExist = coll::exist_collection(addr);
        debug::print(&addr);
        // debug::print(&isExist);
    }
}