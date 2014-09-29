From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/5] i2c: i2c-cros-ec-tunnel: Set retries to 3
Date: Mon, 29 Sep 2014 08:50:14 +0100
Message-ID: <20140929075014.GC5985@lee--X1>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411053538-17237-3-git-send-email-javier.martinez@collabora.co.uk>
 <20140929074940.GB5985@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140929074940.GB5985@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 29 Sep 2014, Lee Jones wrote:

> On Thu, 18 Sep 2014, Javier Martinez Canillas wrote:
>=20
> > From: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >=20
> > Since the i2c bus can get wedged on the EC sometimes, set the numbe=
r of retries
> > to 3. Since we un-wedge the bus immediately after the wedge happens=
, this is the
> > correct fix since only one transfer will fail.
> >=20
> > Signed-off-by: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.=
co.uk>
> > ---
> >  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 3 +++
> >  1 file changed, 3 insertions(+)
>=20
> Applied, thanks.

Wolfram,

Do you want a pull-request?

> > diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/=
busses/i2c-cros-ec-tunnel.c
> > index 3c15dcc..97e6369 100644
> > --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> > +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> > =20
> > +#define I2C_MAX_RETRIES 3
> > +
> >  /**
> >   * struct ec_i2c_device - Driver data for I2C tunnel
> >   *
> > @@ -290,6 +292,7 @@ static int ec_i2c_probe(struct platform_device =
*pdev)
> >  	bus->adap.algo_data =3D bus;
> >  	bus->adap.dev.parent =3D &pdev->dev;
> >  	bus->adap.dev.of_node =3D np;
> > +	bus->adap.retries =3D I2C_MAX_RETRIES;
> > =20
> >  	err =3D i2c_add_adapter(&bus->adap);
> >  	if (err) {
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
