// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract CastVoting {

    // Vote information
    struct Vote {
        string question;
        uint256[] options;
        mapping(uint256 => uint256) votesCount;
        address creater;
        bool closed;
        uint256 timestamp;
    }

    // Mapping from vote id to the vote information
    mapping(uint256 => Vote) public votes;

    // Array of vote ids to keep track of all the votes
    uint256[] public voteIds;

    modifier isVoteOwner(uint256 _voteId) {
        Vote storage vote = votes[_voteId];
        require(
            vote.creater == msg.sender,
            "The address is not owner of this vote id."
        );
        _;
    }

    /***** EVENTS *****/
    event VoteCreated(uint256 voteId);
    event VoteCast(uint256 voteId, uint256 option);
    event VoteClosed(uint256 voteId);
    /***** EVENTS *****/

    /**
     * Function to create a new vote
     *
     * @param _question  Question for the vote
     * @param _options   Options for the vote
     */
    function createVote(string memory _question, uint256[] memory _options)
        public
    {
        uint256 voteId = voteIds.length;
        voteIds.push(voteId);

        Vote storage vote = votes[voteId];

        vote.question = _question;
        vote.options = _options;
        vote.creater = msg.sender;
        vote.closed = false;
        vote.timestamp = block.timestamp;

        emit VoteCreated(voteId);
    }

    /**
     * Function to cast a vote
     *
     * @param _voteId  Id of the vote to cast the vote for
     * @param _option  Option to cast the vote for
     */
    function castVote(uint256 _voteId, uint256 _option) public {

        require(msg.sender != address(0), "Caller is the zero address");
        Vote storage vote = votes[_voteId];

        require(!vote.closed, "Vote is closed");
        require(_option < vote.options.length, "Invalid option");

        vote.votesCount[_option]++;
        emit VoteCast(_voteId, _option);
    }

    /**
     * Function to close a vote
     *
     * @param _voteId  Id of the vote to close
     */
    function closeVote(uint256 _voteId) public isVoteOwner(_voteId) {
        Vote storage vote = votes[_voteId];

        require(!vote.closed, "Vote is already closed");
        vote.closed = true;

        emit VoteClosed(_voteId);
    }

    /**
     * Function to get the vote information
     *
     * @param _voteId  Id of the vote to get the information for
     *
     * @return (question, options, closed status, timestamp)
     */
    function getVote(uint256 _voteId)
        public
        view
        returns (
            string memory,
            uint256[] memory,
            bool
        )
    {
        Vote storage vote = votes[_voteId];

        return (vote.question, vote.options, vote.closed);
    }
}
