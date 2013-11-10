---
layout: single
title: 'Ruby RVM redux (RVM on Windows too!)'
tags: ruby,FreeBSD, rvm
---

### Installing Ruby using RVM 

Using Wayne Seguin's RVM (Ruby Version Manager) is definitely the best way to go for installing Ruby on most UNIX platforms. It allows any kind of Ruby to be installed, even multiple versions, and will keep everything in the home directory under .RVM, so no admin-level system installations are required. It is very well maintained, and considered the defacto standard for maintaining and updating Ruby installations. Visit [http://rvm.io](http://rvm.io) for more information. After installation, use: rvm notes for up-to-date information about the installed framework.

### UNIX Installation 

These instructions should help you get RVM and Ruby MRI installed. During this process, you must be connected to the network the whole time. RVM will download things during the build.

First, install the bash shell. Bash is the required login shell for the account in which RVM is installed. RVM installs itself as a Bash function. For X-Windows: Make sure your terminal is set to call a login shell with

~~~ shell
bash --login 
~~~~~~
<p/>

Next, install the package: curl

Do this as  root using your OS package manager. The specifics will depend on your system.

NOTE: Do not run the rest of these commands as root. RVM requires they be run with the same privileges as the account you.re logged into.

~~~
$ \curl -L https://get.rvm.io | bash -s stable 
~~~~~~
<p/>

(Include the forward slash at the beginning of the command line.)
This installs the RVM framework

~~~
$ rvm list known 
~~~~~~
<p/>


The above command list all the possible rubies that can be installed. We will use MRI version 1.9.3 in this example, but the latest one should be used. That.s the one under the MRI section listed just before -head. The current minor version is p385.

~~~
$ rvm requirements
~~~~~~
<p/>

The above command lists all dependencies and tasks needed to build and install Ruby. Execute all instructions given. These are required software installations. Failure is likely to occur with the build or runtime if the steps are not taken. RVM will tell you what you need to do to prepare your system, and hand you the command lines to do it.

~~~
$ rvm install 1.9.3 
~~~~~~
<p/>

The above command compiles Ruby 1.9.3

~~~
$ rvm use 1.9.3 --default 
~~~~~~
<p/>

The above command sets the built ruby as current and default version.

~~~
$ rvm info 
~~~~~~
<p/>

The command above verifies the Ruby installation.

~~~
$ ruby --version 
~~~~~~
<p/>

Now all that's left is to verify IRB behaves properly:

~~~
$ irb  
~~~~~~
<p/>


### Windows installation (cygwin) 

Goto [Cygwin's web site](http://www.cygwin.com) and download setup.exe from the link on that page. Save the program to your desktop. It is your only package manager. This is the [direct URL to the binary](http://cygwin.com/setup.exe)

Double-click setup.exe and follow the wizard steps to the package manager screen. That's the one with all the software categories in a tree. Use the search box to locate and install the following packages and all their dependencies:

~~~
curl (net/curl) 
libcurl-devel (net/libcurl-devel) 
cert (net/ca-certificates) 
~~~~~~
<p/>

Open the cygwin bash shell from the desktop icon or start menu. Install RVM from inside the shell:

~~~
$ \curl -L https://get.rvm.io | bash -s stable 
~~~~~~
<p/>

Exit the shell and re-open it.

Run:

~~~
$ rvm requirements
~~~~~~
<p/>


The above command lists all dependencies and tasks needed to build and run Ruby. This is a must-do step. But since the cygwin third-party packages change so much in their availability, you may have to fudge a bit in installing some things listed.

For example, rvm requirements lists the build-essential package to be installed. That is a meta-port of a bunch of build tools. At the time of writing and testing this, the build-essential package was available in the cygwin package manager. An hour later it disappeared without a trace.

Since this ingredient is so important, I.ve listed the tools below that I think were in the meta-port.. When possible, choose -devel versions of the software, and select the mingw ports if available.

Here is a mostly-correct list of packages to select and install:

~~~
mingw-gcc-g++ 
make 
mingw-zlib1 
libyaml-devel 
libsqlite-3-devel 
sqlite3 
libxml2-devel 
libxslt-devel 
autoconf (highest version) 
libgdbm-devel 
ncurses-devel 
automake (latest) 
libtool 
bison 
pkg-config
readline: GNU readline
~~~~~~
<p/>

Now compile Ruby 1.9.3:

~~~
$ rvm install 1.9.3 
~~~~~~
<p/>

And now set the built ruby as current and default version:

~~~
$ rvm use 1.9.3 --default 
~~~~~~
<p/>

Verify the Ruby installation:

~~~
$ rvm info 
$ ruby --version 
~~~~~~
<p/>

Lastly, verify irb does not crash

~~~
$ irb
~~~~~~
<p/>
