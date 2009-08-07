From: Mike Murphy <mamurph@cs.clemson.edu>
Subject: Re: [patch 1/4] input: drivers/input/xpad.c: improve Xbox 360
	wireless support and add sysfs interface
Date: Fri, 7 Aug 2009 11:19:43 -0400
Message-ID: <5aa163d00908070819m5285dc78u5203d796b931f826@mail.gmail.com>
References: <200908062304.n76N4Br7002564@imap1.linux-foundation.org>
	 <4A7C21FF.4050603@gmail.com>
	 <5aa163d00908070629tbb2ef11j7c3bb9f90017cbfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:33542 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757552AbZHGPTo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2009 11:19:44 -0400
Received: by fxm28 with SMTP id 28so1387652fxm.17
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2009 08:19:44 -0700 (PDT)
In-Reply-To: <5aa163d00908070629tbb2ef11j7c3bb9f90017cbfd@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Re-sent to list (client misconfigured and was sending HTML).

---------- Forwarded message ----------
=46rom: Mike Murphy <mamurph@cs.clemson.edu>
Date: Fri, Aug 7, 2009 at 9:29 AM
Subject: Re: [patch 1/4] input: drivers/input/xpad.c: improve Xbox 360
wireless support and add sysfs interface
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor@mail.ru, akpm@linux-foundation.org,
linux-input@vger.kernel.org, randy.dunlap@oracle.com


On Fri, Aug 7, 2009 at 8:45 AM, Anssi Hannula <anssi.hannula@gmail.com>=
 wrote:
>
> > +/* Device attributes */
> > +static DEVICE_ATTR(left_dead_zone, 0644, xpad_show_uint, xpad_stor=
e_uint);
> > +static DEVICE_ATTR(right_dead_zone, 0644, xpad_show_uint, xpad_sto=
re_uint);
> > +static DEVICE_ATTR(left_stick_limit, 0644, xpad_show_uint, xpad_st=
ore_uint);
> > +static DEVICE_ATTR(right_stick_limit, 0644, xpad_show_uint, xpad_s=
tore_uint);
>
> I'm somewhat unsure on introducing such device-specific attributes. D=
ead
> zone and stick limit attributes could be useful for non-xpad input
> devices as well, so shouldn't we have a generic interface?

I believe these settings should be part of a generic interface, but in
the time I had available for improving the driver, I didn't find the
appropriate place to put them. Matters are complicated by the fact
that there are at least 2 ways for user-space code to receive inputs
from the game devices: the event interface and the joystick interface.
If I remember correctly, it seems like the joystick interface kernel
code is downstream of the event interface code, so perhaps these
settings could be moved there? The downside is that one could easily
open a worm can by making the settings too generic but too tied to a
specific device... e.g. specific settings for a game device. One could
ask: why are there settings for a game device but not for a mouse
device? And then different devices have different capabilities, so how
do we know what devices support what input tweaks? And then how do we
query the devices from userspace to find the capabilities (especially
if sysfs is supposed to be a "simple" interface and new ioctls are
frowned upon)? Of course, proliferation of a bunch of device-specific
settings in sysfs might be the same problem going in the opposite
direction....

One other thing I tossed around was whether stick limits/dead zones
should even be in the kernel code, or whether they should be left to
the userspace code that uses the device. I find good arguments for
both locations. Moving the code to userspace un-clutters the kernel
code and allows the stick limit/dead zone processing to use, among
other things, floating-point arithmetic. Furthermore, the code doesn't
have to run in an interrupt handler, so it can be fancier.

On the other hand, in practice, the dead zone used with a device is
largely tied to the device itself... some temperamental devices might
require a larger dead zone, while others might benefit from a smaller
dead zone. There is also some user preference in there, but then the
user might want to have the same settings for the same device across
all userspace applications that use the device. The addition of a
device layer (or userspace driver, like the one that exists for the
xpad devices) to permit such a configuration could have the effect of
slowing event delivery to the game, since the intermediate layer would
have to be scheduled. And game players seem to take a dim view of
un-responsive controls :).

>
> > +static DEVICE_ATTR(rumble_enable, 0644, xpad_show_int, xpad_store_=
bool);
>
> Ditto for this one. Disabling FF does not seem like device-specific f=
eature.

Same issue as above, except now there is also the FF core code to consi=
der.

One issue that needs to be addressed with FF on the xpad device,
though apparently nobody has raised it yet, is that I have seen
problems with the Ubuntu kernel + the binary nVidia driver + my
modified xpad driver on another person's system... leading to an X11
deadlock with a fullscreen game. I have not been able to reproduce
this behavior on either an nVidia-tainted or untainted vanilla kernel,
and I have no test data from an untainted Ubuntu kernel (I don't run
Ubuntu)... so for the time being, I'm assuming this is not a kernel
problem. The work-around, however, is to disable the FF effects on the
xpad driver, using the sysfs interface.

>
> Do we wan't the driver changelog in xpad.c or not?
> It was removed in commit bf8cb3141884138c2e4a2ecb56300ece6e8020a2 in
> 2008, no longer being up to date, and subsequent commits haven't been
> listed there (notice the gap between 2004-2009).
>
> I'll leave it to Dmitry to decide :)

This is another case of "I was following what was already there."
Either way is fine with me... though a separate changelog file would
be a lot cleaner.

I haven't done anything with this code lately, but I may have time to
start tinkering again pretty soon... especially with the user-space
side of the game device settings. I am keeping an out-of-tree copy of
the patched source at: http://www.cs.clemson.edu/~mamurph/pub/xpad/

Mike
--
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838 =A0 Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph



--=20
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838   Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
