From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH V4 3/3] mfd: da9063: MFD support for OnKey driver
Date: Tue, 26 May 2015 14:57:35 +0100
Message-ID: <20150526135735.GN11677@x1>
References: <cover.1432031565.git.stwiss.opensource@diasemi.com>
 <a508f5d715e94fb18e6ef4ce755c2225a17090ea.1432031565.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37349 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbbEZN5k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 09:57:40 -0400
Received: by wifw1 with SMTP id w1so31984107wif.0
        for <linux-input@vger.kernel.org>; Tue, 26 May 2015 06:57:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a508f5d715e94fb18e6ef4ce755c2225a17090ea.1432031565.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>

On Tue, 19 May 2015, S Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> Add MFD support for the DA9063 OnKey driver
>=20
> The function da9063_clear_fault_log() is added to mitigate the case o=
f a
> hardware power-cut after a long-long OnKey press. Although there is n=
o
> software intervention in this case (by definition) such a shutdown wo=
uld
> cause persistent information within the DA9063 FAULT_LOG that would b=
e
> available during the next device restart.
>=20
> Clearance of this persistent register must be completed after such a
> hardware power-cut operation has happened so that the FAULT_LOG does =
not
> continue with previous values. The clearance function has been added =
here
> in the kernel driver because wiping the fault-log cannot be counted o=
n
> outside the Linux kernel.
>=20
> Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Version History
>=20
> Changes in V4
>  - Additional description of MFD patch changes for FAULT_LOG in relat=
ion to
>    the requirements of the OnKey driver. Please see a further explana=
tion of
>    the OnKey's operation in this thread: https://lkml.org/lkml/2015/4=
/29/406
>=20
> Changes in V3
>  - The MFD code was originally in [PATCH V2 1/2]. This is now been mo=
ved into
>    this patch [PATCH V3 3/3].
>  - Whitespace cleanup
>=20
> This patch applies against linux-next and v4.1-rc3=20
>=20
>=20
>  drivers/mfd/da9063-core.c        | 54 ++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/da9063/pdata.h |  1 +
>  2 files changed, 55 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index facd361..af841c1 100644
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
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
