From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
 through sysfs
Date: Wed, 11 Nov 2009 08:50:11 +0200
Message-ID: <1257922211.21596.823.camel@localhost>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <20091028054317.GB2368@core.coreip.homeip.net>
	 <20091028105001.GB26199@esdhcp04058.research.nokia.com>
	 <20091104090628.GG31062@gw.healthdatacare.com>
	 <1257326759.21596.92.camel@localhost>
	 <20091106075220.GC11311@core.coreip.homeip.net>
	 <1257779344.21596.502.camel@localhost>
	 <20091109171834.GA30386@core.coreip.homeip.net>
	 <1257851059.21596.725.camel@localhost>
	 <20091110171945.GA15263@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48929 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbZKKGuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 01:50:22 -0500
In-Reply-To: <20091110171945.GA15263@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 2009-11-10 at 09:19 -0800, Dmitry Torokhov wrote:
> On Tue, Nov 10, 2009 at 01:04:19PM +0200, Artem Bityutskiy wrote:
> > On Mon, 2009-11-09 at 09:18 -0800, Dmitry Torokhov wrote:
> > >=20
> > > I am not sure at what level these attributes must be created. Whi=
le the
> > > easiest way is indeed per-input device attribute (for that partic=
ular
> > > driver) the functionality does not really have anything to do wit=
h
> > > input... I'd probably prefer having this attribute elsewhere, may=
be
> > > we should extend /sys/class/gpio/gpioN for these purposes?
> > >=20
> > > > * could you please give an example of how would I switch off, s=
ay, the
> > > >   SW_CAMERA_LENS_COVER gpio by the keycode.
> > >=20
> > > If the code lies in your driver then it is easy (the driver knows=
 the
> > > mapping); otherwsie you'll have to go with GPIO number.
> >=20
> > GPIO numbers are bad for us. We want to work with keycodes, and thi=
s is
> > input subsystem after all. We do not want to do any perversions lik=
e
> > making our user-space figuring out gpio numbers by the keycodes. Th=
is is
> > simply wrong and bad interface.
> >=20
> > We want to have a simple way for the application to disable any key=
 by
> > key code. This should be as simple as calling one single
> > "enable/disable" ioctl for /dev/input/event2. I do not see how this
> > could be done nicely with sysfs, still.
> >=20
>=20
> I understand the appeal of working with the keycodes but what you are
> asking is not simply ignoring certain keypresses (that is easy, just
> ignore corresponding events in userspace), you want to prevent system
> from waking up. In other words you want to "control PM layer through
> input layer" and I believe this is wrong.

Err, this is really about disabling keys. If we think about this in an
abstract way, you have an input device with many keys. And the device's
HW allows you to disable any of it's keys. When you disable the key, th=
e
input device ignores it and does not generate any interrupt for it.

So this is really about ignoring keycodes but on the driver level, not
at the evdev level. We just want to make evdev pass the ioctl down to
the device. If the device does not support it, it'll return an error.
Otherwise the device will just mask out the key on the HW level.

So it is not about playing evil games with PM, it is just about
disabling separate keys on the HW level. We really can look at this tha=
t
way.

=46or me this looks like a good enough abstraction. And probably this m=
ay
be useful for other input devices.

I think Mika had some patch which implements this, right?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
