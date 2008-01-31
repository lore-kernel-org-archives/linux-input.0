From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/12] pxa: rename the pxa27x_keyboard to pxa27x_keypad
Date: Thu, 31 Jan 2008 11:31:23 +0800
Message-ID: <f17812d70801301931p3bd4f0bdmc3d85570aa767720@mail.gmail.com>
References: <f17812d70801222316w52070845r123fd9b54bb27b36@mail.gmail.com>
	 <200801290126.01530.dtor@insightbb.com>
	 <f17812d70801282257x573f2aehd808589344f13f9d@mail.gmail.com>
	 <200801290222.48095.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:10089 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbYAaDbX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jan 2008 22:31:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so795426wah.23
        for <linux-input@vger.kernel.org>; Wed, 30 Jan 2008 19:31:23 -0800 (PST)
In-Reply-To: <200801290222.48095.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@vger.kernel.org

On Jan 29, 2008 3:22 PM, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Tuesday 29 January 2008 01:57, eric miao wrote:
> > On Jan 29, 2008 2:26 PM, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > > Hi Eric,
> > >
> > > On Wednesday 23 January 2008 02:16, eric miao wrote:
> > > > Subject: [PATCH] pxa: rename the pxa27x_keyboard to pxa27x_keypad
> > > >
> > > > The controller should really be called keypad, and also align
> > > > the naming of functions and structures to use "pxa27x_keypad"
> > > > as prefix, instead of "pxakbd".
> > >
> > > Not sure what the difference is... Seems to be a gratuous renaming.
> > >
> >
> > Yeah, though I used git-mv, the result of git-format-patch still looks horrible.
>
> Probably if you do move commit and rename separately it will be somewhat cleaner.
>
> > Anyway, this is just a naming issue. While other pxa drivers are slowly
> > transitioning to a more standard naming convention (if you take a look at
> > recent [arch/arm/mach-pxa/devices.c] in Linus's recent tree) I first update
> > this to later patches could be more specific.
>
> Let me take a look...
>
> --
> Dmitry
>

Here's the diff, generated with "git format-patch -M" to detect renames,
looks much cleaner now:

>From bd0e7b847887682ccedc921527173a3643ced383 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Tue, 22 Jan 2008 16:30:39 +0800
Subject: [PATCH] pxa: rename the pxa27x_keyboard to pxa27x_keypad

The controller should really be called keypad, and also align
the naming of functions and structures to use "pxa27x_keypad"
as prefix, instead of "pxakbd".

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/Kconfig                     |    6 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 .../{pxa27x_keyboard.c => pxa27x_keypad.c}         |   82 ++++++++++----------
 .../{pxa27x_keyboard.h => pxa27x_keypad.h}         |    2 +-
 4 files changed, 46 insertions(+), 46 deletions(-)
 rename drivers/input/keyboard/{pxa27x_keyboard.c => pxa27x_keypad.c} (70%)
 rename include/asm-arm/arch-pxa/{pxa27x_keyboard.h => pxa27x_keypad.h} (85%)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index dfa6592..33e292b 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -239,13 +239,13 @@ config KEYBOARD_OMAP
 	  module will be called omap-keypad.

 config KEYBOARD_PXA27x
-	tristate "PXA27x keyboard support"
+	tristate "PXA27x keypad support"
 	depends on PXA27x
 	help
-	  Enable support for PXA27x matrix keyboard controller
+	  Enable support for PXA27x keypad controller

 	  To compile this driver as a module, choose M here: the
-	  module will be called pxa27x_keyboard.
+	  module will be called pxa27x_keypad.

 config KEYBOARD_AAED2000
 	tristate "AAED-2000 keyboard"
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index e97455f..b361bb9 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_KEYBOARD_SPITZ)		+= spitzkbd.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
-obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keyboard.o
+obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
diff --git a/drivers/input/keyboard/pxa27x_keyboard.c
b/drivers/input/keyboard/pxa27x_keypad.c
similarity index 70%
rename from drivers/input/keyboard/pxa27x_keyboard.c
rename to drivers/input/keyboard/pxa27x_keypad.c
index bdd64ee..06c1d5a 100644
--- a/drivers/input/keyboard/pxa27x_keyboard.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/input/keyboard/pxa27x_keyboard.c
+ * linux/drivers/input/keyboard/pxa27x_keypad.c
  *
  * Driver for the pxa27x matrix keyboard controller.
  *
