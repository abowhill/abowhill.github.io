---
layout: single
title: 'ZFS: A truly Superior Filesystem'
tags: zfs, FreeBSD
---

My wife just recently got a new HP Chromebook, causing her to rapidly abandon her 3-year old Toshiba NB 205 netbook. This gave me a new computer to experiment on, and of course I installed FreeBSD.

This is a very low-powered machine, with a ton of case-edge built-in peripherals. It has 2G ram, and an internal disk upgraded to 230G. It originally came pre-packaged with Win7 "Starter" edition and a bunch of Toshiba bloatware, which makes it the perfect target for an OS nuke and wicked post-nuclear experimentation.

As my new testbed, this machine is running some of the newest, up-and-coming features of FreeBSD, among which is ZFS. I used these instructions for [Road Warrior laptop](http://forums.freebsd.org/showthread.php?t=31662 "click me!").

If you have ZFS, Perl and beadm installed, I wrote this little shell script to dump information from a variety of sources on FreeBSD

~~~ shell
#!/bin/sh
echo "========================================================"
echo "Command: >> gpart show"
gpart show
echo "========================================================"
echo "Command: >> df"
df -H
echo "========================================================"
echo "Command: >> zpool list"
zpool list
echo "========================================================"
echo "Command: >> zfs list"
zfs list
echo "========================================================"
echo "Command: >> beadm mount"
beadm list -s
echo "========================================================"
echo "Command: >> ls -alF /.zfs/snapshots"
ls -alF /.zfs/snapshot
echo "========================================================"
echo 'Command: >> gpart list | perl -ne /(Name:|label:|type:)/ && print $_;'
gpart list | perl -ne '/(Name:|label:| type:)/ && print $_;'
echo "========================================================"
echo "Command: >> zpool status"
zpool status
echo "========================================================"
echo "Command: >> zpool get all"
zpool get all
echo "========================================================"
echo "Command: >> zpool history"
zpool history
~~~~~

What is ZFS exactly? The skinny is that it's Sun's newest(ish) file system that seriously improves on anything else in existence right now. By far and away, it is the most seriously sophisticated file system out there today. It's on OpenSolaris now, and FreeBSD developers have been quietly tooling away at it for a few years now. I expect/can only hope it will ultimately replace UFS.

[ZFS:about](http://hub.opensolaris.org/bin/view/Community+Group+zfs/whatis)

Some things ZFS has that other FS do not:

__End-to-end Data integrity:__ According to Wikipedia's ZFS article (https://en.wikipedia.org/wiki/ZFS) about 1 in 90 hard drives have undetected failures that neither hardware nor software can normally catch. This phenomenon is called "silent corruption", and is experienced at large data providers and small ones with cheap hardware. ZFS can be employed in these cases, to detect and repair silently corrupted data because it uses all kinds of mechanisms to validate and store data that raid doesn't. 

__Snapshots and Boot Environments:__ Similar in concept to Win7 restore-points, this feature gives you the ability to create perfect bootable copy (a snapshot) of an existing OS. On the Toshiba, it takes only 3-5 seconds, and uses a nominal amount of disk space (try that on Win7). You can clone these, boot into them, destroy them, mount them or even export them to another system. The boot configurations concept is from Solaris. If you install a copy of a utility called beadm from the ports tree, it emulates Solaris' nice interface in FreeBSD, and offers even more elegance than using the two management utilities: zpool and zfs

__No fsck:__ ZFS uses a maintenance technique called "scrubbing" which is run periodically, as frequently as you would run an SSD optimizer or defragmenter. Scrubbing, unlike fsck, can be run on an online, mounted, active disk, and checks not only metadata, but the data itself for corruption. Auto-repair is done via RAID-Z (ZFS software raid, another feature) or by a kind of on-disk bit replication mechanism which looks into redundant copies for good replacement data. In ZFS, copy-on-write semantics are used, so data on the disk isn't corrupted the same way it can be on a normal file system.

__No partitions or volumes:__ Hardware is organized using into datasets and zpools, or virtualized storage. No formatting, slices or fdisk. You can easily create filesystems within these pools, and other filesystems. You can add disks in as mirrors from the command line, impose quotas on filesystems, reserve storage, share storage, compress, have transactions, and no real limits on numbers of directories, number of filesystems, paths, and other things normally imposed on file systems.

And there are more features. It's almost mind-boggling. ZFS seems to do E0VERYTHING right, and it's just too good to pass-up.

[ZFS info](http://hub.opensolaris.org/bin/download/Community+Group+zfs/docs/zfslast.pdf)

[FreeBSD ZFS info](https://wiki.freebsd.org/ZFS)
