From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/6] input/mc13783-ts: convert to mc13xxx API
Date: Wed, 24 Aug 2011 15:28:22 +0200
Message-ID: <1314192505-23499-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110824132740.GA28197@pengutronix.de>
 <1314192505-23499-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314192505-23499-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is the first step to also support the touch interface of the mc138=
92
pmic chip.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/input/touchscreen/mc13783_ts.c |   34 ++++++++++++++++--------=
--------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/tou=
chscreen/mc13783_ts.c
index c5bc62d..ede0274 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -35,7 +35,7 @@ MODULE_PARM_DESC(sample_tolerance,
=20
 struct mc13783_ts_priv {
 	struct input_dev *idev;
-	struct mc13783 *mc13783;
+	struct mc13xxx *mc13xxx;
 	struct delayed_work work;
 	struct workqueue_struct *workq;
 	unsigned int sample[4];
@@ -45,7 +45,7 @@ static irqreturn_t mc13783_ts_handler(int irq, void *=
data)
 {
 	struct mc13783_ts_priv *priv =3D data;
=20
-	mc13783_irq_ack(priv->mc13783, irq);
+	mc13xxx_irq_ack(priv->mc13xxx, irq);
=20
 	/*
 	 * Kick off reading coordinates. Note that if work happens already
@@ -121,10 +121,10 @@ static void mc13783_ts_work(struct work_struct *w=
ork)
 {
 	struct mc13783_ts_priv *priv =3D
 		container_of(work, struct mc13783_ts_priv, work.work);
-	unsigned int mode =3D MC13783_ADC_MODE_TS;
+	unsigned int mode =3D MC13XXX_ADC_MODE_TS;
 	unsigned int channel =3D 12;
=20
-	if (mc13783_adc_do_conversion(priv->mc13783,
+	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
 				mode, channel, priv->sample) =3D=3D 0)
 		mc13783_ts_report_sample(priv);
 }
@@ -134,21 +134,21 @@ static int mc13783_ts_open(struct input_dev *dev)
 	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
 	int ret;
=20
-	mc13783_lock(priv->mc13783);
+	mc13xxx_lock(priv->mc13xxx);
=20
-	mc13783_irq_ack(priv->mc13783, MC13783_IRQ_TS);
+	mc13xxx_irq_ack(priv->mc13xxx, MC13XXX_IRQ_TS);
=20
-	ret =3D mc13783_irq_request(priv->mc13783, MC13783_IRQ_TS,
+	ret =3D mc13xxx_irq_request(priv->mc13xxx, MC13XXX_IRQ_TS,
 		mc13783_ts_handler, MC13783_TS_NAME, priv);
 	if (ret)
 		goto out;
=20
-	ret =3D mc13783_reg_rmw(priv->mc13783, MC13783_ADC0,
-			MC13783_ADC0_TSMOD_MASK, MC13783_ADC0_TSMOD0);
+	ret =3D mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
+			MC13XXX_ADC0_TSMOD_MASK, MC13XXX_ADC0_TSMOD0);
 	if (ret)
-		mc13783_irq_free(priv->mc13783, MC13783_IRQ_TS, priv);
+		mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
 out:
-	mc13783_unlock(priv->mc13783);
+	mc13xxx_unlock(priv->mc13xxx);
 	return ret;
 }
=20
@@ -156,11 +156,11 @@ static void mc13783_ts_close(struct input_dev *de=
v)
 {
 	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
=20
-	mc13783_lock(priv->mc13783);
-	mc13783_reg_rmw(priv->mc13783, MC13783_ADC0,
-			MC13783_ADC0_TSMOD_MASK, 0);
-	mc13783_irq_free(priv->mc13783, MC13783_IRQ_TS, priv);
-	mc13783_unlock(priv->mc13783);
+	mc13xxx_lock(priv->mc13xxx);
+	mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
+			MC13XXX_ADC0_TSMOD_MASK, 0);
+	mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
+	mc13xxx_unlock(priv->mc13xxx);
=20
 	cancel_delayed_work_sync(&priv->work);
 }
@@ -177,7 +177,7 @@ static int __init mc13783_ts_probe(struct platform_=
device *pdev)
 		goto err_free_mem;
=20
 	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
-	priv->mc13783 =3D dev_get_drvdata(pdev->dev.parent);
+	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
 	priv->idev =3D idev;
=20
 	/*
--=20
1.7.5.4
