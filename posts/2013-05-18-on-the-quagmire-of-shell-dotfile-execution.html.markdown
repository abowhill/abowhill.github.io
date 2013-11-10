---
layout: single
title: 'On the quagmire of shell dotfile execution'
tags: shell, FreeBSD
---

Have you ever tried to get a third-party full-color 4-directional scrolling pager (aka: most) working under bash so you can see manpages in full color, and have programs like mergemaster call up a special viewing window rather than just scrolling stuff across the screen? You are in for a treat if you use FreeBSD.

Getting this to work is not as easy. And it's all related to the dot-file quagmire underlying every *nix terminal session. The nature of this quagmire is the quad-mode operation of *nix shells and all the dotfiles they potentially execute, depending in which mode the shell is run. And a bunch of other stuff.

Shells generally have two status modes of operation under which they are run: as a "login" shell or not, and as an "interactive" shell or not. A login shell means the shell goes through the login process before it runs. An interactive shell means the shell offers a prompt and waits for user input. Since these modes of operation are either on or off for any given shell session, this gives rise to four potential states of operation of a shell, depending on what kind of task you perform.


+ A login-interactive session, like logging-in and browsing through directories at a prompt (which is what  most of us mostly do.)
+ A session that is neither login or interactive, like a scripted cron job that is run at 3 am the first Thursday of every month.
+ A login-only session, like an ssh remote execution command where you tell ssh to login to a machine, do something, and logout again. (I don't do this a lot, but have needed to on occasion. It feels hackish.)
+ An interactive-only session, like running a subshell when you are already logged-in, like running one shell from another. (For example, I am at the bash prompt, but want to use sh, so I just type "sh" at the prompt.)

The complication arises out of which dotfiles are executed in for each mode. Depending on how you are running things; the context of the shell's use; and what other shells are installed, different dotfiles will execute in non-obvious ways. There are even system-wide dotfiles in /etc that are searched, and some shells (like fish) will store totally non-standard configurations.

For example, if my shell is /bin/sh, and I login to interact with it (scenario #1) on FreeBSD, a file called .profile in my home directory is executed, followed by .shrc, that has effectively been "sourced", or included from the .profile script by getting placed into the environment. If I have the c-shell as my login shell, it's .cshrc, then .login is executed. If I use bash, .bash_profile is run. But then again, it entirely depends on what system you run and what shells (and dotfiles) you have installed.

In scenario 2, you should generally expect few dotfiles to be called, if any. Scenario 3 might give you half of what you expect, and scenario 4 might give you another or the same half.

To amplify the madness, shells that are related or in the same family (csh begat tcsh, sh begat bash) will often search-for and use each other's dotfiles, if present. Sometimes, the order of their searching isn't clear, it's just whichever they happen to come across first, file a, file b, or file c.

Worse yet, you may have no choice if you want to run any important 3rd party frameworks, like RVM or Git, which depend on the presence (usually) of bash.

This ... chaos has a net effect of making a monumental task out of a simple thing installing a like a pager like most to behave in the way you would expect. 

So, here's what I did -- and it sort of works, for whatever it's worth.

First, I went into all the dotfiles and put the line echo "Running $HOME/<dotfile>" near the beginning of each file, to see what exactly was executing when I logged in or ran things in various modes.

Next, I placed the command 

~~~
PAGER=/usr/local/bin/most; export PAGER
~~~~~
<p/>

in .cshrc, .mailrc and .profile, just so there weren't any local references to the pagers less and more (both of which I hate because they are unnecessarily painful). Bash has a built-in less-like pager it uses, and you gotta watch out for that one. It can be a real disappointment if it shows up unexpectedly).

Since I am a conscripted Bourne-shell-type user, I sourced .profile from .bash_profile and .login  to .bash_login. (Even though this sounds logical, I don't think the second one makes much sense. But there you have it. It's there for the feel-good factor.)

So far, all this seems to work - but not for sudo tasks yet. It's taken hours, and there are still things that don't make sense. But hey if it works, don't fix it.

Here's a resource that attempts to [make sense of it all](https://github.com/sstephenson/rbenv/wiki/Unix-shell-initialization), and I still have problems with it.

Good luck!
