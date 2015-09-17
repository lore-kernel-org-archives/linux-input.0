From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] input: gpio_keys_polled: Add support for abs/rel axis
Date: Thu, 17 Sep 2015 18:14:40 -0400
Message-ID: <1442528080-28712-2-git-send-email-hdegoede@redhat.com>
References: <1442528080-28712-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbbIQWO4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 18:14:56 -0400
In-Reply-To: <1442528080-28712-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Add support for EV_ABS / EV_REL events to the gpio-keys-polled driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Fix commit message to actually describe what the patch does
 (fix patch squashing fail)
---
 drivers/input/keyboard/gpio_keys_polled.c | 88 +++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 870cfa6..62bdb1d 100644
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
 		button->wakeup =
 			fwnode_property_read_bool(child, "wakeup-source") ||
 			/* legacy name */
@@ -168,6 +214,25 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
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
@@ -274,6 +339,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 						pdata->poll_interval);
 
 		input_set_capability(input, type, button->code);
+		if (type == EV_ABS)
+			gpio_keys_polled_set_abs_params(input, pdata,
+							button->code);
 	}
 
 	bdev->poll_dev = poll_dev;
@@ -290,9 +358,11 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
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

