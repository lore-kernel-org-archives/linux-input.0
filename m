From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] Input: i8042 fix refcount leak
Date: Sun,  9 Dec 2018 00:19:00 -0500
Message-ID: <20181209051900.19035-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-input@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/input/serio/i8042-sparcio.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..cc6777b4c4ea 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -111,13 +111,17 @@ static int __init i8042_platform_init(void)
 	struct device_node *root = of_find_node_by_path("/");
 
 	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+		of_node_put(root);
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
 		if (!kbd_iobase)
 			return -ENODEV;
 	} else {
-		int err = platform_driver_register(&sparc_i8042_driver);
+		int err;
+
+		of_node_put(root);
+		err = platform_driver_register(&sparc_i8042_driver);
 		if (err)
 			return err;
 
-- 
2.17.0
