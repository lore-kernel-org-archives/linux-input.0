From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] input/mc13783_ts: Add support for mc13892
Date: Wed, 28 Sep 2011 20:51:08 +0200
Message-ID: <1317235868-3436-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1317049057-4936-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49191 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab1I1SvP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Sep 2011 14:51:15 -0400
In-Reply-To: <1317049057-4936-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>, kernel@pengutronix.de, David Jander <david.jander@protonic.nl>

=46rom: David Jander <david.jander@protonic.nl>

The mc13892 has almost the same touchscreen controller as the mc13783.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
changes since (implicit) v1:
 - undo renaming
 - report average of the two samples on mc13892 instead of the first.
 - some minor cosmetic changes
 - set author to David as he did the technical work, I only cleaned up.

 drivers/input/touchscreen/Kconfig      |    8 +++---
 drivers/input/touchscreen/mc13783_ts.c |   35 ++++++++++++++++++++++++=
++-----
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index cabd9e5..aeece83 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -549,11 +549,11 @@ config TOUCHSCREEN_USB_COMPOSITE
 	  module will be called usbtouchscreen.
=20
 config TOUCHSCREEN_MC13783
-	tristate "Freescale MC13783 touchscreen input driver"
-	depends on MFD_MC13783
+	tristate "Freescale MC13783/MC13892 touchscreen input driver"
+	depends on MFD_MC13XXX
 	help
-	  Say Y here if you have an Freescale MC13783 PMIC on your
-	  board and want to use its touchscreen
+	  Say Y here if you have an Freescale MC13783/MC13892 PMIC on your
+	  board and want to use its touchscreen.
=20
 	  If unsure, say N.
=20
diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/tou=
chscreen/mc13783_ts.c
index ede0274..afa62cf 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
=20
-#define MC13783_TS_NAME	"mc13783-ts"
+#define DRIVER_NAME	"mc13783-ts"
=20
 #define DEFAULT_SAMPLE_TOLERANCE 300
=20
@@ -33,7 +33,10 @@ MODULE_PARM_DESC(sample_tolerance,
 		"is supposed to be wrong and is discarded.  Set to 0 to "
 		"disable this check.");
=20
+#define MC13783_TS_TWO_SAMPLES	1
+
 struct mc13783_ts_priv {
+	struct platform_device *pdev;
 	struct input_dev *idev;
 	struct mc13xxx *mc13xxx;
 	struct delayed_work work;
@@ -69,6 +72,7 @@ static irqreturn_t mc13783_ts_handler(int irq, void *=
data)
=20
 static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)
 {
+	struct platform_device *pdev =3D priv->pdev;
 	struct input_dev *idev =3D priv->idev;
 	int x0, x1, x2, y0, y1, y2;
 	int cr0, cr1;
@@ -86,6 +90,13 @@ static void mc13783_ts_report_sample(struct mc13783_=
ts_priv *priv)
 	cr0 =3D (priv->sample[2] >> 12) & 0xfff;
 	cr1 =3D (priv->sample[3] >> 12) & 0xfff;
=20
+	/* On the mc13892, x2 and y2 are invalid */
+	if (platform_get_device_id(pdev)->driver_data &
+			MC13783_TS_TWO_SAMPLES) {
+		x2 =3D (x1 + x0) / 2;
+		y2 =3D (y1 + y0) / 2;
+	}
+
 	dev_dbg(&idev->dev,
 		"x: (% 4d,% 4d,% 4d) y: (% 4d, % 4d,% 4d) cr: (% 4d, % 4d)\n",
 		x0, x1, x2, y0, y1, y2, cr0, cr1);
@@ -139,7 +150,7 @@ static int mc13783_ts_open(struct input_dev *dev)
 	mc13xxx_irq_ack(priv->mc13xxx, MC13XXX_IRQ_TS);
=20
 	ret =3D mc13xxx_irq_request(priv->mc13xxx, MC13XXX_IRQ_TS,
-		mc13783_ts_handler, MC13783_TS_NAME, priv);
+		mc13783_ts_handler, DRIVER_NAME, priv);
 	if (ret)
 		goto out;
=20
@@ -177,6 +188,7 @@ static int __init mc13783_ts_probe(struct platform_=
device *pdev)
 		goto err_free_mem;
=20
 	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
+	priv->pdev =3D pdev;
 	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
 	priv->idev =3D idev;
=20
@@ -184,11 +196,11 @@ static int __init mc13783_ts_probe(struct platfor=
m_device *pdev)
 	 * We need separate workqueue because mc13783_adc_do_conversion
 	 * uses keventd and thus would deadlock.
 	 */
-	priv->workq =3D create_singlethread_workqueue("mc13783_ts");
+	priv->workq =3D create_singlethread_workqueue(pdev->name);
 	if (!priv->workq)
 		goto err_free_mem;
=20
-	idev->name =3D MC13783_TS_NAME;
+	idev->name =3D pdev->name;
 	idev->dev.parent =3D &pdev->dev;
=20
 	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
@@ -232,12 +244,24 @@ static int __devexit mc13783_ts_remove(struct pla=
tform_device *pdev)
=20
 	return 0;
 }
+static const struct platform_device_id mc13783_ts_idtable[] =3D {
+	{
+		.name =3D "mc13783-ts",
+	}, {
+		.name =3D "mc13892-ts",
+		.driver_data =3D MC13783_TS_TWO_SAMPLES,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mc13783_ts_idtable);
=20
 static struct platform_driver mc13783_ts_driver =3D {
+	.id_table	=3D mc13783_ts_idtable,
 	.remove		=3D __devexit_p(mc13783_ts_remove),
 	.driver		=3D {
 		.owner	=3D THIS_MODULE,
-		.name	=3D MC13783_TS_NAME,
+		.name	=3D DRIVER_NAME,
 	},
 };
=20
@@ -256,4 +280,3 @@ module_exit(mc13783_ts_exit);
 MODULE_DESCRIPTION("MC13783 input touchscreen driver");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" MC13783_TS_NAME);
--=20
1.7.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
