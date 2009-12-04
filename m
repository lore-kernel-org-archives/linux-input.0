From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH 1/2] Input: add msi-wmi driver to support hotkeys in
 =?utf-8?q?MSI=C2=A0Windtop?= AE1900-WT
Date: Fri, 4 Dec 2009 11:55:53 +0100
Message-ID: <200912041155.54752.trenn@suse.de>
References: <20091202192603.3e1de98a@destiny.ordissimo> <200912031749.08734.trenn@suse.de> <20091204111506.254dccef@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46253 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbZLDKzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 05:55:50 -0500
In-Reply-To: <20091204111506.254dccef@destiny.ordissimo>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Friday 04 December 2009 11:15:06 Anisse Astier wrote:
> Hi Thomas,
>=20
> On Thu, 3 Dec 2009 17:49:07 +0100, Thomas Renninger <trenn@suse.de>
> wrote :
>=20
> > On Wednesday 02 December 2009 19:26:03 Anisse Astier wrote:
> > >=20
> > > Signed-off-by: Anisse Astier <anisse@astier.eu>
> > > ---
> > > Hi,
> > >=20
> > > This driver (intiated by=20
> > > http://sysmic.org/dotclear2/index.php?post/2009/06/02/83-msi-wmi-=
support) is
> > > aimed at supporting WMI based hotkeys on MSI=C2=A0Windtop all-in-=
one AE1900-WT.
> > I've already submitted a driver together with some other fixes a mo=
nth ago.
> >=20
> Indeed, I am sorry I didn't see it earlier. Did you write it from scr=
atch
> or base it on Jerome's patch?
I wrote it from scratch.
I started by taking over from hp-wmi, but later, beside of the key arra=
y
setup, most things changed...
=20
> > My driver not only registers an input device for backlight/volume u=
p, down,
> > but also registers a backlight driver for software based backlight =
switching.
> Indeed, and that's very nice!
> >=20
> > Not sure whether Len already submitted it to he's test branch, I ho=
pe so:
> > http://patchwork.kernel.org/patch/55944/
> >=20
> > Would be great if you can give it a try.
>=20
> I gave it a try, it works great. Buttons works as expected, and the
> backlight interface works as well. Now I have a few questions/comment=
s:
>=20
> > +static int backlight_map[] =3D { 0x00, 0x33, 0x66, 0x99, 0xCC, 0xF=
=46 };
> Why just 6 levels for backlight? Wasn't it possible to map the whole
> range? Does it work the same way in windows?
I got that from MSI people (one of the rare infos I got and that the
irq storm is a "HW" bug/feature also showing up on Windows),
they told me that's the values that should be used
(and yes, probably it's the way Windows works then as well).

> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <linux/input.h>
> > +#include <acpi/acpi_drivers.h>
> > +#include <linux/acpi.h>
> > +#include <linux/string.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/backlight.h>
> Do you need all these #includes? (e.g string.h)
>=20
> > +#define dprintk(msg...)	do {			\
> Isn't reimplementing some kind of dprintk a little outdated with
> DYNAMIC_PRINTK now in kernel?
Eh, DYNAMIC_PRINTK?
grep DYNAMIC_PRINTK include/linux/ -r
is empty...

> > +	kfree(obj);
> Good thing you're freeing the allocated acpi objects.
:)
Yep, I found that in hp-wmi when looking closer at it.

> > +			cur =3D ktime_get_real();
> > +			/* Ignore event if the same event happened in a 50 ms
> > +			   timeframe -> Key press may result in 10-20 GPEs */
> > +			if (ktime_to_us(ktime_sub(cur, key->last_pressed))
> > +			    < 1000 * 50) {
>=20
> You're debouncing by computing the time difference instead of using
> a kernel timer.
Do you see a problem with above?
You mean ktime_get_real() reads our the time via get getnstimeofday and
accessing IO, while your get_jiffies_64() solution reads out a kernel v=
ariable
incremented via timer irq which is a better solution?
While gettimeofday should be a fast TSC read on modern HW, I still have
to agree.

Testing this I saw ~5-25 IRQs per key hit, showing up in about a ~30ms
time frame, therefore I took 50ms ignoring the same IRQ and it worked o=
ut
fine. Your last_time_pressed timeout of 10ms might be a bit too short..=
=2E

Beside that (backlight) switching takes some time, but this should not
be due to above "debouncing".

> > +static int __init msi_wmi_init(void)
> You're init method could use some gotos to remove code duplication. (=
and
> merge some init with input_setup.)
>=20
> I would be happy to transform these comments into patches once I have=
 the
> time, and if you don't mind.
That would be great!

> I could also adapt it for sparse keymaps as I did with the other driv=
er
> (would reduce code size).
Cool.

Thanks for the review,

    Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
