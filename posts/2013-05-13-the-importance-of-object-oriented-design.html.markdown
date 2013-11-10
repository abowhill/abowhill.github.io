---
layout: single
title: 'The Importance of Object-Oriented Design'
tags: design
---

One of the more stifling features of object-oriented programming is trying to figure out what classes to design.

Unlike its venerated, comparatively simple tribal cousin, procedural programming, object-oriented programming requires you to invent abstractions in the form of classes that describe the problem domain, or selected parts of it - and package functions with data. The classes you design are blueprints from which objects are manufactured at runtime.

Depending on the language, there can also be inheritance, mixins, access permissions, generics, collections, interfaces, and even Eigenclasses that allow you to mutate the original classes and objects at runtime. And for the truly discriminating, pedantic programmer, there are design patterns.

The big advantage of object-oriented design is the ability to speak to the computer in terms of the problem's domain. The prodecedural approach makes you to speak to the computer on its own terms, requiring you to translate the problem domain into terms the computer understands.

But the object-oriented approach is actually just an extension of the procedural approach. It's just the procedural parts (both functions and variables) are heavily modularized and cast into types - protected data structures. We cannot escape the procedural nature of programming. Programs are implementations of algorithms, and algorithms are sequences of steps -- recipes for solving problems.

It follows that as a complex wrapper to procedural methodology, there will be more design decisions to make when using an object-oriented methodology. And design is all about how to get problem P to solution S with code. The design you devise can vary depending on what type of problem you're solving, and the tools you have available.

This is one of the reasons I am trying to leave Perl in favor of Ruby. I've done a fair amount of reading on Ruby, and don't care to delve more deeply into Perl. Unfortunately, most of my practice with Perl has been through jobs. I was always hired as a "perl programmer" no matter what I did until recently. So, although I've had plenty of exposure and education centering on object-oriented design, I haven't had much opportunity to use it - at work or on my own projects. There just hasn't been a need.

However, what little project exposure I've had, has been revealing when it comes to the task of designing classes. There is more than one way to do it. One piece of advise I can give about programming is that you must know your problem domain very well to successfully address it in code. This is especially important with object-oriented class design, as it requires you to declare the problem domain up-front.

So, getting class design correct before coding starts is very important. With reflection and Eigenclassess, it may not be as critical, because you can posthumously mutate objects at runtime with code. Although this violates some of the principles of class-based object-oriented design (encapsulation) it holds some promise of allowing softer, more simplistic cookie-cutter class designs to be planned before coding gets underway, which can be later be mutated and specialized as the project progresses. This saves time over devising rigid strongly-typed blueprints which become, in a way, immutable before coding begins. Reflection may allow for extra refinement to take place after the initial general design is settled-upon. So in this respect, there may be a tradeoff between encapsulation and flexibility with object design.

Using a softly-typed language like Ruby or Python over a strongly-typed one like Java or C++ still doesn't substantially relieve the pain of a blank slate when it comes to devising a correct or suitable class model to address a domain-specific problem, but perhaps it can reduce size of the "blank page" you are required to fill in before coding starts.

On top of that, what layer of coding you are doing has everything to do with what language you might be using. By layer, I'm suggesting how close to the hardware you are. Below is a rough diagram of languages vs. layers for most computing problems:

|Layer                               |Languages most used                              |
|:-----------------------------------|:------------------------------------------------|
|Hardware                            |                                                 |
|Software: No OS                     |    (Hardware Engineering: ASM, C, Verilog       |
|Software: BIOS                      |    (ASM, C)                                     |
|Software: Bootstrap Loaders         |    (OS Engineering: C, Forth, ASM)              |
|Software: OS Kernel                 |    (C)                                          |
|Software: Filesystems and Drivers   |    (C)                                          |
|Software: Privileged User Mode      |    (Critical Operations: C, C++)                |
|Software: OS utilities              |    (Standard Operations: C, C++)                |
|Software: 3rd party system          |    (Application: Java, C#, C++, C)              |
|Software: Services Frameowrks       |    (Services: Perl Ruby, Python, Java, C#, C++) |
|Software: Glue, Build, Admin code   |    (Production: Perl, Ruby, Python, Shells)     |
|Software: Domain specific langs     |    (Integration: JavaScript, ERB, Jquery, SQL)  |
|Software: Entertainment, utilities  |    (Sourceless: C++, C#, Java, JavaScript)      |
|                                    |                                                 |
{: rules="groups"}

Above, I have tried to rougly outline the layers at which coding occurs, and associated heirarchy of useage realms. Each realm can be composed of one or more layers, and there are no firm boundaries.

1. Hardware Engineering - making hardware do something. (embedded)
2. OS Engineering       - making hardware do something sophisticated. (kernel) 
3. Critical Ops         - making sure the OS is running. (critical utils)
4. Standard Ops         - making the OS fully usable.    (complete OS binaries)
5. Application          - making the OS extra usable.    (3rd party software)
6. Services             - making the OS serve an automated purpose. (servers)
7. Production           - using the OS to produce software and services.(glue)
8. Integration          - using client installs for consumption (web browser) 
9. Sourceless           - making self-contained applications (turbo-tax, games)

Whether or not you agree with the categories, there is a distinct migration of lanugages for the different types of code being written at each layer. The closer we are to hardware, the more lower-level languages we see being used. We start with assembly language and veriolg. The further we go from the hardware, the more higher-level languages we see being used, until we are no longer dealing with source code, or even commands, but end-user applications controlled by user interfaces.

Somwhere in-between the OS engineering layer and the critical operations layer we begin to see object-oriented languages being used. Somehere betweeen the applications and services layer we see the emergence of "pointerless" languages like Java. Somewhere around the services and production layer we see "scripting" languages emerging as the language of choice.

So, it's not too hard to see that when we get in a bit to the standard operations layer we see see object-oriented code come into use. And it doesn't go away after that. In fact, object-oriented languages become dominant as we move toward the end-user with his applications, whcih can be very sophisticated programs reaching a million+ lines of code.

Conservatively half of all programming realms, the object-oriented approach is important.


