From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] Input: touchscreen - Use __maybe_unused instead of ifdef
 around suspend/resume
Date: Wed, 29 Oct 2014 14:19:49 +0900
Message-ID: <000701cff337$f6046df0$e20d49d0$%han@samsung.com>
References: <000501cff337$c5f23750$51d6a5f0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8427 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbaJ2FT3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2014 01:19:29 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NE60095VXGFPB80@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Wed, 29 Oct 2014 14:19:27 +0900 (KST)
In-reply-to: <000501cff337$c5f23750$51d6a5f0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use __maybe_unused instead of ifdef guards around suspend/resume
functions, in order to increase build coverage and fix build warnings.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/ad7877.c        |    6 ++----
 drivers/input/touchscreen/ad7879.c        |    6 ++----
 drivers/input/touchscreen/ads7846.c       |    6 ++----
 drivers/input/touchscreen/atmel_mxt_ts.c  |    6 ++----
 drivers/input/touchscreen/auo-pixcir-ts.c |    6 ++----
 drivers/input/touchscreen/cy8ctmg110_ts.c |    6 ++----
 drivers/input/touchscreen/cyttsp_core.c   |    7 ++-----
 drivers/input/touchscreen/edt-ft5x06.c    |    6 ++----
 drivers/input/touchscreen/eeti_ts.c       |    6 ++----
 drivers/input/touchscreen/egalax_ts.c     |    6 ++----
 drivers/input/touchscreen/ili210x.c       |    6 ++----
 drivers/input/touchscreen/ipaq-micro-ts.c |    6 ++----
 drivers/input/touchscreen/mms114.c        |    6 ++----
 drivers/input/touchscreen/pixcir_i2c_ts.c |    6 ++----
 drivers/input/touchscreen/st1232.c        |    7 ++-----
 drivers/input/touchscreen/tsc2005.c       |    6 ++----
 drivers/input/touchscreen/ucb1400_ts.c    |    6 ++----
 drivers/input/touchscreen/wacom_i2c.c     |    6 ++----
 drivers/input/touchscreen/zforce_ts.c     |    6 ++----
 19 files changed, 38 insertions(+), 78 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 523865d..da4e5bb 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -820,8 +820,7 @@ static int ad7877_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ad7877_suspend(struct device *dev)
+static int __maybe_unused ad7877_suspend(struct device *dev)
 {
 	struct ad7877 *ts = dev_get_drvdata(dev);
 
@@ -830,7 +829,7 @@ static int ad7877_suspend(struct device *dev)
 	return 0;
 }
 
-static int ad7877_resume(struct device *dev)
+static int __maybe_unused ad7877_resume(struct device *dev)
 {
 	struct ad7877 *ts = dev_get_drvdata(dev);
 
@@ -838,7 +837,6 @@ static int ad7877_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_resume);
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 1eb9d3c..fec66ad 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -284,8 +284,7 @@ static void ad7879_close(struct input_dev* input)
 		__ad7879_disable(ts);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ad7879_suspend(struct device *dev)
+static int __maybe_unused ad7879_suspend(struct device *dev)
 {
 	struct ad7879 *ts = dev_get_drvdata(dev);
 
@@ -301,7 +300,7 @@ static int ad7879_suspend(struct device *dev)
 	return 0;
 }
 
