module MyCoinAddr::MyCoin{
    use std::signer;
    const MODULE_OWNER: address = @MyCoinAddr;

    /// Error codes
    const ENOT_MODULE_OWNER: u64 = 0;
    const EINSUFFICIENT_BALANCE: u64 = 1;
    const EALREADY_HAS_BALANCE: u64 = 2;
    const ACCOUNT_INITIALIZED: u64 = 3;

    struct Coin has store{
        value: u64
    }

    struct Balance has key{
        coin: Coin
    }

    public fun init_account(account: &signer){
        let account_addr = signer::address_of(account);
        assert!(!exists<Balance>(account_addr), ACCOUNT_INITIALIZED);

        if (!exists<Balance>(account_addr)){
            move_to<Balance>(account, Balance{
                coin: Coin{value: 0}
            });
        }
    }

    public fun mint(module_owner: &signer, mint_address: address, amount: u64) acquires Balance{
        assert!(signer::address_of(module_owner) == MODULE_OWNER, ENOT_MODULE_OWNER);

        deposit(mint_address, Coin{value: amount});
    }

    fun deposit(_addr: address, check: Coin) acquires Balance{
        let balance = balance_of(_addr);

        let balance_ref = &mut borrow_global_mut<Balance>(_addr).coin.value;

        let Coin { value } = check;

        *balance_ref  = balance + value;

    }

    public fun balance_of(owner: address): u64 acquires Balance{
        borrow_global<Balance>(owner).coin.value
    }


    public fun transfer(from: &signer, to: address, amount: u64) acquires Balance{
        // 1.withdraw from
        let check = withdraw(signer::address_of(from), amount);
        // 2.deposit to
        deposit(to, check);
    }

    fun withdraw(_addr: address, amount: u64): Coin acquires Balance {
        let balance = balance_of(_addr);
        assert!(balance >= amount, EINSUFFICIENT_BALANCE);

        let balance_ref = &mut borrow_global_mut<Balance>(_addr).coin.value;

        *balance_ref = balance - amount;

        Coin{ value: amount}

    }
}