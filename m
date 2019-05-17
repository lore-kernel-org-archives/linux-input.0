From: Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 1/2] Input: atmel_mxt_ts - add wakeup support
Date: Fri, 17 May 2019 23:17:40 +0200
Message-ID: <20190517211741.8906-1-stefano.manni@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Stefano Manni <stefano.manni@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add wakeup support to the maxtouch driver.
The device can wake up the system from suspend,
mark the IRQ as wakeup capable, so that device
irq is not disabled during system suspend.

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 5c63d25ce84e..2e0abc0b665d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3041,6 +3041,7 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
 static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct mxt_data *data;
+	struct device_node *node = client->dev.of_node;
 	int error;
 
 	/*
@@ -3125,6 +3126,12 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto err_free_object;
 	}
 
+	if (node) {
+		if (of_property_read_bool(node, "wakeup-source") ||
+			of_property_read_bool(node, "linux,wakeup"))
+			device_init_wakeup(&client->dev, true);
+	}
+
 	return 0;
 
 err_free_object:
@@ -3156,6 +3163,9 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+
 	if (input_dev->users)
 		mxt_stop(data);
 
@@ -3175,6 +3185,9 @@ static int __maybe_unused mxt_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+
 	if (input_dev->users)
 		mxt_start(data);
 
-- 
2.20.1
