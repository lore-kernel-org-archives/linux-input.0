From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
 through sysfs
Date: Thu, 12 Nov 2009 07:31:43 +0200
Message-ID: <1258003903.21596.1154.camel@localhost>
References: <20091106075220.GC11311@core.coreip.homeip.net>
	 <1257779344.21596.502.camel@localhost>
	 <20091109171834.GA30386@core.coreip.homeip.net>
	 <1257851059.21596.725.camel@localhost>
	 <20091110171945.GA15263@core.coreip.homeip.net>
	 <1257922211.21596.823.camel@localhost>
	 <20091111081949.GB22141@core.coreip.homeip.net>
	 <1257929573.21596.960.camel@localhost>
	 <20091111095956.GB3654@core.coreip.homeip.net>
	 <1257935192.21596.1004.camel@localhost>
	 <20091111174010.GB10663@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25796 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZKLFbx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2009 00:31:53 -0500
In-Reply-To: <20091111174010.GB10663@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 2009-11-11 at 09:40 -0800, Dmitry Torokhov wrote:
> On Wed, Nov 11, 2009 at 12:26:32PM +0200, Artem Bityutskiy wrote:
> > On Wed, 2009-11-11 at 01:59 -0800, Dmitry Torokhov wrote:
> > > On Wed, Nov 11, 2009 at 10:52:53AM +0200, Artem Bityutskiy wrote:
> > > > Sorry Dmitry, I'm new to the input subsystem, may be this is wh=
y I still
> > > > do not see any problem with introducing a nice and useful ioctl=
?
> >=20
> > I do not insist on ioctl, if you can show a nice way to use sysfs. =
So
> > far you did suggest this way, and I also do not see any nice way.
> >=20
> > Really, we are happy to use sysfs, just show us how.
> >=20
> > > There are several reasons:
> > >=20
> > > - ioctls are not useful from scripts
> >=20
> > Not valid point. There are tons of ioctls all over the place. And n=
o one
> > prevents us from creating a userspace program which the scripts can=
 use.
> >
>=20
> Which needs to be packaged and distributed... The nice thing about sy=
sfs
> is that echo and cat are always available.

The bad thing about sysfs is that it is PITA when it comes to C
programs. Sysfs stuff is slower and more wasteful - e.g., each 'struct
inode' takes kilobytes.

Anyway, I do not think we really want to have a ioctl vs sysfs
discussion, there pluses and minuses, and lkml wars showed that both ar=
e
perfectly OK in the linux kernel.

> > And your sysfs proposal is unusable for both the scripts and the C
> > programs. It is not any better.
>=20
> It is hard to say at the moment, since we don't have a concrete
> proposal for sysfs interface ;)

Err, OK. I was actually referring to your proposal to use gpio numbers
instead of keycodes.

> >=20
> > > - 32/64 bit comapt issues
> >=20
> > Invalid point. Real compat issues exist only for ioctls which pass
> > pointers. We are not going to do this at all.
>=20
> And longs... and other types that based on longs...

But no one uses longs and pointers in ioctl's nowadays, at least not fo=
r
simple things. This is mostly about legacy stuff.

> > > - currently there islimited number of ioctls in input core, they =
are all
> > >   concentrated in joydev and evdev, almost all of them work on al=
l
> > >   devices, verifying locking is easy
> >=20
> > OK, but this does not look like a blocker for introducing one more
> > ioctl.
> >=20
>=20
> The dfifference in your ioctl that it leaves implementationto drivers
> thus vastly expanding the scope.

Yes, I thought it is just nice general concept - input device can mute
some keys. If it can - you have ioctl, if it cannot - you have -ENOTTY.

> > > > On Wed, 2009-11-11 at 00:19 -0800, Dmitry Torokhov wrote:
> > > > > > > I understand the appeal of working with the keycodes but =
what you are
> > > > > > > asking is not simply ignoring certain keypresses (that is=
 easy, just
> > > > > > > ignore corresponding events in userspace), you want to pr=
event system
> > > > > > > from waking up. In other words you want to "control PM la=
yer through
> > > > > > > input layer" and I believe this is wrong.
> > > > > >=20
> > > > > > Err, this is really about disabling keys.=20
> > > > >=20
> > > > > If you want to stop delivery of certain keycodes to userspace=
 then OK,
> > > > > an option to subscrbe to certain events only instead of getti=
ng all
> > > > > events from the device. But again, it will only work for that=
 particular
> > > > > user only, not everyone.
> > > >=20
> > > > Yes, this will work for some particular input devices only, tho=
se which
> > > > support the keys masking. What is wrong with this? We have the =
'-ENOTTY'
> > > > error code, which for ioctl's means "ioctl is not supported".
> > > >=20
> > > > But no one prevents us from making this work for _every_ input =
device by
> > > > implementing a default ioctl handler in evdev.c, if needed. Thi=
s handler
> > > > can mask certain keys in SW.
> > > >=20
> > > > IOW:
> > > >    1. if my HW supports HW key masking, the evdev ioctl calls m=
y
> > > >       handler, which is implemented in my driver.
> > > >    2. if my HW does not support this, the evdev ioctl masks the=
 keys in
> > > >       SW.
> > > >=20
> > > > We are interested in 1. And if later someone needs 2., he/she c=
an very
> > > > easily implement that. But for now we can just return -ENOTTY (=
or
> > > > -EINVAL, which seems to be used in the input subsystem).
> > >=20
> > > And #2 is what I think input layer should provide. Something that
> > > works for all devices and is isolated (one client does not affect
> > > others).
> >=20
> > We can do this, if you believe it normal if we implement code we do=
 not
> > use and thus, we cannot really test. I do not think it is normal, b=
ut if
> > you insist, we can try doing.
>=20
> I certainly do not insist that you write code that you are not be usi=
ng,
> far from it. I am just saying that from input layer POV #2 is what ma=
kes
> most sense.
>=20
> OK, I can see that limiting everything at evdev layer is not enough f=
or
> you and you would prefer disabling interrupt completely. This kind of
> fine-grained control is possible I think only in gpio-keys and
> gpio-mouse (and maaaaybe matrix_keypad) so I do not think that plumbi=
ng
> it all the way through evdev with ioctl makes much sense. Let's see i=
f I
> can scribble something sysfs-based in a couple of days or if you beat=
 me
> to it.

The list of input drivers may be longer once a new ioctl is there, and
people realize they can mute keys.

Disabling separate key is such a nice and simple concept, that plumbing
it to evdev makes perfect sense for me. And device-specific handlers is
also so standard concept for me.

I feel like we need opinions of other people.

> The basic idea is that you create a new 'disabled_keys' and
> 'disabled_switches' attributes for the gpio-keys platfrom device. The=
y,
> for example, may take input in form of list of keys whose interrupts
> should be disabled:
>=20
> 133-139,143,147,369-370
>=20
> See bitmap_scnlistprintf() and bitmap_parselist() for parsing to bitm=
ap
> and then you can go through all keys and disable according to said
> bitmap. You would need to extend the platform data forst to allow dri=
ver
> specify whether it wants to sharee interrupt or it is greedy since we
> can't disable shared interrupts.
>=20
> What do you think about it?

Looks unnecessarily complicated. We can jut try this, and see.

Thanks!

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
