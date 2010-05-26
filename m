From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 6/8] Input: s3c24xx_ts - Add FEAT for Samsung touchscreen support
Date: Thu, 27 May 2010 00:41:16 +0300
Message-ID: <201005270041.26758.anarsoul@gmail.com>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org> <1274249542-28795-7-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart18481839.n1sj7d4gPF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45551 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab0EZVng (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 May 2010 17:43:36 -0400
Received: by fxm5 with SMTP id 5so4954773fxm.19
        for <linux-input@vger.kernel.org>; Wed, 26 May 2010 14:43:34 -0700 (PDT)
In-Reply-To: <1274249542-28795-7-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Naveen Krishna <ch.naveen@samsung.com>, kgene.kim@samsung.com, dmitry.torokhov@gmail.com, ch.naveen@samsubng.com

--nextPart18481839.n1sj7d4gPF
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
19 =D0=BC=D0=B0=D1=8F 2010 09:12:20 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ben Dook=
s =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> From: Naveen Krishna <ch.naveen@samsung.com>
>=20
> This patch adds a feature bit field in the touchscreen driver for Samsung
> SoCs. Which can be used to distinguish the TSADC module features.
>=20
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> [ben-linux@fluff.org: minor fix to title]
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/input/touchscreen/s3c2410_ts.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c
> b/drivers/input/touchscreen/s3c2410_ts.c index 86086a4..e0b7c83 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -55,6 +55,8 @@
>  			 S3C2410_ADCTSC_AUTO_PST | \
>  			 S3C2410_ADCTSC_XY_PST(0))
>=20
> +#define FEAT_PEN_IRQ	(1 << 0)	/* HAS ADCCLRINTPNDNUP */
> +
>  /* Per-touchscreen data. */
>=20
>  /**
> @@ -69,6 +71,7 @@
>   * @irq_tc: The interrupt number for pen up/down interrupt
>   * @count: The number of samples collected.
>   * @shift: The log2 of the maximum count to read in one go.
> + * @features: The features supported by the TSADC MOdule.
>   */
>  struct s3c2410ts {
>  	struct s3c_adc_client *client;
> @@ -81,6 +84,7 @@ struct s3c2410ts {
>  	int irq_tc;
>  	int count;
>  	int shift;
> +	int features;
>  };
>=20
>  static struct s3c2410ts ts;
> @@ -171,6 +175,11 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
>  	else
>  		dev_info(ts.dev, "%s: count=3D%d\n", __func__, ts.count);
>=20
> +	if (ts.features & FEAT_PEN_IRQ) {
> +		/* Clear pen down/up interrupt */
> +		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>=20
> @@ -317,6 +326,7 @@ static int __devinit s3c2410ts_probe(struct
> platform_device *pdev) ts.input->id.version =3D 0x0102;
>=20
>  	ts.shift =3D info->oversampling_shift;
> +	ts.features =3D platform_get_device_id(pdev)->driver_data;
>=20
>  	ret =3D request_irq(ts.irq_tc, stylus_irq, IRQF_DISABLED,
>  			  "s3c2410_ts_pen", ts.input);
> @@ -403,15 +413,14 @@ static struct dev_pm_ops s3c_ts_pmops =3D {
>  #endif
>=20
>  static struct platform_device_id s3cts_driver_ids[] =3D {
> -	{ "s3c2410-ts", 0 },
> -	{ "s3c2440-ts", 1 },
> +	{ "s3c64xx-ts", FEAT_PEN_IRQ },

Why s3c24xx ids was removed? This driver doesn't attach on my rx1950 anymore
:\

Adding new devices is good thing, but breaking compatibility is evil :(

I'm a bit surprised that _this_ patch series was merged but was not tested =
on=20
s3c24xx-devices.

Regards
Vasily

--nextPart18481839.n1sj7d4gPF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkv9lYYACgkQRM6pQpltKE7XRwCdGKQb0k1xxjX2DyWGX2KpvNxD
fu4AoLN0gf3i0Ex81x8tn735qWSRFOmW
=Ml6f
-----END PGP SIGNATURE-----

--nextPart18481839.n1sj7d4gPF--
