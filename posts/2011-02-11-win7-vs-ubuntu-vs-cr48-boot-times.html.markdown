---
layout: single
title: 'Win7 vs. Ubuntu vs. CR-48 boot times'
tags: Windows, Win7, Chrome, cr-48, Ubuntu, benchmarks
---

I just completed a little informal testing of boot times between Win7 and Ubuntu 10.10. Just for fun I included times for the same operations on the Google CR-48 netbook laptop running Ubuntu. 

Amazingly, between Ubuntus, the desktop machine with somewhere near twice the processing power was at least 50% slower on booting than the Google CR-48 laptop. And Win7 was approximately 50% slower to achieving a state of usability than Ubuntu on the same desktop machine.

Why is the CR-48 so fast? Well, the BIOS boots about 4x faster. Plus Ubuntu on the CR-48 has no swap file to contend with, and therefore no disk thrashing (even if you could thrash a drive with no moving parts.)

However, comparing Ubuntu and Win7 desktop boot performances was a bit more subtle. Superficially, each OS had fairly close stage booting times to each other, with main exception being disk spin-down after a stage was reached. Ubuntu had much less disk spin-down than Win7, and thus became usable much sooner. I think this is mainly due to the way Win7 loads its drivers and prepares its files.

Disk spin-down was measured by when the drive light stopped being solid. From a practical perspective the OS is basically unusable until disk activity allows for some breathing space. Performance can even be made worse if applications are launched before the disk stops intensely thrashing. 

___Informal boot time comparisons___

|:------|:-----|:------|:----|
|  Stage  |  Win7 on Intel Desktop  |  Ubuntu 10.10 on Intel Desktop  |  Ubuntu 10.10 on Google CR-48 laptop  |
|:------|------:|------:|-----:|
| Power on to Boot Select |20s | 20s | 5s |
|===
| Boot Select to Login Screen | 27s + 23s spindown | 27s + 1s spindown | 15s + 0s spindown |
|===
|  Login Screen to Desktop | 10s + 30s spindown	| 18s + 1s spindown | 1s + 0s spindown |
|===
| Desktop to Power Off Shutdown	| 20s-35s | 5s | 2s |
|======
{: rules="groups"}
<p/>

To be fair, the Windows machine had more software to load that would not be normally found on a Linux machine. Although both machines have the same commercial video software drivers, the Windows OS has virus protection software and a few other things to load before becoming usable. But this is still a design issue. Linux simply doesn't thrash the disk by design.

Some extra technical details:

Both machines are 64-bit dual-core Intel architectures with 2G RAM. All operating systems are 32-bit software. All machines have similar usage wear and tear, and a moderate amount of software installed on them. The big difference in the hardware is that the CR-48 is somewhere between a net-book and note-book, and the desktop is a typical desktop with a 0.5 Tb mechanical hard disk, mid-range video card and 2.6 Ghz processing power.
