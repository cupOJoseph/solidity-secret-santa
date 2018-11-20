# solidity-secret-santa
Smart contracts to facilitate secret santa.

## Use
Deploy this contract to the ethereum blockchain.

### Starting
Default, the 'signups_open' variable is true.

#### Join

Call the Join function to join as a participant. Anyone can do this. Please, once per person. Calling the Join function from the same address more than once will enter you more than once. 

The contract will keep track of your ethereum address (where you might get gifts) and also asks for some other data about you.
Please include in your string of data:
- an email address.
- Things you like to give your secret santa ideas. Good: sweaters, kitties, chocolate. Bad: give me btc, a red sweater with a blue stripe.
- an actual IRL address for mailing you nice things.
- double check email is correct.

#### Announce
Allows only the owner to announce who should give presents to whom. Emits lots of events. We will use [chainrelay](https://chainrelay.com) to notify you when this happens and tell you show you should give something to.

#### Helper Functions
Reopen signups. Straight forward.

## Trivia

- Why use emails and do facilitating offchain?? TRUST REEEEEEEE
Because we want to be able to give each other in person gifts, like a printed cryptokitty, or an ugly sweater that says "dogecoin to the moooon"

- Owner can reopen signups any time. They can only close signups by announcing.
