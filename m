From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: [HP6xx/Patch] - update touchscreen driver
Date: Sun, 27 Apr 2008 16:49:44 +0200
Message-ID: <20080427164944.dd3ce43e.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: dmitry <dtor@insightbb.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linux-sh <linux-sh@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

This patch updates the hp jornada 6xx touchscreen driver to work properly,
essentially this brings the driver more inline with other drivers.

The changes include :
* change to platform driver
* proper ABS_X/ABS_Y values now that tsdev has been removed
* additional error reporting
* fix broken work queue handling
* random tidying

Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/drivers/input/touchscreen/hp680_ts_input.c b/drivers/input/touchscreen/hp680_ts_input.c
index c38d4e0..2fb53c0 100644
--- a/drivers/input/touchscreen/hp680_ts_input.c
+++ b/drivers/input/touchscreen/hp680_ts_input.c
@@ -1,7 +1,16 @@
+/*
+ * Platform driver for the HP Jornada 620/660/680/690 Touchscreen.
+ *
+ * Copyright 2008 Kristoffer Ericson <kristoffer.ericson@gmail.com>
+ *  Copyright ...-2007 Andriy Skulysh <askulysh@image.kiev.ua>
+ */
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/adc.h>
@@ -9,20 +18,14 @@
 
 #define MODNAME "hp680_ts_input"
 
-#define HP680_TS_ABS_X_MIN	40
-#define HP680_TS_ABS_X_MAX	950
-#define HP680_TS_ABS_Y_MIN	80
-#define HP680_TS_ABS_Y_MAX	910
-
-#define	PHDR	0xa400012e
-#define SCPDR	0xa4000136
+#define	PHDR	0xa400012e	/* PORT H  DATA REGISTER */
+#define SCPDR	0xa4000136	/* PORT SC DATA REGISTER */
 
-static void do_softint(struct work_struct *work);
-
-static struct input_dev *hp680_ts_dev;
+struct input_dev *dev;
+static void do_softint(struct delayed_work *work);
 static DECLARE_DELAYED_WORK(work, do_softint);
 
-static void do_softint(struct work_struct *work)
+static void do_softint(struct delayed_work *work)
 {
 	int absx = 0, absy = 0;
 	u8 scpdr;
@@ -53,77 +56,104 @@ static void do_softint(struct work_struct *work)
 		touched = ctrl_inb(PHDR) & PHDR_TS_PEN_DOWN;
 	}
 
+
+	/* note, tslib currently expects ABS_PRESSURE also */
 	if (touched) {
-		input_report_key(hp680_ts_dev, BTN_TOUCH, 1);
-		input_report_abs(hp680_ts_dev, ABS_X, absx);
-		input_report_abs(hp680_ts_dev, ABS_Y, absy);
+		input_report_abs(dev, ABS_X, absx);
+		input_report_abs(dev, ABS_Y, absy);
+		input_report_key(dev, BTN_TOUCH, 1);
 	} else {
-		input_report_key(hp680_ts_dev, BTN_TOUCH, 0);
+		input_report_key(dev, BTN_TOUCH, 0);
 	}
-
-	input_sync(hp680_ts_dev);
+	input_sync(dev);
 	enable_irq(HP680_TS_IRQ);
 }
 
-static irqreturn_t hp680_ts_interrupt(int irq, void *dev)
+static irqreturn_t hp680_ts_interrupt(int irq, void *pdev)
 {
 	disable_irq_nosync(irq);
 	schedule_delayed_work(&work, HZ / 20);
-
 	return IRQ_HANDLED;
 }
 
-static int __init hp680_ts_init(void)
+static int __devinit jornada680_ts_probe(struct platform_device *pdev)
 {
-	int err;
+	int error;
 
-	hp680_ts_dev = input_allocate_device();
-	if (!hp680_ts_dev)
-		return -ENOMEM;
+	dev = input_allocate_device();
 
-	hp680_ts_dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
-	hp680_ts_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	if (!dev) {
+		printk(KERN_INFO "ts: failed to allocate device\n");
+		error = -ENODEV;
+		return error;
+	}
 
-	input_set_abs_params(hp680_ts_dev, ABS_X,
-		HP680_TS_ABS_X_MIN, HP680_TS_ABS_X_MAX, 0, 0);
-	input_set_abs_params(hp680_ts_dev, ABS_Y,
-		HP680_TS_ABS_Y_MIN, HP680_TS_ABS_Y_MAX, 0, 0);
+	dev->name = "HP Jornada 6xx Touchscreen";
+	dev->phys = "jornadats/input0";
+	dev->id.bustype = BUS_HOST;
+	dev->dev.parent = &pdev->dev;
+	dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+	dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y);
+	dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(dev, ABS_X, 40, 950, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 80, 910, 0, 0);
+
+	error = input_register_device(dev);
+	if (error) {
+		printk(KERN_ERR "ts: failed to register device\n");
+		goto fail2;
+	}
 
