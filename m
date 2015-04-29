From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH V2 1/2] input: misc: da9063: OnKey driver
Date: Wed, 29 Apr 2015 17:15:28 +0100
Message-ID: <20150429161528.GZ9169@x1>
References: <cover.1429272200.git.stwiss.opensource@diasemi.com>
 <b9068c6e41a08b620c9e1674e17e508ab0d76d55.1429272200.git.stwiss.opensource@diasemi.com>
 <20150428115631.GA9169@x1>
 <6ED8E3B22081A4459DAC7699F3695FB7014B217B51@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35237 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbbD2QPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2015 12:15:34 -0400
Received: by wgyo15 with SMTP id o15so33954073wgy.2
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2015 09:15:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B217B51@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On Wed, 29 Apr 2015, Opensource [Steve Twiss] wrote:

>=20
> On 28 April 2015 12:57 Lee Jones [mailto:lee.jones@linaro.org] wrote:
>=20
> > On Fri, 17 Apr 2015, S Twiss wrote:
> >=20
> > ++++++++++++++++++++++++++++++++++++++
> > >  drivers/mfd/da9063-core.c         |  55 +++++++++
> > >  include/linux/mfd/da9063/pdata.h  |   1 +
> >=20
> > This should be a seperate patch.
> >=20
>=20
> Okay, done this now. Added a new PATCH 3/3
>=20
> > >  static struct resource da9063_onkey_resources[] =3D {
> > >  	{
> > > +		.name	=3D "ONKEY",
> > >  		.start	=3D DA9063_IRQ_ONKEY,
> > >  		.end	=3D DA9063_IRQ_ONKEY,
> > >  		.flags	=3D IORESOURCE_IRQ,
> > > @@ -97,6 +98,7 @@ static const struct mfd_cell da9063_devs[] =3D =
{
> > >  		.name		=3D DA9063_DRVNAME_ONKEY,
> > >  		.num_resources	=3D
> > ARRAY_SIZE(da9063_onkey_resources),
> > >  		.resources	=3D da9063_onkey_resources,
> > > +		.of_compatible =3D "dlg,da9063-onkey",
> > >  	},
> > >  	{
> > >  		.name		=3D DA9063_DRVNAME_RTC,
> >=20
> > This is lowercase, so why does "ONKEY" have to be uppercase?
> >=20
>=20
> No real reason why this is uppercase in favour of lowercase except it
> is following the convention of the existing DA9063 driver code.
> Currently the DA9063 uses uppercase for its naming, there are several
> others components that use the same uppercase convention, e.g. the
> RTC alarm and tick interrupt and the hardware LDO limit:
>=20
> > cat /proc/interrupts | grep 9063
> 384:          0          0          0          0  da9063-irq   0  ONK=
EY
> 385:          0          2          0          0  da9063-irq   1  ALA=
RM
> 387:          0         30          0          0  da9063-irq   3  HWM=
ON
> 392:          0          0          0          0  da9063-irq   8  LDO=
_LIM
>=20
> I was going to leave this uppercase, but I can easily change it if
> this is necessary.
>=20
> > >  	if (ret)
> > >  		dev_err(da9063->dev, "Cannot add MFD cells\n");
> > >
> > > +
> >=20
> > Tut tut!
> >=20
> > >  	return ret;
> > >  }
>=20
> I've changed that to remove the lazy fall-through on the error path.
> It now has the following form:
>=20
> @@ -229,9 +229,10 @@ int da9063_device_init(struct da9063 *da9063, un=
signed int irq)
>         ret =3D mfd_add_devices(da9063->dev, -1, da9063_devs,
>                               ARRAY_SIZE(da9063_devs), NULL, da9063->=
irq_base,
>                               NULL);
> -       if (ret)
> +       if (ret) {
>                 dev_err(da9063->dev, "Cannot add MFD cells\n");
> -
> +               return ret;
> +       }
> =20
>         return ret;
>  }

Sorry, that's not what I meant.

The fall-through is perfectly fine.  I was tutting because you added
an unrelated 'clean-up'.

> Thanks for the review comments.
> The next patch set for DA9063 will follow shortly.
>=20
> Regards,
> Steve

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
