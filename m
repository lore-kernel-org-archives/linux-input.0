From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Tue, 23 Sep 2014 10:59:16 -0400
Message-ID: <20140923145916.GA3110@mail.corp.redhat.com>
References: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22934 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbaIWO7v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 10:59:51 -0400
Content-Disposition: inline
In-Reply-To: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Cc: hdegoede@redhat.com, rydberg@euromail.se, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, peter.hutterer@who-t.net, dmitry.torokhov@gmail.com, Linux Input <linux-input@vger.kernel.org>

Hi Andrew,

On Sep 23 2014 or thereabouts, Andrew de los Reyes wrote:
> Hi folks,
> 
> More and more we're seeing touch input devices that support detection of
> fingers that are above the surface and not touching. We were thinking of
> writing a kernel patch for one such device. Normally we would indicate
> distance with ABS_MT_DISTANCE, but we ran into the problem that sometimes
> the hardware will not be able to report a distance (or will stop reporting
> a distance when it's too great a number), and we had the (bad) idea to
> simply report a value or 1 or 255 or something like that when distance is
> unknown.

FWIW, hid-multitouch already support those devices.
ABS_MT_DISTANCE is set with a min/max of 0/1 when we detect win8
certified panels with hovering capability. By default the spec does not
provide the distance IIRC, and you only have one byte: InRange.

I think Xorg can deal with that (the touch emulation discards the
ABS_MT_DISTANCE, but the xorg-evdev driver should be smart enough to not
take BTN_TOUCH into account).

> 
> Dmitry warned that a similar thing happened with PRESSURE a while ago, and
> it was a mess as different drivers did different things.

As I said, IIRC, xorg-evdev is fine with that. For generic desktop, we
have to make sure libinput is aware, and then you only have to handle
your own xorg chromebook driver. This is not something which scares me
that much, especially given that this is what hid-multitouch reports
since the v3.9 kernel.
libinput is based on a per slot device information, so it is really easy
to implement if it is not already in place. xorg-Synaptics and xorg-Wacom
should not be ported to wayland from what I understood, so the mess with
several implementations can be solved easily.

> 
> We are now wondering if we should come up with a standard way to indicate
> hover with or without distance (or with distance being optional). Dmitry
> had the idea for a new tool type, HOVER; FINGER would be for touches that
> are actually touching.

The tool is still the finger. So I am not very happy with having a new
tool. In the end, it may also disturb older clients which will not know
what to do with HOVER.
And the ABS_MT_DISTANCE approach used to be fully retro-compatible
(assuming that the hovering distance is small enough for the user not to
detect it).

> 
> What do folks here think?
> 

I made my point. Unfortunately, I never had in my hand such device, so
I can not guarantee this approach is the best.

Cheers,
Benjamin