-static int ad7879_resume(struct device *dev)
+static int __maybe_unused ad7879_resume(struct device *dev)
 {
 	struct ad7879 *ts = dev_get_drvdata(dev);
 
@@ -316,7 +315,6 @@ static int ad7879_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
 EXPORT_SYMBOL(ad7879_pm_ops);
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index e57ba52..e4eb8a6 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -883,8 +883,7 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ads7846_suspend(struct device *dev)
+static int __maybe_unused ads7846_suspend(struct device *dev)
 {
 	struct ads7846 *ts = dev_get_drvdata(dev);
 
@@ -906,7 +905,7 @@ static int ads7846_suspend(struct device *dev)
 	return 0;
 }
 
-static int ads7846_resume(struct device *dev)
+static int __maybe_unused ads7846_resume(struct device *dev)
 {
 	struct ads7846 *ts = dev_get_drvdata(dev);
 
@@ -927,7 +926,6 @@ static int ads7846_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend, ads7846_resume);
 
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index aaacf8b..bb07020 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2244,8 +2244,7 @@ static int mxt_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mxt_suspend(struct device *dev)
+static int __maybe_unused mxt_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mxt_data *data = i2c_get_clientdata(client);
@@ -2261,7 +2260,7 @@ static int mxt_suspend(struct device *dev)
 	return 0;
 }
 
-static int mxt_resume(struct device *dev)
+static int __maybe_unused mxt_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mxt_data *data = i2c_get_clientdata(client);
@@ -2276,7 +2275,6 @@ static int mxt_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
 
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 7f3c947..40e02dd 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -417,8 +417,7 @@ static void auo_pixcir_input_close(struct input_dev *dev)
 	return;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int auo_pixcir_suspend(struct device *dev)
+static int __maybe_unused auo_pixcir_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct auo_pixcir_ts *ts = i2c_get_clientdata(client);
@@ -450,7 +449,7 @@ unlock:
 	return ret;
 }
 
-static int auo_pixcir_resume(struct device *dev)
+static int __maybe_unused auo_pixcir_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct auo_pixcir_ts *ts = i2c_get_clientdata(client);
@@ -479,7 +478,6 @@ unlock:
 
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops,
 			 auo_pixcir_suspend, auo_pixcir_resume);
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 5bf1aee..f2119ee 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -291,8 +291,7 @@ err_free_mem:
 	return err;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cy8ctmg110_suspend(struct device *dev)
+static int __maybe_unused cy8ctmg110_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
@@ -306,7 +305,7 @@ static int cy8ctmg110_suspend(struct device *dev)
 	return 0;
 }
 
-static int cy8ctmg110_resume(struct device *dev)
+static int __maybe_unused cy8ctmg110_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
@@ -319,7 +318,6 @@ static int cy8ctmg110_resume(struct device *dev)
 	}
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(cy8ctmg110_pm, cy8ctmg110_suspend, cy8ctmg110_resume);
 
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index eee656f..5b74e8b 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -472,8 +472,7 @@ static int cyttsp_disable(struct cyttsp *ts)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cyttsp_suspend(struct device *dev)
+static int __maybe_unused cyttsp_suspend(struct device *dev)
 {
 	struct cyttsp *ts = dev_get_drvdata(dev);
 	int retval = 0;
@@ -491,7 +490,7 @@ static int cyttsp_suspend(struct device *dev)
 	return retval;
 }
 
-static int cyttsp_resume(struct device *dev)
+static int __maybe_unused cyttsp_resume(struct device *dev)
 {
 	struct cyttsp *ts = dev_get_drvdata(dev);
 
@@ -507,8 +506,6 @@ static int cyttsp_resume(struct device *dev)
 	return 0;
 }
 
-#endif
-
 SIMPLE_DEV_PM_OPS(cyttsp_pm_ops, cyttsp_suspend, cyttsp_resume);
 EXPORT_SYMBOL_GPL(cyttsp_pm_ops);
 
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ee3434f..3793fcc 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1092,8 +1092,7 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int edt_ft5x06_ts_suspend(struct device *dev)
+static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -1103,7 +1102,7 @@ static int edt_ft5x06_ts_suspend(struct device *dev)
 	return 0;
 }
 
-static int edt_ft5x06_ts_resume(struct device *dev)
+static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -1112,7 +1111,6 @@ static int edt_ft5x06_ts_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
 			 edt_ft5x06_ts_suspend, edt_ft5x06_ts_resume);
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index b1884dd..09be6ce 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -264,8 +264,7 @@ static int eeti_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int eeti_ts_suspend(struct device *dev)
+static int __maybe_unused eeti_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
@@ -284,7 +283,7 @@ static int eeti_ts_suspend(struct device *dev)
 	return 0;
 }
 
