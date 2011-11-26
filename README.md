Negatives
=========

![Pyscho](https://github.com/spagalloco/negatives/raw/master/psycho.png)

Negatives is a ruby library for quickly resolving image urls from link shorteners and image hosting services like yfrog and twitpic.

Installation
------------

    (sudo) gem install negatives

Usage
-----

    Negatives.extract('http://twitpic.com')
    # => 'http://twitpic.com/show/full/6yckws'

TODO
----

* more image services: flickr, lockerz, pic.twitter.com, etc.

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2011 Steve Agalloco. See LICENSE for details.