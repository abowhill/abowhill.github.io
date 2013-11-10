---
layout: single
title: 'Upgrading a -STABLE ZFS system with clang'
tags: FreeBSD, clang, zfs
---

One of the technologies I was interested in testing along with ZFS was the LLVM-based clang compiler suite on FreeBSD, which is currently under integration and slated officially to replace the gcc/g++ compiler suite in FreeBSD 10.  Right now, clang is in the 9-STABLE base system alongside gcc/g++.

Clang has a lot of virtues compared to gcc/g++ among which are:

+ Better, more informative error messages
+ Better compliance for c++
+ Better support for IDEs and diagnostic tools
+ Uses less memory
+ Has JIT support
+ Isn't monolithic, as is gcc/g++
+ BSD license, so commercially viable.

This is one of the things I love about FreeBSD. It's always kept as commercially viable as possible with the BSD license. There is no reason to use open source software at work or home that has restrictive licensing. Adoption of clang is just another good reason to use FreeBSD.

Instructions for building the OS with clang are located at: https://wiki.freebsd.org/BuildingFreeBSDWithClang

This page has some useful tips, and there are a couple worth mentioning here. If you want to buildworld and your kernel with clang, you have to enable the clang suite in /etc/make.conf to replace gcc/g++:

~~~
CC=clang
CXX=clang++
CPP=clang-cpp
~~~~~
<p/>

If you do a:  

~~~ shell
make buildworld kernel 
~~~~~
<p/>

with the default command line options, it should work just fine. Nothing further to do.

However, if you're feeling cautious and want to test the kernel itself first, run the following from /usr/src:

~~~ shell
make kernel KERNCONF=GENERIC INSTKERNNAME=clang
~~~~~
<p/>

The line above builds a GENERIC kernel called clang, but places it into a separate directory along with its modules in /boot. This way, you leave your previous gcc kernel in place, yet can test the clang kernel easily with some intervention at the boot loader.

If you go this route, when you reboot, drop to the bootloader (option 2) and enter the following to change the module path to boot into the clang kernel:

~~~
set module_path=/boot/clang
boot clang
~~~~~
<p/>

If the kernel panics, there is no need to do so yourself. Just reboot into the old gcc /boot/kernel without intervention, and it will load by default. If you moved or destroyed the old kernel instead, and the option isn't available you can always opt to load /boot/kernel.old and its modules instead from the boot loader.

However, a clang boot will likely work, and the system should boot and enable you to make kernel buildworld, installworld, etc. This worked fine for me, but on one machine there was a kernel panic bootstrapping the system due to (probably) module installation paths, which was fairly easy to address.

For some reason, the clang kernel was loading but clang modules were not. I decided to reinstall the kernel again, leaving off the KERNCONF=GENERIC build option:
<p/>

~~~
make reinstallkernel
~~~~~
<p/>

Which did the trick.

Once booted, a subsequent view of dmesg will show which compiler was used to build the kernel.

I will be experimenting with this ZFS clang build setup for a little while, and note some of the issues I come across in following posts, but so far, ZFS and clang kernel/OS are performing nicely on my little underpowered Toshiba NB 205 netbook!

> Note: Rebuilding the kernel/OS worked fine on my server machine - an old Celeron 1G box.
