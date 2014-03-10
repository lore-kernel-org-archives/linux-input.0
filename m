From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V1 1/2] mfd: da9063: Linkages for ONKEY support in core
 files
Date: Mon, 10 Mar 2014 16:40:26 +0000
Message-ID: <20140310164026.GB16697@lee--X1>
References: <cover.1394468644.git.stwiss.opensource@diasemi.com>
 <f5a169e00565134fa856a3daa615b17253ce844e.1394468644.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f5a169e00565134fa856a3daa615b17253ce844e.1394468644.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>, LKML-INPUT <linux-input@vger.kernel.org>, LKML-KERNEL <linux-kernel@vger.kernel.org>, Mark Brown <broonie@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-input@vger.kernel.org

> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
>=20
> This change adds the name field "ONKEY" to the properties of the=20
> the OnKey IORESOURCE_IRQ resource structure (part of the mfd_cell
> Onkey resource).
>=20
> The addition of bool key_power which will be passed to the onkey
> driver and allow KEY_POWER support to be turned on/off as a
> driver configuration option.
>=20
>=20
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.co=
m>
> ---
> Checks performed with linux-next/next-20140307/scripts/checkpatch.pl
>  da9063-core.c             total: 0 errors, 0 warnings, 189 lines che=
cked
>  pdata.h                   total: 0 errors, 0 warnings, 112 lines che=
cked
>=20
> This change is a dependency for the new DA9063 OnKey driver which
> forms the remainder of this patch set.
> This patch applies against kernel linux-next next-20140307
>=20
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
>=20
>=20
>=20
>  drivers/mfd/da9063-core.c        | 1 +
>  include/linux/mfd/da9063/pdata.h | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index e70ae31..b410a14 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -60,6 +60,7 @@ static struct resource da9063_rtc_resources[] =3D {
> =20
>  static struct resource da9063_onkey_resources[] =3D {
>  	{
> +		.name	=3D "ONKEY",
>  		.start	=3D DA9063_IRQ_ONKEY,
>  		.end	=3D DA9063_IRQ_ONKEY,
>  		.flags	=3D IORESOURCE_IRQ,
> diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9=
063/pdata.h
> index 95c8742..612383b 100644
> --- a/include/linux/mfd/da9063/pdata.h
> +++ b/include/linux/mfd/da9063/pdata.h
> @@ -103,6 +103,7 @@ struct da9063;
>  struct da9063_pdata {
>  	int				(*init)(struct da9063 *da9063);
>  	int				irq_base;
> +	bool				key_power;
>  	unsigned			flags;
>  	struct da9063_regulators_pdata	*regulators_pdata;
>  	struct led_platform_data	*leds_pdata;

I'd like this change to be added by the first patch which makes use of
it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
