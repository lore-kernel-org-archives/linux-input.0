From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work
	anymore
Date: Mon, 12 Oct 2009 08:45:54 -0700
Message-ID: <20091012154553.GA7996@core.coreip.homeip.net>
References: <4AD120F2.3020606@tremplin-utc.net> <20091011030029.GA6526@suse.de> <200910112135.29384.dmitry.torokhov@gmail.com> <4AD31709.4000103@tremplin-utc.net> <20091012144458.GA1326@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:53648 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632AbZJLPqi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 11:46:38 -0400
Content-Disposition: inline
In-Reply-To: <20091012144458.GA1326@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, Oct 12, 2009 at 07:44:58AM -0700, Greg KH wrote:
> On Mon, Oct 12, 2009 at 01:46:17PM +0200, =C9ric Piel wrote:
> > Op 12-10-09 06:35, Dmitry Torokhov schreef:
> > > On Saturday 10 October 2009 08:00:29 pm Greg KH wrote:
> > >> On Sun, Oct 11, 2009 at 02:04:02AM +0200, ?ric Piel wrote:
> > >>> Hello,
> > >>>
> > >>> After a suspend, I used to do this (to get the PS2 keyboard wor=
king
> > >>> again), and it used to work fine:
> > >>> echo -n "i8042" > /sys/bus/platform/drivers/i8042/unbind ; slee=
p 1 ; echo
> > >>> -n "i8042" > /sys/bus/platform/drivers/i8042/bind
> > >>>
> > >>> Unfortunately since 2.6.32-rc1, the unbind works fine, but the =
bind
> > >>> returns a "no such device" error now (and the binding is not do=
ne). After
> > >>> that, additional unbinds also report the error. I think 2.6.31 =
worked
> > >>> fine. Any idea what's going wrong?
> > >> Odd.  Any chance you can run 'git bisect' to figure out which pa=
tch
> > >> might have caused it?
> > >=20
> > > I8042 has been converted to use platform_driver_probe() - we are =
creating=20
> > > platform device and platform driver together, there is no chance =
that some=20
> > > other device might be driven by i8042 driver.
> > I haven't finished bisecting, but indeed, the problem seemed to con=
verge
> > toward this patch.
> >=20
> >=20
> > > Eric, do you still need to fiddle with i8042 to get your keyboard=
 working with=20
> > > 2.6.32-rc3? We need to make sure that resube works without users =
needing to=20
> > > mess with bind/unbind.
> > Yes, the keyboard doesn't work after the first resume from ram (the
> > later resumes do work). I haven't tried any special option to the i=
8042
> > driver. This is on a HP 2510, in 64 bits.
> >=20
> > Indeed, it would be great to fix this root problem! Is there any bu=
g
> > report opened to work on this?
> >=20
> > However, currently the first problem is that unbind works, while bi=
nd
> > doesn't. Which means anyone doing an unbind will have keyboard and =
mouse
> > lost until the next reboot. That's rather bad because it has been
> > recommended for a long time to have this kind of script at resume:
> > http://intertrusion.com/files/hp-s2ram.patch
> > http://en.opensuse.org/Pm-utils
> >=20
> > So at least, unbind should fail as well as bind.
>=20
> Ah, I bet I know why bind fails...  Yeah, the i8042_platform_device i=
s
> never freed up in the i8042_remove() function in
> drivers/input/serio/i8042.c, so when you try to register it again, it
> fails.
>=20

Huh? Platform device and driver are created in i8042_init() and removed
in i8042_exit(); i8042_remove() is a remove() method of the platform
driver so it never should be freeing the platform device.

The issue is that with platform drivers using i8042_driver_probe() the
probe frunction is discarded afterwards so the driver can't be bound to
anything after initialization has been completed; however unbinding
through 'unbind' attribute still works (once). You may recall a thread
with me and David arguing about it a couple of weeks ago...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
