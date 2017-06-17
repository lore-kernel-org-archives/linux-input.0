From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] Input: icn8318 - Add support for capacative home button
Date: Sat, 17 Jun 2017 12:58:34 +0200
Message-ID: <20170617105834.16255-4-hdegoede@redhat.com>
References: <20170617105834.16255-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbdFQK6m (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Jun 2017 06:58:42 -0400
In-Reply-To: <20170617105834.16255-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Some x86 tablets with an icn8505 touchscreen have a capacative home
button, add support for this.

Note that it turns out the removed comment turns out to be inaccurate,
yes when the capacative home button is pressed the touch info contains
invalid data, but touch_count is set to 0 so this is not a problem and
if both the button is used and a finger is touching the normal
touchscreen area then there is valid touch data.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/chipone_icn8318.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index b209872954f7..2209ccf596f3 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -64,6 +64,7 @@ struct icn8318_data {
 	struct gpio_desc *wake_gpio;
 	struct touchscreen_properties prop;
 	enum icn8318_model model;
+	int softbutton;
 };
 
 static int icn8318_read_touch_data(struct icn8318_data *data,
@@ -122,15 +123,9 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (touch_data.softbutton) {
-		/*
-		 * Other data is invalid when a softbutton is pressed.
-		 * This needs some extra devicetree bindings to map the icn8318
-		 * softbutton codes to evdev codes. Currently no known devices
-		 * use this.
-		 */
-		return IRQ_HANDLED;
-	}
+	if (data->softbutton)
+		input_report_key(data->input, data->softbutton,
+				 touch_data.softbutton == 0x01);
 
 	if (touch_data.touch_count > ICN8318_MAX_TOUCHES) {
 		dev_warn(dev, "Too much touches %d > %d\n",
@@ -268,6 +263,7 @@ static int icn8318_probe_acpi(struct icn8318_data *data, struct device *dev)
 	if (strcmp(sub, "HAMP0002") == 0) {
 		input_set_abs_params(input, ABS_MT_POSITION_X, 0, 1199, 0, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 1919, 0, 0);
+		data->softbutton = KEY_LEFTMETA;
 	} else {
 		dev_err(dev, "Unknown model _SUB: %s\n", sub);
 		kfree(buf.pointer);
@@ -339,6 +335,9 @@ static int icn8318_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
+	if (data->softbutton)
+		input_set_capability(data->input, EV_KEY, data->softbutton);
+
 	error = input_mt_init_slots(input, ICN8318_MAX_TOUCHES,
 				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 	if (error)
-- 
2.13.0

