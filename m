From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] Input: gpio-keys - fix unbalanced call pair for err handle
Date: Tue,  2 Feb 2016 10:58:19 +0800
Message-ID: <1454381899-18725-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:56740 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcBBDDA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Feb 2016 22:03:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

If we fail to get pdata, we should not directly break
from the for_each_available_child_of_node since it calls of_node_get
while iterating. This patch add of_node_put to fix the unbalanced
call pair.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/input/keyboard/gpio_keys.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2909365..87744d3 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -661,7 +661,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 					dev_err(dev,
 						"Failed to get gpio flags, error: %d\n",
 						error);
-				return ERR_PTR(error);
+				goto err_out;
 			}
 		} else {
 			button->active_low = flags & OF_GPIO_ACTIVE_LOW;
@@ -671,13 +671,15 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 		if (!gpio_is_valid(button->gpio) && !button->irq) {
 			dev_err(dev, "Found button without gpios or irqs\n");
-			return ERR_PTR(-EINVAL);
+			error = -EINVAL;
+			goto err_out;
 		}
 
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
 			dev_err(dev, "Button without keycode: 0x%x\n",
 				button->gpio);
-			return ERR_PTR(-EINVAL);
+			error = -EINVAL;
+			goto err_out;
 		}
 
 		button->desc = of_get_property(pp, "label", NULL);
@@ -700,6 +702,10 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		return ERR_PTR(-EINVAL);
 
 	return pdata;
+
+err_out:
+	of_node_put(pp);
+	return ERR_PTR(error);
 }
 
 static const struct of_device_id gpio_keys_of_match[] = {
-- 
2.3.7


