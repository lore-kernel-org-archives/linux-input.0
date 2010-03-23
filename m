From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Tue, 23 Mar 2010 04:13:34 +0100
Message-ID: <201003230413.34255.marek.vasut@gmail.com>
References: <4BA70831.1040606@gmail.com> <4BA81BC7.9040107@gmail.com> <0D753D10438DA54287A00B02708426976368DDD236@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:37816 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab0CWDOL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 23:14:11 -0400
Received: by fxm23 with SMTP id 23so1535653fxm.21
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 20:14:10 -0700 (PDT)
In-Reply-To: <0D753D10438DA54287A00B02708426976368DDD236@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Graham Gower <graham.gower@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dne =C3=9At 23. b=C5=99ezna 2010 03:08:21 H Hartley Sweeten napsal(a):
> On Monday, March 22, 2010 6:39 PM, Graham Gower wrote:
> > H Hartley Sweeten wrote:
> >>>> That is the first thing I tried and it doesn't work. I suggest y=
ou
> >>>> printk the pdata in the ucb1400_core driver after having done th=
is to
> >>>> confirm (I got NULL). You don't need to register a platform driv=
er for
> >>>>  ucb1400_core_probe() to be called anyway - presumably its enume=
rated
> >>>> from the ac97 bus.
> >>>
> >>> Oh yes you have to, otherwise the pdata won't be passed. Besides,=
 it's
> >>> weird probe()'s called if you didn't register it. But obviously
> >>> whatever calls it doesn't pass the pdata.
> >>
> >> The driver is registered with platform_driver_register, as such it=
 will
> >> be tied to the platform bus not the ac97 bus.  Being a platform dr=
iver,
> >> you do need a matching platform_device_register so that you get a
> >> device<->driver binding.
> >
> > I suspect we are looking at different files, or different versions =
of the
> > file. I'm looking at drivers/mfd/ucb1400_core.c, which looks like t=
his:
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dblob;f
> >=3Ddrivers/mfd/ucb1400_core.c;hb=3DHEAD
>=20
> Ah, I just saw that.  I was only looking at the ucb1400_ts.c driver i=
tself
>  and the only direct in-tree user arch/avr32/boards/atngw100/mrmt.c. =
 I
>  didn't notice that there was also a mfd driver.

There's no ucb1400_ts anymore. There's only the MFD driver, nothing els=
e.
>=20
> > The ucb1400_core is registered with driver_register.
>=20
> That mfd driver still registers it's children as platform drivers usi=
ng
> platform_device_alloc, platform_device_add_data, and platform_device_=
add.
>=20
> > I have grepped my tree and the only places I see "ucb12400_core" ar=
e in a
> > couple of arm board files and in my board file. Mine is commented o=
ut,
> > and I definitely still get the probe being called.
>=20
> The only in tree users of the mfd driver appear to be mach-pxa/cm-x2x=
x.c
>  and mach-pxa/palmtc.c, neither of which pass the platform_data.

You can pass platform data as I said in the earlier example. That was t=
ested on=20
PalmTC.
>=20
> >>> And yes, I printk'd it when I was sending this patch in and it wo=
rked
> >>> for me ... register the platform device and you should be ok.
> >>>
> >>>>> btw. you don't have to pass pdata at all ... the logic for
> >>>>> auto-detecting IRQ is still there and is active if no pdata are
> >>>>> supplied.
> >>>>
> >>>> This does not work for me. I have not yet investigated why.
> >>>
> >>> I'd better get rid of that autodetection stuff altogether, but ft=
tb it
> >>> can be there.
> >>
> >> Another reason your irq might not be working is that its not valid=
=2E  Is
> >> gpio 123 a valid IRQ producer on your platform?  IRQ_GPIO(123) mig=
ht
> >> resolve to (ucb->irq < 0) which would cause the probe to try auto
> >> detecting the irq.
> >
> > This has nothing to do with the irq number that I'm passing (which =
is not
> > 123 anyway). The ucb1400_core's dev->platform_data pointer is NULL.
>=20
> That number was from the avr code.  Sorry for any confusion.

The '123' was just a silly number, an example, you need to fill you own=
 ... it=20
wasnt from AVR code.
>=20
> >> BTW, this driver looks a little scary.
> >>
> >> The 'platform data' that is passed to the driver is also the 'priv=
ate
> >> data' used by the driver.  Since the only data passed by the platf=
orm is
> >> the irq it would probably be cleaner to pass a struct ucb1400_pdat=
a to
> >> the driver and kzalloc the private struct ucb1400_ts data in the d=
river.
> >>
> >> Just my 0.02...
>=20
> I'm going to step out of this one.
>=20
> I started looking at the mfd driver to see if I could help out with y=
our
>  problem. I honestly don't even get how this all works....

Maybe I'm starting to recall how that whole thing worked. I took a look=
 at the=20
code and my guess might be -- it takes pdata from the ac97 bus. I'm not=
 sure=20
here, but pxa2xx-ac97 allows passing platform data through the ac97 bus=
, dunno=20
how are other platform's ac97 implementations. If I'm right here, you m=
ight need=20
to fix your mips-whatever-ac97 to allow passing platform data and then =
pass them=20
through there.

If that's the case, the earlier example was wrong and you should start =
digging=20
around ac97 (see git log for pxa2xx-ac97.c and find a patch that added =
this=20
passing of platform data there).
>=20
> The two in-tree users register the 'ucb1400_core' device differently.=
=20
>  cm-x2xx.c uses platform_device_register and palmtc.c uses
>  platform_add_devices.  Those two paths are completely different, but=
 they
>  probably get to the same state eventually.
>=20
> The ucb1400_core driver registers a 'device_driver' on the ac97 bus. =
 As
>  such, it probably does get probed by the ac97 bus not the platform b=
us.=20
>  The actual ucb1400_core probe function probably isn't even tied to t=
he
>  correct platform data, it's parameter is a struct device * not a str=
uct
>  platform_device *.
>=20
> Anyway, good luck.  Sorry I can't offer any help.
>=20
> Regards,
> Hartley
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
