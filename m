From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/33] Input: cap11xx - Drop unnecessary call to i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 09:46:24 -0800
Message-ID: <1484761614-12225-4-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Amitoj Kaur Chawla <amitoj1606@gmail.com>
List-Id: linux-input@vger.kernel.org

There is no call to i2c_get_clientdata() or dev_get_drvdata().
Drop the unnecessary call to i2c_set_clientdata().
Other relevant changes:
  Simplify error return

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'if (e) return e; return 0;' with 'return e;'
- Drop i2c_set_clientdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/cap11xx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 4401be225d64..9cbba2dd0e29 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -189,11 +189,11 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 	 */
 	ret = regmap_update_bits(priv->regmap, CAP11XX_REG_MAIN_CONTROL, 1, 0);
 	if (ret < 0)
-		goto out;
+		return IRQ_HANDLED;
 
 	ret = regmap_read(priv->regmap, CAP11XX_REG_SENSOR_INPUT, &status);
 	if (ret < 0)
-		goto out;
+		return IRQ_HANDLED;
 
 	for (i = 0; i < priv->idev->keycodemax; i++)
 		input_report_key(priv->idev, priv->keycodes[i],
@@ -201,7 +201,6 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 
 	input_sync(priv->idev);
 
-out:
 	return IRQ_HANDLED;
 }
 
@@ -392,7 +391,6 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 		return error;
 
 	dev_info(dev, "CAP11XX detected, revision 0x%02x\n", rev);
-	i2c_set_clientdata(i2c_client, priv);
 	node = dev->of_node;
 
 	if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
@@ -476,12 +474,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 		return -ENXIO;
 	}
 
-	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
-					  IRQF_ONESHOT, dev_name(dev), priv);
-	if (error)
-		return error;
-
-	return 0;
+	return devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
+					 IRQF_ONESHOT, dev_name(dev), priv);
 }
 
 static const struct of_device_id cap11xx_dt_ids[] = {
-- 
2.7.4
