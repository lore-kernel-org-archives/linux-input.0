From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/15] input: convert LoCoMo keyboard driver to use new locomo core
Date: Tue, 28 Oct 2014 03:01:57 +0300
Message-ID: <1414454528-24240-5-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

As LoCoMo is switching to new device model, adapt keyboard driver to
support new locomo core driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/keyboard/Kconfig     |   1 -
 drivers/input/keyboard/locomokbd.c | 165 ++++++++++++++++++++-----------------
 2 files changed, 91 insertions(+), 75 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a3958c6..b660516 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -337,7 +337,6 @@ config KEYBOARD_LM8333
 
 config KEYBOARD_LOCOMO
 	tristate "LoCoMo Keyboard Support"
-	depends on SHARP_LOCOMO
 	help
 	  Say Y here if you are running Linux on a Sharp Zaurus Collie or Poodle based PDA
 
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index c94d610..c2fabf3 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -28,16 +28,10 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/delay.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-
-#include <asm/hardware/locomo.h>
-#include <asm/irq.h>
-
-MODULE_AUTHOR("John Lenz <lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>");
-MODULE_DESCRIPTION("LoCoMo keyboard driver");
-MODULE_LICENSE("GPL");
+#include <linux/io.h>
+#include <linux/mfd/locomo.h>
 
 #define LOCOMOKBD_NUMKEYS	128
 
@@ -75,7 +69,8 @@ struct locomokbd {
 	struct input_dev *input;
 	char phys[32];
 
-	unsigned long base;
+	void __iomem *base;
+	int irq;
 	spinlock_t lock;
 
 	struct timer_list timer;
@@ -84,37 +79,37 @@ struct locomokbd {
 };
 
 /* helper functions for reading the keyboard matrix */
-static inline void locomokbd_charge_all(unsigned long membase)
+static inline void locomokbd_charge_all(void __iomem *membase)
 {
-	locomo_writel(0x00FF, membase + LOCOMO_KSC);
+	writew(0x00FF, membase + LOCOMO_KSC);
 }
 
-static inline void locomokbd_activate_all(unsigned long membase)
+static inline void locomokbd_activate_all(void __iomem *membase)
 {
 	unsigned long r;
 
-	locomo_writel(0, membase + LOCOMO_KSC);
-	r = locomo_readl(membase + LOCOMO_KIC);
+	writew(0, membase + LOCOMO_KSC);
+	r = readw(membase + LOCOMO_KIC);
 	r &= 0xFEFF;
-	locomo_writel(r, membase + LOCOMO_KIC);
+	writew(r, membase + LOCOMO_KIC);
 }
 
-static inline void locomokbd_activate_col(unsigned long membase, int col)
+static inline void locomokbd_activate_col(void __iomem *membase, int col)
 {
 	unsigned short nset;
 	unsigned short nbset;
 
 	nset = 0xFF & ~(1 << col);
 	nbset = (nset << 8) + nset;
-	locomo_writel(nbset, membase + LOCOMO_KSC);
+	writew(nbset, membase + LOCOMO_KSC);
 }
 
-static inline void locomokbd_reset_col(unsigned long membase, int col)
+static inline void locomokbd_reset_col(void __iomem *membase, int col)
 {
 	unsigned short nbset;
 
 	nbset = ((0xFF & ~(1 << col)) << 8) + 0xFF;
-	locomo_writel(nbset, membase + LOCOMO_KSC);
+	writew(nbset, membase + LOCOMO_KSC);
 }
 
 /*
@@ -129,7 +124,7 @@ static void locomokbd_scankeyboard(struct locomokbd *locomokbd)
 	unsigned int row, col, rowd;
 	unsigned long flags;
 	unsigned int num_pressed;
-	unsigned long membase = locomokbd->base;
+	void __iomem *membase = locomokbd->base;
 
 	spin_lock_irqsave(&locomokbd->lock, flags);
 
@@ -141,7 +136,7 @@ static void locomokbd_scankeyboard(struct locomokbd *locomokbd)
 		locomokbd_activate_col(membase, col);
 		udelay(KB_DELAY);
 
-		rowd = ~locomo_readl(membase + LOCOMO_KIB);
+		rowd = ~readw(membase + LOCOMO_KIB);
 		for (row = 0; row < KB_ROWS; row++) {
 			unsigned int scancode, pressed, key;
 
@@ -194,11 +189,11 @@ static irqreturn_t locomokbd_interrupt(int irq, void *dev_id)
 	struct locomokbd *locomokbd = dev_id;
 	u16 r;
 
-	r = locomo_readl(locomokbd->base + LOCOMO_KIC);
+	r = readw(locomokbd->base + LOCOMO_KIC);
 	if ((r & 0x0001) == 0)
 		return IRQ_HANDLED;
 
-	locomo_writel(r & ~0x0100, locomokbd->base + LOCOMO_KIC); /* Ack */
+	writew(r & ~0x0100, locomokbd->base + LOCOMO_KIC); /* Ack */
 
 	/** wait chattering delay **/
 	udelay(100);
@@ -222,8 +217,8 @@ static int locomokbd_open(struct input_dev *dev)
 	struct locomokbd *locomokbd = input_get_drvdata(dev);
 	u16 r;
 	
-	r = locomo_readl(locomokbd->base + LOCOMO_KIC) | 0x0010;
-	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
+	r = readw(locomokbd->base + LOCOMO_KIC) | 0x0010;
+	writew(r, locomokbd->base + LOCOMO_KIC);
 	return 0;
 }
 
