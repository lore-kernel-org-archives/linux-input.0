From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/6] mrst_touchscreen: clean up input side
Date: Fri, 23 Jul 2010 14:51:52 +0100
Message-ID: <20100723135151.19151.73344.stgit@localhost.localdomain>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13938 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892Ab0GWOYU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 10:24:20 -0400
In-Reply-To: <20100723134852.19151.6999.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg@kroah.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Fix most of the stuff that Dmitry pointed out. This leaves the mutex in IRQ
and misuse of SPI to sort out.

Also fix the build bits so it actually builds in staging - whoops.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/staging/Makefile                           |    2 
 drivers/staging/mrst-touchscreen/Kconfig           |    2 
 drivers/staging/mrst-touchscreen/Makefile          |    2 
 drivers/staging/mrst-touchscreen/TODO              |    2 
 drivers/staging/mrst-touchscreen/intel-mid-touch.c |   98 ++++----------------
 5 files changed, 25 insertions(+), 81 deletions(-)


diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 26942aa..4df0df9 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_CXT1E1)		+= cxt1e1/
 obj-$(CONFIG_TI_ST)		+= ti-st/
 obj-$(CONFIG_ADIS16255)		+= adis16255/
 obj-$(CONFIG_FB_XGI)		+= xgifb/
-obj-$(CONFIG_TOUCHSCREEN_MRSTOUCH)	+= mrst-touchscreen/
+obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= mrst-touchscreen/
 obj-$(CONFIG_MSM_STAGING)	+= msm/
 obj-$(CONFIG_EASYCAP)		+= easycap/
 obj-$(CONFIG_SOLO6X10)		+= solo6x10/
diff --git a/drivers/staging/mrst-touchscreen/Kconfig b/drivers/staging/mrst-touchscreen/Kconfig
index c2af492..775d740 100644
--- a/drivers/staging/mrst-touchscreen/Kconfig
+++ b/drivers/staging/mrst-touchscreen/Kconfig
@@ -1,6 +1,6 @@
 config TOUCHSCREEN_INTEL_MID
 	tristate "Intel MID platform resistive touchscreen"
-	depends on INTEL_SCU_IPC
+	depends on INTEL_SCU_IPC && INPUT_TOUCHSCREEN
 	default y
 	help
 	  Say Y here if you have a Intel MID based touchscreen
diff --git a/drivers/staging/mrst-touchscreen/Makefile b/drivers/staging/mrst-touchscreen/Makefile
index 2d638b0..155f58b 100644
--- a/drivers/staging/mrst-touchscreen/Makefile
+++ b/drivers/staging/mrst-touchscreen/Makefile
@@ -1,3 +1,3 @@
-obj-$(CONFIG_TOUCHSCREEN_INTEL_MID) := intel_mid_touch.o
+obj-$(CONFIG_TOUCHSCREEN_INTEL_MID) := intel-mid-touch.o
 
 
diff --git a/drivers/staging/mrst-touchscreen/TODO b/drivers/staging/mrst-touchscreen/TODO
index 7157028..84aa695 100644
--- a/drivers/staging/mrst-touchscreen/TODO
+++ b/drivers/staging/mrst-touchscreen/TODO
@@ -1,2 +1,4 @@
 - Move the driver to not think it is SPI (requires fixing some of the SFI
   and firmware side)
+- Fix mutex in IRQ stuff - threaded IRQ ?
+
diff --git a/drivers/staging/mrst-touchscreen/intel-mid-touch.c b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
index abba22f..6fed01e 100644
--- a/drivers/staging/mrst-touchscreen/intel-mid-touch.c
+++ b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
@@ -23,7 +23,6 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  * TODO:
- *	kill off mrstouch_debug eventually
  *	review conversion of r/m/w sequences
  *	Replace interrupt mutex abuse
  *	Kill of mrstouchdevp pointer
@@ -43,16 +42,6 @@
 #include <asm/intel_scu_ipc.h>
 
 
