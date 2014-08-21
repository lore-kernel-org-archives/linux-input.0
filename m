From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 6/7] mfd: cros_ec: Instantiate sub-devices from
 device tree
Date: Thu, 21 Aug 2014 15:25:42 +0100
Message-ID: <20140821142542.GN4266@lee--X1>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408536812-7836-7-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408536812-7836-7-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 20 Aug 2014, Javier Martinez Canillas wrote:

> From: Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>=20
> If the EC device tree node has sub-nodes, try to instantiate them as
> MFD sub-devices.  We can configure the EC features provided by the bo=
ard.
>=20
> Signed-off-by: Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8rSCDK34cm6iQ@public.gmane.org=
=2Euk>
> ---
>  drivers/mfd/cros_ec.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 634c434..96c926c 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/mfd/core.h>
> +#include <linux/of_platform.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/delay.h>
> @@ -109,22 +110,16 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_=
dev,
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> =20
>  static const struct mfd_cell cros_devs[] =3D {
> -	{
> -		.name =3D "cros-ec-keyb",
> -		.id =3D 1,
> -		.of_compatible =3D "google,cros-ec-keyb",
> -	},
> -	{
> -		.name =3D "cros-ec-i2c-tunnel",
> -		.id =3D 2,
> -		.of_compatible =3D "google,cros-ec-i2c-tunnel",
> -	},
>  };

Why are you keeping this round if it's empty?

>  int cros_ec_register(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev =3D ec_dev->dev;
>  	int err =3D 0;
> +#ifdef CONFIG_OF
> +	struct device_node *node;
> +	int id =3D ARRAY_SIZE(cros_devs);
> +#endif
> =20
>  	if (ec_dev->din_size) {
>  		ec_dev->din =3D devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
> @@ -146,6 +141,31 @@ int cros_ec_register(struct cros_ec_device *ec_d=
ev)
>  		dev_err(dev, "failed to add mfd devices\n");
>  		return err;
>  	}
> +#ifdef CONFIG_OF
> +	/*
> +	 * Add sub-devices declared in the device tree.  NOTE they should N=
OT be
> +	 * declared in cros_devs
> +	 */
> +	for_each_child_of_node(dev->of_node, node) {
> +		char name[128];
> +		struct mfd_cell cell =3D {
> +			.id =3D 0,
> +			.name =3D name,
> +		};
> +
> +		if (of_modalias_node(node, name, sizeof(name)) < 0) {
> +			dev_err(dev, "modalias failure on %s\n",
> +				node->full_name);
> +			continue;
> +		}
> +		dev_dbg(dev, "adding MFD sub-device %s\n", node->name);
> +		cell.of_compatible =3D of_get_property(node, "compatible", NULL);
> +		err =3D mfd_add_devices(dev, ++id, &cell, 1, NULL, ec_dev->irq,
> +				      NULL);
> +		if (err)
> +			dev_err(dev, "fail to add %s\n", node->full_name);
> +	}
> +#endif

This is grim!

Why don't you use of_platform_populate()?

>  	dev_info(dev, "Chrome EC device registered\n");
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
