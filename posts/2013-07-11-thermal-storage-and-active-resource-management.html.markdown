---
layout: single
title: 'Thermal storage and Active Resource Management'
tags: storage, disk
---

I recently added a couple of new games to my system recently, each about 25 Gigabytes in size, and I noticed how poorly I planned to use my own computing resources properly. I installed the game I never use on my best drive, but not after installing the game I now often use on my worst. 

Games can be very file intensive at times, for example when loading scenery as you play. If these scenery files reside on a slow or sluggish drive, it can have a terrible effect on your play experience. I also notice that I have several bulky games that I do not use very often. Why should these occupy my best resources?

Games aren't getting any smaller. With each successive year, the size of the software packages is increasing. Here is a list of a few games I have installed, and their respective sizes:

+ ARMA 2 / Operation Arrowhead: 24 G
+ Guild Wars 2: 22 G
+ ARMA 3: 7 G
+ Skyrim: 10 G
+ Age of Conan: 25 G

I can remember when games took less than a few floppies to install, and the average disk size was in Megabytes, not Gigabytes. Games have gotten larger for sure. But computing resources have become more varied and capable. Back in the day of Duke Nukem and Wolfenstein, I could install everything from floppies or CD to a single disk and be happy. But a single disk is all I had. There were no DVDs, SSDs or Pen Drives. 

Today, we have more storage choices on the average computer. For example, my current system has several kinds of drives (theoretically) available to it: 

1. A very fast but somewhat small SSD (128 G)

1. A quite small but relatively fast pen drive (32 G)

1. A fairly large but slow mechanical hard drive (320 G)

1. A very large but very slow DVD that is capable of read/write/erase (8 G)

1. The cloud. Very slow, not that large and not that secure. (10 G)

1. Ideally, at any given time, I would like to have the games I play the most on the fastest drive, and the ones I play the least on the slowest. For me, this would mean a game like Skyrim (which I don't play often) to be packed away on a slow DVD, and something like ARMA (which I play a lot right now) to be available on the very fast SSD. 

But there are complications. I like to call this problem one of Active Resource Management, and it is really the domain of the operating system. 

+ My tastes vary! One week I may be playing ARMA2, but the next week I might be really into playing Age of Conan. 
+ I can't fit too many games on the SSD because it's too small. The operating system takes up 25% of the drive and needs breathing space.
+ Copying huge amounts of data from one disk to another is error-prone and can break a lot of things like shortcuts and deinstallation scripts. Plus it takes a lot of time, and hogs the computer's resources. It's just terribly inconvenient. 
+ Removable disks are not always there. I don't necessarily have a rewritable DVD in the player all the time, nor do I always have a Pen Drive in the USB port.
+ Not all the drives are predictably the same size and speed. My USB pen drive could be large and fast or small and slower, depending on which stick I install. Likewise, DVDs can vary in capacity, depending on what disc you install.
The problem of Active Resource Management on the computer can be solved by taking a Thermal Storage approach. Files that are infrequently accessed would be demoted to slow, high capacity, low-availability devices (Cold Store); while frequently-accessed files would be promoted to fast, high-availability devices (Hot Store). 

Currently, even the most advanced operating systems do not perform this complex function. So we, as human beings, we are forced to do the work of the computer manually. This is just the state of affairs. A lack of innovation in the industry.

But imagine for a minute on what such a system would be, and how it might behave:
1. The OS would have to have a monitoring system that noticed which files you opened and closed. It would have to keep track of this in a table.

1. The OS would have to know the capacity, performance characteristics and availability of all storage devices on the system. It would have to store that in a table.

1. The OS would have to "adopt" and "melt" devices together as they were plugged in -- to appear dynamically as one storage unit to the user, even though 4 or 5 different devices may be currently used.

1. The OS would have to dynamically and thermally schedule files for promotion or demotion to hot / warm/ cool / cold storage based on heuristics and ranking of what it observed by frequency and duration of access. Conversely, it would have to evaluate the capacity/reliability/availability of storage devices, and judge which would be the best place to store something. Content of removable devices would have to be mirrored onto another non-removable device, depending on policy the user chooses.

1. It would have to do thermal storage for the user in a hands-off manner. You might be able to set policies and rules, but operationally the whole thing is done for you transparently.

As a user, you'd notice a more optimized system. The more you used file, a group of files, or a software package, you'd see faster access times and much better performance. Your changing usage habits and tastes would be accommodated.

For example, games you play frequently would get promoted to fast, available storage and would deliver what you'd expect. You wouldn't have to manually manage this when your priorities changed. No more copying huge directory trees from one device to another depending on your anticipated usage.

