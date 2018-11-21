From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] Input: i8042 add of_node_put()
Date: Wed, 21 Nov 2018 09:35:13 -0500
Message-ID: <20181121143513.22961-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-input@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/input/serio/i8042-sparcio.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..5495bc035518 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -108,18 +108,21 @@ static struct platform_driver sparc_i8042_driver = {
 
 static int __init i8042_platform_init(void)
 {
+	int rc;
 	struct device_node *root = of_find_node_by_path("/");
 
 	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
-		if (!kbd_iobase)
-			return -ENODEV;
+		if (!kbd_iobase){
+			rc = -ENODEV;
+			goto out;
+		}
 	} else {
-		int err = platform_driver_register(&sparc_i8042_driver);
-		if (err)
-			return err;
+		rc = platform_driver_register(&sparc_i8042_driver);
+		if (rc)
+			goto out;
 
 		if (i8042_kbd_irq == -1 ||
 		    i8042_aux_irq == -1) {
@@ -127,13 +130,18 @@ static int __init i8042_platform_init(void)
 				of_iounmap(kbd_res, kbd_iobase, 8);
 				kbd_iobase = (void __iomem *) NULL;
 			}
-			return -ENODEV;
+			rc = -ENODEV;
+			goto out;
 		}
 	}
 
 	i8042_reset = I8042_RESET_ALWAYS;
 
-	return 0;
+	rc = 0;
+out:
+	of_node_put(root);
+
+	return rc;
 }
 
 static inline void i8042_platform_exit(void)
@@ -142,6 +150,8 @@ static inline void i8042_platform_exit(void)
 
 	if (strcmp(root->name, "SUNW,JavaStation-1"))
 		platform_driver_unregister(&sparc_i8042_driver);
+
+	of_node_put(root);
 }
 
 #else /* !CONFIG_PCI */
-- 
2.17.0
