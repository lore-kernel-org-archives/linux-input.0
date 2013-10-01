From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock
 handling
Date: Tue, 01 Oct 2013 11:57:40 +0100
Message-ID: <524AAAA4.6060006@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-2-git-send-email-jbe@pengutronix.de> <52405A7F.1050801@freescale.com> <201309240950.54789.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53745 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab3JAJ5N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Oct 2013 05:57:13 -0400
In-Reply-To: <201309240950.54789.jbe@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, marex@denx.de, jic23@cam.ac.uk, linux-input@vger.kernel.org

On 09/24/13 08:50, J=FCrgen Beisert wrote:
> Hi Fabio,
>=20
> On Monday 23 September 2013 17:13:03 Fabio Estevam wrote:
>> On 09/23/2013 11:36 AM, Juergen Beisert wrote:
>>> +	lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
>>> +	clk_prepare_enable(lradc->clk);
>>
>> clk_prepare_enable() may fail, so better check its return value.
>=20
> Thanks for the comment. Better this way?
>=20
> commit 825c5bb787a0dc9d25d480178e117be08810639c
> Author: Juergen Beisert <jbe@pengutronix.de>
> Date:   Mon Sep 23 16:10:56 2013 +0200
Applied.  If you are going to have a new patch version in the middle of=
 the thread
please generate it with git format-patch and then send it as a reply to=
 the email
you are responding to.  Applying a patch like this is no where near as =
easy.

Applied to the togreg branch of iio.git

Thanks
>=20
>     Staging/iio/adc/touchscreen/MXS: add proper clock handling
>    =20
>     The delay units inside the LRADC depend on the presence of a 2 kH=
z clock.
>     This change enables the clock to be able to use the delay unit fo=
r the
>     touchscreen part of the driver.
>    =20
>     Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>=20
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.d=
tsi
> index 28b5ce2..07caf76 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -430,6 +430,7 @@
>  				reg =3D <0x80050000 0x2000>;
>  				interrupts =3D <36 37 38 39 40 41 42 43 44>;
>  				status =3D "disabled";
> +				clocks =3D <&clks 26>;
>  			};
> =20
>  			spdif@80054000 {
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.d=
tsi
> index 7363fde..175deef 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -902,6 +902,7 @@
>  				interrupts =3D <10 14 15 16 17 18 19
>  						20 21 22 23 24 25>;
>  				status =3D "disabled";
> +				clocks =3D <&clks 41>;
>  			};
> =20
>  			spdif: spdif@80054000 {
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/ii=
o/adc/mxs-lradc.c
> index a08c173..eaca1ae 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -35,6 +35,7 @@
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/input.h>
> +#include <linux/clk.h>
> =20
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -134,6 +135,8 @@ struct mxs_lradc {
>  	void __iomem		*base;
>  	int			irq[13];
> =20
> +	struct clk		*clk;
> +
>  	uint32_t		*buffer;
>  	struct iio_trigger	*trig;
> =20
> @@ -928,6 +931,17 @@ static int mxs_lradc_probe(struct platform_devic=
e *pdev)
>  	if (IS_ERR(lradc->base))
>  		return PTR_ERR(lradc->base);
> =20
> +	lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(lradc->clk)) {
> +		dev_err(dev, "Failed to get the delay unit clock\n");
> +		return PTR_ERR(lradc->clk);
> +	}
> +	ret =3D clk_prepare_enable(lradc->clk);
> +	if (ret !=3D 0) {
> +		dev_err(dev, "Failed to enable the delay unit clock\n");
> +		return ret;
> +	}
> +
>  	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
> =20
>  	/* Check if touchscreen is enabled in DT. */
> @@ -1020,6 +1034,7 @@ static int mxs_lradc_remove(struct platform_dev=
ice *pdev)
>  	iio_triggered_buffer_cleanup(iio);
>  	mxs_lradc_trigger_remove(iio);
> =20
> +	clk_disable_unprepare(lradc->clk);
>  	return 0;
>  }
> =20
> Juergen
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
