From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Sat, 20 Feb 2010 23:35:13 -0800
Message-ID: <20100221073512.GA18298@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
 <1266510750-9846-3-git-send-email-anarsoul@gmail.com>
 <20100219091755.GB2856@core.coreip.homeip.net>
 <201002191202.16384.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f193.google.com ([209.85.210.193]:49074 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab0BUHfT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Feb 2010 02:35:19 -0500
Received: by yxe31 with SMTP id 31so244706yxe.21
        for <linux-input@vger.kernel.org>; Sat, 20 Feb 2010 23:35:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201002191202.16384.anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

On Fri, Feb 19, 2010 at 12:02:10PM +0200, Vasily Khoruzhick wrote:
> Hi Dmitry,
>=20
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 19 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 11:17:55 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
>=20
> > I do not think this is right. Here you reset sampling data regardle=
ss
> > of whether you got the right number of samples or not. You should r=
epeat
> > s3c_adc_start only if you got (1 << ts.shift) samples. But I think =
I see
> > why touchpad may stop reporintg sometimes - if timer fires before y=
ou
> > get the needed number of samples nothing will happen as timer is no=
t
> > gettign rearmed.
>=20
> Problem is driver reports "stylus down" event when stylus is already =
up,=20
> anyway I agree that samples should not be discarded.
>=20
> > >  	} else {
> > >  =09
> > >  		ts.count =3D 0;
> >=20
> > I also think this branch is missing ts.xp =3D ts.yp =3D 0;
>=20
> Ok.
>=20
> Fixed version is in attachment
>=20
> Thanks for review.

Applied, thank you Vasily.

One more thing though - why do we need that timer to report input event=
s
and reschedule ADC conversions? It looks like it is not really needed.
Could you please give a try to the patch below?

Thanks!

--=20
Dmitry

Input s3c2410_ts - get rid of timer

=46rom: Dmitry Torokhov <dmitry.torokhov@gmail.com>

There seem to be no justification for using timer to report input event=
s,
this can be done right in the ADC selection callback.

Also set proper parent for the input device and use common name prefix
throughout the driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/s3c2410_ts.c |  169 ++++++++++++++----------=
--------
 1 files changed, 75 insertions(+), 94 deletions(-)


diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/tou=
chscreen/s3c2410_ts.c
index 3755a47..60f18c2 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -38,7 +38,6 @@
=20
 #include <plat/adc.h>
 #include <plat/regs-adc.h>
-
 #include <mach/regs-gpio.h>
 #include <mach/ts.h>
=20
@@ -73,7 +72,7 @@
  * @count: The number of samples collected.
  * @shift: The log2 of the maximum count to read in one go.
  */
-struct s3c2410ts {
+struct s3c2410_ts {
 	struct s3c_adc_client *client;
 	struct device *dev;
 	struct input_dev *input;
@@ -86,7 +85,7 @@ struct s3c2410ts {
 	int shift;
 };
=20
-static struct s3c2410ts ts;
+static struct s3c2410_ts ts;
=20
 /**
  * s3c2410_ts_connect - configure gpio for s3c2410 systems
@@ -95,7 +94,7 @@ static struct s3c2410ts ts;
  * connected to the device (later systems such as the S3C2440 integrat=
e
  * these into the device).
 */
-static inline void s3c2410_ts_connect(void)
+static void s3c2410_ts_connect(void)
 {
 	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
 	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
@@ -104,88 +103,57 @@ static inline void s3c2410_ts_connect(void)
 }
=20
 /**
- * get_down - return the down state of the pen
- * @data0: The data read from ADCDAT0 register.
- * @data1: The data read from ADCDAT1 register.
- *
- * Return non-zero if both readings show that the pen is down.
+ * s3c2410_ts_check_pen_down - return the down state of the pen
  */
-static inline bool get_down(unsigned long data0, unsigned long data1)
+static bool s3c24xx_ts_check_pen_down(void)
 {
+	unsigned long data0 =3D readl(ts.io + S3C2410_ADCDAT0);
+	unsigned long data1 =3D readl(ts.io + S3C2410_ADCDAT1);
+
 	/* returns true if both data values show stylus down */
-	return (!(data0 & S3C2410_ADCDAT0_UPDOWN) &&
-		!(data1 & S3C2410_ADCDAT0_UPDOWN));
+	return !((data0 | data1) & S3C2410_ADCDAT0_UPDOWN);
 }
=20
-static void touch_timer_fire(unsigned long data)
+static void s3c24xx_ts_report_state(bool pen_is_down)
 {
-	unsigned long data0;
-	unsigned long data1;
-	bool down;
-
-	data0 =3D readl(ts.io + S3C2410_ADCDAT0);
-	data1 =3D readl(ts.io + S3C2410_ADCDAT1);
-
-	down =3D get_down(data0, data1);
-
-	if (down) {
-		if (ts.count =3D=3D (1 << ts.shift)) {
-			ts.xp >>=3D ts.shift;
-			ts.yp >>=3D ts.shift;
-
-			dev_dbg(ts.dev, "%s: X=3D%lu, Y=3D%lu, count=3D%d\n",
-				__func__, ts.xp, ts.yp, ts.count);
+	if (pen_is_down) {
+		ts.xp >>=3D ts.shift;
+		ts.yp >>=3D ts.shift;
=20
-			input_report_abs(ts.input, ABS_X, ts.xp);
-			input_report_abs(ts.input, ABS_Y, ts.yp);
+		dev_dbg(ts.dev, "%s: X=3D%lu, Y=3D%lu, count=3D%d\n",
+			__func__, ts.xp, ts.yp, ts.count);
=20
-			input_report_key(ts.input, BTN_TOUCH, 1);
-			input_sync(ts.input);
+		input_report_abs(ts.input, ABS_X, ts.xp);
+		input_report_abs(ts.input, ABS_Y, ts.yp);
=20
-			ts.xp =3D 0;
-			ts.yp =3D 0;
-			ts.count =3D 0;
-		}
-
-		s3c_adc_start(ts.client, 0, 1 << ts.shift);
+		input_report_key(ts.input, BTN_TOUCH, 1);
 	} else {
-		ts.xp =3D 0;
-		ts.yp =3D 0;
-		ts.count =3D 0;
-
 		input_report_key(ts.input, BTN_TOUCH, 0);
-		input_sync(ts.input);
-
-		writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
 	}
+
+	input_sync(ts.input);
+
 }
=20
-static DEFINE_TIMER(touch_timer, touch_timer_fire, 0, 0);
+static void s3c24xx_ts_schedule_read(void)
+{
+	ts.xp =3D ts.yp =3D 0;
+	ts.count =3D 0;
+
+	s3c_adc_start(ts.client, 0, 1 << ts.shift);
+}
=20
 /**
- * stylus_irq - touchscreen stylus event interrupt
+ * s3c24xx_ts_stylus_irq - touchscreen stylus event interrupt
  * @irq: The interrupt number
  * @dev_id: The device ID.
  *
  * Called when the IRQ_TC is fired for a pen up or down event.
  */
-static irqreturn_t stylus_irq(int irq, void *dev_id)
+static irqreturn_t s3c24xx_ts_stylus_irq(int irq, void *dev_id)
 {
-	unsigned long data0;
-	unsigned long data1;
-	bool down;
-
-	data0 =3D readl(ts.io + S3C2410_ADCDAT0);
-	data1 =3D readl(ts.io + S3C2410_ADCDAT1);
-
-	down =3D get_down(data0, data1);
-
-	/* TODO we should never get an interrupt with down set while
-	 * the timer is running, but maybe we ought to verify that the
-	 * timer isn't running anyways. */
-
-	if (down)
-		s3c_adc_start(ts.client, 0, 1 << ts.shift);
+	if (s3c24xx_ts_check_pen_down())
+		s3c24xx_ts_schedule_read();
 	else
 		dev_info(ts.dev, "%s: count=3D%d\n", __func__, ts.count);
=20
@@ -231,12 +199,26 @@ static void s3c24xx_ts_conversion(struct s3c_adc_=
client *client,
  */
 static void s3c24xx_ts_select(struct s3c_adc_client *client, unsigned =
select)
 {
+	bool pen_is_down;
+
 	if (select) {
+		/*
+		 * Prepare for the next sample.
+		 */
 		writel(S3C2410_ADCTSC_PULL_UP_DISABLE | AUTOPST,
 		       ts.io + S3C2410_ADCTSC);
 	} else {
-		mod_timer(&touch_timer, jiffies+1);
-		writel(WAIT4INT | INT_UP, ts.io + S3C2410_ADCTSC);
+		/*
+		 * Conversion is complete, we have desired number of samples.
+		 */
+		pen_is_down =3D s3c24xx_ts_check_pen_down();
+
+		s3c24xx_ts_report_state(pen_is_down);
+
+		if (pen_is_down)
+			s3c24xx_ts_schedule_read();
+		else
+			writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
 	}
 }
=20
@@ -247,7 +229,7 @@ static void s3c24xx_ts_select(struct s3c_adc_client=
 *client, unsigned select)
  * Initialise, find and allocate any resources we need to run and then
  * register with the ADC and input systems.
  */
-static int __devinit s3c2410ts_probe(struct platform_device *pdev)
+static int __devinit s3c24xx_ts_probe(struct platform_device *pdev)
 {
 	struct s3c2410_ts_mach_info *info;
 	struct device *dev =3D &pdev->dev;
@@ -256,7 +238,7 @@ static int __devinit s3c2410ts_probe(struct platfor=
m_device *pdev)
 	int ret =3D -EINVAL;
=20
 	/* Initialise input stuff */
-	memset(&ts, 0, sizeof(struct s3c2410ts));
+	memset(&ts, 0, sizeof(struct s3c2410_ts));
=20
 	ts.dev =3D dev;
=20
@@ -313,8 +295,6 @@ static int __devinit s3c2410ts_probe(struct platfor=
m_device *pdev)
 	if ((info->delay & 0xffff) > 0)
 		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);
=20
-	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
-
 	input_dev =3D input_allocate_device();
 	if (!input_dev) {
 		dev_err(dev, "Unable to allocate the input device !!\n");
@@ -333,17 +313,18 @@ static int __devinit s3c2410ts_probe(struct platf=
orm_device *pdev)
 	ts.input->id.vendor =3D 0xDEAD;
 	ts.input->id.product =3D 0xBEEF;
 	ts.input->id.version =3D 0x0102;
+	ts.input->dev.parent =3D &pdev->dev;
=20
 	ts.shift =3D info->oversampling_shift;
=20
-	ret =3D request_irq(ts.irq_tc, stylus_irq, IRQF_DISABLED,
+	ret =3D request_irq(ts.irq_tc, s3c24xx_ts_stylus_irq, IRQF_DISABLED,
 			  "s3c2410_ts_pen", ts.input);
 	if (ret) {
 		dev_err(dev, "cannot get TC interrupt\n");
 		goto err_inputdev;
 	}
=20
-	dev_info(dev, "driver attached, registering input device\n");
+	dev_dbg(dev, "driver attached, registering input device\n");
=20
 	/* All went ok, so register to the input system */
 	ret =3D input_register_device(ts.input);
@@ -353,16 +334,17 @@ static int __devinit s3c2410ts_probe(struct platf=
orm_device *pdev)
 		goto err_tcirq;
 	}
=20
+	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
+
 	return 0;
=20
  err_tcirq:
 	free_irq(ts.irq_tc, ts.input);
  err_inputdev:
-	input_unregister_device(ts.input);
+	input_free_device(ts.input);
  err_iomap:
 	iounmap(ts.io);
  err_clk:
-	del_timer_sync(&touch_timer);
 	clk_put(ts.clock);
 	return ret;
 }
@@ -373,10 +355,9 @@ static int __devinit s3c2410ts_probe(struct platfo=
rm_device *pdev)
  *
  * Free up our state ready to be removed.
  */
-static int __devexit s3c2410ts_remove(struct platform_device *pdev)
+static int __devexit s3c24xx_ts_remove(struct platform_device *pdev)
 {
 	free_irq(ts.irq_tc, ts.input);
-	del_timer_sync(&touch_timer);
=20
 	clk_disable(ts.clock);
 	clk_put(ts.clock);
@@ -388,7 +369,7 @@ static int __devexit s3c2410ts_remove(struct platfo=
rm_device *pdev)
 }
=20
 #ifdef CONFIG_PM
-static int s3c2410ts_suspend(struct device *dev)
+static int s3c24xx_ts_suspend(struct device *dev)
 {
 	writel(TSC_SLEEP, ts.io + S3C2410_ADCTSC);
 	disable_irq(ts.irq_tc);
@@ -397,7 +378,7 @@ static int s3c2410ts_suspend(struct device *dev)
 	return 0;
 }
=20
-static int s3c2410ts_resume(struct device *dev)
+static int s3c24xx_ts_resume(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct s3c2410_ts_mach_info *info =3D pdev->dev.platform_data;
@@ -414,44 +395,44 @@ static int s3c2410ts_resume(struct device *dev)
 	return 0;
 }
=20
-static struct dev_pm_ops s3c_ts_pmops =3D {
-	.suspend	=3D s3c2410ts_suspend,
-	.resume		=3D s3c2410ts_resume,
+static struct dev_pm_ops s3c24xx_ts_pmops =3D {
+	.suspend	=3D s3c24xx_ts_suspend,
+	.resume		=3D s3c24xx_ts_resume,
 };
 #endif
=20
-static struct platform_device_id s3cts_driver_ids[] =3D {
+static struct platform_device_id s3c24xx_ts_driver_ids[] =3D {
 	{ "s3c2410-ts", 0 },
 	{ "s3c2440-ts", 1 },
 	{ }
 };
-MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);
+MODULE_DEVICE_TABLE(platform, s3c24xx_ts_driver_ids);
=20
-static struct platform_driver s3c_ts_driver =3D {
+static struct platform_driver s3c24xx_ts_driver =3D {
 	.driver         =3D {
 		.name   =3D "s3c24xx-ts",
 		.owner  =3D THIS_MODULE,
 #ifdef CONFIG_PM
-		.pm	=3D &s3c_ts_pmops,
+		.pm	=3D &s3c24xx_ts_pmops,
 #endif
 	},
-	.id_table	=3D s3cts_driver_ids,
-	.probe		=3D s3c2410ts_probe,
-	.remove		=3D __devexit_p(s3c2410ts_remove),
+	.id_table	=3D s3c24xx_ts_driver_ids,
+	.probe		=3D s3c24xx_ts_probe,
+	.remove		=3D __devexit_p(s3c24xx_ts_remove),
 };
=20
-static int __init s3c2410ts_init(void)
+static int __init s3c24xx_ts_init(void)
 {
-	return platform_driver_register(&s3c_ts_driver);
+	return platform_driver_register(&s3c24xx_ts_driver);
 }
=20
-static void __exit s3c2410ts_exit(void)
+static void __exit s3c24xx_ts_exit(void)
 {
-	platform_driver_unregister(&s3c_ts_driver);
+	platform_driver_unregister(&s3c24xx_ts_driver);
 }
=20
-module_init(s3c2410ts_init);
-module_exit(s3c2410ts_exit);
+module_init(s3c24xx_ts_init);
+module_exit(s3c24xx_ts_exit);
=20
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>, "
 	      "Ben Dooks <ben@simtec.co.uk>, "

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
