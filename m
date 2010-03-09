From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 7/7] HID: N-trig MTM Driver fix And cleanup patch 7
Date: Tue, 09 Mar 2010 12:32:24 -0500
Message-ID: <4B968628.7060409@seas.upenn.edu>
References: <micki@n-trig.com> <1268083024-3029-1-git-send-email-micki@n-trig.com> <4B95A521.3070208@seas.upenn.edu> <48A28051AC6D7A48B64F28272458190301AF42@Exchange-IL.n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:44152 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0CIRcp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 12:32:45 -0500
In-Reply-To: <48A28051AC6D7A48B64F28272458190301AF42@Exchange-IL.n-trig.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Micki Balanga <micki@n-trig.com>
Cc: jkosina@suse.cz, chatty@enac.fr, peterhuewe@gmx.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com

On 03/09/2010 11:40 AM, Micki Balanga wrote:
>
> Hi All
> In this mail I will try to answer all your questions. First I will
> explain to you N-trig Solution:
> N-trig solution contains:
> 1. Hid kernel driver
> 2. User space application =C2=96 N-trig propriety IP. An application =
which
> analyzes the data received from the driver
> (Pen and touch) into real events.

Already are real events.  Just a little messy/noisy.

> 3. X11 Driver =C2=96 communicate with N-trig user space application.
> N-trig will release to the open source updates (bugs, and features) f=
or
> the driver and an installation package (RPM, DEB)
> for user space applications. I will release an update version of the
> driver, once we agree about all the changes.

Why hold back on the userspace and x11 driver source?  I'm not=20
suggesting a press release or a major publication.  But perhaps showing=
=20
off your other applications might explain some of your proposed changes=
=20
and offer us an opportunity to help you refactor your kernel<->user=20
space assumptions to bring them in line with other devices.

Please remember, people already have these things working in the field.=
=20
  They are already using pen, touch and even multi-touch.  You can not=20
offer initial support, its too late for that.  And you have not been=20
making much of a case for why your support is an improvement.  Please=20
enlighten us.

> 1. I'd rather remove all the MODULE_VERSION: Answer: will be done in =
the
> next patch release,
> also with the change log update.
>
> 2. MODULE_NAME "hid_ntrig=C2=94 - Answer will change it back to =C2=94=
ntrig=C2=94, as
> it was in the first patch submitted.
>
> 3. N-trig application (Propriety IP) analyze (math algorithms) the
> information received from the driver
> into real touch event. Events like fake fingers, frame index , generi=
c
> byte, palm
Is frame index any more than a checksum?

Still haven't explained what you mean by "fake fingers".  Its not clear=
=20
what they have to do with the user space.  And its really unclear why=20
you bother with extra computation and an extra field in the kernel=20
driver.  The only place in the kernel code you actually be replaced wit=
h=20
"real_fingers =3D=3D 0", or "real_fingers =3D=3D 1".

> used by the application in parsing the events received from the drive=
r
> (firmware)
> into real fingers, pen events.

What purpose do the Proprietary IP algorithms serve?  I suspect you wil=
l=20
find a lot of resistance to adopting closed portions of your drivers=20
unless they actually serve a novel purpose that isn't readily available=
=20
with obvious or pre-existing algorithms.  Finger tracking, noise/ghost=20
elimination and suppression and many other analytic operations you coul=
d=20
perform to clean up the behavior are already well known.  What else to=20
do you plan to offer?

> 4. Our driver support N-trig old firmware but we will supply a Firmwa=
re
> upgrade (MTM)
> version in order to user to enjoy the full multi-touch experience.

Glad to hear it.

> 5. Later we will be evolved with the X11 development.
> 6. You still haven't actually established why it=C2=92s necessary to =
fuss
> with pen events if we split the pen off to a separate input device - =
We
> need to separate Pen from Finger to allow our user space application =
to
> analyze Pen and Touch events

I'm confused, you do want to split pen and touch?  Cause you took out=20
the line of code that does that.  Do you perchance have the multiple=20
input quirk set in hid-quirks.c?  I was thinking of moving it there at=20
some point soon.  The patch you sent in did not split the two streams t=
o=20
separate input devices when I tried it.

> 7. case HID_DG_CONTACTID - At develop stage we used USB analyzer and
> gizmod tool and we didn't see any problem using case HID_DG_CONTACTID=
=2E

Please clarify.  I have not seen any protocol issues with it, just that=
=20
the values are incorrect.  Is this just the result of a single buggy=20
firmware?  On my screen, contact 0 is the lowest finger, and changes=20
when I move my fingers up and down (y+/y-) along the screen.  (If you=20
send firmware version code, I'll send the version of firmware I'm using=
,=20
its from the 2.172 bundle).

> 8. Even if you want to argue that you need to pull the multi-input
> quirk, that doesn't justify pulling the names. Perhaps you may wish t=
o
> truncate the name to "N-Trig" or something. But give them some name.
> Those names simplify driver correlation in user space. In kernel 2.6.=
31
> - I got kernel panic, will put it in the next release.

Yes, that's my bad, there should be a guard before the switch:
list_for_each_entry(hidinput, &hdev->inputs, list) {
       input =3D hidinput->input;
+ if(hidinput->report->maxfield > 0)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
