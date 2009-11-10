From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
 through sysfs
Date: Tue, 10 Nov 2009 13:04:19 +0200
Message-ID: <1257851059.21596.725.camel@localhost>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com>
	 <20091028054317.GB2368@core.coreip.homeip.net>
	 <20091028105001.GB26199@esdhcp04058.research.nokia.com>
	 <20091104090628.GG31062@gw.healthdatacare.com>
	 <1257326759.21596.92.camel@localhost>
	 <20091106075220.GC11311@core.coreip.homeip.net>
	 <1257779344.21596.502.camel@localhost>
	 <20091109171834.GA30386@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45132 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbZKJLE5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 06:04:57 -0500
In-Reply-To: <20091109171834.GA30386@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2009-11-09 at 09:18 -0800, Dmitry Torokhov wrote:
> Hi Artem,
>=20
> On Mon, Nov 09, 2009 at 05:09:04PM +0200, Artem Bityutskiy wrote:
> > On Thu, 2009-11-05 at 23:52 -0800, Dmitry Torokhov wrote:
> > > On Wed, Nov 04, 2009 at 11:25:59AM +0200, Artem Bityutskiy wrote:
> > > > > > > I think registering a full-blown device for every key is =
way too much,
> > > > > > > given that most consumers of gpio-keys driver are embedde=
d... Besides, I
> > > > > > > don't think this should be driven from userspace. Board (=
platform) code
> > > > > > > should know what GPIO make sense as wake up sources for t=
he particular
> > > > > > > device and should set up platform data accordingly.
> > > >=20
> > > > For example, on N900 we want to disable the lens cover / proxim=
ity / etc
> > > > gpios when the phones' screen is locked. Simply because we do n=
ot want
> > > > the lines to generate interrupts, wakes up the CPU and waste ou=
r battery
> > > > energy. But we do not want to disable the screen lock gpio, and=
 some
> > > > incoming call related gpios.
> > > >=20
> > > > So we really do want this to be userspace-driven.
> > > >=20
> > >=20
> > > OK, then maybe we should use 2 attributes, one showing gpios that=
 can
> > > be used for wakeup and one showing gpios that are currently set u=
p as
> > > wakeup sources. These can be built on using bitmap_scnlistprintf(=
) and
> > > bitmap_parselist() and can work with either GPIO numbers or keyco=
des.
> >=20
> > Hi Dmitry,
> >=20
> > could you please elaborate some more?
> >=20
> > * are you talking about per-input device sysfs files?
>=20
> I am not sure at what level these attributes must be created. While t=
he
> easiest way is indeed per-input device attribute (for that particular
> driver) the functionality does not really have anything to do with
> input... I'd probably prefer having this attribute elsewhere, maybe
> we should extend /sys/class/gpio/gpioN for these purposes?
>=20
> > * could you please give an example of how would I switch off, say, =
the
> >   SW_CAMERA_LENS_COVER gpio by the keycode.
>=20
> If the code lies in your driver then it is easy (the driver knows the
> mapping); otherwsie you'll have to go with GPIO number.

GPIO numbers are bad for us. We want to work with keycodes, and this is
input subsystem after all. We do not want to do any perversions like
making our user-space figuring out gpio numbers by the keycodes. This i=
s
simply wrong and bad interface.

We want to have a simple way for the application to disable any key by
key code. This should be as simple as calling one single
"enable/disable" ioctl for /dev/input/event2. I do not see how this
could be done nicely with sysfs, still.

But we will try to come up with some solution.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
