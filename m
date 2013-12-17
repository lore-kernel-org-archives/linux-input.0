From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH V2] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Tue, 17 Dec 2013 12:16:01 -0800
Message-ID: <1387311361-29411-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:58635 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab3LQUQF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 15:16:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This patch fixes two bugs in handling of the RMI4 attention line GPIO.

1) in enable_sensor(), make sure the attn_gpio is defined before attempting to
get its value.

2) in rmi_driver_probe(), declare the name of the attn_gpio, then
request the attn_gpio before attempting to export it.

Also introduces a GPIO_LABEL constant for identifying the attention GPIO.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index a30c7d3..33fb8f8 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -169,7 +169,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 
 	data->enabled = true;
 
-	if (!pdata->level_triggered &&
+	if (pdata->attn_gpio && !pdata->level_triggered &&
 		    gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity)
 		retval = process_interrupt_requests(rmi_dev);
 
@@ -807,6 +807,8 @@ static int rmi_driver_remove(struct device *dev)
 	return 0;
 }
 
+static const char GPIO_LABEL[] = "attn";
+
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
@@ -959,20 +961,24 @@ static int rmi_driver_probe(struct device *dev)
 	}
 
 	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
-		retval = gpio_export(pdata->attn_gpio, false);
+		retval = gpio_request(pdata->attn_gpio, GPIO_LABEL);
 		if (retval) {
-			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
-			retval = 0;
+			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code: %d.\n",
+				pdata->attn_gpio, retval);
 		} else {
-			retval = gpio_export_link(dev,
-						  "attn", pdata->attn_gpio);
+			retval = gpio_export(pdata->attn_gpio, false);
 			if (retval) {
-				dev_warn(dev,
-					"WARNING: Failed to symlink ATTN gpio!\n");
-				retval = 0;
+				dev_warn(dev, "WARNING: Failed to export ATTN gpio %d, code: %d.\n",
+					pdata->attn_gpio, retval);
 			} else {
-				dev_info(dev, "Exported ATTN GPIO %d.",
-					pdata->attn_gpio);
+				retval = gpio_export_link(dev, GPIO_LABEL,
+							  pdata->attn_gpio);
+				if (retval)
+					dev_warn(dev,
+						"WARNING: Failed to symlink ATTN gpio!\n");
+				else
+					dev_info(dev, "Exported ATTN GPIO %d.",
+						pdata->attn_gpio);
 			}
 		}
 	}
