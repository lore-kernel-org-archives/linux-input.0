From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
Date: Mon, 3 Mar 2014 10:56:16 +0900
Message-ID: <20140303015616.GN2411@sirena.org.uk>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtmVPk+Smchi6n7w"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBXWCZ6MAKGQETJZ3UGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393692352-10839-7-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--BtmVPk+Smchi6n7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:

> index d59c826..0cef101 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -69,3 +69,4 @@ CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_NLS=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_REGULATOR_AXP20X=y

If you want to update the defconfig do it in a separate patch.

> +static int axp20x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	return regulator_set_voltage_sel_regmap(rdev, 0);
> +}

I'm not entirely clear what this is supposed to do but it's broken - it
both ignores the voltage that is passed in and immediately writes to the
normal voltage select register which will presumably distrupt the system.

> +static int axp20x_io_enable_regmap(struct regulator_dev *rdev)
> +{
> +	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
> +				  rdev->desc->enable_mask, AXP20X_IO_ENABLED);
> +}

Please make some helpers for this (or extend the existing ones to cope
with more than a single bit control) - there's several other devices
which have similar multi-bit controls so we should factor this out
rather than open coding.

> +	np = of_node_get(pdev->dev.parent->of_node);
> +	if (!np)
> +		return 0;
> +
> +	regulators = of_find_node_by_name(np, "regulators");
> +	if (!regulators) {
> +		dev_err(&pdev->dev, "regulators node not found\n");
> +		return -EINVAL;
> +	}

The driver should be able to start up with no configuration provided at
all except for the device being registered - the user won't be able to
change anything but they will be able to read the current state of the
hardware which can be useful for diagnostics.

> +static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 workmode)
> +{
> +	unsigned int mask = AXP20X_WORKMODE_DCDC2_MASK;
> +
> +	if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
> +		return -EINVAL;
> +
> +	if (id == AXP20X_DCDC3)
> +		mask = AXP20X_WORKMODE_DCDC3_MASK;
> +
> +	return regmap_update_bits(rdev->regmap, AXP20X_DCDC_MODE, mask, workmode);
> +}

What is a workmode?

> +		pmic->rdev[i] = regulator_register(&pmic->rdesc[i], &config);
> +		if (IS_ERR(pmic->rdev[i])) {

Use devm_regulator_register() and then you don't need to clean up the
regulators either.

> +static int __init axp20x_regulator_init(void)
> +{
> +	return platform_driver_register(&axp20x_regulator_driver);
> +}
> +
> +subsys_initcall(axp20x_regulator_init);

module_platform_driver().

--BtmVPk+Smchi6n7w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+E9AAoJELSic+t+oim9fRwP/0QxUA5UG8TiDoAV6A7neTQY
GlQBzZwzHRes4V6DHOi1rRTp+rYgmbBGUhgamuRM1AuIDlYoAbQsI4hMudhTbSap
SSHjx/C/qCyS6hGLDBEmbPFbktw2x8L6l4G9mQaCC9a9M1s5z4MdQHQZiwxMVz+d
kydiR1aNLbqg0aAcsKpjGys62j/f6ph+dagrXS3mnS9f5AUzd3QJQJ2y9ImIFCqC
rBzFCfP+V2j2AY/01Tgh78Vvmgqn9hVS5ADDeLOiJJkdXe9uPMIPr6BC+SxoW51C
HJ1Wv0YyhS1s4No+baSTouQoUw9lDOszRtMq5qK7Mrys7ZZeARSuDdWtB/DoMEVX
WQ+cPH5SUvN8Yel1/bZAv8qXWqvHYuFLUQHP2frImzKLL5lY3rsvLQyGgx75Gr/y
5qKMTWwq8mo0ksfjl2hsib2HXrfXZvlV+Fo3ftpPk36EKhWejz9iFJIVF9uc8LCf
Uzg7YWr4PsjmywY2Gfw89ilqZuBii2A0Yf4oEyVQDmMdH7X4s2jz4foppgcrhlA2
WJgdgdHEjnaB3FKP6B3m2B4kGBno+P3XvsX8yxhzUnzI2wgCw0pOiFgKR7BZlaUw
SYi1+wxj4hy2PQphC+vK7fhYGQoO3oNPY9yu8yppOB+mowJ/BQx/kbYz/4EeW8TZ
zChCQh/cQRiJmGHl5myj
=giD2
-----END PGP SIGNATURE-----

--BtmVPk+Smchi6n7w--
