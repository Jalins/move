module tokenswap::USDC{
    use aptos_framework::coin;
    use std::string;
    use aptos_framework::coin::{BurnCapability, MintCapability};
    use std::signer;

    struct  USDC{}

    struct HoldCap has key{
        burn: BurnCapability<USDC>,
        mint: MintCapability<USDC>,
    }

    public entry  fun init_token(sender: &signer){
        let (burn, freezse, mint ) = coin::initialize<USDC>(sender, string::utf8(b"move USDT"), string::utf8(b"USDT"), 8, true);
        move_to(sender, HoldCap{burn, mint});

        coin::destroy_freeze_cap(freezse);
    }

    public entry fun mint_token(sender: &signer, amount: u64)acquires HoldCap {
        let addr = signer::address_of(sender);
        if (!coin::is_account_registered<USDC>(addr)){
            coin::register<USDC>(sender);
        };

        let cap = borrow_global<HoldCap>(@tokenswap);
        let mint_coin = coin::mint(amount, &cap.mint);

        coin::deposit(addr, mint_coin);
    }
}