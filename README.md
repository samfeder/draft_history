Draft History
=============

A simple ruby script to build a mini API for working with draft history data from your ESPN Fantasy Football auctions.

### How to use

Glad you asked, open the directory containing draft-history.rb and open up irb/pry, and load that sucka in.

Now you have a Ruby object called `@draftboard`.

```ruby
pry(main)> @draftboard.teams[0].owner
=> "Sam Feder"

pry(main)> @draftboard.teams.map{|team| team.owner}
=> ["Sam Feder",
 "Nicholas Piscani",
 "Eric Furspan",
 "Jesse R",
 "Gregory Becker, Jonathan Abossedgh",
 "jason vigotsky",
 "Anthony D",
 "A Schreiber",
 "Randal Jason Caburnay",
 "frank voce",
 "Emmet Meehan",
 "Shane Jacobs"]

pry(main)> @draftboard.team_owned_by('Eric Furspan').prices_paid('qb')
 => [31, 11]
```
