//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20CappedUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract Token_V1 is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, ERC20CappedUpgradeable, ERC20PausableUpgradeable, OwnableUpgradeable {
    function initt() public initializer{
        __ERC20_init_unchained("BUMI TOKEN", "BUMI");
        __ERC20Burnable_init();
        __ERC20Pausable_init();
        __ERC20Capped_init(1e29);
        __Ownable_init();
        
        ERC20CappedUpgradeable._mint(msg.sender,1e29);
    }

    function _mint(address account, uint256 amount) internal virtual override(ERC20Upgradeable, ERC20CappedUpgradeable) {
        ERC20CappedUpgradeable._mint(account, amount);
    }
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override (ERC20Upgradeable, ERC20PausableUpgradeable) {
        ERC20PausableUpgradeable._beforeTokenTransfer(from, to, amount);

        require(!paused(), "ERC20Pausable: token transfer while paused");
    }

    function Pause() public onlyOwner{
        _pause();
    }

    function Unpause() public onlyOwner{
        _unpause();
    }

    function getSender() public view returns(address){
        return msg.sender;
    }

}
