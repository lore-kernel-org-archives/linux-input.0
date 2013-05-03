From: Todd Showalter <todd@electronjump.com>
Subject: Re: Game Controllers
Date: Fri, 3 May 2013 08:57:12 -0400
Message-ID: <CAFmpkyhiDp6ji=9P6XtCwvNWFvw+DNAc3p+sJ06QOPAL_ewQhQ@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
	<CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
	<3024546.hGDLPfhqRN@f17simon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:47725 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761757Ab3ECM5O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 08:57:14 -0400
Received: by mail-qa0-f42.google.com with SMTP id p6so319532qad.8
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 05:57:13 -0700 (PDT)
In-Reply-To: <3024546.hGDLPfhqRN@f17simon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Fri, May 3, 2013 at 6:29 AM, Simon Farnsworth
<simon.farnsworth@onelan.com> wrote:

> Could you consider a gamepad equivalent of libv4l2 (source found in
> http://git.linuxtv.org/v4l-utils.git/tree/HEAD:/lib )?

[8<]

> A gamepad version would intercept opens of /dev/input/event* nodes, and if
> that node was a gamepad, do the remapping from gamepad-specific events to the
> standard gamepad events. You can then use this with unmodified apps as an
> LD_PRELOAD, or with modified apps as a shared library that only gets in the way
> if the app is accessing a gamepad.

    The problem here is that this really shouldn't be a shared library
if it's going to be accessed directly by (say) games.  Unless there's
something I'm missing, accessing /dev/input/event* requires elevated
privileges, and the idea that all games will run as root kind of
terrifies me.  The only way it makes sense is either:

- as a library for the X11 or Wayland server, in which case it might a
well be a static library

- as a server delivering events over AF_UNIX or AF_INET sockets

    If non-root clients are going to want to talk to this, it needs to
be mediated by something.  Unless there's some ELF trickery I don't
know about, that means passing through some sort of RPC mechanism,
whether it's X11, Wayland or the network stack.

    I suppose there's d-bus, but I'm reluctant to involve xml parsing
in anything with performance requirements.

    I've got a prototype server now, actually; it isn't binding an
address yet, but it should be shortly.  It basically throws an inotify
watch on /dev/input and maintains a list of active devices that it
understands, with open file descriptors.  The next stage is to get it
binding a port on localhost and dumping appropriately rewritten events
via udp.  It'd be nice to use SOCK_SEQPACKET, but does anyone other
than me actually build their kernel with sctp support?

    The way I'm currently planning this is essentially in two parts; a
static library that deals with slurping and massaging data from evdev,
and a server built with it that spews the results out in a udp torrent
to whoever is listening.  The hope would be that your graphical
library of choice (X11, Wayland...) builds against the static lib and
delivers the messages through its own standardized RPC mechanism.  In
the mean time, the server is there partly as a testbed and partly so
that you don't have to run your game as root to get a gamepad.

                                        Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
