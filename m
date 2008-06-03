From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack reporting v2
Date: Wed, 4 Jun 2008 00:38:14 +0100
Message-ID: <20080603233813.GA30512@sirena.org.uk>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com> <20080603104048.GA17007@rakim.wolfsonmicro.main> <20080603105920.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4958 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbYFCXiS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jun 2008 19:38:18 -0400
Content-Disposition: inline
In-Reply-To: <20080603105920.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org, mjg59@srcf.ucam.org

On Tue, Jun 03, 2008 at 11:17:26AM -0400, Dmitry Torokhov wrote:

> Pros for using input devices:
> - we already have them

...and it already models switches.

As mentioned in the description of the original patch there's also the
fact that the existing implementations I've found are doing things this
way.  The only in-kernel ones are corgi and spitz which skip the input
device overhead by using the keyboard input device.

There is an additional motivation for using an input device for jacks -
it is common to support a button implemented by shorting the microphone
connection as well as simply detecting the presence of something in the
jack.

> Cons:
> - space consideration. Input_dev structure is quite fat. It has all
>   the capabilities strings exported through sysfs, hist of other
>   attributes, etc. On top of that we have a character device (evdev)
>   plus its own sysfs representation. IOW lots of stuff.

I'm not sure how many systems this is a concern for these days (the
things I found exporting to user space at the minute are embedded) but
it could be an issue.

> - input device require ioctl to get the switch state, no easy way to
>   do it through sysfs.

That sounds like something that is worth adding anyway, regardless of
what gets done with jacks.

> - As the number of types of connectors grows new switches will need to
>   be added to input, potentially completely unrelated. My lacmus test
>   for it - does it make sense to add network cable state to inputi
>   core?

The number of potential switches could get rather large, yes - to my
mind it's the main concern with using the input API.

> Do you think that something small that has only one sysfs device per
> switch and uses KOBJ_ONLINE/KOBJ_OFFLINE to signal state change would
> be better suited here?

It's certainly doable and it would avoid any issues with memory overhead
and with the number of switch types.

Jacks would in general have more than one thing to report - as well as
jacks for headsets with both headphone and optional microphone support
on one physical jack many devices will also be able to give an idea of
the device connected to a jack, doing things like distinguishing between
speakers and headphones.  This information could still be exported via
the sort of interface you suggest, for example with one sysfs file per
thing that can be detected contents indicating the state for that thing.
It could also be exported as environment variables along with the
uevent.  The jack API would be able to standardise the names so that
shouldn't be an issue.

Ignoring the buttons it should be fairly straightforward from a kernel
point of view.  I'm not sure how some of the userspace people would feel
about it, mainly those in embedded systems not already dealing with
uevents, but if they don't want to use netlink then uevent_helper should
do the job for them even though it is a bit more cumbersome than the
input API.

Buttons would presumably end up as an input device registered only if
supported by the jack - this would be easy enough for the kernel.

If jack reporting is implemented this way we'd want to add a comment
indicating that SW_HEADPHONE_INSERT shouldn't be used.
