From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/4] input: gpio_keys_polled: input_sync once after polling all the buttons
Date: Wed,  9 Sep 2015 11:11:25 +0200
Message-ID: <1441789886-5868-3-git-send-email-hdegoede@redhat.com>
References: <1441789886-5868-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441789886-5868-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

There is no need to do a separate input_sync per changed button. Instead
do the input_sync once after polling all the buttons.

This is a preparation patch for adding support for EV_ABS / EV_REL events.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/keyboard/gpio_keys_polled.c | 88 +++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 097d721..0a80e6f 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -40,10 +40,36 @@ struct gpio_keys_polled_dev {
 	struct input_polled_dev *poll_dev;
 	struct device *dev;
 	const struct gpio_keys_platform_data *pdata;
+	unsigned long rel_axis_seen[BITS_TO_LONGS(REL_CNT)];
+	unsigned long abs_axis_seen[BITS_TO_LONGS(ABS_CNT)];
 	struct gpio_keys_button_data data[0];
 };
 
-static void gpio_keys_polled_check_state(struct input_dev *input,
+static void gpio_keys_button_event(struct input_polled_dev *dev,
+				   struct gpio_keys_button *button,
+				   int state)
+{
+	struct gpio_keys_polled_dev *bdev = dev->private;
+	struct input_dev *input = dev->input;
+	unsigned int type = button->type ?: EV_KEY;
+
+	if (type == EV_REL) {
+		if (state) {
+			input_event(input, type, button->code, button->value);
+			__set_bit(button->code, bdev->rel_axis_seen);
+		}
+	} else if (type == EV_ABS) {
+		if (state) {
+			input_event(input, type, button->code, button->value);
+			__set_bit(button->code, bdev->abs_axis_seen);
+		}
+	} else {
+		input_event(input, type, button->code, state);
+		input_sync(input);
+	}
+}
+
+static void gpio_keys_polled_check_state(struct input_polled_dev *dev,
 					 struct gpio_keys_button *button,
 					 struct gpio_keys_button_data *bdata)
 {
@@ -54,11 +80,9 @@ static void gpio_keys_polled_check_state(struct input_dev *input,
 	else
 		state = !!gpiod_get_value(button->gpiod);
 
-	if (state != bdata->last_state) {
-		unsigned int type = button->type ?: EV_KEY;
+	gpio_keys_button_event(dev, button, state);
 
-		input_event(input, type, button->code, state);
-		input_sync(input);
+	if (state != bdata->last_state) {
 		bdata->count = 0;
 		bdata->last_state = state;
 	}
@@ -71,15 +95,33 @@ static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 	struct input_dev *input = dev->input;
 	int i;
 
+	memset(bdev->rel_axis_seen, 0, sizeof(bdev->rel_axis_seen));
+	memset(bdev->abs_axis_seen, 0, sizeof(bdev->abs_axis_seen));
+
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button_data *bdata = &bdev->data[i];
 
-		if (bdata->count < bdata->threshold)
+		if (bdata->count < bdata->threshold) {
 			bdata->count++;
-		else
-			gpio_keys_polled_check_state(input, &pdata->buttons[i],
+			gpio_keys_button_event(dev, &pdata->buttons[i],
+					       bdata->last_state);
+		} else {
+			gpio_keys_polled_check_state(dev, &pdata->buttons[i],
 						     bdata);
+		}
+	}
+
+	for_each_set_bit(i, input->relbit, REL_CNT) {
+		if (!test_bit(i, bdev->rel_axis_seen))
+			input_event(input, EV_REL, i, 0);
+	}
+
+	for_each_set_bit(i, input->absbit, ABS_CNT) {
+		if (!test_bit(i, bdev->abs_axis_seen))
+			input_event(input, EV_ABS, i, 0);
 	}
+
+	input_sync(input);
 }
 
 static void gpio_keys_polled_open(struct input_polled_dev *dev)
@@ -152,6 +194,10 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 					     &button->type))
 			button->type = EV_KEY;
 
+		if (fwnode_property_read_u32(child, "linux,input-value",
+					     (u32 *)&button->value))
+			button->value = 1;
+
 		button->wakeup = fwnode_property_present(child, "gpio-key,wakeup");
 
 		if (fwnode_property_read_u32(child, "debounce-interval",
@@ -165,6 +211,25 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 	return pdata;
 }
 
+static void gpio_keys_polled_set_abs_params(struct input_dev *input,
+	const struct gpio_keys_platform_data *pdata, unsigned int code)
+{
+	int i, min = 0, max = 0;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_keys_button *button = &pdata->buttons[i];
+
+		if (button->type != EV_ABS || button->code != code)
+			continue;
+
+		if (button->value < min)
+			min = button->value;
+		if (button->value > max)
+			max = button->value;
+	}
+	input_set_abs_params(input, code, min, max, 0, 0);
+}
+
 static const struct of_device_id gpio_keys_polled_of_match[] = {
 	{ .compatible = "gpio-keys-polled", },
 	{ },
@@ -271,6 +336,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 						pdata->poll_interval);
 
 		input_set_capability(input, type, button->code);
+		if (type == EV_ABS)
+			gpio_keys_polled_set_abs_params(input, pdata,
+							button->code);
 	}
 
 	bdev->poll_dev = poll_dev;
@@ -287,9 +355,11 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	/* report initial state of the buttons */
 	for (i = 0; i < pdata->nbuttons; i++)
-		gpio_keys_polled_check_state(input, &pdata->buttons[i],
+		gpio_keys_polled_check_state(poll_dev, &pdata->buttons[i],
 					     &bdev->data[i]);
 
+	input_sync(input);
+
 	return 0;
 }
 
-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