@@ -33,21 +33,21 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/irqs.h>
-#include <asm/arch/pxa27x_keyboard.h>
+#include <asm/arch/pxa27x_keypad.h>

-#define DRIVER_NAME		"pxa27x-keyboard"
+#define DRIVER_NAME		"pxa27x-keypad"

 #define KPASMKP(col)		(col/2 == 0 ? KPASMKP0 : \
 				 col/2 == 1 ? KPASMKP1 : \
 				 col/2 == 2 ? KPASMKP2 : KPASMKP3)
 #define KPASMKPx_MKC(row, col)	(1 << (row + 16 * (col % 2)))

-static struct clk *pxakbd_clk;
+static struct clk *pxa27x_keypad_clk;

-static irqreturn_t pxakbd_irq_handler(int irq, void *dev_id)
+static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
 	struct input_dev *input_dev = platform_get_drvdata(pdev);
 	unsigned long kpc = KPC;
 	int p, row, col, rel;
@@ -93,7 +93,7 @@ static irqreturn_t pxakbd_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }

-static int pxakbd_open(struct input_dev *dev)
+static int pxa27x_keypad_open(struct input_dev *dev)
 {
 	/* Set keypad control register */
 	KPC |= (KPC_ASACT |
@@ -108,21 +108,21 @@ static int pxakbd_open(struct input_dev *dev)
 	KPREC = 0x7F;

 	/* Enable unit clock */
-	clk_enable(pxakbd_clk);
+	clk_enable(pxa27x_keypad_clk);

 	return 0;
 }

-static void pxakbd_close(struct input_dev *dev)
+static void pxa27x_keypad_close(struct input_dev *dev)
 {
 	/* Disable clock unit */
-	clk_disable(pxakbd_clk);
+	clk_disable(pxa27x_keypad_clk);
 }

 #ifdef CONFIG_PM
-static int pxakbd_suspend(struct platform_device *pdev, pm_message_t state)
+static int pxa27x_keypad_suspend(struct platform_device *pdev,
pm_message_t state)
 {
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;

 	/* Save controller status */
 	pdata->reg_kpc = KPC;
@@ -131,9 +131,9 @@ static int pxakbd_suspend(struct platform_device
*pdev, pm_message_t state)
 	return 0;
 }

-static int pxakbd_resume(struct platform_device *pdev)
+static int pxa27x_keypad_resume(struct platform_device *pdev)
 {
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
 	struct input_dev *input_dev = platform_get_drvdata(pdev);

 	mutex_lock(&input_dev->mutex);
@@ -144,8 +144,8 @@ static int pxakbd_resume(struct platform_device *pdev)
 		KPREC = pdata->reg_kprec;

 		/* Enable unit clock */
-		clk_disable(pxakbd_clk);
-		clk_enable(pxakbd_clk);
+		clk_disable(pxa27x_keypad_clk);
+		clk_enable(pxa27x_keypad_clk);
 	}

 	mutex_unlock(&input_dev->mutex);
@@ -153,19 +153,19 @@ static int pxakbd_resume(struct platform_device *pdev)
 	return 0;
 }
 #else
-#define pxakbd_suspend	NULL
-#define pxakbd_resume	NULL
+#define pxa27x_keypad_suspend	NULL
+#define pxa27x_keypad_resume	NULL
 #endif

-static int __devinit pxakbd_probe(struct platform_device *pdev)
+static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 {
-	struct pxa27x_keyboard_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
 	struct input_dev *input_dev;
 	int i, row, col, error;

-	pxakbd_clk = clk_get(&pdev->dev, "KBDCLK");
-	if (IS_ERR(pxakbd_clk)) {
-		error = PTR_ERR(pxakbd_clk);
+	pxa27x_keypad_clk = clk_get(&pdev->dev, "KBDCLK");
+	if (IS_ERR(pxa27x_keypad_clk)) {
+		error = PTR_ERR(pxa27x_keypad_clk);
 		goto err_clk;
 	}

@@ -179,8 +179,8 @@ static int __devinit pxakbd_probe(struct
platform_device *pdev)

 	input_dev->name = DRIVER_NAME;
 	input_dev->id.bustype = BUS_HOST;
-	input_dev->open = pxakbd_open;
-	input_dev->close = pxakbd_close;
+	input_dev->open = pxa27x_keypad_open;
+	input_dev->close = pxa27x_keypad_close;
 	input_dev->dev.parent = &pdev->dev;

 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
@@ -194,7 +194,7 @@ static int __devinit pxakbd_probe(struct
platform_device *pdev)
 		}
 	}

