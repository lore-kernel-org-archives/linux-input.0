From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 6/8] Input: pixcir_i2c_ts: Implement wakeup from suspend
Date: Wed, 26 Feb 2014 17:28:04 +0200
Message-ID: <1393428486-15001-7-git-send-email-rogerq@ti.com>
References: <1393428486-15001-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393428486-15001-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, jcbian@pixcir.com.cn, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-input@vger.kernel.org

Improve the suspend and resume handlers to allow the device
to wakeup the system from suspend.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 46 ++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index b1e92f6..8ca258b 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -345,21 +345,59 @@ static void pixcir_input_close(struct input_dev *dev)
 static int pixcir_i2c_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct pixcir_i2c_ts_data *ts = i2c_get_clientdata(client);
+	struct input_dev *input = ts->input;
+	int ret = 0;
+
+	mutex_lock(&input->mutex);
+
+	if (device_may_wakeup(&client->dev)) {
+		/* need to start device if not open, to be wakeup source */
+		if (!input->users) {
+			ret = pixcir_start(ts);
+			if (ret)
+				goto unlock;
+		}
 
-	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
 
-	return 0;
+	} else if (input->users) {
+		ret = pixcir_stop(ts);
+	}
+
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
+
+	mutex_lock(&input->mutex);
 
-	if (device_may_wakeup(&client->dev))
+	if (device_may_wakeup(&client->dev)) {
 		disable_irq_wake(client->irq);
 
-	return 0;
+		/* need to stop device if it was not open on suspend */
+		if (!input->users) {
+			ret = pixcir_stop(ts);
+			if (ret)
+				goto unlock;
+		}
+
+	} else if (input->users) {
+		ret = pixcir_start(ts);
+	}
+
+unlock:
+	mutex_unlock(&input->mutex);
+
+	return ret;
 }
 #endif
 
-- 
1.8.3.2
