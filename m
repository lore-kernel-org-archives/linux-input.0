From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 31/33] Input: rohm_bu21023 - Use 'dev' instead of dereferencing it and other changes
Date: Wed, 18 Jan 2017 12:36:48 -0800
Message-ID: <1484771819-13761-2-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484771819-13761-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484771819-13761-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Use local variable 'dev' instead of dereferencing it several times.
Other relevant changes:
  Replace devm_add_action() with devm_add_action_or_reset()

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace devm_add_action() followed by failure action with
  devm_add_action_or_reset()
- Use local variable 'struct device *dev' consistently

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/rohm_bu21023.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index 611156a2ef80..cce3ef94c1ab 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -1166,9 +1166,9 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_request_threaded_irq(dev, client->irq,
-					  NULL, rohm_ts_soft_irq,
-					  IRQF_ONESHOT, client->name, ts);
+	error = devm_request_threaded_irq(dev, client->irq, NULL,
+					  rohm_ts_soft_irq, IRQF_ONESHOT,
+					  client->name, ts);
 	if (error) {
 		dev_err(dev, "failed to request IRQ: %d\n", error);
 		return error;
@@ -1186,11 +1186,9 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(dev, rohm_ts_remove_sysfs_group, dev);
+	error = devm_add_action_or_reset(dev, rohm_ts_remove_sysfs_group, dev);
 	if (error) {
-		rohm_ts_remove_sysfs_group(dev);
-		dev_err(&client->dev,
-			"Failed to add sysfs cleanup action: %d\n",
+		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
 	}
-- 
2.7.4
