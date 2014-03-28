From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 01/10] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Fri, 28 Mar 2014 09:21:54 +0000
Message-ID: <20140328092154.GF17779@lee--X1>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-2-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBN762SMQKGQESCKERJA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1395955764-18103-2-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

> This patch introduces the preliminary support for PMICs X-Powers AXP202
> and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
> used by A10, A13 and A20 SoCs and developed by X-Powers, a sister company
> of Allwinner.
>=20
> The core enables support for two subsystems:
> - PEK (Power Enable Key)
> - Regulators
>=20
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mfd/Kconfig        |  12 +++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/axp20x.c       | 240 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/axp20x.h | 180 ++++++++++++++++++++++++++++++++++
>  4 files changed, 433 insertions(+)
>  create mode 100644 drivers/mfd/axp20x.c
>  create mode 100644 include/linux/mfd/axp20x.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 49bb445..24ba61a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -59,6 +59,18 @@ config MFD_AAT2870_CORE
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
> =20
> +config MFD_AXP20X
> +	bool "X-Powers AXP20X"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=3Dy
> +	help
> +	  If you say Y here you get support for the AXP20X.
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the
> +	  functionality of the device.

Please tell us what this device is and what sub-devices are available?

[...]

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> new file mode 100644
> index 0000000..f77a663
> --- /dev/null
> +++ b/drivers/mfd/axp20x.c
> @@ -0,0 +1,240 @@
> +/*
> + * axp20x.c - MFD core driver for the X-Powers AXP202 and AXP209

... which consist of ...

[...]

> +static struct resource axp20x_pek_resources[] =3D {
> +	{
> +		.name	=3D "PEK_DBR",
> +		.start	=3D AXP20X_IRQ_PEK_RIS_EDGE,
> +		.end	=3D AXP20X_IRQ_PEK_RIS_EDGE,
> +		.flags	=3D IORESOURCE_IRQ,
> +	}, {
> +		.name	=3D "PEK_DBF",
> +		.start	=3D AXP20X_IRQ_PEK_FAL_EDGE,
> +		.end	=3D AXP20X_IRQ_PEK_FAL_EDGE,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};

Have you considered doing this in the Device Tree? It's a lot less
code/overhead.

> +static const struct i2c_device_id axp20x_i2c_id[] =3D {
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
=20
We really should consider changing the I2C subsystem!

Can you add a comment here describing why we have to add this
seemingly pointless empty struct please?

> +static struct mfd_cell axp20x_cells[] =3D {
> +	{
> +		.name		=3D "axp20x-pek",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_pek_resources),
> +		.resources	=3D axp20x_pek_resources,
> +	}, {
> +		.name		=3D "axp20x-regulator",
> +	},
> +};

Do these drivers don't look inside the DTB at all?

[...]

> +	of_id =3D of_match_device(axp20x_of_match, &i2c->dev);
> +	if (!of_id) {
> +		dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> +		return -ENODEV;
> +	}
> +	axp20x->variant =3D (int) of_id->data;

'variant' needs to be a (unsigned?) long or it will break on 64bit
architectures.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