-static int eeti_ts_resume(struct device *dev)
+static int __maybe_unused eeti_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
@@ -302,7 +301,6 @@ static int eeti_ts_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(eeti_ts_pm, eeti_ts_suspend, eeti_ts_resume);
 
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index c805784..4c56299 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -239,8 +239,7 @@ static const struct i2c_device_id egalax_ts_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, egalax_ts_id);
 
-#ifdef CONFIG_PM_SLEEP
-static int egalax_ts_suspend(struct device *dev)
+static int __maybe_unused egalax_ts_suspend(struct device *dev)
 {
 	static const u8 suspend_cmd[MAX_I2C_DATA_LEN] = {
 		0x3, 0x6, 0xa, 0x3, 0x36, 0x3f, 0x2, 0, 0, 0
@@ -252,13 +251,12 @@ static int egalax_ts_suspend(struct device *dev)
 	return ret > 0 ? 0 : ret;
 }
 
-static int egalax_ts_resume(struct device *dev)
+static int __maybe_unused egalax_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
 	return egalax_wake_up_device(client);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(egalax_ts_pm_ops, egalax_ts_suspend, egalax_ts_resume);
 
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 2a50891..da6dc81 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -311,8 +311,7 @@ static int ili210x_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ili210x_i2c_suspend(struct device *dev)
+static int __maybe_unused ili210x_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -322,7 +321,7 @@ static int ili210x_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int ili210x_i2c_resume(struct device *dev)
+static int __maybe_unused ili210x_i2c_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -331,7 +330,6 @@ static int ili210x_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ili210x_i2c_pm,
 			 ili210x_i2c_suspend, ili210x_i2c_resume);
diff --git a/drivers/input/touchscreen/ipaq-micro-ts.c b/drivers/input/touchscreen/ipaq-micro-ts.c
index 62c8976..33c1348 100644
--- a/drivers/input/touchscreen/ipaq-micro-ts.c
+++ b/drivers/input/touchscreen/ipaq-micro-ts.c
@@ -122,8 +122,7 @@ static int micro_ts_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int micro_ts_suspend(struct device *dev)
+static int __maybe_unused micro_ts_suspend(struct device *dev)
 {
 	struct touchscreen_data *ts = dev_get_drvdata(dev);
 
@@ -132,7 +131,7 @@ static int micro_ts_suspend(struct device *dev)
 	return 0;
 }
 
-static int micro_ts_resume(struct device *dev)
+static int __maybe_unused micro_ts_resume(struct device *dev)
 {
 	struct touchscreen_data *ts = dev_get_drvdata(dev);
 	struct input_dev *input = ts->input;
@@ -146,7 +145,6 @@ static int micro_ts_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops micro_ts_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(micro_ts_suspend, micro_ts_resume)
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 372bbf7..67c0d31 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -515,8 +515,7 @@ static int mms114_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mms114_suspend(struct device *dev)
+static int __maybe_unused mms114_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mms114_data *data = i2c_get_clientdata(client);
@@ -540,7 +539,7 @@ static int mms114_suspend(struct device *dev)
 	return 0;
 }
 
-static int mms114_resume(struct device *dev)
+static int __maybe_unused mms114_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mms114_data *data = i2c_get_clientdata(client);
@@ -559,7 +558,6 @@ static int mms114_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(mms114_pm_ops, mms114_suspend, mms114_resume);
 
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index fc49c75..4fb5537 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -347,8 +347,7 @@ static void pixcir_input_close(struct input_dev *dev)
 	pixcir_stop(ts);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pixcir_i2c_ts_suspend(struct device *dev)
