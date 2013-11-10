---
layout: single
title: 'A Neat Trick'
tags: Unix
---
The [Linuxcommando Blog](http://linuxcommando.blogspot.com/2008/06/show-progress-during-dd-copy.html)  showed a neat inter-process commandline trick that really shows the versatility of the UNIX terminal. It involves prodding a process running in one terminal with a signal from a shell prompt in another, making the process in the first terminal tell something about what it's doing.

The specific scenario has to do with dd, the UNIX tape drive copying program. It essentially gives no status while it's running, which for large file copies can be annoying, especially if things are going rather slow. The deal is, once you fire off dd on a long copy, it doesn't say anything until it's done. Below is a command to copy a 900+ MB recovery image to a flash drive:

~~~~ shell
dd if=chromeos_0.15.1011.118_x86-mario_recovery_stable-channel_mp-v2.bin of=/dev/da0
~~~~~~
<p/>

Due to the slow transfer speed of flash drives, and the large size of the file, this can take 20 minutes and dd will (dutifully) not report anything during that period. However, (on FreeBSD) if you open another terminal and discover the process ID of the dd process, you can prod it into telling you what its progress is:

~~~~ shell
sudo kill -SIGINFO 18940
~~~~~~
<p/>

Every time you run this, the process running in the first terminal will spit out something like this on stderr, but it won't stop running:

~~~
71055360 bytes transferred in 262.988274 secs (270185 bytes/sec)
346343+0 records in
346342+0 records out
~~~~
