From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/7] touchscreen: icn8318: Use
 parse_properties and apply_prop_to_x_y helpers
Date: Fri, 20 Nov 2015 14:24:48 +0100
Message-ID: <1448025892-20899-4-git-send-email-hdegoede@redhat.com>
References: <1448025892-20899-1-git-send-email-hdegoede@redhat.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORBPF6XSZAKGQE5435CJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1448025892-20899-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Use the touchscreen_parse_properties and touchscreen_apply_prop_to_x_y
functions, instead of DIY code, this results in a nice cleanup.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
-Call input_set_capability() before calling touchscreen_parse_properties()
---
 drivers/input/touchscreen/chipone_icn8318.c | 58 +++++++----------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 22a6fea..92151f9 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
@@ -52,11 +53,7 @@ struct icn8318_data {
 	struct i2c_client *client;
 	struct input_dev *input;
 	struct gpio_desc *wake_gpio;
-	u32 max_x;
-	u32 max_y;
-	bool invert_x;
-	bool invert_y;
-	bool swap_x_y;
+	struct touchscreen_properties prop;
 };
 
 static int icn8318_read_touch_data(struct i2c_client *client,
@@ -91,7 +88,8 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 	struct icn8318_data *data = dev_id;
 	struct device *dev = &data->client->dev;
 	struct icn8318_touch_data touch_data;
-	int i, ret, x, y;
+	int i, ret;
+	s16 x, y;
 
 	ret = icn8318_read_touch_data(data->client, &touch_data);
 	if (ret < 0) {
@@ -127,19 +125,9 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 		x = be16_to_cpu(touch->x);
 		y = be16_to_cpu(touch->y);
 
-		if (data->invert_x)
-			x = data->max_x - x;
-
-		if (data->invert_y)
-			y = data->max_y - y;
-
-		if (!data->swap_x_y) {
-			input_event(data->input, EV_ABS, ABS_MT_POSITION_X, x);
-			input_event(data->input, EV_ABS, ABS_MT_POSITION_Y, y);
-		} else {
-			input_event(data->input, EV_ABS, ABS_MT_POSITION_X, y);
-			input_event(data->input, EV_ABS, ABS_MT_POSITION_Y, x);
-		}
+		touchscreen_apply_prop_to_x_y(&data->prop, &x, &y);
+		input_event(data->input, EV_ABS, ABS_MT_POSITION_X, x);
+		input_event(data->input, EV_ABS, ABS_MT_POSITION_Y, y);
 	}
 
 	input_mt_sync_frame(data->input);
@@ -200,10 +188,8 @@ static int icn8318_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	struct device_node *np = dev->of_node;
 	struct icn8318_data *data;
 	struct input_dev *input;
-	u32 fuzz_x = 0, fuzz_y = 0;
 	int error;
 
 	if (!client->irq) {
@@ -223,19 +209,6 @@ static int icn8318_probe(struct i2c_client *client,
 		return error;
 	}
 
-	if (of_property_read_u32(np, "touchscreen-size-x", &data->max_x) ||
-	    of_property_read_u32(np, "touchscreen-size-y", &data->max_y)) {
-		dev_err(dev, "Error touchscreen-size-x and/or -y missing\n");
-		return -EINVAL;
-	}
-
-	/* Optional */
-	of_property_read_u32(np, "touchscreen-fuzz-x", &fuzz_x);
-	of_property_read_u32(np, "touchscreen-fuzz-y", &fuzz_y);
-	data->invert_x = of_property_read_bool(np, "touchscreen-inverted-x");
-	data->invert_y = of_property_read_bool(np, "touchscreen-inverted-y");
-	data->swap_x_y = of_property_read_bool(np, "touchscreen-swapped-x-y");
-
 	input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
@@ -246,16 +219,13 @@ static int icn8318_probe(struct i2c_client *client,
 	input->close = icn8318_stop;
 	input->dev.parent = dev;
 
-	if (!data->swap_x_y) {
-		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
-				     data->max_x, fuzz_x, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
-				     data->max_y, fuzz_y, 0);
-	} else {
-		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
-				     data->max_y, fuzz_y, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
-				     data->max_x, fuzz_x, 0);
+	input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
+	input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
+	touchscreen_parse_properties(input, true, &data->prop);
+	if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
+	    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
+		dev_err(dev, "Error touchscreen-size-x and/or -y missing\n");
+		return -EINVAL;
 	}
 
 	error = input_mt_init_slots(input, ICN8318_MAX_TOUCHES,
-- 
2.5.0
