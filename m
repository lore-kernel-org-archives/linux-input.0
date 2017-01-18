From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 29/33] Input: melfas_mip4 - Use devm_add_action_or_reset and other changes
Date: Wed, 18 Jan 2017 09:46:50 -0800
Message-ID: <1484761614-12225-30-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59124 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753402AbdARRtB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 12:49:01 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Sangwon Jee <jeesw@melfas.com>

Replace devm_add_action() followed by failure action with
devm_add_action_or_reset()

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace devm_add_action() followed by failure action with
  devm_add_action_or_reset()
- Replace 'goto l; ... l: return e;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/melfas_mip4.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 703d7f983d0a..3cad6f72dbf8 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -594,7 +594,7 @@ static irqreturn_t mip4_interrupt(int irq, void *dev_id)
 	if (error) {
 		dev_err(&client->dev,
 			"Failed to read packet info: %d\n", error);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	size = ts->buf[0] & 0x7F;
@@ -604,7 +604,7 @@ static irqreturn_t mip4_interrupt(int irq, void *dev_id)
 	/* Check size */
 	if (!size) {
 		dev_err(&client->dev, "Empty packet\n");
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	/* Read packet data */
@@ -614,7 +614,7 @@ static irqreturn_t mip4_interrupt(int irq, void *dev_id)
 	if (error) {
 		dev_err(&client->dev,
 			"Failed to read packet data: %d\n", error);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	if (alert) {
@@ -629,7 +629,6 @@ static irqreturn_t mip4_interrupt(int irq, void *dev_id)
 		input_sync(ts->input);
 	}
 
-out:
 	return IRQ_HANDLED;
 }
 
@@ -1531,9 +1530,8 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
-	error = devm_add_action(&client->dev, mip4_sysfs_remove, ts);
+	error = devm_add_action_or_reset(&client->dev, mip4_sysfs_remove, ts);
 	if (error) {
-		mip4_sysfs_remove(ts);
 		dev_err(&client->dev,
 			"Failed to install sysfs remoce action: %d\n", error);
 		return error;
-- 
2.7.4

