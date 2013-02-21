# govweb

[![Dependency Status](https://gemnasium.com/miketheman/govweb.png)](https://gemnasium.com/miketheman/govweb)

## WTF is this?

To anyone that manages a Github Organization:

It kind of sucks, right?

Very often, as teams grow, as repository count increases, we get into a snarl of
permissions, who has access to what, and at some point a lot of us just give up,
and give access to everyone via one team.

Well, if you've been in a tangled situations before, this webapp attempts to
help by visualizing the relationships between user, team and repo.


## Where did it come from?

I'm big on tools that help you do your job. I'm an ops person, in charge of
security, permissions, delegation, automated builds, etc.

I also firmly believe in the power of visualization. If you don't well, go
somewhere else.

In this app's previous lifetime, it was a CLI tool that generated a static PNG
file using Graphviz, as that's a fairly straightforward tool for building
relationship graphs.

I figured it would prove more useful if it was a more dynamic image, something
you could click on and see more details, and overall more feature-full.

I am by no means a web developer, and cobbled together a lot of Other People's
Software, and produced something viable.


# TODO
I really wanted to try out d3.js - I think some of the networks look pretty
awesome, but in the interest of time and simplicity, I used Sigma.js instead.

If someone with more JavaScript/d3 on their hands wants to take a stab at it,
then by all means, pull requests are welcomed.

## Things used

* sinatra 1.3.3
* twitter bootstrap 2.2.2
* jQuery 1.8.3
* `sinatra_auth_github` (uses `octokit` under the hood)
* sigma.js
* coffee (the drink, not the script)
