From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Tue, 23 Mar 2010 04:01:48 +0100
Message-ID: <201003230401.48660.marek.vasut@gmail.com>
References: <4BA70831.1040606@gmail.com> <0D753D10438DA54287A00B02708426976368DDD220@AUSP01VMBX24.collaborationhost.net> <4BA81BC7.9040107@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:44368 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab0CWDC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 23:02:28 -0400
Received: by fxm23 with SMTP id 23so1528234fxm.21
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 20:02:26 -0700 (PDT)
In-Reply-To: <4BA81BC7.9040107@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Graham Gower <graham.gower@gmail.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dne =C3=9At 23. b=C5=99ezna 2010 02:39:19 Graham Gower napsal(a):
> H Hartley Sweeten wrote:
> > On Monday, March 22, 2010 5:59 PM, Marek Vasut wrote:
> >> Dne Po 22. b=C5=99ezna 2010 23:44:26 Graham Gower napsal(a):
> >>> Marek Vasut wrote:
> >>>> Dne Po 22. b=C5=99ezna 2010 07:03:29 Graham Gower napsal(a):
> >>>>> Hi Marek,
> >>>>> I wish to use the ucb1400_ts driver on my device. But I'm havin=
g
> >>>>> trouble passing the platform_data to the ucb1400_core driver.
> >>>>>
> >>>>> I couldn't see any in tree examples of this being done and my
> >>>>> attempts to do this via registering a platform_driver for
> >>>>> ucb1400_core have failed (probably since this driver is
> >>>>> ac97_bus_type, not a
> >>>>> platform_driver).
> >>>>>
> >>>>> Can you provide me with info regarding the correct method for p=
assing
> >>>>> the irq to the driver?
> >>>>>
> >>>>> Thanks,
> >>>>> -Graham
> >>>>
> >>>> static struct ucb1400_pdata pdata =3D {
> >>>> 	.irq	=3D IRQ_GPIO(123),
> >>>> };
> >>>>
> >>>> static struct platform_device ucb1400_core =3D {
> >>>>         .name   =3D "ucb1400_core",
> >>>>         .id     =3D -1,
> >>>> 	.dev	=3D {
> >>>> 		.platform_data =3D &pdata,
> >>>> 	},
> >>>> };
> >>>>
> >>>> init() {
> >>>> 	platform_device_register(&ucb1400_core);
> >>>> }
> >>>>
> >>>> Like this ?
> >>>
> >>> That is the first thing I tried and it doesn't work. I suggest yo=
u
> >>> printk the pdata in the ucb1400_core driver after having done thi=
s to
> >>> confirm (I got NULL). You don't need to register a platform drive=
r for
> >>>  ucb1400_core_probe() to be called anyway - presumably its enumer=
ated
> >>> from the ac97 bus.
> >>
> >> Oh yes you have to, otherwise the pdata won't be passed. Besides, =
it's
> >> weird probe()'s called if you didn't register it. But obviously wh=
atever
> >> calls it doesn't pass the pdata.
> >
> > The driver is registered with platform_driver_register, as such it =
will
> > be tied to the platform bus not the ac97 bus.  Being a platform dri=
ver,
> > you do need a matching platform_device_register so that you get a
> > device<->driver binding.
>=20
> I suspect we are looking at different files, or different versions of=
 the
>  file. I'm looking at drivers/mfd/ucb1400_core.c, which looks like th=
is:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Dd
> rivers/mfd/ucb1400_core.c;hb=3DHEAD
>=20
> The ucb1400_core is registered with driver_register.
>=20
> I have grepped my tree and the only places I see "ucb12400_core" are =
in a
>  couple of arm board files and in my board file. Mine is commented ou=
t, and
>  I definitely still get the probe being called.
>=20
> I added dump_stack() to the probe function.
>=20
> [<80014f50>] dump_stack+0x8/0x34
> [<801b1dec>] ucb1400_core_probe+0x48/0x1ac
> [<801ab114>] driver_probe_device+0x128/0x254
> [<801aa440>] bus_for_each_drv+0x60/0xb0
> [<801ab3e4>] device_attach+0x60/0x88
> [<801aa234>] bus_probe_device+0x30/0x54
> [<801a8a74>] device_add+0x368/0x4f0
> [<80210970>] snd_ac97_dev_register+0xa0/0xd8
> [<801ef6e8>] snd_device_register_all+0x44/0x80
> [<801eb2f4>] snd_card_register+0x64/0x18c
> [<80216f3c>] snd_soc_instantiate_cards+0x368/0x5c4
> [<80217214>] soc_probe+0x7c/0xc4
> [<801ab114>] driver_probe_device+0x128/0x254
> [<801aa440>] bus_for_each_drv+0x60/0xb0
> [<801ab3e4>] device_attach+0x60/0x88
> [<801aa234>] bus_probe_device+0x30/0x54
> [<801a8a74>] device_add+0x368/0x4f0
> [<801aca5c>] platform_device_add+0x14c/0x1b8
> [<803813a4>] quokka_init+0x98/0xec
> [<800180f0>] do_one_initcall+0x68/0x200
> [<80371328>] kernel_init+0xc4/0x164
> [<8001ac2c>] kernel_thread_helper+0x10/0x18

Aren't you probing it from some driver or something ?
>=20
> >> And yes, I printk'd it when I was sending this patch in and it wor=
ked
> >> for me ... register the platform device and you should be ok.
> >>
> >>>> btw. you don't have to pass pdata at all ... the logic for
> >>>> auto-detecting IRQ is still there and is active if no pdata are
> >>>> supplied.
> >>>
> >>> This does not work for me. I have not yet investigated why.
> >>
> >> I'd better get rid of that autodetection stuff altogether, but ftt=
b it
> >> can be there.
> >
> > Another reason your irq might not be working is that its not valid.=
  Is
> > gpio 123 a valid IRQ producer on your platform?  IRQ_GPIO(123) migh=
t
> > resolve to (ucb->irq < 0) which would cause the probe to try auto
> > detecting the irq.
>=20
> This has nothing to do with the irq number that I'm passing (which is=
 not
>  123 anyway). The ucb1400_core's dev->platform_data pointer is NULL.

We know it is NULL ... that's because you're not passing it.
>=20
> > BTW, this driver looks a little scary.
> >
> > The 'platform data' that is passed to the driver is also the 'priva=
te
> > data' used by the driver.  Since the only data passed by the platfo=
rm is
> > the irq it would probably be cleaner to pass a struct ucb1400_pdata=
 to
> > the driver and kzalloc the private struct ucb1400_ts data in the dr=
iver.
> >
> > Just my 0.02...
> >
> > Regards,
> > Hartley
>=20
> -Graham
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
