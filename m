From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v6 0/6] mc13783: add pwr button support
Date: Mon, 25 Jul 2011 15:13:58 +0800
Message-ID: <20110725071357.GD21641@S2100-06.ap.freescale.net>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
 <20110724034418.GA28189@S2100-06.ap.freescale.net>
 <201107250849.26071.philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:4352
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750798Ab1GYHGu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 03:06:50 -0400
Content-Disposition: inline
In-Reply-To: <201107250849.26071.philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, gaowanlong@cn.fujitsu.com

On Mon, Jul 25, 2011 at 08:49:25AM +0200, Philippe R=E9tornaz wrote:
> Le dimanche 24 juillet 2011 05:44:19, Shawn Guo a =E9crit :
> > On Fri, Jul 22, 2011 at 04:17:06PM +0200, Philippe R=E9tornaz wrote=
:
> > > Hello
> > >=20
> > > This add button handling for the MC13783 PMIC.
> > >=20
> > > Patch 1 & 2 modify the mc13xxx MFD driver to use the platform dat=
a to
> > > resgister the led subdevice and unconditionally register the regu=
lator
> > > subdevice (as suggested by Mark and Uwe).
> > >=20
> > > Patch 3 remove the use of the *_USE_REGULATOR and *_USE_LED macro=
s in
> > > the platform files.
> > >=20
> > > Patch 4 must be applied after patch 1,2,3 to remove the obsolete =
define.
> > >=20
> > > Patch 5 modify the mc13xxx MFD driver to add a button subdevice a=
nd
> > > also adds the mc13783-pwrbutton driver using a misc input device.
> > >=20
> > > The last patch adds the power on button support to the mx31moboar=
d
> > > boards.
> > >=20
> > > v2: first patch modified according to comments by Dmitry Torokhov
> > > v3: Implement review by Uwe
> > > v4: Implement comments by Uwe and Mark
> > > v5: Reorder patchset
> > > v6: Minor corrections
> >=20
> > It seems you did not address the comment about possible NULL pdata =
I
> > put on v4?
>=20
> Yes I did in patch 5:
>=20
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -716,6 +716,11 @@ static int mc13xxx_probe(struct spi_device *spi)
>         enum mc13xxx_id id;
>         int ret;
> =20
> +       if (!pdata) {
> +               dev_err(&spi->dev, "invalid platform data\n");
> +               return -EINVAL;
> +       }
> +
>=20
Ah, missed that.  I thought it should be fixed with a separate patch
in the first place.  But I'm fine with it, as long as it gets fixed :)

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