-	hp680_ts_dev->name = "HP Jornada touchscreen";
-	hp680_ts_dev->phys = "hp680_ts/input0";
+	error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
+			IRQF_DISABLED, "HP6xx Touchscreen driver", NULL);
 
-	if (request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
-			IRQF_DISABLED, MODNAME, 0) < 0) {
-		printk(KERN_ERR "hp680_touchscreen.c: Can't allocate irq %d\n",
-		       HP680_TS_IRQ);
-		err = -EBUSY;
-		goto fail1;
+	if (error) {
+		printk(KERN_INFO "ts: unable to aquire irq\n");
+		goto fail3;
 	}
 
-	err = input_register_device(hp680_ts_dev);
-	if (err)
-		goto fail2;
-
 	return 0;
 
- fail2:	free_irq(HP680_TS_IRQ, NULL);
-	cancel_delayed_work(&work);
-	flush_scheduled_work();
- fail1:	input_free_device(hp680_ts_dev);
-	return err;
+fail3:
+		input_unregister_device(dev);
+fail2:
+		input_free_device(dev);
+	return error;
 }
 
-static void __exit hp680_ts_exit(void)
+static int __devexit jornada680_ts_remove(struct platform_device *pdev)
 {
-	free_irq(HP680_TS_IRQ, NULL);
 	cancel_delayed_work(&work);
 	flush_scheduled_work();
-	input_unregister_device(hp680_ts_dev);
+	free_irq(HP680_TS_IRQ, pdev);
+	input_unregister_device(dev);
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:jornada_ts");
+
+static struct platform_driver jornada680_ts_driver = {
+	.probe	= jornada680_ts_probe,
+	.remove	= jornada680_ts_remove,
+	.driver = {
+		.name = "jornada_ts",
+		.owner= THIS_MODULE,
+	},
+};
+
+static int __init hp680_ts_init(void)
+{
+	return platform_driver_register(&jornada680_ts_driver);
 }
 
+static void __exit hp680_ts_exit(void)
+{
+	platform_driver_unregister(&jornada680_ts_driver);
+}
 module_init(hp680_ts_init);
 module_exit(hp680_ts_exit);
 
-MODULE_AUTHOR("Andriy Skulysh, askulysh@image.kiev.ua");
-MODULE_DESCRIPTION("HP Jornada 680 touchscreen driver");
+MODULE_AUTHOR("Andriy Skulysh <askulysh@image.kiev.ua>, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
+MODULE_DESCRIPTION("HP Jornada 6xx touchscreen driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/hp680_ts_input.c b/drivers/input/touchscreen/hp680_ts_input.c
index c38d4e0..92a4a08 100644
--- a/drivers/input/touchscreen/hp680_ts_input.c
+++ b/drivers/input/touchscreen/hp680_ts_input.c
@@ -1,7 +1,16 @@
+/*
+ * Platform driver for the HP Jornada 620/660/680/690 Touchscreen.
+ *
+ * Copyright 2008 Kristoffer Ericson <kristoffer.ericson@gmail.com>
+ *  Copyright ...-2007 Andriy Skulysh <askulysh@image.kiev.ua>
+ */
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/adc.h>
@@ -9,20 +18,14 @@
 
 #define MODNAME "hp680_ts_input"
 
-#define HP680_TS_ABS_X_MIN	40
-#define HP680_TS_ABS_X_MAX	950
-#define HP680_TS_ABS_Y_MIN	80
-#define HP680_TS_ABS_Y_MAX	910
-
-#define	PHDR	0xa400012e
-#define SCPDR	0xa4000136
+#define	PHDR	0xa400012e	/* PORT H  DATA REGISTER */
+#define SCPDR	0xa4000136	/* PORT SC DATA REGISTER */
 
-static void do_softint(struct work_struct *work);
-
-static struct input_dev *hp680_ts_dev;
+struct input_dev *dev;
+static void do_softint(struct delayed_work *work);
 static DECLARE_DELAYED_WORK(work, do_softint);
 
-static void do_softint(struct work_struct *work)
+static void do_softint(struct delayed_work *work)
 {
 	int absx = 0, absy = 0;
 	u8 scpdr;
@@ -53,77 +56,104 @@ static void do_softint(struct work_struct *work)
 		touched = ctrl_inb(PHDR) & PHDR_TS_PEN_DOWN;
 	}
 
+
+	/* note, tslib currently expects ABS_PRESSURE also */
 	if (touched) {
-		input_report_key(hp680_ts_dev, BTN_TOUCH, 1);
-		input_report_abs(hp680_ts_dev, ABS_X, absx);
-		input_report_abs(hp680_ts_dev, ABS_Y, absy);
+		input_report_abs(dev, ABS_X, absx);
+		input_report_abs(dev, ABS_Y, absy);
+		input_report_key(dev, BTN_TOUCH, 1);
 	} else {
-		input_report_key(hp680_ts_dev, BTN_TOUCH, 0);
+		input_report_key(dev, BTN_TOUCH, 0);
 	}
-
-	input_sync(hp680_ts_dev);
+	input_sync(dev);
 	enable_irq(HP680_TS_IRQ);
 }
 
-static irqreturn_t hp680_ts_interrupt(int irq, void *dev)
+static irqreturn_t hp680_ts_interrupt(int irq, void *pdev)
 {
 	disable_irq_nosync(irq);
 	schedule_delayed_work(&work, HZ / 20);
-
 	return IRQ_HANDLED;
 }
 
-static int __init hp680_ts_init(void)
+static int __devinit jornada680_ts_probe(struct platform_device *pdev)
 {
-	int err;
+	int error;
 
-	hp680_ts_dev = input_allocate_device();
-	if (!hp680_ts_dev)
-		return -ENOMEM;
+	dev = input_allocate_device();
 
-	hp680_ts_dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
-	hp680_ts_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	if (!dev) {
+		printk(KERN_ERR "ts: failed to allocate device\n");
+		error = -ENODEV;
+		return error;
+	}
 
-	input_set_abs_params(hp680_ts_dev, ABS_X,
-		HP680_TS_ABS_X_MIN, HP680_TS_ABS_X_MAX, 0, 0);
-	input_set_abs_params(hp680_ts_dev, ABS_Y,
-		HP680_TS_ABS_Y_MIN, HP680_TS_ABS_Y_MAX, 0, 0);
+	dev->name = "HP Jornada 6xx Touchscreen";
+	dev->phys = "jornadats/input0";
+	dev->id.bustype = BUS_HOST;
+	dev->dev.parent = &pdev->dev;
+	dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+	dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y);
+	dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(dev, ABS_X, 40, 950, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 80, 910, 0, 0);
+
+	error = input_register_device(dev);
+	if (error) {
+		printk(KERN_ERR "ts: failed to register device\n");
+		goto fail2;
+	}
 
-	hp680_ts_dev->name = "HP Jornada touchscreen";
-	hp680_ts_dev->phys = "hp680_ts/input0";
+	error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
+			IRQF_DISABLED, "HP6xx Touchscreen driver", NULL);
 
-	if (request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
-			IRQF_DISABLED, MODNAME, 0) < 0) {
-		printk(KERN_ERR "hp680_touchscreen.c: Can't allocate irq %d\n",
-		       HP680_TS_IRQ);
-		err = -EBUSY;
-		goto fail1;
+	if (error) {
+		printk(KERN_ERR "ts: unable to aquire irq\n");
+		goto fail3;
 	}
 
-	err = input_register_device(hp680_ts_dev);
-	if (err)
-		goto fail2;
-
 	return 0;
 
- fail2:	free_irq(HP680_TS_IRQ, NULL);
-	cancel_delayed_work(&work);
-	flush_scheduled_work();
- fail1:	input_free_device(hp680_ts_dev);
-	return err;
+fail3:
+		input_unregister_device(dev);
+fail2:
+		input_free_device(dev);
+	return error;
 }
 
