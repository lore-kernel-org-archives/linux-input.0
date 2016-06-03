From: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: Issue caused by your commit to the linux kernel
Date: Fri, 3 Jun 2016 10:43:12 +0200
Message-ID: <20160603084312.GA6063@mail.corp.redhat.com>
References: <15227381b21.be24b19a14291.7794248722302336410@vlrz.es>
 <20160121164725.GC20099@mail.corp.redhat.com>
 <15284a5ef2c.bfd3652817115.6670882487483674658@vlrz.es>
 <15284a969a1.f76ccc5f17182.598695392442003133@vlrz.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbcFCInS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Jun 2016 04:43:18 -0400
Content-Disposition: inline
In-Reply-To: <15284a969a1.f76ccc5f17182.598695392442003133@vlrz.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Valls <manolo@vlrz.es>
Cc: "Eric.Brunet@lps.ens.fr" <Eric.Brunet@lps.ens.fr>, "jkosina@suse.cz" <jkosina@suse.cz>, "<linux-input@vger.kernel.org>" <linux-input@vger.kernel.org>

Hi Manuel,

[apologies for the delay, your mail fell through the cracks]

On Jan 27 2016 or thereabouts, Manuel Valls wrote:
> There you go:
> 
> gamepad.hid - pressed all buttons and moved all axes
> left_stick.hid - moved only left thumb stick
> right_stick.hid - moved only right thumb stick
> 
> kernel was 4.4.0-mainline

Looks like the faulty commit is 18339f59c3a6698ee17d32970c9e1e450b16e7c3
("HID: dragonrise: fix HID Descriptor for 0x0006 PID").

This commit reorder the axes enumeration and thus changes your axes.

I have been recently contacted by some debian guys[1], and it looks like
your device has been first broken by me in 79346d620e9d, but then "fixed"
in v4.4 by 18339f59.

I can always add a special case for gamepads in hid-input.c, but given
that your gamepad will not use this path anymore, it won't change
anything for you.

On the other hand, it looks like this gamepad is the only one in 2 years
that exported a faulty behavior with my 79346d620e9d commit, so maybe we
don't need to add a special case for gamepads after all.

Cheers,
Benjamin

PS: I had a look at the raw events and I am quite puzzled to understand
how your gamepad works: it reports 5 axis for both sticks, and one
changes when you move either the left or right stick. It looks like a
really badly designed device :(

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=785606

> 
> ---- On jue, 21 ene 2016 17:47:25 +0100 <benjamin.tissoires@redhat.com>wrote ---- 
>  > 
>  > Hi Manuel,
>  > 
>  > On Jan 09 2016 or thereabouts, Manuel Valls wrote:
>  > > 
>  > > 
>  > > Commit 79346d620e9de87912de73337f6df8b7f9a46888 caused DragonRise Inc. PC TWIN SHOCK Gamepad's right stick to be wrongly detected as a Z axis, making it unusable. I'm writing to you as the authors of said commit requesting a fix. Looking forward to an answer.
>  > > 
>  > 
>  > It looks like I finally understood why this commit broke some gamepads.
>  > Basically, nothing prevents a HID device to use an axis more than once.
>  > This is noticeably used by multitouch devices.
>  > 
>  > So some gamepads manufacturers, are using for both joysticks (under the
>  > 2 thumbs) X and Y. Before 79346d620, this used to be working in Linux
>  > because we were looking for the next available axis.
>  > So when the second joystick gets parsed, X and Y are already in used,
>  > and so they gets assigned Z and RX. Luckily, the gamepad does not uses
>  > those particular axis (plus the fact that we actually do not care which
>  > axis is which, this gets sorted out later on by userspace).
>  > 
>  > To be able to fix this, I will need you to provide the report
>  > descriptors of your gamepad. Can you run hid-recorder[1] on the gamepad?
>  > 
>  > Once I have those, I should be able to either remove the gamepads from
>  > the list of "hey, if you declare X, you should map it to X", or I might
>  > just force the pen usages to be on this list only.
>  > 
>  > Cheers,
>  > Benjamin
>  > 
>  > [1] https://bentiss.github.io/hid-replay-docs/
>  > 
>  > 