+static int __maybe_unused pixcir_i2c_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pixcir_i2c_ts_data *ts = i2c_get_clientdata(client);
@@ -377,7 +376,7 @@ unlock:
 	return ret;
 }
 
-static int pixcir_i2c_ts_resume(struct device *dev)
+static int __maybe_unused pixcir_i2c_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pixcir_i2c_ts_data *ts = i2c_get_clientdata(client);
@@ -405,7 +404,6 @@ unlock:
 
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(pixcir_dev_pm_ops,
 			 pixcir_i2c_ts_suspend, pixcir_i2c_ts_resume);
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 3c0f57e..697e26e 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -243,8 +243,7 @@ static int st1232_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int st1232_ts_suspend(struct device *dev)
+static int __maybe_unused st1232_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
@@ -259,7 +258,7 @@ static int st1232_ts_suspend(struct device *dev)
 	return 0;
 }
 
-static int st1232_ts_resume(struct device *dev)
+static int __maybe_unused st1232_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
@@ -274,8 +273,6 @@ static int st1232_ts_resume(struct device *dev)
 	return 0;
 }
 
-#endif
-
 static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
 			 st1232_ts_suspend, st1232_ts_resume);
 
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 52380b6..72657c5 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -773,8 +773,7 @@ static int tsc2005_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tsc2005_suspend(struct device *dev)
+static int __maybe_unused tsc2005_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct tsc2005 *ts = spi_get_drvdata(spi);
@@ -791,7 +790,7 @@ static int tsc2005_suspend(struct device *dev)
 	return 0;
 }
 
-static int tsc2005_resume(struct device *dev)
+static int __maybe_unused tsc2005_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct tsc2005 *ts = spi_get_drvdata(spi);
@@ -807,7 +806,6 @@ static int tsc2005_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(tsc2005_pm_ops, tsc2005_suspend, tsc2005_resume);
 
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index b46c55c..bf132c4 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -406,8 +406,7 @@ static int ucb1400_ts_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ucb1400_ts_suspend(struct device *dev)
+static int __maybe_unused ucb1400_ts_suspend(struct device *dev)
 {
 	struct ucb1400_ts *ucb = dev_get_platdata(dev);
 	struct input_dev *idev = ucb->ts_idev;
@@ -421,7 +420,7 @@ static int ucb1400_ts_suspend(struct device *dev)
 	return 0;
 }
 
-static int ucb1400_ts_resume(struct device *dev)
+static int __maybe_unused ucb1400_ts_resume(struct device *dev)
 {
 	struct ucb1400_ts *ucb = dev_get_platdata(dev);
 	struct input_dev *idev = ucb->ts_idev;
@@ -434,7 +433,6 @@ static int ucb1400_ts_resume(struct device *dev)
 	mutex_unlock(&idev->mutex);
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops,
 			 ucb1400_ts_suspend, ucb1400_ts_resume);
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index 7ccaa1b..32f8ac0 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -242,8 +242,7 @@ static int wacom_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int wacom_i2c_suspend(struct device *dev)
+static int __maybe_unused wacom_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -252,7 +251,7 @@ static int wacom_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int wacom_i2c_resume(struct device *dev)
+static int __maybe_unused wacom_i2c_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -260,7 +259,6 @@ static int wacom_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c_resume);
 
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 8ba48f5..19880c7 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -602,8 +602,7 @@ static void zforce_input_close(struct input_dev *dev)
 	return;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int zforce_suspend(struct device *dev)
+static int __maybe_unused zforce_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct zforce_ts *ts = i2c_get_clientdata(client);
@@ -648,7 +647,7 @@ unlock:
 	return ret;
 }
 
-static int zforce_resume(struct device *dev)
+static int __maybe_unused zforce_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct zforce_ts *ts = i2c_get_clientdata(client);
@@ -685,7 +684,6 @@ unlock:
 
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(zforce_pm_ops, zforce_suspend, zforce_resume);
 
-- 
1.7.9.5


