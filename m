From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Mon, 25 Jul 2016 16:59:17 +0200
Message-ID: <20160725145917.GZ29844@pali>
References: <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly>
 <20160721063234.GA14200@amd>
 <20160721064241.GA31008@jelly>
 <20160721085421.GA15485@amd>
 <20160721090429.GP29844@pali>
 <20160722001219.GB11426@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37744 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbcGYO7U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 10:59:20 -0400
Content-Disposition: inline
In-Reply-To: <20160722001219.GB11426@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com

On Friday 22 July 2016 10:12:19 Peter Hutterer wrote:
> On Thu, Jul 21, 2016 at 11:04:29AM +0200, Pali Roh=C3=A1r wrote:
> > On Thursday 21 July 2016 10:54:21 Pavel Machek wrote:
> > > On Thu 2016-07-21 16:42:41, Peter Hutterer wrote:
> > > > On Thu, Jul 21, 2016 at 08:32:34AM +0200, Pavel Machek wrote:
> > > > > Hi!
> > > > >=20
> > > > > > > In the mean time you can adjust the name or use XID inste=
ad.
> > > > > >=20
> > > > > > X has partially fixed this a few years ago. All input drive=
rs (that
> > > > > > matter) export a Device Node property that sets the device =
node for each
> > > > > > device.
> > > > > >=20
> > > > > >  $ xinput list-props "SynPS/2 Synaptics TouchPad" | grep "D=
evice Node"
> > > > > >         Device Node (261):      "/dev/input/event4"
> > > > > >=20
> > > > > > Based on that you can get the udev device and work your way=
 into any of the
> > > > > > sysfs tree. Or do whatever else you want.
> > > > > >=20
> > > > > > But other than that there isn't anything in X to fix. xinpu=
t is primarily a
> > > > > > debugging tool and it does name resolution for convenience.=
 But it's not a
> > > > > > tool for complex configurations. It does exactly what it ne=
eds to do, if you
> > > > > > need something that's more complicated and relies on inform=
ation not
> > > > > > available to the X device itself then you'll need to write =
a custom tool
> > > > > > that does what you need. sorry.
> > > > >=20
> > > > > Ok.. so out of the box, touchscreen is "upside down" and misc=
alibrated
> > > > > on n900. So I need to run
> > > > >=20
> > > > > xinput --set-prop --type=3Dfloat 8 115  1.10 0.00 -0.05  0.00=
 1.18 -0.10 0.00 0.00 1.00
> > > > > xinput --set-prop --type=3Dint 8 249 0 1
> > > > >=20
> > > > > (or equivalent with names) so that I can use the touchscreen.=
 (And
> > > > > that's quite important -- X is somehow unusable without point=
ing
> > > > > device).
> > > > >=20
> > > > > If xinput is not the right solution, what is the right soluti=
on?
> > > >=20
> > > > if it's reliably miscalibrated (i.e. the numbers don't change),=
 use an
> > > > xorg.conf snippet. If it needs some run-time changes add the ho=
oks
> > > > to
> > >=20
> > > Does not change and is needed for all the N900's.
> > >=20
> > > Well. I guess xorg.conf snippet will do the trick, but that's har=
dly
> > > better.
> > >=20
> > > Should x.org have internal database saying "Nokia N900 with tsc20=
05
> > > touchscreen means this calibration"?
> > >=20
> > > Should we have calibration info in the device tree, with kernel
> > > passing it to the x?
> > >=20
> > > Should kernel somehow do the calibration itself?
> >=20
> > From my memory how this problem is solved on Maemo 5:
> >=20
> > There is XML snippet of HAL file which contains xorg properties for
> > input driver. Xorg server loads from HAL xorg settings and somehow
> > propagate them. That file is generated either from default system d=
ata
> > (those comes from DEB package) or from user config file (that is
> > generated from Settings application) or from CAL partition (NAND
> > partition which contains device/product specific calibration data).
> >=20
> > Because it is read also from CAL, I need to say those data does not=
 have
> > to be same for all N900 devices.
> >=20
> > And because there is Settings application which can re-calibrate
> > touchscreen, those data are not even static.
> >=20
> > Now HAL is deprecated, but I suspect that xorg.conf.d/ directory or=
 UDEV
> > can be used in same way to propagate device specific settings for
> > touchscreen device...
>=20
> yes, xorg.conf.d snippets replaced HAL configuration, with pretty muc=
h the
> same functionality. Using udev is not generally recommended.

In case that calibration data are stored in different format as
xorg.conf.d accept (and these data can be changed), what is preferred
way for pushing these calibration into X server?

I thought that udev could be right way as it contains key/value
properties in unified format (not X specific) and lot of other helpers
fill these data for different devices.

Why is is not generally recommended?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
