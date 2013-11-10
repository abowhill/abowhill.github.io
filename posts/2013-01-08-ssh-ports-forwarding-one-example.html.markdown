---
layout: single
title: 'SSH Port Forwarding: one example'
tags: ssh, FreeBSD
---

Ssh port forwarding leverages the idea that your secure identity - once established on a bunch of machines that are aware of each other -- can give you kind of superman access abilities - to leap servers and firewalls with a single bound, assign services on one machine to exist on another, etc. Practically every barrier you would normally encounter on a network can be circumvented - be it hardware or software.
Wherever your tokens (RSA keys) exist, you can perform all kinds of access tricks you wouldn't think possible. SSH allows you to trade machine boundaries and security measures for total authentication.

Getting your head wrapped around this is not terribly easy because frankly the examples on the internet suck and never make sense to your situation.

I think it's important to remember a couple of facts about ssh port forwarding:

+ Like installing a copied license plate from one car onto another,  port forwarding can attach a masquerading service tunnel on host A from any machine A can see - call it host B - who may have no idea A is making its ports available to an outside computer, called host D.
+ As with a remote control, you can giving permission to do this remotely from any machine C, as long as there are SSH tokens on A and C that allow each other access. C can become A, in a sense - at least for a moment. Trivialities like formal identities are forgone.
+ Port forwarding usually establishes a relationship between 3 machines.
+ Where you do what to what is important, and a huge source of confusion.

The first two points listed above - masquerading one port as another (1) and erasing machine boundaries/identities for strong authentication (2) is what port-forwarding is all about.  

Think of it as a way of connecting traffic from one machine to another like the old phone cable operators (Lily Tomlin) used to do with wires. The ability to create, on the fly, a kind of ad-hoc party line connecting ssh machines with secure cables in any fashion you want. 

To the concrete. Here is a nice piece of advice I got to work from [Redhat Magazine](http://magazine.redhat.com/2007/11/06/ssh-port-forwarding/) - modified here to fit my own setup - which I am hoping other people have as well.

My machines at home are setup behind a firewall/router on the 192.168.0 net. All my home devices are a member of this net. This includes wireless phones, computers, laptops and other devices. The 192.168 network is a set of reserved addresses that cannot be accessed from the outside.

Comcast assigns one IP address to a cable modem in front of the router, and the router translates everything from internal home addresses to external internet addresses as long as the convo was initialized internally first. All other requests coming from the outside are blocked.

Well, not entirely true. I have one machine outside the network in the "demilitarized zone" which is home router-speak for dual homed address.  It's a FreeBSD machine with an SSH port. The deal with this is if I want to open a terminal to my home network securely, I can do this from the outside, and the router will allow any incoming requests for the IP address of the modem to be sent to this machine.

On this FreeBSD machine, in addition to the mother machine I have several child service jails running, which can only be accessed directly from the internal 192.168 network. One of these runs a Rails webserver on port 3000. Because of the internal nature of the jails, I can only see this webserver from a machine inside my network.

Here's where port forwarding comes in. Suppose I take my laptop to the coffee shop, and want to hit my internal webserver from my web browser. I can't normally do this, because I am on the outside (public) Internet. But - on my laptop in the coffeeshop, I open a terminal window and enter:

~~~
ssh -L 1234:192.168.0.12:3000 joeblow@freebsd-internet
~~~~~
<p/>

I will be able to access my internal service jail at home by browsing to:

~~~
http://localhost:1234/index.html
~~~~~~
<p/>

Port 1234 on the laptop at the coffeeshop on the outside has been assigned a direct connection to the webserver running on Port 3000 inside the service jail at 192.168.0.12 on my FreeBSD-internet machine.

The FreeBSD-internet machine is a member of two networks:

+ The outside internet, joined when comcast assigned an IP address to the modem. My router has exclusive access to this device, so plays like the FreeBSD-internet machine is sitting in front of it.
+ The inside Internet, a 192.168 address assigned by me and my router.

The relationship between the laptop and the freebsd-internet machine to act as the same sort of device is granted by SSH tokens existing on both, and a shared relationship of trust.  Machine and network distinctions, rules and barriers are all erased when the two tokens have been made aware of each other.
