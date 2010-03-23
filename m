From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: UCB1400: Passing IRQ through platform_data
Date: Tue, 23 Mar 2010 01:59:18 +0100
Message-ID: <201003230159.19010.marek.vasut@gmail.com>
References: <4BA70831.1040606@gmail.com> <201003221413.20841.marek.vasut@gmail.com> <4BA7F2CA.1060608@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:33548 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab0CWA75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 20:59:57 -0400
Received: by fxm23 with SMTP id 23so1435976fxm.21
        for <linux-input@vger.kernel.org>; Mon, 22 Mar 2010 17:59:56 -0700 (PDT)
In-Reply-To: <4BA7F2CA.1060608@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Graham Gower <graham.gower@gmail.com>
Cc: linux-input@vger.kernel.org

Dne Po 22. b=C5=99ezna 2010 23:44:26 Graham Gower napsal(a):
> Marek Vasut wrote:
> > Dne Po 22. b=C5=99ezna 2010 07:03:29 Graham Gower napsal(a):
> >> Hi Marek,
> >> I wish to use the ucb1400_ts driver on my device. But I'm having t=
rouble
> >> passing the platform_data to the ucb1400_core driver.
> >>
> >> I couldn't see any in tree examples of this being done and my atte=
mpts
> >> to do this via registering a platform_driver for ucb1400_core have
> >> failed (probably since this driver is ac97_bus_type, not a
> >> platform_driver).
> >>
> >> Can you provide me with info regarding the correct method for pass=
ing
> >> the irq to the driver?
> >>
> >> Thanks,
> >> -Graham
> >
> > static struct ucb1400_pdata pdata =3D {
> > 	.irq	=3D IRQ_GPIO(123),
> > };
> >
> > static struct platform_device ucb1400_core =3D {
> >         .name   =3D "ucb1400_core",
> >         .id     =3D -1,
> > 	.dev	=3D {
> > 		.platform_data =3D &pdata,
> > 	},
> > };
> >
> > init() {
> > 	platform_device_register(&ucb1400_core);
> > }
> >
> > Like this ?
>=20
> That is the first thing I tried and it doesn't work. I suggest you pr=
intk
> the pdata in the ucb1400_core driver after having done this to confir=
m (I
>  got NULL). You don't need to register a platform driver for
>  ucb1400_core_probe() to be called anyway - presumably its enumerated=
 from
>  the ac97 bus.

Oh yes you have to, otherwise the pdata won't be passed. Besides, it's =
weird=20
probe()'s called if you didn't register it. But obviously whatever call=
s it=20
doesn't pass the pdata.

And yes, I printk'd it when I was sending this patch in and it worked f=
or me ...=20
register the platform device and you should be ok.
>=20
> > btw. you don't have to pass pdata at all ... the logic for auto-det=
ecting
> > IRQ is still there and is active if no pdata are supplied.
>=20
> This does not work for me. I have not yet investigated why.

I'd better get rid of that autodetection stuff altogether, but fttb it =
can be=20
there.
>=20
> -Graham
>=20
> PS: I am on mips, not arm. Arm CC removed.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