-static void __exit hp680_ts_exit(void)
+static int __devexit jornada680_ts_remove(struct platform_device *pdev)
 {
-	free_irq(HP680_TS_IRQ, NULL);
 	cancel_delayed_work(&work);
 	flush_scheduled_work();
-	input_unregister_device(hp680_ts_dev);
+	free_irq(HP680_TS_IRQ, pdev);
+	input_unregister_device(dev);
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:jornada_ts");
+
+static struct platform_driver jornada680_ts_driver = {
+	.probe	= jornada680_ts_probe,
+	.remove	= jornada680_ts_remove,
+	.driver = {
+		.name = "jornada_ts",
+		.owner= THIS_MODULE,
+	},
+};
+
+static int __init hp680_ts_init(void)
+{
+	return platform_driver_register(&jornada680_ts_driver);
 }
 
+static void __exit hp680_ts_exit(void)
+{
+	platform_driver_unregister(&jornada680_ts_driver);
+}
 module_init(hp680_ts_init);
 module_exit(hp680_ts_exit);
 
-MODULE_AUTHOR("Andriy Skulysh, askulysh@image.kiev.ua");
-MODULE_DESCRIPTION("HP Jornada 680 touchscreen driver");
+MODULE_AUTHOR("Andriy Skulysh <askulysh@image.kiev.ua>, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
+MODULE_DESCRIPTION("HP Jornada 6xx touchscreen driver");
 MODULE_LICENSE("GPL");