-	error = request_irq(IRQ_KEYPAD, pxakbd_irq_handler, IRQF_DISABLED,
+	error = request_irq(IRQ_KEYPAD, pxa27x_keypad_irq_handler, IRQF_DISABLED,
 			    DRIVER_NAME, pdev);
 	if (error) {
 		printk(KERN_ERR "Cannot request keypad IRQ\n");
@@ -230,45 +230,45 @@ static int __devinit pxakbd_probe(struct
platform_device *pdev)
  err_free_dev:
 	input_free_device(input_dev);
  err_alloc:
-	clk_put(pxakbd_clk);
+	clk_put(pxa27x_keypad_clk);
  err_clk:
 	return error;
 }

-static int __devexit pxakbd_remove(struct platform_device *pdev)
+static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
 {
 	struct input_dev *input_dev = platform_get_drvdata(pdev);

 	input_unregister_device(input_dev);
 	free_irq(IRQ_KEYPAD, pdev);
-	clk_put(pxakbd_clk);
+	clk_put(pxa27x_keypad_clk);
 	platform_set_drvdata(pdev, NULL);

 	return 0;
 }

-static struct platform_driver pxakbd_driver = {
-	.probe		= pxakbd_probe,
-	.remove		= __devexit_p(pxakbd_remove),
-	.suspend	= pxakbd_suspend,
-	.resume		= pxakbd_resume,
+static struct platform_driver pxa27x_keypad_driver = {
+	.probe		= pxa27x_keypad_probe,
+	.remove		= __devexit_p(pxa27x_keypad_remove),
+	.suspend	= pxa27x_keypad_suspend,
+	.resume		= pxa27x_keypad_resume,
 	.driver		= {
 		.name	= DRIVER_NAME,
 	},
 };

-static int __init pxakbd_init(void)
+static int __init pxa27x_keypad_init(void)
 {
-	return platform_driver_register(&pxakbd_driver);
+	return platform_driver_register(&pxa27x_keypad_driver);
 }

-static void __exit pxakbd_exit(void)
+static void __exit pxa27x_keypad_exit(void)
 {
-	platform_driver_unregister(&pxakbd_driver);
+	platform_driver_unregister(&pxa27x_keypad_driver);
 }

-module_init(pxakbd_init);
-module_exit(pxakbd_exit);
+module_init(pxa27x_keypad_init);
+module_exit(pxa27x_keypad_exit);

-MODULE_DESCRIPTION("PXA27x Matrix Keyboard Driver");
+MODULE_DESCRIPTION("PXA27x Keypad Controller Driver");
 MODULE_LICENSE("GPL");
diff --git a/include/asm-arm/arch-pxa/pxa27x_keyboard.h
b/include/asm-arm/arch-pxa/pxa27x_keypad.h
similarity index 85%
rename from include/asm-arm/arch-pxa/pxa27x_keyboard.h
rename to include/asm-arm/arch-pxa/pxa27x_keypad.h
index 3aaff92..f19f74a 100644
--- a/include/asm-arm/arch-pxa/pxa27x_keyboard.h
+++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
@@ -1,7 +1,7 @@
 #define PXAKBD_MAXROW		8
 #define PXAKBD_MAXCOL		8

-struct pxa27x_keyboard_platform_data {
+struct pxa27x_keypad_platform_data {
 	int nr_rows, nr_cols;
 	int keycodes[PXAKBD_MAXROW][PXAKBD_MAXCOL];
 	int gpio_modes[PXAKBD_MAXROW + PXAKBD_MAXCOL];
-- 
1.5.3.8



-- 
Cheers
- eric
