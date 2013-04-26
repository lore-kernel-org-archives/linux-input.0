From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: eGalax touchscreen regression
Date: Fri, 26 Apr 2013 08:39:11 -0700
Message-ID: <20130426153911.GA18528@core.coreip.homeip.net>
References: <1366708088.9823.16.camel@sauron.fi.intel.com>
 <20130423154007.GB4104@core.coreip.homeip.net>
 <1366794193.21369.11.camel@sauron.fi.intel.com>
 <3076410.nE1Nu6ITeM@wuerfel>
 <1366988945.3603.46.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34212 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab3DZPjP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Apr 2013 11:39:15 -0400
Content-Disposition: inline
In-Reply-To: <1366988945.3603.46.camel@sauron.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hui Wang <jason77.wang@gmail.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hofemeier, Ulf" <ulf.hofemeier@intel.com>

On Fri, Apr 26, 2013 at 06:09:05PM +0300, Artem Bityutskiy wrote:
> On Fri, 2013-04-26 at 16:59 +0200, Arnd Bergmann wrote:
> > On Wednesday 24 April 2013 12:03:13 Artem Bityutskiy wrote:
> > > On Tue, 2013-04-23 at 08:40 -0700, Dmitry Torokhov wrote:
> > > > > the eGalax driver now requires OF. For us this is a regressio=
n because
> > > > > we do not have OF: https://bugs.tizen.org/jira/browse/TIVI-74=
0
> > > >=20
> > > > I see. In this case we need to come up with a platform data to =
pass
> > > > wakeup gpio in case platform does not support OF. irq_to_gpio()=
 is not
> > > > supported on many platforms, causing compilation errors.
> > > >=20
> > > > Is the platform that you are trying to use the touchscreen upst=
ream?
> > >=20
> > > OK, so this is about just a monitor with a touchscreen (Giantec h=
igh-res
> > > capacitive 11.6=E2=80=9D LCD monitor). The touchscreen is connect=
ed to a
> > > commodity hardware via USB.
> > >=20
> > > So yes, the platform _is_ upstream  Namely, we use just a SandyBr=
idge
> > > PC.
> >=20
> > So you use a usb-to-i2c interface?
>=20
> I do not think so. The problem is that I do not have the HW, so I was
> making guesses, and it looks like this driver has nothing to do with =
the
> regression we've got. Sorry for the noise. We'll investigate this mor=
e
> carefully internally.

OK, so assuming you simply using USB version of eGalax device the only
recent change (3.6-rc7) was:

commit 037a833ed05a86d01ea27a2c32043b86c549be1b
Author: Forest Bond <forest.bond@rapidrollout.com>
Date:   Tue Sep 4 20:27:37 2012 -0700

    Input: usbtouchscreen - initialize eGalax devices
   =20
    Certain eGalax devices expose an interface with class HID and proto=
col
    None.  Some work with usbhid and some work with usbtouchscreen, but
    there is no easy way to differentiate.  Sending an eGalax diagnosti=
c
    packet seems to kick them all into using the right protocol for
    usbtouchscreen, so we can continue to bind them all there (as oppos=
ed to
    handing some off to usbhid).
   =20
    This fixes a regression for devices that were claimed by (and worke=
d
    with) usbhid prior to commit 139ebe8dc80dd74cb2ac9f5603d18fbf5cff04=
9f
    ("Input: usbtouchscreen - fix eGalax HID ignoring"), which made
    usbtouchscreen claim them instead.  With this patch they will still=
 be
    claimed by usbtouchscreen, but they will actually report events
    usbtouchscreen can understand.  Note that these devices will be lim=
ited
    to the usbtouchscreen feature set so e.g. dual touch features are n=
ot
    supported.
   =20
    I have the distinct pleasure of needing to support devices of both =
types
    and have tested accordingly.
   =20
    Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
