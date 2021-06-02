// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC1155.sol";
import "../../../security/Pausable.sol";

/**
 * @dev ERC1155 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 *
 * _Available since v3.1._
 */
abstract contract ERC1155Blacklistable is ERC1155 {
    event AddedBlackList(address _user);

    event RemovedBlackList(address _user);

    mapping (address => bool) public isBlackListed;

    function getBlackListStatus(address _maker) public view returns (bool) {
        return isBlackListed[_maker];
    }

    function _addBlackList (address _evilUser) internal virtual {
        isBlackListed[_evilUser] = true;
        emit AddedBlackList(_evilUser);
    }

    function _removeBlackList (address _clearedUser) internal virtual {
        isBlackListed[_clearedUser] = false;
        emit RemovedBlackList(_clearedUser);
    }

}
