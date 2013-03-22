From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] Input: da9052_tsi: make TSI reference regulator configurable
Date: Fri, 22 Mar 2013 15:55:29 +0100
Message-ID: <1363964129-23392-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719Ab3CVOzj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Mar 2013 10:55:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Philipp Zabel <p.zabel@pengutronix.de>

This patch allows to use a different regulator than LDO9 as TSIREF.
It also only turns on the regulator when there are actual measurements
to be done. It is not needed for pen detection.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/mfd/da9052-i2c.txt         | 10 ++++++
 drivers/input/touchscreen/da9052_tsi.c             | 38 +++++++++++++++++-----
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
index 1857f4a..807eb63 100644
--- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
+++ b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
@@ -4,6 +4,10 @@ Required properties:
 - compatible : Should be "dlg,da9052", "dlg,da9053-aa",
 			 "dlg,da9053-ab", or "dlg,da9053-bb"
 
+Optional properties:
+- tsiref-supply : Touch screen interface reference voltage regulator.
+                  This is usually LDO9.
+
 Sub-nodes:
 - regulators : Contain the regulator nodes. The DA9052/53 regulators are
   bound using their names as listed below:
@@ -34,6 +38,7 @@ i2c@63fc8000 { /* I2C1 */
 	pmic: dialog@48 {
 		compatible = "dlg,da9053-aa";
 		reg = <0x48>;
+		tsiref-supply = <&reg_ldo9>;
 
 		regulators {
 			buck0 {
@@ -55,6 +60,11 @@ i2c@63fc8000 { /* I2C1 */
 				regulator-min-microvolt = <925000>;
 				regulator-max-microvolt = <2500000>;
 			};
+
+			reg_ldo9: ldo9 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+			};
 		};
 	};
 };
diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 8f561e2..1eb323f 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -11,10 +11,12 @@
  *  option) any later version.
  *
  */
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/interrupt.h>
 
 #include <linux/mfd/da9052/reg.h>
@@ -25,6 +27,7 @@
 struct da9052_tsi {
 	struct da9052 *da9052;
 	struct input_dev *dev;
+	struct regulator *tsiref;
 	struct delayed_work ts_pen_work;
 	struct mutex mutex;
 	bool stopped;
@@ -40,8 +43,17 @@ static void da9052_ts_adc_toggle(struct da9052_tsi *tsi, bool on)
 static irqreturn_t da9052_ts_pendwn_irq(int irq, void *data)
 {
 	struct da9052_tsi *tsi = data;
+	int error;
 
 	if (!tsi->stopped) {
+		error = regulator_enable(tsi->tsiref);
+		if (error < 0) {
+			dev_err(tsi->da9052->dev,
+				"Failed to enable TSIREF regualtor: %d\n",
+				error);
+			return IRQ_HANDLED;
+		}
+
 		/* Mask PEN_DOWN event and unmask TSI_READY event */
 		da9052_disable_irq_nosync(tsi->da9052, DA9052_IRQ_PENDOWN);
 		da9052_enable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
@@ -137,6 +149,12 @@ static void da9052_ts_pen_work(struct work_struct *work)
 			/* Mask TSI_READY event and unmask PEN_DOWN event */
 			da9052_disable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
 			da9052_enable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
+
+			ret = regulator_disable(tsi->tsiref);
+			if (ret < 0)
+				dev_err(tsi->da9052->dev,
+					"Failed to disable TSIREF regulator: %d\n",
+					ret);
 		}
 	}
 }
@@ -179,11 +197,6 @@ static int da9052_configure_tsi(struct da9052_tsi *tsi)
 	if (error < 0)
 		return error;
 
-	/* Supply TSIRef through LD09 */
-	error = da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x59);
-	if (error < 0)
-		return error;
-
 	return 0;
 }
 
@@ -274,12 +287,20 @@ static int da9052_ts_probe(struct platform_device *pdev)
 	/* Disable ADC */
 	da9052_ts_adc_toggle(tsi, false);
 
+	tsi->tsiref = regulator_get(tsi->da9052->dev, "tsiref");
+	if (IS_ERR(tsi->tsiref)) {
+		dev_err(tsi->da9052->dev,
+				"Failed to get TSIREF regulator: %ld\n",
+				PTR_ERR(tsi->tsiref));
+		goto err_free_mem;
+	}
+
 	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_PENDOWN,
 				"pendown-irq", da9052_ts_pendwn_irq, tsi);
 	if (error) {
 		dev_err(tsi->da9052->dev,
 			"Failed to register PENDWN IRQ: %d\n", error);
-		goto err_free_mem;
+		goto err_put_reg;
 	}
 
 	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_TSIREADY,
@@ -310,6 +331,8 @@ err_free_datardy_irq:
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
 err_free_pendwn_irq:
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
+err_put_reg:
+	regulator_put(tsi->tsiref);
 err_free_mem:
 	kfree(tsi);
 	input_free_device(input_dev);
@@ -321,10 +344,9 @@ static int  da9052_ts_remove(struct platform_device *pdev)
 {
 	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
 
-	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
-
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
+	regulator_put(tsi->tsiref);
 
 	input_unregister_device(tsi->dev);
 	kfree(tsi);
-- 
1.8.2.rc2

