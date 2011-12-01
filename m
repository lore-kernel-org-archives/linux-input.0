From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: i8042 - do not leak driver on error on Sparc
Date: Thu, 1 Dec 2011 00:40:40 -0800
Message-ID: <20111201084040.GA31610@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55789 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1LAIkp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Dec 2011 03:40:45 -0500
Received: by iage36 with SMTP id e36so2151604iag.19
        for <linux-input@vger.kernel.org>; Thu, 01 Dec 2011 00:40:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Grant Likely <grant.likely@secretlab.ca>

If we did not find OF nodes describing AUX or KBD ports we'd bail
out but forget to unregister sparc_i8042_driver platform driver.

Switch over to platform_driver_probe() instead which automatically
unregisters driver if it does not bind to any device; it also has
a side effect of suppressing "bind" and "unbind" sysfs attributes
ensuring that we do not unmap IO registers while i8042 core is
running. This also allows us to switch annotations from
__devinit/__devexit to __init/__exit and maybe save some memory.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

1. This haven't even been compiled - I lost my sparc cross-compile
toolchain - but I hope I did not screw up.

2. I do not understand how it all even work - we register
sparc_i8042_driver which is a platform driver with 'i8042' name;
i8042 core also registers platform driver with exactly the same name.
Surely the core one will fail since it would be a duplicate...

Thanks.

 drivers/input/serio/i8042-sparcio.h |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)


diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 395a9af..be6512b 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -49,7 +49,7 @@ static inline void i8042_write_command(int val)
 #define OBP_PS2MS_NAME1		"kdmouse"
 #define OBP_PS2MS_NAME2		"mouse"
 
-static int __devinit sparc_i8042_probe(struct platform_device *op)
+static int __init sparc_i8042_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 
@@ -77,12 +77,23 @@ static int __devinit sparc_i8042_probe(struct platform_device *op)
 		dp = dp->sibling;
 	}
 
+	if (i8042_kbd_irq == -1 || i8042_aux_irq == -1) {
+		i8042_kbd_irq = i8042_aux_irq = -1;
+		if (kbd_iobase) {
+			of_iounmap(kbd_res, kbd_iobase, 8);
+			kbd_iobase = (void __iomem *) NULL;
+		}
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
-static int __devexit sparc_i8042_remove(struct platform_device *op)
+static int __exit sparc_i8042_remove(struct platform_device *op)
 {
 	of_iounmap(kbd_res, kbd_iobase, 8);
+	kbd_iobase = (void __iomem *) NULL;
+	i8042_kbd_irq = i8042_aux_irq = -1;
 
 	return 0;
 }
@@ -101,8 +112,7 @@ static struct platform_driver sparc_i8042_driver = {
 		.owner = THIS_MODULE,
 		.of_match_table = sparc_i8042_match,
 	},
-	.probe		= sparc_i8042_probe,
-	.remove		= __devexit_p(sparc_i8042_remove),
+	.remove		= __exit_p(sparc_i8042_remove),
 };
 
 static int __init i8042_platform_init(void)
@@ -116,18 +126,10 @@ static int __init i8042_platform_init(void)
 		if (!kbd_iobase)
 			return -ENODEV;
 	} else {
-		int err = platform_driver_register(&sparc_i8042_driver);
+		int err = platform_driver_probe(&sparc_i8042_driver,
+						sparc_i8042_probe);
 		if (err)
 			return err;
-
-		if (i8042_kbd_irq == -1 ||
-		    i8042_aux_irq == -1) {
-			if (kbd_iobase) {
-				of_iounmap(kbd_res, kbd_iobase, 8);
-				kbd_iobase = (void __iomem *) NULL;
-			}
-			return -ENODEV;
-		}
 	}
 
 	i8042_reset = 1;
-- 
Dmitry
