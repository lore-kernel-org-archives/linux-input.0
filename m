From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v2] Input: gpio_keys - Use of_property_read_u32
Date: Mon, 19 Sep 2011 11:09:51 +0200
Message-ID: <1316423391-20219-1-git-send-email-tklauser@distanz.ch>
References: <1314775945-6822-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:52506 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab1ISJJx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 05:09:53 -0400
In-Reply-To: <1314775945-6822-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-input@vger.kernel.org

Use the of_property_read_u32 helper function to retreive u32 values
from the device tree. Also do not pass the len parameter to
of_get_property if it isn't checked afterwards.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
v2: Fix build failure caused by a missing opening brace (reported by
    Stephen Rothwell)

 drivers/input/keyboard/gpio_keys.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 67df91a..e913294 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -462,7 +462,6 @@ static int gpio_keys_get_devtree_pdata(struct device *dev,
 	int i;
 	struct gpio_keys_button *buttons;
 	const u32 *reg;
-	int len;
 
 	node = dev->of_node;
 	if (node == NULL)
@@ -470,7 +469,7 @@ static int gpio_keys_get_devtree_pdata(struct device *dev,
 
 	memset(pdata, 0, sizeof *pdata);
 
-	pdata->rep = !!of_get_property(node, "autorepeat", &len);
+	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
 
 	/* First count the subnodes */
 	pdata->nbuttons = 0;
@@ -498,22 +497,25 @@ static int gpio_keys_get_devtree_pdata(struct device *dev,
 		buttons[i].gpio = of_get_gpio_flags(pp, 0, &flags);
 		buttons[i].active_low = flags & OF_GPIO_ACTIVE_LOW;
 
-		reg = of_get_property(pp, "linux,code", &len);
-		if (!reg) {
+		if (of_property_read_u32(pp, "linux,code", &reg)) {
 			dev_err(dev, "Button without keycode: 0x%x\n", buttons[i].gpio);
 			goto out_fail;
 		}
-		buttons[i].code = be32_to_cpup(reg);
+		buttons[i].code = reg;
 
-		buttons[i].desc = of_get_property(pp, "label", &len);
+		buttons[i].desc = of_get_property(pp, "label", NULL);
 
-		reg = of_get_property(pp, "linux,input-type", &len);
-		buttons[i].type = reg ? be32_to_cpup(reg) : EV_KEY;
+		if (of_property_read_u32(pp, "linux,input-type", &reg) == 0)
+			buttons[i].type = reg;
+		else
+			buttons[i].type = EV_KEY;
 
 		buttons[i].wakeup = !!of_get_property(pp, "gpio-key,wakeup", NULL);
 
-		reg = of_get_property(pp, "debounce-interval", &len);
-		buttons[i].debounce_interval = reg ? be32_to_cpup(reg) : 5;
+		if (of_property_read_u32(pp, "debounce-interval", &reg) == 0)
+			buttons[i].debounce_interval = reg;
+		else
+			buttons[i].debounce_interval = 5;
 
 		i++;
 	}
-- 
1.7.5.4

