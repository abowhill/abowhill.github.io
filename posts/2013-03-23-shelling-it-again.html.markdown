---
layout: single
title: 'Shelling it again'
tags: shell, scripts
---

Sadly again, I find myself using the punishing /bin/sh to script tasks in FreeBSD. And again, I am reminded how painful and time-consuming it can be to do some of the simplest things.

One of the first things you should realize is that sh is not Bash. It is Bash featureless ancestor - a kind of pygmy caveman. It is smaller, faster, and somewhat harder to work with. It has nearly meaningless error-messages.

One thing I am absorbing about the language this shell speaks is that variables take several forms.

__Left-hand side name:__

~~~
dinosaur="Dino"
~~~~~
In this form, a variable is recieving a value. 

__Right-hand side name:__

~~~
animal=$dinosaur
~~~~~
In tools form, $dinosaur is a variable is being used for something. Here, assignment to another variable.

__Formal name:__

~~~
${dinosaur}
~~~~~
The same as $dinosaur, but in this form you can change the entire tone and context of the name, like __\_$(dinosaur)!!\___, which will translate to __\_dino!!\___. 

__Verbing-name__

~~~
animal=$(dinosaur)
~~~~~
Although it looks like it, this is not a variable, but a command to do something in a shell. In this case, we are trying to call a program name "dinosaur" in the operating system. If dinosaur exists and replies, __$animal__ will hold the response.

__Deep verbing-name:__

~~~
$($dinosaur)
~~~~~
Just like the verbing name, but specificlly calling the program "Dino" in the operating system.

__Subshell verbing-name:__

~~~
`dinosaur`
~~~~~
Here, we are calling a subshell to try to run the program "dinosaur".

And so on. It's worth noting the shell has two parts:

+ The enviroment storage area
+ The shell storage area

The environment contains all the variables that have been exported to semi-protected storage, and will persist throughout the shell's various operating modes and subshells. However, the shell's unprotected variable storage area can be assigned-to without using the export command.

This is important in shell programming, because when you assign some value to a variable, names and values are stored in this unprotected environment. Unlike programming languages, the shell has no other way to store names and values. 

When you run a script from the prompt like this:

~~~ shell
> scriptname.sh
~~~~~

It runs in a subshell, and all the unprotected storage it used is destroyed when it returns, but the semi-protected environment is transferred to the subshell. When you run a script like this:

~~~ shell
> source scriptname.sh
~~~~~

it is not run in a subshell, and all the variables and values the script created are retained in the unprotected environment. This can have ramifications between subsequent runs if you don't reset your variables in your script.

It is also true that all variables are global by default in a script. So although these variables are often destroyed after the script has completed running in a subshell, you can get into trouble by assuming names are localized inside the body of the script itself.

Shell scripts do have callable functions, but they can't return values other than exit codes. If you want return values, you have to assign a global variable the role of holding a return value from all functions, and clear that variable at the beginning of every function. This is called defensive programming.

So the deal is, you can have functions effectively return two values: the status code (an integer, usually indicating failure or success) and a string containing some result data. 

Below, is a function to take a pathname as a string and and clean out duplicate slashes from it, returning it as a string. It also returns a status code, on whether the clean path was found (0) or not found (1). If the function was handed an empty input string, it returns (2) and if some other error occurs, it returns that too.

The test driver for the function basically calls the function and parses the results. The input to the test driver are various unclean paths.

I think it shows functions are viable in sh scripts, which can serve as an advantage to programming these things. But getting the syntax and behavior correct is actually quite hard to. 

Using Perl or Ruby, something like this can be done in minutes. Doing it in shell can take a lot longer, especially because it's a blind man's walk of trial and error, especially if you're used to more sophisticated languages where true is true and false is false; not having to call external programs for regular expressions, or are unaccustomed to built-in variables disappearing if you don't capture them right away.

~~~ shell
unset ret
 
fixpath()
   {
   unset ret
   [ -z "$1" ] && return 2
   ret=`echo ${1} | sed -r 's/\/+/\//g'`
   [ -e "$ret" ] && return 0 || return 1
   }
 
testfixpath()
   {
   unset ret
   path=$1
   echo "Input path: $path"
   fixpath "$path"
   err=$?
   echo "Output path: ${ret}"
 
   case $err in
     0)   echo "Return code $err (true) ${ret} exists.";;
     1)   echo "Return code $err (false) ${ret} does not exist.";;
     2)   echo "Return code $err (error) missing argument ${ret}";;
     *)   echo "Return code $err (undefined error) ${ret}";;
   esac
   echo "---"
   }
 
testfixpath "/foobar/me/////me///me//you.txt"
testfixpath "/usr/local/////sbin///"
testfixpath ""
~~~~~
