From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5] Input: bu21013_ts - Add support for Device Tree
 booting
Date: Mon, 26 Nov 2012 09:07:36 +0000
Message-ID: <20121126090736.GC12782@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-4-git-send-email-lee.jones@linaro.org>
 <20121123155258.GE28552@gmail.com>
 <20121124075009.GB24711@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60350 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab2KZJHl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 04:07:41 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4422714bkw.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 01:07:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121124075009.GB24711@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, 23 Nov 2012, Dmitry Torokhov wrote:

> On Fri, Nov 23, 2012 at 03:52:58PM +0000, Lee Jones wrote:
> > On Wed, 14 Nov 2012, Lee Jones wrote:
> >=20
> > > Now we can register the BU21013_ts touch screen when booting with
> > > Device Tree enabled. Here we parse all the necessary components
> > > previously expected to be passed from platform data.
> > >=20
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/input/touchscreen/bu21013_ts.c |   39 ++++++++++++++++++=
++++++++++----
> > >  1 file changed, 35 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/inp=
ut/touchscreen/bu21013_ts.c
> > > index 5d8fc75..afef874 100644
> > > --- a/drivers/input/touchscreen/bu21013_ts.c
> > > +++ b/drivers/input/touchscreen/bu21013_ts.c
> > > @@ -15,6 +15,8 @@
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/module.h>
> > >  #include <linux/gpio.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_gpio.h>
> > > =20
> > >  /* Reference tracking for multiple displays. */
> > >  static int bu21013_devices =3D 0;
> > > @@ -487,13 +489,33 @@ static void bu21013_free_irq(struct bu21013=
_ts_data *bu21013_data)
> > >   * This function used to initializes the i2c-client touchscreen
> > >   * driver and returns integer.
> > >   */
> > > +static void __devinit bu21013_of_probe(struct device_node *np,
> > > +				struct bu21013_platform_device *pdata)
> > > +{
> > > +	pdata->y_flip =3D pdata->x_flip =3D false;
> > > +
> > > +	if (of_get_property(np, "rohm,flip-x", NULL))
> > > +		pdata->x_flip =3D true;
>=20
> 	pdata->x_flip =3D of_property_read_bool(np, "rohm,flip-x");
>=20
> ?

Yes, we can do this now it exists.

> Can I also get patch documenting the DT properties?

Sure. As a follow-up? I'll resubmit this first, right away.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
