// sources/debug_script.move
script {
    use std::debug;
    fun main_script(account: signer) {
        debug::print(&account)
    }
}
