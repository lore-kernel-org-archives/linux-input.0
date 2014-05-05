From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 3/7] Input: pixcir_i2c_ts: Get rid of pdata->attb_read_val()
Date: Mon, 5 May 2014 12:04:34 +0300
Message-ID: <1399280678-23925-4-git-send-email-rogerq@ti.com>
References: <1399280678-23925-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399280678-23925-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, mugunthanvnm-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Get rid of the attb_read_val() platform hook. Instead,
read the ATTB gpio directly from the driver.

Fail if valid ATTB gpio is not provided by patform data.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 16 +++++++++++++++-
 include/linux/input/pixcir_ts.h           |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 53d01d4..d0f6989 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/pixcir_ts.h>
+#include <linux/gpio.h>
 
 struct pixcir_i2c_ts_data {
 	struct i2c_client *client;
@@ -87,11 +88,12 @@ static void pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)
 static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
 {
 	struct pixcir_i2c_ts_data *tsdata = dev_id;
+	const struct pixcir_ts_platform_data *pdata = tsdata->chip;
 
 	while (!tsdata->exiting) {
 		pixcir_ts_poscheck(tsdata);
 
-		if (tsdata->chip->attb_read_val())
+		if (gpio_get_value(pdata->gpio_attb))
 			break;
 
 		msleep(20);
@@ -296,6 +298,11 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 	if (!pdata) {
 		dev_err(&client->dev, "platform data not defined\n");
 		return -EINVAL;
+	} else {
+		if (!gpio_is_valid(pdata->gpio_attb)) {
+			dev_err(dev, "Invalid gpio_attb in pdata\n");
+			return -EINVAL;
+		}
 	}
 
 	tsdata = devm_kzalloc(dev, sizeof(*tsdata), GFP_KERNEL);
@@ -328,6 +335,13 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 
 	input_set_drvdata(input, tsdata);
 
+	error = devm_gpio_request_one(dev, pdata->gpio_attb,
+				      GPIOF_DIR_IN, "pixcir_i2c_attb");
+	if (error) {
+		dev_err(dev, "Failed to request ATTB gpio\n");
+		return error;
+	}
+
 	error = devm_request_threaded_irq(dev, client->irq, NULL, pixcir_ts_isr,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					  client->name, tsdata);
diff --git a/include/linux/input/pixcir_ts.h b/include/linux/input/pixcir_ts.h
index 7942804..160cf35 100644
--- a/include/linux/input/pixcir_ts.h
+++ b/include/linux/input/pixcir_ts.h
@@ -44,9 +44,9 @@ enum pixcir_int_mode {
 #define PIXCIR_INT_POL_HIGH	(1UL << 2)
 
 struct pixcir_ts_platform_data {
-	int (*attb_read_val)(void);
 	int x_max;
 	int y_max;
+	int gpio_attb;		/* GPIO connected to ATTB line */
 };
 
 #endif
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
