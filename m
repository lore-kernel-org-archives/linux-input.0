From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/6] Input: da9052_tsi.c: Fix interrupt handling
Date: Thu,  4 Oct 2012 00:15:06 -0300
Message-ID: <1349320509-26930-3-git-send-email-festevam@gmail.com>
References: <1349320509-26930-1-git-send-email-festevam@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349320509-26930-1-git-send-email-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com
Cc: broonie@opensource.wolfsonmicro.com, ashish.jangam@kpitcummins.com, dchen@diasemi.com, arnd@arndb.de, kernel@pengutronix.de, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently da9062_tsi does not probe and it fails as follows:

da9052 1-0048: Unable to determine device interrupts

Use the new da9052 irq functions and allow the driver to probe and operate 
correctly.

Tested on mx53qsb board using 'evtest' tool.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/da9052_tsi.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 71f6165..33fd3fa 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -274,16 +274,16 @@ static int __devinit da9052_ts_probe(struct platform_device *pdev)
 	/* Disable ADC */
 	da9052_ts_adc_toggle(tsi, false);
 
-	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_PENDOWN, "pendown-irq",
-			    da9052_ts_pendwn_irq, tsi);
+	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_PENDOWN,
+				"pendown-irq", da9052_ts_pendwn_irq, tsi);
 	if (error) {
 		dev_err(tsi->da9052->dev,
 			"Failed to register PENDWN IRQ: %d\n", error);
 		goto err_free_mem;
 	}
 
-	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_TSIREADY, "tsiready-irq",
-			    da9052_ts_datardy_irq, tsi);
+	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_TSIREADY,
+				"tsiready-irq", da9052_ts_datardy_irq, tsi);
 	if (error) {
 		dev_err(tsi->da9052->dev,
 			"Failed to register TSIRDY IRQ :%d\n", error);
@@ -307,9 +307,9 @@ static int __devinit da9052_ts_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_datardy_irq:
-	da9052_free_irq(da9052, DA9052_IRQ_TSIREADY, da9052);
+	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
 err_free_pendwn_irq:
-	da9052_free_irq(da9052, DA9052_IRQ_PENDOWN, da9052);
+	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
 err_free_mem:
 	kfree(tsi);
 	input_free_device(input_dev);
@@ -320,12 +320,11 @@ err_free_mem:
 static int  __devexit da9052_ts_remove(struct platform_device *pdev)
 {
 	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
-	struct da9052 *da9052 = dev_get_drvdata(pdev->dev.parent);
 
 	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
 
-	da9052_free_irq(da9052, DA9052_IRQ_TSIREADY, da9052);
-	da9052_free_irq(da9052, DA9052_IRQ_PENDOWN, da9052);
+	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
+	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
 
 	input_unregister_device(tsi->dev);
 	kfree(tsi);
-- 
1.7.9.5
