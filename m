From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] input: keyboard: cap11xx: Add missing of_node_put
Date: Mon, 25 Jan 2016 21:01:21 +0530
Message-ID: <20160125153121.GA21093@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33506 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcAYPb1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2016 10:31:27 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr

for_each_child_of_node performs an of_node_get on each iteration, so
to break out of the loop an of_node_put is required.

Found using Coccinelle. The semantic patch used for this is as follows:

// <smpl>
@@
expression e;
local idexpression n;
@@

 for_each_child_of_node(..., n) {
   ... when != of_node_put(n)
       when != e = n
(
   return n;
|
+  of_node_put(n);
?  return ...;
)
   ...
 }
// </smpl

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 378db10..27cd7df 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -304,8 +304,10 @@ static int cap11xx_init_leds(struct device *dev,
 		led->cdev.brightness = LED_OFF;
 
 		error = of_property_read_u32(child, "reg", &reg);
-		if (error != 0 || reg >= num_leds)
-			return -EINVAL;
+		if (error != 0 || reg >= num_leds) {
+			error = -EINVAL;
+			goto putchild;
+		}
 
 		led->reg = reg;
 		led->priv = priv;
@@ -314,13 +316,17 @@ static int cap11xx_init_leds(struct device *dev,
 
 		error = devm_led_classdev_register(dev, &led->cdev);
 		if (error)
-			return error;
+			goto putchild;
 
 		priv->num_leds++;
 		led++;
 	}
 
 	return 0;
+
+putchild:
+	of_node_put(child);
+	return error;
 }
 #else
 static int cap11xx_init_leds(struct device *dev,
-- 
1.9.1

