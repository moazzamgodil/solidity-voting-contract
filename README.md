# Solidity Voting Contract

This is a Solidity contract for a simple voting system on the Ethereum blockchain. The contract allows anyone to create a new vote, cast a vote for a particular option in a vote, and close a vote at any time.

## Features

-   Create a new vote with a given question and options
-   Cast a vote for a particular option in a vote
-   Close a vote at any time
-   Get vote information (question, options, closed status)
-   Emits events for vote creation, vote casting, and vote closing

## Functions

-   `createVote`: Creates a new vote with the given question and options
-   `castVote`: Casts a vote for the given option in the vote with the given id
-   `closeVote`: Closes the vote with the given id, after which no more votes can be cast
-   `getVote`: Returns the question, options, and closed status of the vote with the given id

## Events

-   `VoteCreated`: Emitted when a new vote is created. The event includes the id of the new vote.
-   `VoteCast`: Emitted when a vote is cast. The event includes the id of the vote and the option that was voted for.
-   `VoteClosed`: Emitted when a vote is closed. The event includes the id of the vote.

## Testing

Unit tests can be written to call the contract's functions and assert the expected results.
