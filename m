From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] Input: pixcir_i2c_ts: remove wakeirq related code from pixcir driver
Date: Wed, 14 Oct 2015 11:23:56 +0530
Message-ID: <1444802036-18005-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Henrik Rydberg <rydberg@bitmath.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Vignesh R <vigneshr@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

With commit 3fffd1283927 ("i2c: allow specifying separate wakeup
interrupt in device tree") wakeirq is managed by i2c-core, so remove
wakeirq related code from pixcir_i2c_ts driver.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 91621725bfb5..4b961ad9f0b5 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -377,8 +377,6 @@ static int __maybe_unused pixcir_i2c_ts_suspend(struct device *dev)
 				goto unlock;
 			}
 		}
-
-		enable_irq_wake(client->irq);
 	} else if (input->users) {
 		ret = pixcir_stop(ts);
 	}
@@ -399,7 +397,6 @@ static int __maybe_unused pixcir_i2c_ts_resume(struct device *dev)
 	mutex_lock(&input->mutex);
 
 	if (device_may_wakeup(&client->dev)) {
-		disable_irq_wake(client->irq);
 
 		if (!input->users) {
 			ret = pixcir_stop(ts);
@@ -564,14 +561,6 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 		return error;
 
 	i2c_set_clientdata(client, tsdata);
-	device_init_wakeup(&client->dev, 1);
-
-	return 0;
-}
-
-static int pixcir_i2c_ts_remove(struct i2c_client *client)
-{
-	device_init_wakeup(&client->dev, 0);
 
 	return 0;
 }
@@ -609,7 +598,6 @@ static struct i2c_driver pixcir_i2c_ts_driver = {
 		.of_match_table = of_match_ptr(pixcir_of_match),
 	},
 	.probe		= pixcir_i2c_ts_probe,
-	.remove		= pixcir_i2c_ts_remove,
 	.id_table	= pixcir_i2c_ts_id,
 };
 
-- 
2.6.1
