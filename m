From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock handling
Date: Tue, 24 Sep 2013 09:50:54 +0200
Message-ID: <201309240950.54789.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-2-git-send-email-jbe@pengutronix.de> <52405A7F.1050801@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52405A7F.1050801-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Fabio,

On Monday 23 September 2013 17:13:03 Fabio Estevam wrote:
> On 09/23/2013 11:36 AM, Juergen Beisert wrote:
> > +	lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	clk_prepare_enable(lradc->clk);
>
> clk_prepare_enable() may fail, so better check its return value.

Thanks for the comment. Better this way?

commit 825c5bb787a0dc9d25d480178e117be08810639c
Author: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date:   Mon Sep 23 16:10:56 2013 +0200

    Staging/iio/adc/touchscreen/MXS: add proper clock handling
   =20
    The delay units inside the LRADC depend on the presence of a 2 kHz =
clock.
    This change enables the clock to be able to use the delay unit for =
the
    touchscreen part of the driver.
   =20
    Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dts=
i
index 28b5ce2..07caf76 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -430,6 +430,7 @@
 				reg =3D <0x80050000 0x2000>;
 				interrupts =3D <36 37 38 39 40 41 42 43 44>;
 				status =3D "disabled";
+				clocks =3D <&clks 26>;
 			};
=20
 			spdif@80054000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dts=
i
index 7363fde..175deef 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -902,6 +902,7 @@
 				interrupts =3D <10 14 15 16 17 18 19
 						20 21 22 23 24 25>;
 				status =3D "disabled";
+				clocks =3D <&clks 41>;
 			};
=20
 			spdif: spdif@80054000 {
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/=
adc/mxs-lradc.c
index a08c173..eaca1ae 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -35,6 +35,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/clk.h>
=20
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -134,6 +135,8 @@ struct mxs_lradc {
 	void __iomem		*base;
 	int			irq[13];
=20
+	struct clk		*clk;
+
 	uint32_t		*buffer;
 	struct iio_trigger	*trig;
=20
@@ -928,6 +931,17 @@ static int mxs_lradc_probe(struct platform_device =
*pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
=20
+	lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(lradc->clk)) {
+		dev_err(dev, "Failed to get the delay unit clock\n");
+		return PTR_ERR(lradc->clk);
+	}
+	ret =3D clk_prepare_enable(lradc->clk);
+	if (ret !=3D 0) {
+		dev_err(dev, "Failed to enable the delay unit clock\n");
+		return ret;
+	}
+
 	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
=20
 	/* Check if touchscreen is enabled in DT. */
@@ -1020,6 +1034,7 @@ static int mxs_lradc_remove(struct platform_devic=
e *pdev)
 	iio_triggered_buffer_cleanup(iio);
 	mxs_lradc_trigger_remove(iio);
=20
+	clk_disable_unprepare(lradc->clk);
 	return 0;
 }
=20
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
