From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: q40kbd - convert driver to the split model
Date: Fri, 30 Dec 2011 17:11:11 -0800
Message-ID: <20111231010814.7392.52389.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41344 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab1LaBLR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Dec 2011 20:11:17 -0500
Received: by iaeh11 with SMTP id h11so26071472iae.19
        for <linux-input@vger.kernel.org>; Fri, 30 Dec 2011 17:11:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>

Convert the driver to standard spilt model arch-specific code registers
platform device to which driver code can bind later.

Also request IRQ immediately upon binding to the device instead of doing
this when serio port is being opened.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Not tested as I don't have the hardware...

 arch/m68k/q40/config.c       |   12 ++++
 drivers/input/serio/q40kbd.c |  134 ++++++++++++++++++++++++------------------
 2 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index ad10fec..27d3f76 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -24,6 +24,7 @@
 #include <linux/rtc.h>
 #include <linux/vt_kern.h>
 #include <linux/bcd.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/rtc.h>
@@ -329,3 +330,14 @@ static int q40_set_rtc_pll(struct rtc_pll_info *pll)
 	} else
 		return -EINVAL;
 }
+
+static struct platform_device q40_kbd_pdev = {
+	.name	= "q40kbd",
+	.id	= -1,
+};
+
+static __init int q40_add_kbd_device(void)
+{
+	return platform_device_register(&q40_kbd_pdev);
+}
+arch_initcall(q40_add_kbd_device);
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 5eb84b3..1e61dd4 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -44,26 +44,31 @@
 #include <asm/irq.h>
 #include <asm/q40ints.h>
 
+#define DRV_NAME	"q40kbd"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
 
