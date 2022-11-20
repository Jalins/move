module tokenswap::Pool {
    use aptos_framework::coin::{Self, Coin};

    struct Pool<phantom X, phantom Y> has key {
        coin_x: coin::Coin<X>,
        coin_y: coin::Coin<Y>,
    }

    public entry fun creat_pool<X, Y>(sender: &signer) {
        move_to(sender, Pool<X, Y> {
            coin_x: coin::zero(),
            coin_y: coin::zero(),
        })
    }

    public entry fun add<X, Y>(coin_x: Coin<X>, coin_y: Coin<Y>) acquires Pool {
        let pool = borrow_global_mut<Pool<X, Y>>(@tokenswap);
        coin::merge(&mut pool.coin_x, coin_x);
        coin::merge(&mut pool.coin_y, coin_y);
    }

    // swap x to y
    public entry fun swap_x_to_y<IN, OUT>(in: Coin<IN>): Coin<OUT> acquires Pool {
        let pool = borrow_global_mut<Pool<IN, OUT>>(@tokenswap);

        let val_in = coin::value(&in);
        /*
            merge: deposit coin to the pool;  extract: withdraw coin from pool
        */
        coin::merge(&mut pool.coin_x, in);
        let out = coin::extract(&mut pool.coin_y, val_in);
        out
    }


    public fun is_have<X, Y>():bool{
        exists<Pool<X, Y>>(@tokenswap)
    }
}