From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 6/7] Input: pixcir_i2c_ts: Implement wakeup from suspend
Date: Mon, 5 May 2014 12:04:37 +0300
Message-ID: <1399280678-23925-7-git-send-email-rogerq@ti.com>
References: <1399280678-23925-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399280678-23925-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, mugunthanvnm-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Improve the suspend and resume handlers to allow the device
to wakeup the system from suspend.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 53 ++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 927aed1..5f6a27e 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -348,21 +348,66 @@ static void pixcir_input_close(struct input_dev *dev)
 static int pixcir_i2c_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct pixcir_i2c_ts_data *ts = i2c_get_clientdata(client);
+	struct input_dev *input = ts->input;
+	int ret = 0;
+
+	mutex_lock(&input->mutex);
+
+	if (input->users) {
+		ret = pixcir_stop(ts);
+		if (ret)
+			goto unlock;
+	}
+
+	/*
+	 * If wakeup is enabled we need to enable interrupt generation
+	 * but don't need to process any reports i.e. ts->exiting must be true.
+	 */
+	if (device_may_wakeup(&client->dev)) {
+		/* enable wakeup interrupt generation */
+		ret = pixcir_int_enable(ts, 1);
+		if (ret) {
+			dev_err(dev, "Failed to enable interrupt generation\n");
+			goto unlock;
+		}
 
-	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
+	}
 
-	return 0;
+unlock:
+	mutex_unlock(&input->mutex);
+
+	return ret;
 }
 
 static int pixcir_i2c_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct pixcir_i2c_ts_data *ts = i2c_get_clientdata(client);
+	struct input_dev *input = ts->input;
+	int ret = 0;
 
-	if (device_may_wakeup(&client->dev))
+	mutex_lock(&input->mutex);
+
+	if (device_may_wakeup(&client->dev)) {
 		disable_irq_wake(client->irq);
 
-	return 0;
+		/* disable wakeup interrupt generation */
+		ret = pixcir_int_enable(ts, 0);
+		if (ret) {
+			dev_err(dev, "Failed to disable interrupt generation\n");
+			goto unlock;
+		}
+	}
+
+	if (input->users)
+		ret = pixcir_start(ts);
+
+unlock:
+	mutex_unlock(&input->mutex);
+
+	return ret;
 }
 #endif
 
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
