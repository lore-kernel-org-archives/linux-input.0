From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 6/7] mfd: cros_ec: Instantiate sub-devices from device tree
Date: Mon, 25 Aug 2014 15:40:07 +0200
Message-ID: <1408974008-17184-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:46166 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365AbaHYNki (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 09:40:38 -0400
In-Reply-To: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

From: Todd Broch <tbroch@chromium.org>

If the EC device tree node has sub-nodes, try to instantiate them as
MFD sub-devices.  We can configure the EC features provided by the board.

Signed-off-by: Todd Broch <tbroch@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1:
 - Don't leave an empty struct mfd_cell array. Suggested by Lee Jones.
 - Just use of_platform_populate() instead of manually iterating through
   sub-devices and calling mfd_add_devices. Suggested by Lee Jones.
---
 drivers/mfd/cros_ec.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index cd0c93c..ab70791 100644
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
@@ -107,22 +108,12 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
-static const struct mfd_cell cros_devs[] = {
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
-};
-
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
+#ifdef CONFIG_OF
+	struct device_node *node = dev->of_node;
+#endif
 	int err = 0;
 
 	if (ec_dev->din_size) {
@@ -138,13 +129,19 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	mutex_init(&ec_dev->lock);
 
-	err = mfd_add_devices(dev, 0, cros_devs,
-			      ARRAY_SIZE(cros_devs),
-			      NULL, ec_dev->irq, NULL);
-	if (err) {
-		dev_err(dev, "failed to add mfd devices\n");
-		return err;
+#ifdef CONFIG_OF
+	/*
+	 * Add sub-devices declared in the device tree.  NOTE they should NOT be
+	 * declared in cros_devs
+	 */
+	if (node) {
+		err = of_platform_populate(node, NULL, NULL, dev);
+		if (err) {
+			dev_err(dev, "fail to add %s\n", node->full_name);
+			return err;
+		}
 	}
+#endif
 
 	dev_info(dev, "Chrome EC device registered\n");
 
-- 
2.0.1

