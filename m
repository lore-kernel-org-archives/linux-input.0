From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Input: Add ioctl to block suspend while event queue is not empty.
Date: Thu, 16 Feb 2012 23:31:06 +0100
Message-ID: <201202162331.07051.rjw@sisk.pl>
References: <1327112659-31145-1-git-send-email-arve@android.com> <201202160051.16011.rjw@sisk.pl> <CAMP5XgfpM8309wHMW+W0XrEYvsz6pYdcwdqxkp-Jgpbm1m5hgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56665 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650Ab2BPW1O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Feb 2012 17:27:14 -0500
In-Reply-To: <CAMP5XgfpM8309wHMW+W0XrEYvsz6pYdcwdqxkp-Jgpbm1m5hgQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>, Chase Douglas <chase.douglas@canonical.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org

On Thursday, February 16, 2012, Arve Hj=F8nnev=E5g wrote:
> 2012/2/15 Rafael J. Wysocki <rjw@sisk.pl>:
> ...
> > Still, I have one issue with adding those ioctls.  Namely, wouldn't=
 it be
> > simpler to treat all events coming from wakeup devices as wakeup ev=
ents?
> >
>=20
> User-space needs to block suspend between select/poll and read for
> this to work, so an explicit call to enable this is useful.
>=20
> > With the new ioctls user space can "mark" a queue of events coming =
out of
> > a device that's not a wakeup one as a "wakeup source", which doesn'=
t seem to
> > be correct.
> >
>=20
> OK, but I don't think this is a big problem.
>=20
> > Conversely, with those ioctls user space can effectively turn event=
s coming
> > out of a wakeup device into non-wakeup ones, which doesn't seem to =
be correct
> > either.
> >
>=20
> I don't agree with this. There can be multiple readers on an input
> device. Only the reader that is responsible for acting on the wakeup
> event should call this ioctl.

Ah, OK.  So you envision the new ioctls as the way of saying "I'm the o=
ne
who's going to take care of those wakeup events"?  If that's the case, =
may
I suggest changing the names?

> > So, I think evdev client queue's wakeup source (or wakelock) should=
 stay active
> > if there are any events in the queue and the underlying device is a=
 wakeup one,
>=20
> I don't want additional readers of the device to prevent suspend.

OK

> > i.e. device_may_wakeup() returns true for it.  Then, we won't need =
the new
> > ioctls at all and user space will still be able to control which ev=
ents are to
> > be regarded as wakeup ones by changing the wakeup settings of the d=
evices that
> > generate them.
> >
>=20
> I don't think this is currently hooked up for most of the devices we
> have. If we do add a dynamic wakeup settings I would prefer to have a=
n
> ioctl to set which events on a device should be enabled for wakeup (o=
r
> just enabled) instead of switching the entire drive. That way we coul=
d
> turn off unneeded rows and columns in a key matrix.

Can you actually select what keys may wake up the system from sleep
(I mean "real sleep", when the whole system is entirely off except for =
wakeup
devices)?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
