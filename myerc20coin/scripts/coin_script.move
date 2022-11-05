script {
    use MyCoinAddr::MyCoin;
    use std::signer;
    use std::debug;

    fun main(account: signer, mint_addr: signer){
        MyCoin::init_account(&account);
        MyCoin::init_account(&mint_addr);
        
        MyCoin::mint(&account, signer::address_of(&mint_addr), 100);
        let mintBalance = MyCoin::balance_of(signer::address_of(&mint_addr));
        
        debug::print(&mintBalance);
        
        MyCoin::transfer(&mint_addr, signer::address_of(&account), 50);

        let accountBalance = MyCoin::balance_of(signer::address_of(&account));
        debug::print(&accountBalance);

        let mintNewBalance = MyCoin::balance_of(signer::address_of(&mint_addr));
        debug::print(&mintNewBalance);
    }
}