-static DEFINE_SPINLOCK(q40kbd_lock);
-static struct serio *q40kbd_port;
-static struct platform_device *q40kbd_device;
+struct q40kbd {
+	struct serio *port;
+	spinlock_t lock;
+};
 
 static irqreturn_t q40kbd_interrupt(int irq, void *dev_id)
 {
+	struct q40kbd *q40kbd = dev_id;
 	unsigned long flags;
 
-	spin_lock_irqsave(&q40kbd_lock, flags);
+	spin_lock_irqsave(&q40kbd->lock, flags);
 
 	if (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
-		serio_interrupt(q40kbd_port, master_inb(KEYCODE_REG), 0);
+		serio_interrupt(q40kbd->port, master_inb(KEYCODE_REG), 0);
 
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
 
-	spin_unlock_irqrestore(&q40kbd_lock, flags);
+	spin_unlock_irqrestore(&q40kbd->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -72,17 +77,23 @@ static irqreturn_t q40kbd_interrupt(int irq, void *dev_id)
  * q40kbd_flush() flushes all data that may be in the keyboard buffers
  */
 
-static void q40kbd_flush(void)
+static void q40kbd_flush(struct q40kbd *q40kbd)
 {
 	int maxread = 100;
 	unsigned long flags;
 
-	spin_lock_irqsave(&q40kbd_lock, flags);
+	spin_lock_irqsave(&q40kbd->lock, flags);
 
 	while (maxread-- && (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
 		master_inb(KEYCODE_REG);
 
-	spin_unlock_irqrestore(&q40kbd_lock, flags);
+	spin_unlock_irqrestore(&q40kbd->lock, flags);
+}
+
+static void q40kbd_stop(struct q40kbd *q40kbd)
+{
+	master_outb(0, KEY_IRQ_ENABLE_REG);
+	master_outb(-1, KEYBOARD_UNLOCK_REG);
 }
 
 /*
@@ -92,12 +103,9 @@ static void q40kbd_flush(void)
 
 static int q40kbd_open(struct serio *port)
 {
-	q40kbd_flush();
+	struct q40kbd *q40kbd = port->port_data;
 
-	if (request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0, "q40kbd", NULL)) {
-		printk(KERN_ERR "q40kbd.c: Can't get irq %d.\n", Q40_IRQ_KEYBOARD);
-		return -EBUSY;
-	}
+	q40kbd_flush(q40kbd);
 
 	/* off we go */
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
@@ -108,35 +116,68 @@ static int q40kbd_open(struct serio *port)
 
 static void q40kbd_close(struct serio *port)
 {
-	master_outb(0, KEY_IRQ_ENABLE_REG);
-	master_outb(-1, KEYBOARD_UNLOCK_REG);
-	free_irq(Q40_IRQ_KEYBOARD, NULL);
+	struct q40kbd *q40kbd = port->port_data;
 
-	q40kbd_flush();
+	q40kbd_stop(q40kbd);
+	q40kbd_flush(q40kbd);
 }
 
-static int __devinit q40kbd_probe(struct platform_device *dev)
+static int __devinit q40kbd_probe(struct platform_device *pdev)
 {
-	q40kbd_port = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!q40kbd_port)
-		return -ENOMEM;
-
-	q40kbd_port->id.type	= SERIO_8042;
-	q40kbd_port->open	= q40kbd_open;
-	q40kbd_port->close	= q40kbd_close;
-	q40kbd_port->dev.parent	= &dev->dev;
-	strlcpy(q40kbd_port->name, "Q40 Kbd Port", sizeof(q40kbd_port->name));
-	strlcpy(q40kbd_port->phys, "Q40", sizeof(q40kbd_port->phys));
-
-	serio_register_port(q40kbd_port);
+	struct q40kbd *q40kbd;
+	struct serio *port;
+	int error;
+
+	q40kbd = kzalloc(sizeof(struct q40kbd), GFP_KERNEL);
+	port = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!q40kbd || !port) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	q40kbd->port = port;
+	spin_lock_init(&q40kbd->lock);
+
+	port->id.type = SERIO_8042;
+	port->open = q40kbd_open;
+	port->close = q40kbd_close;
+	port->port_data = q40kbd;
+	port->dev.parent = &pdev->dev;
+	strlcpy(port->name, "Q40 Kbd Port", sizeof(port->name));
+	strlcpy(port->phys, "Q40", sizeof(port->phys));
+
+	q40kbd_stop(q40kbd);
+
+	error = request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0,
+			    DRV_NAME, q40kbd);
+	if (error) {
+		dev_err(&pdev->dev, "Can't get irq %d.\n", Q40_IRQ_KEYBOARD);
+		goto err_free_mem;
+	}
+
+	serio_register_port(q40kbd->port);
+
+	platform_set_drvdata(pdev, q40kbd);
 	printk(KERN_INFO "serio: Q40 kbd registered\n");
 
 	return 0;
+
+err_free_mem:
+	kfree(port);
+	kfree(q40kbd);
+	return error;
 }
 
-static int __devexit q40kbd_remove(struct platform_device *dev)
+static int __devexit q40kbd_remove(struct platform_device *pdev)
 {
-	serio_unregister_port(q40kbd_port);
+	struct q40kbd *q40kbd = platform_get_drvdata(pdev);
+
+	free_irq(Q40_IRQ_KEYBOARD, q40kbd);
+
+	serio_unregister_port(q40kbd->port);
+	kfree(q40kbd);
+
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
@@ -146,41 +187,16 @@ static struct platform_driver q40kbd_driver = {
 		.name	= "q40kbd",
 		.owner	= THIS_MODULE,
 	},
-	.probe		= q40kbd_probe,
 	.remove		= __devexit_p(q40kbd_remove),
 };
 
 static int __init q40kbd_init(void)
 {
-	int error;
-
-	if (!MACH_IS_Q40)
-		return -ENODEV;
-
-	error = platform_driver_register(&q40kbd_driver);
-	if (error)
-		return error;
-
-	q40kbd_device = platform_device_alloc("q40kbd", -1);
-	if (!q40kbd_device)
-		goto err_unregister_driver;
-
-	error = platform_device_add(q40kbd_device);
-	if (error)
-		goto err_free_device;
-
-	return 0;
-
- err_free_device:
-	platform_device_put(q40kbd_device);
- err_unregister_driver:
-	platform_driver_unregister(&q40kbd_driver);
-	return error;
+	return platform_driver_probe(&q40kbd_driver, q40kbd_probe);
 }
 
 static void __exit q40kbd_exit(void)
 {
-	platform_device_unregister(q40kbd_device);
 	platform_driver_unregister(&q40kbd_driver);
 }
 

