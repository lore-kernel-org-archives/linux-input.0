From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4/6] *	Register platform interface
Date: Fri, 23 Jul 2010 14:52:21 +0100
Message-ID: <20100723135219.19151.98855.stgit@localhost.localdomain>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16412 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892Ab0GWOYt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 10:24:49 -0400
In-Reply-To: <20100723134852.19151.6999.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg@kroah.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

From: Alek Du <alek.du@intel.com>

*	Fix some coding style

AC: Reworked to merge with upstream input device work from Dmitry et al.

Signed-off-by: Alek Du <alek.du@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/staging/mrst-touchscreen/intel-mid-touch.c |   63 ++++++++++----------
 1 files changed, 30 insertions(+), 33 deletions(-)


diff --git a/drivers/staging/mrst-touchscreen/intel-mid-touch.c b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
index c41989b..db286eb 100644
--- a/drivers/staging/mrst-touchscreen/intel-mid-touch.c
+++ b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
@@ -32,7 +32,8 @@
 #include <linux/interrupt.h>
 #include <linux/err.h>
 #include <linux/param.h>
-#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <asm/intel_scu_ipc.h>
@@ -94,7 +95,7 @@
 
 /* Touch screen device structure */
 struct mrstouch_dev {
-	struct spi_device *spi;
+	struct device *dev; /* device associated with touch screen */
 	struct input_dev *input;
 	char phys[32];
 	u16 asr;		/* Address selection register */
@@ -162,7 +163,7 @@ static int mrstouch_nec_adc_read_finish(struct mrstouch_dev *tsdev)
 
 		if (!pendet_enabled) {
 			if (++retry >= 10) {
-				dev_err(&tsdev->spi->dev,
+				dev_err(tsdev->dev,
 					"Touch screen disabled.\n");
 				return -EIO;
 			}
@@ -282,7 +283,7 @@ static int mrstouch_nec_adc_read(struct mrstouch_dev *tsdev,
 	return 0;
 
 ipc_error:
-	dev_err(&tsdev->spi->dev, "ipc error during adc read\n");
+	dev_err(tsdev->dev, "ipc error during adc read\n");
 	return err;
 }
 
@@ -341,7 +342,7 @@ static int mrstouch_fs_adc_read_prepare(struct mrstouch_dev *tsdev)
 	return 0;
 
 ipc_error:
-	dev_err(&tsdev->spi->dev, "ipc error during %s\n", __func__);
+	dev_err(tsdev->dev, "ipc error during %s\n", __func__);
 	return err;
 }
 
@@ -387,7 +388,7 @@ static int mrstouch_fs_adc_read(struct mrstouch_dev *tsdev,
 	return 0;
 
 ipc_error:
-	dev_err(&tsdev->spi->dev, "ipc error during %s\n", __func__);
+	dev_err(tsdev->dev, "ipc error during %s\n", __func__);
 	return err;
 }
 
@@ -428,7 +429,7 @@ static int mrstouch_fs_adc_read_finish(struct mrstouch_dev *tsdev)
 	return 0;
 
 ipc_error:
-	dev_err(&tsdev->spi->dev, "ipc error during %s\n", __func__);
+	dev_err(tsdev->dev, "ipc error during %s\n", __func__);
 	return err;
 }
 
@@ -558,7 +559,7 @@ static int __devinit mrstouch_adc_init(struct mrstouch_dev *tsdev)
 
 	err = mrstouch_read_pmic_id(&tsdev->vendor, &tsdev->rev);
 	if (err) {
-		dev_err(&tsdev->spi->dev, "Unable to read PMIC id\n");
+		dev_err(tsdev->dev, "Unable to read PMIC id\n");
 		return err;
 	}
 
@@ -577,14 +578,14 @@ static int __devinit mrstouch_adc_init(struct mrstouch_dev *tsdev)
 		break;
 
 	default:
-		dev_err(&tsdev->spi->dev,
+		dev_err(tsdev->dev,
 			"Unsupported touchscreen: %d\n", tsdev->vendor);
 		return -ENXIO;
 	}
 
 	start = mrstouch_chan_parse(tsdev);
 	if (start < 0) {
-		dev_err(&tsdev->spi->dev, "Unable to parse channels\n");
+		dev_err(tsdev->dev, "Unable to parse channels\n");
 		return start;
 	}
 
@@ -625,43 +626,43 @@ static int __devinit mrstouch_adc_init(struct mrstouch_dev *tsdev)
 
 
 /* Probe function for touch screen driver */
-static int __devinit mrstouch_probe(struct spi_device *spi)
+static int __devinit mrstouch_probe(struct platform_device *pdev)
 {
 	struct mrstouch_dev *tsdev;
 	struct input_dev *input;
 	int err;
+	int irq;
 
-	if (!spi->irq) {
-		dev_err(&spi->dev, "no interrupt assigned\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no interrupt assigned\n");
 		return -EINVAL;
 	}
 
 	tsdev = kzalloc(sizeof(struct mrstouch_dev), GFP_KERNEL);
 	input = input_allocate_device();
 	if (!tsdev || !input) {
-		dev_err(&spi->dev, "unable to allocate memory\n");
+		dev_err(&pdev->dev, "unable to allocate memory\n");
 		err = -ENOMEM;
 		goto err_free_mem;
 	}
 
-	tsdev->spi = spi;
+	tsdev->dev = &pdev->dev;
 	tsdev->input = input;
-	tsdev->irq = spi->irq;
+	tsdev->irq = irq;
 
 	snprintf(tsdev->phys, sizeof(tsdev->phys),
-		 "%s/input0", dev_name(&spi->dev));
-
-	tsdev->spi = mrstouch_spi;
+		 "%s/input0", dev_name(tsdev->dev));
 
 	err = mrstouch_adc_init(tsdev);
 	if (err) {
-		dev_err(&spi->dev, "ADC initialization failed\n");
+		dev_err(&pdev->dev, "ADC initialization failed\n");
 		goto err_free_mem;
 	}
 
 	input->name = "mrst_touchscreen";
 	input->phys = tsdev->phys;
-	input->dev.parent = &spi->dev;
+	input->dev.parent = tsdev->dev;
 
 	input->id.vendor = tsdev->vendor;
 	input->id.version = tsdev->rev;
@@ -679,17 +680,17 @@ static int __devinit mrstouch_probe(struct spi_device *spi)
 	err = request_threaded_irq(tsdev->irq, NULL, mrstouch_pendet_irq,
 				   0, "mrstouch", tsdev);
 	if (err) {
-		dev_err(&tsdev->spi->dev, "unable to allocate irq\n");
+		dev_err(tsdev->dev, "unable to allocate irq\n");
 		goto err_free_mem;
 	}
 
 	err = input_register_device(tsdev->input);
 	if (err) {
-		dev_err(&tsdev->spi->dev, "unable to register input device\n");
+		dev_err(tsdev->dev, "unable to register input device\n");
 		goto err_free_irq;
 	}
 
-	spi_set_drvdata(spi, tsdev);
+	dev_set_drvdata(tsdev->dev, tsdev);
 	return 0;
 
 err_free_irq:
@@ -700,23 +701,19 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit mrstouch_remove(struct spi_device *spi)
+static int __devexit mrstouch_remove(struct platform_device *pdev)
 {
-	struct mrstouch_dev *tsdev = spi_get_drvdata(spi);
+	struct mrstouch_dev *tsdev = dev_get_drvdata(&pdev->dev);
 
 	free_irq(tsdev->irq, tsdev);
 	input_unregister_device(tsdev->input);
 	kfree(tsdev);
-
-	spi_set_drvdata(spi, NULL);
-
 	return 0;
 }
 
-static struct spi_driver mrstouch_driver = {
+static struct platform_driver mrstouch_driver = {
 	.driver = {
 		.name   = "pmic_touch",
-		.bus    = &spi_bus_type,
 		.owner  = THIS_MODULE,
 	},
 	.probe          = mrstouch_probe,
@@ -725,13 +722,13 @@ static struct spi_driver mrstouch_driver = {
 
 static int __init mrstouch_init(void)
 {
-	return spi_register_driver(&mrstouch_driver);
+	return platform_driver_register(&mrstouch_driver);
 }
 module_init(mrstouch_init);
 
 static void __exit mrstouch_exit(void)
 {
-	spi_unregister_driver(&mrstouch_driver);
+	platform_driver_unregister(&mrstouch_driver);
 }
 module_exit(mrstouch_exit);
 

