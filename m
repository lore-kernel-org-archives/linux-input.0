From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH 6/7] mfd: cros_ec: Instantiate sub-devices from device tree
Date: Mon, 28 Jul 2014 14:19:26 +0200
Message-ID: <1406549967-21291-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406549967-21291-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

If the EC device tree node has sub-nodes, try to instantiate them as
MFD sub-devices.  We can configure the EC features provided by the board.

Signed-off-by: Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/mfd/cros_ec.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 634c434..96c926c 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mfd/core.h>
+#include <linux/of_platform.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/delay.h>
@@ -109,22 +110,16 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
 static const struct mfd_cell cros_devs[] = {
-	{
-		.name = "cros-ec-keyb",
-		.id = 1,
-		.of_compatible = "google,cros-ec-keyb",
-	},
-	{
-		.name = "cros-ec-i2c-tunnel",
-		.id = 2,
-		.of_compatible = "google,cros-ec-i2c-tunnel",
-	},
 };
 
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
 	int err = 0;
+#ifdef CONFIG_OF
+	struct device_node *node;
+	int id = ARRAY_SIZE(cros_devs);
+#endif
 
 	if (ec_dev->din_size) {
 		ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
@@ -146,6 +141,31 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		dev_err(dev, "failed to add mfd devices\n");
 		return err;
 	}
+#ifdef CONFIG_OF
+	/*
+	 * Add sub-devices declared in the device tree.  NOTE they should NOT be
+	 * declared in cros_devs
+	 */
+	for_each_child_of_node(dev->of_node, node) {
+		char name[128];
+		struct mfd_cell cell = {
+			.id = 0,
+			.name = name,
+		};
+
+		if (of_modalias_node(node, name, sizeof(name)) < 0) {
+			dev_err(dev, "modalias failure on %s\n",
+				node->full_name);
+			continue;
+		}
+		dev_dbg(dev, "adding MFD sub-device %s\n", node->name);
+		cell.of_compatible = of_get_property(node, "compatible", NULL);
+		err = mfd_add_devices(dev, ++id, &cell, 1, NULL, ec_dev->irq,
+				      NULL);
+		if (err)
+			dev_err(dev, "fail to add %s\n", node->full_name);
+	}
+#endif
 
 	dev_info(dev, "Chrome EC device registered\n");
 
-- 
2.0.0.rc2
