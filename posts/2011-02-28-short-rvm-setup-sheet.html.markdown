---
layout: single
title: 'A short RVM setup sheet'
tags: RVM, FreeBSD, Ruby
---
___RVM Installation on FreeBSD___

There are a few good steps outlined on the RVM website. This document is mostly echoed from those steps: [RVM install](http://rvm.io)

The author (originally Wayne Seguin) offers probably the best tech support available. He is on irc.freenode.net, but you'll have to authenticate in order to post. The best route is to Register on freenode , setup a username, and login to the #rvm channel with authentication. The web interface is pretty nice.

~~~
/msg nickerv identify <your password>
~~~~~
<p/>

___Basic Installation___


Most of these steps should NOT be run as root. Some of the dependencies will need to be. Install git, bash and curl. When these are installed, run bash and
and update your .bashrc with this line:


~~~
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
~~~~~
<p/>


Then:

~~~
chmod 600 .bashrc
~~~~~
<p/>

and edit .profile, adding the line as the last in the file:

~~~
source ~/.bashrc
~~~~~
<p/>


Log out of the console, and log back in to make sure everything works.
Now fetch rvm: 

~~~
bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
~~~~~
<p/>


Logout and log back in again. To test the rvm installation, it should say "rvm is a function" when the following is typed: 

~~~
type rvm | head -1
~~~~~
<p/>


___Updating the install___


You should probably run these 2 commands each time you login to your shell, but do it now to make sure you have the newest version:

~~~
$rvm get head
$rvm reload
~~~~~
<p/>


___Getting Dependencies and Ruby___

You'll have to check the notes for your platform: 

~~~
$rvm notes 
~~~~~
<p/>


> NOTE: You'll have to install a bunch of dependencies as root. For Ubuntu, for example it will give a list of packages to install: 

~~~
ruby: /usr/bin/apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev
~~~~~
<p/>

To find out which Rubies you can install, type:

~~~
rvm list known
~~~~~
<p/>

Now for the ruby installation (NOT done as root). Just choose the version, and run the following:  

~~~
$ rvm install 1.9.2  where the ruby version is 1.9.2. 
~~~~~
<p/>

This will take some time to build, since it's being built from source. Also, there will be no screen messages during the build process. When completed, both ruby and rubygems will be installed somewhere under your .rvm directory.

___Setting default Ruby & Gems___


If this is the first installation, you won't have any ruby or gems defined by default. So, to set your default ruby to ruby-1.9.2-p180 enter:

~~~
$ rvm --default use ruby-1.9.2-p180
$ rvm list
~~~~~
<p/>


The above lines will display which version is the current default. You can further verify with:

~~~
$ruby --version
$gem --version
~~~~~
<p/>


Next, set your default gemset to something bound to the purpose (say rails3)

~~~
$ rvm --create use 1.9.2@rails3
~~~~~
<p/>

This tells rvm to use ruby1.9.2 paired with the gemset called rails3. What happens is that rvm creates a separate set of gems to use with rails-1.9.2. If you should ever need to use another ruby and another version of gems, you can have multiple combinations hanging around, and simply tell rvm which one you would like to use. To verify the current gemset, type: 
~~~
$ rvm gemset list

~~~~~
<p/>

You should see an entry for "global" and your special gemset: rails3. At this point, you should update your gems to the latest. This is done by:

~~~
$ gem --version
$ gem update --system
$ gem --version
~~~~~
<p/>

You should see the version jump to the latest (currently 1.8.5.) There is some debate on whether any of these commands should be run as root, but I would not recommend it if everything appears to work. There is no sense giving root access to programs that do not need it, especially on web servers.


___Installing rails (optional)___


That should be it for the ruby installation. You can run ruby normally as the current user without worries. RVM basically intercepts calls to ruby and its utilities, and allows you to have everything installed in your local directory, as well as multiple versions of Ruby and Gems, which are kept as "Gemsets". 


Before installing Ruby on Rails, it's worth visiting the Rails website to determine the correct version. At http://rubyonrails.org there are three available, the release candidate (unstable), the dot-zero version (too old) and the bugfix version. In this case, the bugfix version is 3.0.7 so we will install that:

~~~
$ gem install rails --version 3.0.7
~~~~~
<p/>


All dependencies should binplace locally (in the .rvm subdirectory) and without 
the need for root access. You should be able to see what's installed with:

~~~
$ gem list
~~~~~
<p/>


If any troubles occur, or there is a need for build-time modifications, you can always poke around in the sources in the .rvm directory to customize anything you install.


___Maintenance___

~~~
$rvm get head
$rvm reload
~~~~~
<p/>
