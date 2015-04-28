From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH V2 1/2] input: misc: da9063: OnKey driver
Date: Tue, 28 Apr 2015 12:56:31 +0100
Message-ID: <20150428115631.GA9169@x1>
References: <cover.1429272200.git.stwiss.opensource@diasemi.com>
 <b9068c6e41a08b620c9e1674e17e508ab0d76d55.1429272200.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b9068c6e41a08b620c9e1674e17e508ab0d76d55.1429272200.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On Fri, 17 Apr 2015, S Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> Add OnKey driver support for DA9063
>=20
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Changes from PATCH V1 to V2
> ---------------------------
> - Remove the circular dependency comment in the main e-mail body
>   linking PATCH V1 1/2 and 2/2
> - Alter the copyright header information to match expected GPLv2
>   text from http://www.gnu.org/licenses/gpl-2.0.html
>=20
> This patch applies against linux-next and v4.0-rc6=20
>=20
>=20
>  MAINTAINERS                       |   2 +-
>  drivers/input/misc/Kconfig        |  10 ++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/da9063-onkey.c | 228 ++++++++++++++++++++++++++++=
++++++++++
>  drivers/mfd/da9063-core.c         |  55 +++++++++
>  include/linux/mfd/da9063/pdata.h  |   1 +

This should be a seperate patch.

>  6 files changed, 296 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/input/misc/da9063-onkey.c

[...]

> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index facd361..b6d6f18 100644
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
> @@ -97,6 +98,7 @@ static const struct mfd_cell da9063_devs[] =3D {
>  		.name		=3D DA9063_DRVNAME_ONKEY,
>  		.num_resources	=3D ARRAY_SIZE(da9063_onkey_resources),
>  		.resources	=3D da9063_onkey_resources,
> +		.of_compatible =3D "dlg,da9063-onkey",
>  	},
>  	{
>  		.name		=3D DA9063_DRVNAME_RTC,

This is lowercase, so why does "ONKEY" have to be uppercase?

> @@ -109,12 +111,64 @@ static const struct mfd_cell da9063_devs[] =3D =
{
>  	},
>  };
> =20
> +static int da9063_clear_fault_log(struct da9063 *da9063)
> +{
> +	int ret =3D 0;
> +	int fault_log =3D 0;
> +
> +	ret =3D regmap_read(da9063->regmap, DA9063_REG_FAULT_LOG, &fault_lo=
g);
> +	if (ret < 0) {
> +		dev_err(da9063->dev, "Cannot read FAULT_LOG.\n");
> +		return -EIO;
> +	}
> +
> +	if (fault_log) {
> +		if (fault_log & DA9063_TWD_ERROR)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_TWD_ERROR\n");
> +		if (fault_log & DA9063_POR)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_POR\n");
> +		if (fault_log & DA9063_VDD_FAULT)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_VDD_FAULT\n");
> +		if (fault_log & DA9063_VDD_START)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_VDD_START\n");
> +		if (fault_log & DA9063_TEMP_CRIT)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_TEMP_CRIT\n");
> +		if (fault_log & DA9063_KEY_RESET)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_KEY_RESET\n");
> +		if (fault_log & DA9063_NSHUTDOWN)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_NSHUTDOWN\n");
> +		if (fault_log & DA9063_WAIT_SHUT)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_WAIT_SHUT\n");
> +	}
> +
> +	ret =3D regmap_write(da9063->regmap,
> +			   DA9063_REG_FAULT_LOG,
> +			   fault_log);
> +	if (ret < 0)
> +		dev_err(da9063->dev,
> +			"Cannot reset FAULT_LOG values %d\n", ret);
> +
> +	return ret;
> +}
> +
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  {
>  	struct da9063_pdata *pdata =3D da9063->dev->platform_data;
>  	int model, variant_id, variant_code;
>  	int ret;
> =20
> +	ret =3D da9063_clear_fault_log(da9063);
> +	if (ret < 0)
> +		dev_err(da9063->dev, "Cannot clear fault log\n");
> +
>  	if (pdata) {
>  		da9063->flags =3D pdata->flags;
>  		da9063->irq_base =3D pdata->irq_base;
> @@ -178,6 +232,7 @@ int da9063_device_init(struct da9063 *da9063, uns=
igned int irq)
>  	if (ret)
>  		dev_err(da9063->dev, "Cannot add MFD cells\n");
> =20
> +

Tut tut!

>  	return ret;
>  }
> =20
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

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