@@ -232,35 +227,39 @@ static void locomokbd_close(struct input_dev *dev)
 	struct locomokbd *locomokbd = input_get_drvdata(dev);
 	u16 r;
 	
-	r = locomo_readl(locomokbd->base + LOCOMO_KIC) & ~0x0010;
-	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
+	r = readw(locomokbd->base + LOCOMO_KIC) & ~0x0010;
+	writew(r, locomokbd->base + LOCOMO_KIC);
 }
 
-static int locomokbd_probe(struct locomo_dev *dev)
+static int locomokbd_probe(struct platform_device *dev)
 {
 	struct locomokbd *locomokbd;
 	struct input_dev *input_dev;
 	int i, err;
+	struct resource *res;
+
+	locomokbd = devm_kzalloc(&dev->dev, sizeof(struct locomokbd),
+			GFP_KERNEL);
+	if (!locomokbd)
+		return -ENOMEM;
 
-	locomokbd = kzalloc(sizeof(struct locomokbd), GFP_KERNEL);
 	input_dev = input_allocate_device();
-	if (!locomokbd || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
+	if (!input_dev)
+		return -ENOMEM;
 
-	/* try and claim memory region */
-	if (!request_mem_region((unsigned long) dev->mapbase,
-				dev->length,
-				LOCOMO_DRIVER_NAME(dev))) {
-		err = -EBUSY;
-		printk(KERN_ERR "locomokbd: Can't acquire access to io memory for keyboard\n");
-		goto err_free_mem;
-	}
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
 
-	locomo_set_drvdata(dev, locomokbd);
+	locomokbd->irq = platform_get_irq(dev, 0);
+	if (locomokbd->irq < 0)
+		return -ENXIO;
 
-	locomokbd->base = (unsigned long) dev->mapbase;
+	platform_set_drvdata(dev, locomokbd);
+
+	locomokbd->base = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(locomokbd->base))
+		return PTR_ERR(locomokbd->base);
 
 	spin_lock_init(&locomokbd->lock);
 
@@ -296,11 +295,15 @@ static int locomokbd_probe(struct locomo_dev *dev)
 		set_bit(locomokbd->keycode[i], input_dev->keybit);
 	clear_bit(0, input_dev->keybit);
 
+	writew(0, locomokbd->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
+	writew(0, locomokbd->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
+
 	/* attempt to get the interrupt */
-	err = request_irq(dev->irq[0], locomokbd_interrupt, 0, "locomokbd", locomokbd);
+	err = request_irq(locomokbd->irq, locomokbd_interrupt, 0,
+			"locomokbd", locomokbd);
 	if (err) {
 		printk(KERN_ERR "locomokbd: Can't get irq for keyboard\n");
-		goto err_release_region;
+		goto err_free_mem;
 	}
 
 	err = input_register_device(locomokbd->input);
@@ -309,54 +312,68 @@ static int locomokbd_probe(struct locomo_dev *dev)
 
 	return 0;
 
- err_free_irq:
-	free_irq(dev->irq[0], locomokbd);
- err_release_region:
-	release_mem_region((unsigned long) dev->mapbase, dev->length);
-	locomo_set_drvdata(dev, NULL);
- err_free_mem:
+err_free_irq:
+	free_irq(locomokbd->irq, locomokbd);
+err_free_mem:
+	platform_set_drvdata(dev, NULL);
 	input_free_device(input_dev);
-	kfree(locomokbd);
 
 	return err;
 }
 
-static int locomokbd_remove(struct locomo_dev *dev)
+static int locomokbd_remove(struct platform_device *dev)
 {
-	struct locomokbd *locomokbd = locomo_get_drvdata(dev);
+	struct locomokbd *locomokbd = platform_get_drvdata(dev);
 
-	free_irq(dev->irq[0], locomokbd);
+	free_irq(locomokbd->irq, locomokbd);
 
 	del_timer_sync(&locomokbd->timer);
 
 	input_unregister_device(locomokbd->input);
-	locomo_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
 
-	release_mem_region((unsigned long) dev->mapbase, dev->length);
+#ifdef CONFIG_PM_SLEEP
+static int locomokbd_resume(struct device *dev)
+{
+	struct locomokbd *locomokbd = dev_get_drvdata(dev);
+	unsigned long flags;
+	u16 r;
+
+	spin_lock_irqsave(&locomokbd->lock, flags);
+
+	writew(0, locomokbd->base + LOCOMO_KSC);
+	r = readw(locomokbd->base + LOCOMO_KIC);
+	r &= 0xFEFF;
+	writew(r, locomokbd->base + LOCOMO_KIC);
+	writew(0x1, locomokbd->base + LOCOMO_KCMD);
 
-	kfree(locomokbd);
+	spin_unlock_irqrestore(&locomokbd->lock, flags);
 
 	return 0;
 }
 
-static struct locomo_driver keyboard_driver = {
-	.drv = {
-		.name = "locomokbd"
+static SIMPLE_DEV_PM_OPS(locomo_kbd_pm, NULL, locomokbd_resume);
+#define LOCOMO_KBD_PM	(&locomo_kbd_pm)
+#else
+#define LOCOMO_KBD_PM	NULL
+#endif
+
+static struct platform_driver locomokbd_driver = {
+	.driver = {
+		.name	= "locomo-kbd",
+		.owner	= THIS_MODULE,
+		.pm	= LOCOMO_KBD_PM,
 	},
-	.devid	= LOCOMO_DEVID_KEYBOARD,
 	.probe	= locomokbd_probe,
 	.remove	= locomokbd_remove,
 };
 
-static int __init locomokbd_init(void)
-{
-	return locomo_driver_register(&keyboard_driver);
-}
-
-static void __exit locomokbd_exit(void)
-{
-	locomo_driver_unregister(&keyboard_driver);
-}
+module_platform_driver(locomokbd_driver);
 
-module_init(locomokbd_init);
-module_exit(locomokbd_exit);
+MODULE_AUTHOR("John Lenz <lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>");
+MODULE_DESCRIPTION("LoCoMo keyboard driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:locomo-kbd");
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
