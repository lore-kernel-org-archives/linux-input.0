From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4 1/6] hid: new driver for PicoLCD device
Date: Tue, 30 Mar 2010 10:12:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz>
References: <20100324233707.7243b04d@neptune.home> <20100324234022.0361bd80@neptune.home> <20100326065656.GC26602@core.coreip.homeip.net> <20100326102951.3b9ecda1@neptune.home> <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz> <20100327012245.0ace6a09@neptune.home>
 <alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz> <20100329121611.0c22dcaf@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58619 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755427Ab0C3IMM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Mar 2010 04:12:12 -0400
In-Reply-To: <20100329121611.0c22dcaf@pluto.restena.lu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Mon, 29 Mar 2010, Bruno Pr=C3=A9mont wrote:

> > > +static struct hid_driver picolcd_driver =3D {
> > > +	.name =3D          "hid-picolcd",
> > > +	.id_table =3D      picolcd_devices,
> > > +	.probe =3D         picolcd_probe,
> > > +	.remove =3D        picolcd_remove,
> > > +	.raw_event =3D     picolcd_raw_event,
> > > +#ifdef CONFIG_PM
> > > +	.suspend =3D       picolcd_suspend,
> > > +	.resume =3D        picolcd_resume,
> > > +	.reset_resume =3D  picolcd_reset_resume,
> > > +#endif
> > > +};
> >=20
> > struct hid_driver doesn't provide power-management related callback=
s.
> > So I guess that you have either not tested this feature at all, or
> > you have some extra patch somewhere which adds such callbacks to HI=
D
> > core, but you haven't sent it out for review?
> >=20
> > In any cases, this will very likely cause compilation failure with=20
> > CONFIG_PM turned on.
>=20
> That's the patch I referred to (under series introduction mail) when
> saying:
> > The series depends on my previous patch adding HID suspend support
> > (I've not yet looked at improving it).
>=20
> Link to the patch:
>   http://lkml.org/lkml/2010/2/24/233
>=20
> Especially the reset-resume part is important as the device has to be
> reprogrammed with framebuffer content, brightness/contrast in that ca=
se.
>=20
> As stated, Oliver didn't like the implementation of the addition of
> those hooks too much and I have yet to look at improving it.

Ah, OK, I have missed that one, thanks for pointing it out.

The driver itself now looks fine to me and I am willing to merge it,=20
modulo the power-management code -- so please either remove the parts t=
hat=20
depend on power management for now, or I'll wait on your respin of the=20
generic HID-PM patch.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
