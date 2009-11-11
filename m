From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
 through sysfs
Date: Wed, 11 Nov 2009 10:52:53 +0200
Message-ID: <1257929573.21596.960.camel@localhost>
References: <20091028054317.GB2368@core.coreip.homeip.net>
	 <20091028105001.GB26199@esdhcp04058.research.nokia.com>
	 <20091104090628.GG31062@gw.healthdatacare.com>
	 <1257326759.21596.92.camel@localhost>
	 <20091106075220.GC11311@core.coreip.homeip.net>
	 <1257779344.21596.502.camel@localhost>
	 <20091109171834.GA30386@core.coreip.homeip.net>
	 <1257851059.21596.725.camel@localhost>
	 <20091110171945.GA15263@core.coreip.homeip.net>
	 <1257922211.21596.823.camel@localhost>
	 <20091111081949.GB22141@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63135 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZKKIxG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 03:53:06 -0500
In-Reply-To: <20091111081949.GB22141@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Sorry Dmitry, I'm new to the input subsystem, may be this is why I stil=
l
do not see any problem with introducing a nice and useful ioctl?

On Wed, 2009-11-11 at 00:19 -0800, Dmitry Torokhov wrote:
> > > I understand the appeal of working with the keycodes but what you=
 are
> > > asking is not simply ignoring certain keypresses (that is easy, j=
ust
> > > ignore corresponding events in userspace), you want to prevent sy=
stem
> > > from waking up. In other words you want to "control PM layer thro=
ugh
> > > input layer" and I believe this is wrong.
> >=20
> > Err, this is really about disabling keys.=20
>=20
> If you want to stop delivery of certain keycodes to userspace then OK=
,
> an option to subscrbe to certain events only instead of getting all
> events from the device. But again, it will only work for that particu=
lar
> user only, not everyone.

Yes, this will work for some particular input devices only, those which
support the keys masking. What is wrong with this? We have the '-ENOTTY=
'
error code, which for ioctl's means "ioctl is not supported".

But no one prevents us from making this work for _every_ input device b=
y
implementing a default ioctl handler in evdev.c, if needed. This handle=
r
can mask certain keys in SW.

IOW:
   1. if my HW supports HW key masking, the evdev ioctl calls my
      handler, which is implemented in my driver.
   2. if my HW does not support this, the evdev ioctl masks the keys in
      SW.

We are interested in 1. And if later someone needs 2., he/she can very
easily implement that. But for now we can just return -ENOTTY (or
-EINVAL, which seems to be used in the input subsystem).

> > If we think about this in an
> > abstract way, you have an input device with many keys. And the devi=
ce's
> > HW allows you to disable any of it's keys. When you disable the key=
, the
> > input device ignores it and does not generate any interrupt for it.
>=20
> And the reason you want to stop interrupts?

The reason is that I want simply mute certain keys. This is the only
reason.

Now the question is _how_ I want to mute the key. My HW supports muting=
,
so I want to mute it in HW level, just because it is much better and
more efficient. Just because in this case I will not have any interrupt
and my device will wake up less.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
