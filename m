From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
 through sysfs
Date: Wed, 11 Nov 2009 12:26:32 +0200
Message-ID: <1257935192.21596.1004.camel@localhost>
References: <20091104090628.GG31062@gw.healthdatacare.com>
	 <1257326759.21596.92.camel@localhost>
	 <20091106075220.GC11311@core.coreip.homeip.net>
	 <1257779344.21596.502.camel@localhost>
	 <20091109171834.GA30386@core.coreip.homeip.net>
	 <1257851059.21596.725.camel@localhost>
	 <20091110171945.GA15263@core.coreip.homeip.net>
	 <1257922211.21596.823.camel@localhost>
	 <20091111081949.GB22141@core.coreip.homeip.net>
	 <1257929573.21596.960.camel@localhost>
	 <20091111095956.GB3654@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19290 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZKKK0z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 05:26:55 -0500
In-Reply-To: <20091111095956.GB3654@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 2009-11-11 at 01:59 -0800, Dmitry Torokhov wrote:
> On Wed, Nov 11, 2009 at 10:52:53AM +0200, Artem Bityutskiy wrote:
> > Sorry Dmitry, I'm new to the input subsystem, may be this is why I =
still
> > do not see any problem with introducing a nice and useful ioctl?

I do not insist on ioctl, if you can show a nice way to use sysfs. So
far you did suggest this way, and I also do not see any nice way.

Really, we are happy to use sysfs, just show us how.

> There are several reasons:
>=20
> - ioctls are not useful from scripts

Not valid point. There are tons of ioctls all over the place. And no on=
e
prevents us from creating a userspace program which the scripts can use=
=2E

And your sysfs proposal is unusable for both the scripts and the C
programs. It is not any better.

> - 32/64 bit comapt issues

Invalid point. Real compat issues exist only for ioctls which pass
pointers. We are not going to do this at all.

> - currently there islimited number of ioctls in input core, they are =
all
>   concentrated in joydev and evdev, almost all of them work on all
>   devices, verifying locking is easy

OK, but this does not look like a blocker for introducing one more
ioctl.

> > On Wed, 2009-11-11 at 00:19 -0800, Dmitry Torokhov wrote:
> > > > > I understand the appeal of working with the keycodes but what=
 you are
> > > > > asking is not simply ignoring certain keypresses (that is eas=
y, just
> > > > > ignore corresponding events in userspace), you want to preven=
t system
> > > > > from waking up. In other words you want to "control PM layer =
through
> > > > > input layer" and I believe this is wrong.
> > > >=20
> > > > Err, this is really about disabling keys.=20
> > >=20
> > > If you want to stop delivery of certain keycodes to userspace the=
n OK,
> > > an option to subscrbe to certain events only instead of getting a=
ll
> > > events from the device. But again, it will only work for that par=
ticular
> > > user only, not everyone.
> >=20
> > Yes, this will work for some particular input devices only, those w=
hich
> > support the keys masking. What is wrong with this? We have the '-EN=
OTTY'
> > error code, which for ioctl's means "ioctl is not supported".
> >=20
> > But no one prevents us from making this work for _every_ input devi=
ce by
> > implementing a default ioctl handler in evdev.c, if needed. This ha=
ndler
> > can mask certain keys in SW.
> >=20
> > IOW:
> >    1. if my HW supports HW key masking, the evdev ioctl calls my
> >       handler, which is implemented in my driver.
> >    2. if my HW does not support this, the evdev ioctl masks the key=
s in
> >       SW.
> >=20
> > We are interested in 1. And if later someone needs 2., he/she can v=
ery
> > easily implement that. But for now we can just return -ENOTTY (or
> > -EINVAL, which seems to be used in the input subsystem).
>=20
> And #2 is what I think input layer should provide. Something that
> works for all devices and is isolated (one client does not affect
> others).

We can do this, if you believe it normal if we implement code we do not
use and thus, we cannot really test. I do not think it is normal, but i=
f
you insist, we can try doing.

> > > > If we think about this in an
> > > > abstract way, you have an input device with many keys. And the =
device's
> > > > HW allows you to disable any of it's keys. When you disable the=
 key, the
> > > > input device ignores it and does not generate any interrupt for=
 it.
> > >=20
> > > And the reason you want to stop interrupts?
> >=20
> > The reason is that I want simply mute certain keys. This is the onl=
y
> > reason.
> >=20
> > Now the question is _how_ I want to mute the key. My HW supports mu=
ting,
> > so I want to mute it in HW level, just because it is much better an=
d
> > more efficient. Just because in this case I will not have any inter=
rupt
> > and my device will wake up less.
>=20
> And the reason you care about number of wake ups is not saving power =
by
> any chance?

Yes it is. But there could be many other reasons as well. E.g., we may
want to achieve smaller latency by lessening amount of interrupts.

Really, you can look at this as we simply want to disable specific keys=
=2E
=46or exampe, for power savings. Or for smaller latency because of less
interrupts. Whatever.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
