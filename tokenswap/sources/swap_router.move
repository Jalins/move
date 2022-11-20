module tokenswap::router{
    use tokenswap::Pool::{creat_pool, add, swap_x_to_y, is_have};
    use aptos_framework::coin;
    use std::signer;

    // create the pool
    public  entry fun create_pool<X,Y>(sender: &signer){
        creat_pool<X,Y>(sender)
    }

    // add asset to pool
    public entry  fun add_coin_to_pool<X, Y>(sender: &signer, amount_x: u64, amount_y: u64){
        let coin_x = coin::withdraw<X>(sender, amount_x);
        let coin_y = coin::withdraw<Y>(sender, amount_y);

        add(coin_x,coin_y);
    }

    // swap coins
    public entry fun swap<CoinIn, CoinOut>(sender: &signer, amount: u64){
        /*
            1.withdraw coinIn; 2.swap coinOut; 3.deposit address
        */
        if (is_have<CoinIn, CoinOut>()) {
            let coin_in = coin::withdraw<CoinIn>(sender, amount);

            let coin_out = swap_x_to_y<CoinIn, CoinOut>(coin_in);

            let addr = signer::address_of(sender);

            if (!coin::is_account_registered<CoinOut>(addr)){
                coin::register<CoinOut>(sender);
            };
            coin::deposit(addr, coin_out)
        }

    }
}