-#if defined(MRSTOUCH_DEBUG)
-#define mrstouch_debug(fmt, args...)\
-	do { \
-		printk(KERN_DEBUG "\n[MRSTOUCH(%d)] - ", __LINE__); \
-		printk(KERN_DEBUG fmt, ##args); \
-	} while (0);
-#else
-#define mrstouch_debug(fmt, args...)
-#endif
-
 /* PMIC Interrupt registers */
 #define PMIC_REG_ID1   0x00 /*PMIC ID1 register */
 
@@ -100,6 +89,9 @@
 #define MAX_X		1024
 #define MIN_Y		10
 #define MAX_Y		1024
+#define MIN_P		0
+#define MAX_P		TOUCH_PRESSURE_FS
+
 #define WAIT_ADC_COMPLETION 10
 
 /* PMIC ADC round robin delays */
@@ -124,8 +116,6 @@ struct mrstouch_dev {
 	int             irq;    /* Touch screen IRQ # */
 	uint		vendor;  /* PMIC vendor */
 	uint		rev;  /* PMIC revision */
-	bool		suspended; /* Device suspended status */
-	bool		disabled;  /* Device disabled status */
 	u16		x;  /* X coordinate */
 	u16		y;  /* Y coordinate */
 	bool		pendown;  /* PEN position */
@@ -320,8 +310,6 @@ static int mrstouch_adc_init(struct mrstouch_dev *tsdev)
 
 	tsdev->asr = start;
 
-	mrstouch_debug("Channel offset(%d): 0x%X\n", tsdev->asr, tsdev->vendor);
-
 	/* ADC power on, start, enable PENDET and set loop delay
 	 * ADC loop delay is set to 4.5 ms approximately
 	 * Loop delay more than this results in jitter in adc readings
@@ -355,7 +343,6 @@ static void mrstouch_report_xy(struct mrstouch_dev *tsdev, u16 x, u16 y, u16 z)
 
 	if (tsdev->pendown && z <= TOUCH_PRESSURE) {
 		/* Pen removed, report button release */
-		mrstouch_debug("BTN REL(%d)", z);
 		input_report_key(tsdev->input, BTN_TOUCH, 0);
 		tsdev->pendown = false;
 	}
@@ -371,7 +358,6 @@ static void mrstouch_report_xy(struct mrstouch_dev *tsdev, u16 x, u16 y, u16 z)
 	if (x < MIN_X || x > MAX_X || y < MIN_Y || y > MAX_Y) {
 		/* Spurious values, release button if touched and return */
 		if (tsdev->pendown) {
-			mrstouch_debug("BTN REL(%d)", z);
 			input_report_key(tsdev->input, BTN_TOUCH, 0);
 			tsdev->pendown = false;
 		}
@@ -382,13 +368,13 @@ static void mrstouch_report_xy(struct mrstouch_dev *tsdev, u16 x, u16 y, u16 z)
 
 		input_report_abs(tsdev->input, ABS_X, x);
 		input_report_abs(tsdev->input, ABS_Y, y);
+		input_report_abs(tsdev->input, ABS_PRESSURE, z);
 		input_sync(tsdev->input);
 	}
 
 
 	if (!tsdev->pendown && z > TOUCH_PRESSURE) {
 		/* Pen touched, report button touch */
-		mrstouch_debug("BTN TCH(%d, %d, %d)", x, y, z);
 		input_report_key(tsdev->input, BTN_TOUCH, 1);
 		tsdev->pendown = true;
 	}
@@ -446,18 +432,7 @@ static int mrstouch_pmic_fs_adc_read(struct mrstouch_dev *tsdev)
 	z |= data[1] & 0x7; /* Lower 3 bits */
 	z &= 0x3FF;
 
-#if defined(MRSTOUCH_PRINT_XYZP)
-	mrstouch_debug("X: %d, Y: %d, Z: %d", x, y, z);
-#endif
-
-	if (z >= TOUCH_PRESSURE_FS) {
-		mrstouch_report_xy(tsdev, x, y, TOUCH_PRESSURE - 1); /* Pen Removed */
-		return TOUCH_PRESSURE - 1;
-	} else {
-		mrstouch_report_xy(tsdev, x, y, TOUCH_PRESSURE + 1); /* Pen Touched */
-		return TOUCH_PRESSURE + 1;
-	}
-
+	mrstouch_report_xy(tsdev, x, y, z);
 	return 0;
 
 ipc_error:
@@ -615,14 +590,6 @@ static int mrstouch_adc_read(struct mrstouch_dev *tsdev)
 	if (err)
 		goto ipc_error;
 
-#if defined(MRSTOUCH_PRINT_XYZP)
-	printk(KERN_INFO "X+: %d, Y+: %d, Z+: %d\n", xp, yp, zp);
-#endif
-
-#if defined(MRSTOUCH_PRINT_XYZM)
-	printk(KERN_INFO "X-: %d, Y-: %d, Z-: %d\n", xm, ym, zm);
-#endif
-
 	mrstouch_report_xy(tsdev, xp, yp, zp); /* report x and y to eventX */
 
 	return zp;
@@ -694,12 +661,10 @@ static int ts_input_dev_init(struct mrstouch_dev *tsdev, struct spi_device *spi)
 {
 	int err = 0;
 
-	mrstouch_debug("%s", __func__);
-
 	tsdev->input = input_allocate_device();
 	if (!tsdev->input) {
 		dev_err(&tsdev->spi->dev, "Unable to allocate input device.\n");
-		return -EINVAL;
+		return -ENOMEM;
 	}
 
 	tsdev->input->name = "mrst_touchscreen";
@@ -714,8 +679,9 @@ static int ts_input_dev_init(struct mrstouch_dev *tsdev, struct spi_device *spi)
 	tsdev->input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	tsdev->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	input_set_abs_params(tsdev->input, ABS_X, MIN_X, MIN_Y, 0, 0);
-	input_set_abs_params(tsdev->input, ABS_Y, MIN_X, MIN_Y, 0, 0);
+	input_set_abs_params(tsdev->input, ABS_X, MIN_X, MAX_X, 0, 0);
+	input_set_abs_params(tsdev->input, ABS_Y, MIN_Y, MAX_Y, 0, 0);
+	input_set_abs_params(tsdev->input, ABS_PRESSURE, MIN_P, MAX_P, 0, 0);
 
 	err = input_register_device(tsdev->input);
 	if (err) {
@@ -723,9 +689,6 @@ static int ts_input_dev_init(struct mrstouch_dev *tsdev, struct spi_device *spi)
 		input_free_device(tsdev->input);
 		return err;
 	}
-
-	mrstouch_debug("%s", "mrstouch initialized");
-
 	return 0;
 
 }
@@ -737,8 +700,6 @@ static int __devinit mrstouch_probe(struct spi_device *mrstouch_spi)
 	unsigned int myirq;
 	struct mrstouch_dev *tsdev;
 
-	mrstouch_debug("%s(%p)", __func__, mrstouch_spi);
-
 	mrstouchdevp = NULL;
 	myirq = mrstouch_spi->irq;
 
@@ -768,18 +729,17 @@ static int __devinit mrstouch_probe(struct spi_device *mrstouch_spi)
 	err = ts_input_dev_init(tsdev, mrstouch_spi);
 	if (err) {
 		dev_err(&tsdev->spi->dev, "ts_input_dev_init failed");
-		goto mrstouch_err_free_mem;
+		goto mrstouch_err_free_dev;
 	}
 
 	mutex_init(&tsdev->lock);
-	mutex_lock(&tsdev->lock)
+	mutex_lock(&tsdev->lock);
 
-	mrstouch_debug("Requesting IRQ-%d", myirq);
 	err = request_irq(myirq, pendet_intr_handler,
 				0, "mrstouch", tsdev);
 	if (err) {
 		dev_err(&tsdev->spi->dev, "unable to allocate irq\n");
-		goto mrstouch_err_free_mem;
+		goto mrstouch_err_free_dev;
 	}
 
 	tsdev->pendet_thrd = kthread_run(mrstouch_pendet,
@@ -787,38 +747,24 @@ static int __devinit mrstouch_probe(struct spi_device *mrstouch_spi)
 	if (IS_ERR(tsdev->pendet_thrd)) {
 		dev_err(&tsdev->spi->dev, "kthread_run failed\n");
 		err = PTR_ERR(tsdev->pendet_thrd);
-		goto mrstouch_err_free_mem;
+		goto mrstouch_err_free_irq;
 	}
-	mrstouch_debug("%s", "Driver initialized");
 	return 0;
-
+mrstouch_err_free_irq:
+	free_irq(myirq, tsdev);
+mrstouch_err_free_dev:
+	input_unregister_device(tsdev->input);
 mrstouch_err_free_mem:
 	kfree(tsdev);
 	return err;
 }
 
-static int mrstouch_suspend(struct spi_device *spi, pm_message_t msg)
-{
-	mrstouch_debug("%s", __func__);
-	mrstouchdevp->suspended = 1;
-	return 0;
-}
-
-static int mrstouch_resume(struct spi_device *spi)
-{
-	mrstouch_debug("%s", __func__);
-	mrstouchdevp->suspended = 0;
-	return 0;
-}
-
 static int mrstouch_remove(struct spi_device *spi)
 {
-	mrstouch_debug("%s", __func__);
 	free_irq(mrstouchdevp->irq, mrstouchdevp);
-	input_unregister_device(mrstouchdevp->input);
-	input_free_device(mrstouchdevp->input);
 	if (mrstouchdevp->pendet_thrd)
 		kthread_stop(mrstouchdevp->pendet_thrd);
+	input_unregister_device(mrstouchdevp->input);
 	kfree(mrstouchdevp);
 	return 0;
 }
@@ -830,8 +776,6 @@ static struct spi_driver mrstouch_driver = {
 		.owner  = THIS_MODULE,
 	},
 	.probe          = mrstouch_probe,
-	.suspend        = mrstouch_suspend,
-	.resume         = mrstouch_resume,
 	.remove         = mrstouch_remove,
 };
 
@@ -839,11 +783,10 @@ static int __init mrstouch_module_init(void)
 {
 	int err;
 
-	mrstouch_debug("%s", __func__);
 	err = spi_register_driver(&mrstouch_driver);
 	if (err) {
-		mrstouch_debug("%s(%d)", "SPI PENDET failed", err);
-		return -1;
+		printk(KERN_ERR "%s(%d)", "SPI PENDET failed", err);
+		return err;;
 	}
 
 	return 0;
@@ -851,7 +794,6 @@ static int __init mrstouch_module_init(void)
 
 static void __exit mrstouch_module_exit(void)
 {
-	mrstouch_debug("%s", __func__);
 	spi_unregister_driver(&mrstouch_driver);
 	return;
 }

