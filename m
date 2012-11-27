From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] Input: bu21013_ts - Request a regulator that
 actually exists
Date: Tue, 27 Nov 2012 09:05:12 +0000
Message-ID: <20121127090512.GE7897@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-2-git-send-email-lee.jones@linaro.org>
 <20121126121618.GL12782@gmail.com>
 <20121126164708.GB14623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47322 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758390Ab2K0JFR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 04:05:17 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4986516bkw.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 01:05:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121126164708.GB14623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 26 Nov 2012, Dmitry Torokhov wrote:

> On Mon, Nov 26, 2012 at 12:16:18PM +0000, Lee Jones wrote:
> > On Wed, 14 Nov 2012, Lee Jones wrote:
> >=20
> > > Currently the BU21013 Touch Screen driver requests a regulator by=
 the
> > > name of 'V-TOUCH', which doesn't exist anywhere in the kernel. Th=
e
> > > correct name, as referenced in platform regulator code is 'avdd'.=
 Here,
> > > when we request a regulator, we use the correct name instead.
> > >=20
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/input/touchscreen/bu21013_ts.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/inp=
ut/touchscreen/bu21013_ts.c
> > > index 5c487d2..2fae682 100644
> > > --- a/drivers/input/touchscreen/bu21013_ts.c
> > > +++ b/drivers/input/touchscreen/bu21013_ts.c
> > > @@ -461,7 +461,7 @@ static int __devinit bu21013_probe(struct i2c=
_client *client,
> > >  	bu21013_data->chip =3D pdata;
> > >  	bu21013_data->client =3D client;
> > > =20
> > > -	bu21013_data->regulator =3D regulator_get(&client->dev, "V-TOUC=
H");
> > > +	bu21013_data->regulator =3D regulator_get(&client->dev, "avdd")=
;
> > >  	if (IS_ERR(bu21013_data->regulator)) {
> > >  		dev_err(&client->dev, "regulator_get failed\n");
> > >  		error =3D PTR_ERR(bu21013_data->regulator);
> > > --=20
> > > 1.7.9.5
> >=20
> > Did you see this one also Dmitry?
>=20
> Yes, I have it, I am waiting for the other 2 patches in series to
> settle.

This patch is unrelated to the others and fixes a bug. Would you
be kind enough to take it in right away please?

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
