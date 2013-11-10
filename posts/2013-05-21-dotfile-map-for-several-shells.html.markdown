---
layout: single
title: Dotfile map for several shells
tags: shell, dotfile
---

Here is a preliminary dotfile invocation map for several FreeBSD shells:

+ /bin/sh
+ /usr/local/bin/bash
+ /usr/local/bin/ksh93
+ /bin/csh 
+ /bin/tcsh. 
READMORE


~~~
/bin/sh 
/usr/local/bin/ksh93
   1. /etc/profile | /etc/suid_profile (if -p)  (login)
   2. ~/.profile (login)
   3. $ENV (interactive) | ~/.kshrc (interactive, ksh93 only)
   Order: (1,2,3)
 
/usr/local/bin/bash
   1. /etc/profile  (login)
   2. [~/.bash_profile | ~/.bash_login | ~/.profile (login)] | [~/.bashrc (interactive only)]
   3. $BASH_ENV (non-interactive)
   4. ~/.bash_logout (login)
   Order: (1,2,3,4)
      
/bin/csh
/bin/tcsh
      1. /etc/csh.cshrc (login & interactive)       
      2. /etc/csh.login (login)
      3. ~/.tcshrc (tcsh only) | ~/.cshrc (login & interactive)
      4. ~/.history | $HISTFILE (login)
      5. ~/.login (login)
      6. ~/.cshdirs | $DIRSFILE (login)
      7. /etc/csh.logout
      8. ~/.logout
      Order: (1,2|2,1) (3,4,5 | 3,5,4 | 5,3,4) (6,7,8)
~~~~~~
<p/>

This information was taken from manpages and not completely tested on my own systems, but you can see how important execution context (aka: interactive, login) is to dotfile script execution. Actual out-of-box behavior can vary, depending on what is being done in pre-installed dotfiles.

For example, for /bin/sh and ksh93, the local environment variable ENV will determine at execution-time whether the shell runs an additional dotfile on login: either .shrc or .kshrc. And I still may not have the rules down correctly. It's very easy to be wrong when trying to describe this behavior in simple terms.

My general impression is that this needs to be harnessed and organized.

I am contemplating testing a system of indirect links to shell dotfiles, using the following scheme:

__First__, place all real dotfiles from all shells in a ~/shell-dotfiles directory, with their names prefixed by "DOT" as in DOT.kshrc and DOT.profile.

__Second__, create a ~/.sane directory containing the following subdirectories:

* interactive
* login
* neither
* both
* (non-interactive?, non-login?)

Under each of those four subdirectories, have a subdirectory for each shell, containing links to files read in that particular mode.

So, for example, dotfiles executed in a Bash interactive-login mode would be linked (either hard or soft) under ~/.sane/both/bash, to their corresponding real dotfiles in ~/shell-dotfiles. So specifically, .profile (as one case) would have a link under ~/.sane/both/bash/DOT.profile to ~/shell-dotffiles/DOT.profile.

__Third__, links would be created from the dotfiles expected locations in $HOME to the corresponding link in ~/shell-dotfiles. So, for example $HOME/.profile would link to ~/shell-dotfiles/DOT.profile,.

So, there would always be one place to store the real files flatly (~/shell-dotfiles) and conspicuously so there is never a name conflict. Secondly, there is a a single place to store shell dotfiles specifically, used or unused. Good for spot backups. Also, if hard links are made, there is some referential integrity to the whole thing.

The purpose of the ~/.sane directory would be to have a place to edit a file based on the shell and particular login scenario, like interactive-only or login-only. It would be very clear  when editing in the ~/.sane directory that you were editing for a particular context, and could be better informed about the expected set of consequences.
