---
layout: single
title: 'A Notation for Functional Design with Binary Outcomes'
tags: design
---

I've been working out the design for a Ruby program that builds regular, plain old  jails over the past couple of days.

After identifying and reading-up on the problem domain, then writing a set of manual setup instructions for it (still underway[^1]), I felt I knew enough to begin design. The program I'm writing is kind of a warm-up to eventually writing a script that installs service jails, which is an advanced setup task.


The program operates at the "glue" layer of coding (see last blog post on Object Oriented Design) and I began writing the thing using the Bourne shell. After encountering a problem with pattern-matching command line options, I became very discouraged about the extremely limited capabilities of the Bourne shell. To the most simple tasks we take for granted in Perl, we have to call two or three other programs in Bourne, and call a sub-shell and use the environment to do it.

The only reason to use Bourne shell scripts is to follow the old Unix grind that states "It's good engineering practice to employ technologies that preexist in the OS, because someone might not have XYZ dependency installed on the system to make use of your program"

Although this may be true, after reading about the speed of Perl one-liners against the awk and sed counterparts for pattern-matching, I don't understand why Perl was taken out of FreeBSD in the first place. Absolutely obstinate adherence to tradition. Perl was part of the base OS until a political rift swept away some of the FreeBSD leadership post-911/dot-com implosion. But what little is wrong with FreeBSD these days is another story.

In any case, I felt like loosing my cookies when faced with the prospect of using such primitive, awkward technology just to live up to an old UNIX grind. So I decided to choose my kind of tool: Ruby!

I decided, as an experiment, to design my jail-building program from the outside-in, with an emphasis first on user interface. I wrote a few short shell scripts with the prefix "simple_jail" and tested them to see if they covered all my use cases from beginning to end:

~~~
simple_jail_config
simple_jail_init
simple_jail_start
simple_jail_stop
simple_jail_jump_in
simple_jail_ssh
~~~~~
<p/>

These scripts have no options, logic, control flow or conditional instructions in them. They are simple linear sets of commands that just work for a single, fixed configuration.

Next, I translated these items into command options:

~~~
simple_jail <configure|initialize|rootlogin|sshlogin|start|stop> <ip_address> .. <subargs>
simple_jail configure <ip_address> <hostname> <username> <password>
simple_jail initialize <ip_address>
simple_jail start <ip_address>
simple_jail stop <ip_address>
simple_jail rootlogin <ip_address>
simple_jail sshlogin <ip_address>
~~~~~
<p/>

These are the options I could realistically support.

At this point I researched my choices for options-handling. I could either write this myself, use one of two Ruby libraries, or use one of several third-party gems. Each of these packages has somewhat limited features, and may or may not support my command line schema above. Although one of the Ruby built-ins looked like a good candidate, I needed to verify exactly what I would be doing for validation checks once I actually obtained the user's options. So I began to write a long set of logical rules like the ones below:

~~~
# check arguments
#
#   if there is one and only one valid option provided
#     and one and only one ip_address provided
#   pass
#
#   if option is configure
#     validate confugure subargs
#       one and only one hostname
#       one and only one username
#       one and only one password
#   pass
~~~~~
<p/>

At that point, I began to ask myself: what would the supporting function names be for doing systems checks on these options rules? And what other checks would I want to do globally? For example:

~~~
# Process_and_environment_checks:
#
# script_running_in_jail? true : false
# script_running_as_only_copy? true : false
# script_running_as_root? true : false
# jail_already_running? true : false
~~~~~
<p/>

I kind of put together a list of function calls that represented checks to options and the system globally, and found myself using a concocted notation to describe sequential program behavior that was helpful in thinking about algorithmic steps.

It's based on the true false short testing line found in many languages which takes the familiar form:

~~~
<expression> ? <expr if true> : <expr if false> # documentation
~~~~~
<p/>

This idiom takes an expression (left), evaluates and tests it for true or false,then evaluates one of the two following expressions for a return value. The true return expression is after the "?". The false return expression is listed after the colon ":". It's kind of a shorthand boolean method.

In my twisted version of this idiom, I use it to represent a line of code in a sequence of function calls in a very high level, hypothetical language:

~~~
<function_name> ? <happy-ppath return value> : <sad-path return value> # error message describing sad path
~~~~~
<p/>

For example, some function calls using this notation return only true or false. These are status checks. For example:

~~~
jail_dir_exists ? true : false
~~~~~
<p/>

The method jail_dir_exists does the checking. The return values are a simple booleans.

In other cases where I used this notation, a function call is made, and if it succeeds, it takes the happy path, and if it fails, it takes the sad path: For example, a function that adds a new jail entry to the configuration file:

~~~
configure_add_new_jail continue : exit # could not create new entry
~~~~~
<p/>

In the case above, the function configure_add_new_jail is called. If it succeeds, the program proceeds silently to the next step in the program sequence. If it fails, an action is taken: exit the program. The part to the right of the hash is the error message sent to the console on failure.

In a slightly more complex form of this idiom, a function calls another conditionally. For example, in a utility function:

~~~
user_jail_dir_destroy? jail_dir_destroy! : exit # true = user answers 'y'
~~~~~
<p/>

Above, the user is prompted to destroy a partly-created or preexisting jail on the system by the user_jail_dir_destroy function. The precondition is that he has, at some point in the past,  run the script with the "initialize" option, which essentially runs "make installworld" and ":make distribution" of a new jail from the host's object tree. If he previously built this jail (partly or fully) he might be unaware of it when running the script this time around, and would need to be prompted for which action to take to prevent his previous work from being overwritten.

So the gist of the pseudo-code line above is to provide the logical plan for doing so. The documentation to the right of the hash describes the mapping between the user's response to the [y/n] prompt with the true or false return parameter. In this case, the one needing description is the true parameter, which contains a call to another function to actually destroy the jail directory:

~~~
jail.dir.destroy! continue : exit # true = chflags and rm -rf on jail succeeded
~~~~~
<p/>


Above, if the destroy function fails to delete the directory, the program exits.But the interesting case is what happens if it succeeds, so that is documented with a message - which could be used in debug mode. In this case, if the operation succeeds, the function returns and the happy path is resumed.

So basically, for each option taken on the command line, I have been defining steps to be taken in this revised true/false idiom format. It's not only compact, but can be edited in a plain text editor as something of a low-level program specification.

The interesting thing is, if you get enough of these statements going, class names begin to emerge, suggesting an underlying object model:

~~~
host.configure.etc.dir.exists? true : false

jail.dir_empty? true : false

configure.file.entry_valid? true : false
~~~~~
<p/>

Above, I can replace underscores with dots and get some idea of how refined I want to make the potential class structure. Note I don't have to know what the classes are *before* writing psuedocode. The steps in psuedocode collect, and define emerging class names as I go.


[^1]: The [notes](https://docs.google.com/document/d/1y2c1O0mAagWD0Eypw0EuB_BbN5vm0MMjrrwLkvfnVcI/edit?usp=sharing) are my own, pilfered from a variety of sources, and should be taken with some advice and caution. They are still incomplete.




