From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Fri, 22 Jul 2016 10:12:19 +1000
Message-ID: <20160722001219.GB11426@jelly>
References: <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly>
 <20160721063234.GA14200@amd>
 <20160721064241.GA31008@jelly>
 <20160721085421.GA15485@amd>
 <20160721090429.GP29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160721090429.GP29844@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-input@vger.kernel.org

On Thu, Jul 21, 2016 at 11:04:29AM +0200, Pali Roh=E1r wrote:
> On Thursday 21 July 2016 10:54:21 Pavel Machek wrote:
> > On Thu 2016-07-21 16:42:41, Peter Hutterer wrote:
> > > On Thu, Jul 21, 2016 at 08:32:34AM +0200, Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > > > In the mean time you can adjust the name or use XID instead=
=2E
> > > > >=20
> > > > > X has partially fixed this a few years ago. All input drivers=
 (that
> > > > > matter) export a Device Node property that sets the device no=
de for each
> > > > > device.
> > > > >=20
> > > > >  $ xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Dev=
ice Node"
> > > > >         Device Node (261):      "/dev/input/event4"
> > > > >=20
> > > > > Based on that you can get the udev device and work your way i=
nto any of the
> > > > > sysfs tree. Or do whatever else you want.
> > > > >=20
> > > > > But other than that there isn't anything in X to fix. xinput =
is primarily a
> > > > > debugging tool and it does name resolution for convenience. B=
ut it's not a
> > > > > tool for complex configurations. It does exactly what it need=
s to do, if you
> > > > > need something that's more complicated and relies on informat=
ion not
> > > > > available to the X device itself then you'll need to write a =
custom tool
> > > > > that does what you need. sorry.
> > > >=20
> > > > Ok.. so out of the box, touchscreen is "upside down" and miscal=
ibrated
> > > > on n900. So I need to run
> > > >=20
> > > > xinput --set-prop --type=3Dfloat 8 115  1.10 0.00 -0.05  0.00 1=
=2E18 -0.10 0.00 0.00 1.00
> > > > xinput --set-prop --type=3Dint 8 249 0 1
> > > >=20
> > > > (or equivalent with names) so that I can use the touchscreen. (=
And
> > > > that's quite important -- X is somehow unusable without pointin=
g
> > > > device).
> > > >=20
> > > > If xinput is not the right solution, what is the right solution=
?
> > >=20
> > > if it's reliably miscalibrated (i.e. the numbers don't change), u=
se an
> > > xorg.conf snippet. If it needs some run-time changes add the hook=
s
> > > to
> >=20
> > Does not change and is needed for all the N900's.
> >=20
> > Well. I guess xorg.conf snippet will do the trick, but that's hardl=
y
> > better.
> >=20
> > Should x.org have internal database saying "Nokia N900 with tsc2005
> > touchscreen means this calibration"?
> >=20
> > Should we have calibration info in the device tree, with kernel
> > passing it to the x?
> >=20
> > Should kernel somehow do the calibration itself?
>=20
> From my memory how this problem is solved on Maemo 5:
>=20
> There is XML snippet of HAL file which contains xorg properties for
> input driver. Xorg server loads from HAL xorg settings and somehow
> propagate them. That file is generated either from default system dat=
a
> (those comes from DEB package) or from user config file (that is
> generated from Settings application) or from CAL partition (NAND
> partition which contains device/product specific calibration data).
>=20
> Because it is read also from CAL, I need to say those data does not h=
ave
> to be same for all N900 devices.
>=20
> And because there is Settings application which can re-calibrate
> touchscreen, those data are not even static.
>=20
> Now HAL is deprecated, but I suspect that xorg.conf.d/ directory or U=
DEV
> can be used in same way to propagate device specific settings for
> touchscreen device...

yes, xorg.conf.d snippets replaced HAL configuration, with pretty much =
the
same functionality. Using udev is not generally recommended.

Cheers,
   Peter

> So... if we decide that it is good idea to put calibration data (eith=
er
> to kernel driver/N900 DTS or xorg project), first we need to somehow
> check and verify that those default calibration data are good for mos=
t
> (or all) N900. Or check on more N900 how differs data in CAL partitio=
n
> (maybe they are really static??).
>=20
> --=20
> Pali Roh=E1r
> pali.rohar@gmail.com
