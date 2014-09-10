From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] Input: atmel_mxt_ts: Add of node type to the i2c table
Date: Wed, 10 Sep 2014 10:28:32 +0100
Message-ID: <20140910092832.GM30307@lee--X1>
References: <1410249158-18192-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <540ED495.20609@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35958 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbaIJJ2h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 05:28:37 -0400
Received: by mail-ig0-f182.google.com with SMTP id h18so758222igc.9
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 02:28:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540ED495.20609@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Tue, 09 Sep 2014, Javier Martinez Canillas wrote:

> [adding Lee Jones to cc list since I'm referring on a series he poste=
d]
>=20
> Hello Sjoerd,
>=20
> On 09/09/2014 09:52 AM, Sjoerd Simons wrote:
> > For i2c devices in OF the modalias exposed to userspace is i2c:<nod=
e
> > type>, for the Maxtouch driver this is i2c:maxtouch.
> >=20
> > Add maxtouch to the i2c id table such that userspace can correctly
> > load the module for the device and drop the OF table as it's not
> > needed for i2c devices.
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/inp=
ut/touchscreen/atmel_mxt_ts.c
> > index db178ed..57ff26d 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -2267,16 +2267,11 @@ static int mxt_resume(struct device *dev)
> > =20
> >  static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
> > =20
> > -static const struct of_device_id mxt_of_match[] =3D {
> > -	{ .compatible =3D "atmel,maxtouch", },
> > -	{},
> > -};
> > -MODULE_DEVICE_TABLE(of, mxt_of_match);
> > -
> >  static const struct i2c_device_id mxt_id[] =3D {
> >  	{ "qt602240_ts", 0 },
> >  	{ "atmel_mxt_ts", 0 },
> >  	{ "atmel_mxt_tp", 0 },
> > +	{ "maxtouch", 0 },
> >  	{ "mXT224", 0 },
> >  	{ }
> >  };
> > @@ -2286,7 +2281,6 @@ static struct i2c_driver mxt_driver =3D {
> >  	.driver =3D {
> >  		.name	=3D "atmel_mxt_ts",
> >  		.owner	=3D THIS_MODULE,
> > -		.of_match_table =3D of_match_ptr(mxt_of_match),
> >  		.pm	=3D &mxt_pm_ops,
> >  	},
> >  	.probe		=3D mxt_probe,
> >=20
>=20
> I see that Lee is working to allow the I2C subsystem to not need an I=
2C ID
> table to match [0]. I'll let Lee to comment what the future plans are=
 and if
> his series are going to solve your issue since I'm not that familiar =
with the
> I2C core.

It's wrong to expect DT to probe these devices without a compatible
string.  It does so at the moment, but this is a bi-product and not
the correct method.

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
