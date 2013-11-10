---
layout: single
title: 'SSH port forwarding ala crosh'
tags: ssh, forwarding, chromebook
---

On a Google Chromebook you can access a UNIX-like terminal window by typing CTRL-T from the Chrome browser. This feature makes a Chromebook much more viable to use for technical people.

Without it, you'd have to setup your own HTTP/SSL Tunneling/Comet server at home to even come close to embedding a terminal in a web browser (a complicated setup project I have done before). So hat's off to whoever had the wherewithal to put that feature in. 

The terminal's bound shell - called "crosh" - is however limited in the Chromebook's user mode for security purposes, so you won't be able to do your typical UNIX-y stuff on your Chromebook directly; but a copy of SSH has been provided to securely connect to a real UNIX-like machine over the internet.

One trick you can do is to use port-forwarding with this shell, enabling you to plug into a system like a protected web server deep behind a firewall, and have it deliver pages to your Chromebook as if the webserver were running on the Chromebook itself.

So given the following steps, you should be able to do this:

1. You are at some location outside the network protecting the webserver you want to acccess.

2. You are in the crosh shell on a Chromebook.

3. You can publicly access an SSH host computer connected to the firewalled network. 

4. The SSH host has SSH access to the internal webserver sitting behind the firewall. The webserver is serving-up pages on that machine's local port 3000

In crosh, just run:

~~~ shell
crosh> ssh
ssh> user (your username)
ssh> host (IP address or name of publicly-accessible SSH server)
ssh> forward 8000:(internal webserver IP address):3000
ssh> connect
~~~~~~


__(enter credentials)__

Done! Leave everything alone.

Open a Chrome browser tab, and point it to:

~~~ shell
http://localhost:8000
~~~~~~
<p>

Bang! Your internal, firewall protected website is being served up to your local chromebook as if it were running on the chromebook itself. 

It's a freaking miracle.
