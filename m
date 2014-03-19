From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 1/3] Input: synaptics-rmi4 - add capabilities for touchpads
Date: Tue, 18 Mar 2014 18:03:49 -0700
Message-ID: <1395191031-3144-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:23255 "EHLO
	us-mx2.synaptics.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1758366AbaCSBE0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 21:04:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

When the device is a touchpad additional capabilities need to
be set and reported.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Acked-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---
 drivers/input/rmi4/rmi_f11.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 8709abe..07044d79 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -688,6 +688,9 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
 	/* MT sync between fingers */
 	if (sensor->type_a)
 		input_mt_sync(sensor->input);
+
+	if (sensor->sensor_type == rmi_f11_sensor_touchpad)
+		input_mt_report_pointer_emulation(sensor->input, true);
 }
 
 static void rmi_f11_finger_handler(struct f11_data *f11,
@@ -717,7 +720,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 		if (sensor->data.rel_pos)
 			rmi_f11_rel_pos_report(sensor, i);
 	}
-	input_mt_sync(sensor->input);
+	input_report_key(sensor->input, BTN_TOUCH, finger_pressed_count);
 	input_sync(sensor->input);
 }
 
@@ -1137,6 +1140,9 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
 	dev_dbg(&fn->dev, "Set ranges X=[%d..%d] Y=[%d..%d].",
 			x_min, x_max, y_min, y_max);
 
+	input_set_abs_params(input, ABS_X, x_min, x_max, 0, 0);
+	input_set_abs_params(input, ABS_Y, y_min, y_max, 0, 0);
+
 	input_set_abs_params(input, ABS_MT_PRESSURE, 0,
 			DEFAULT_MAX_ABS_MT_PRESSURE, 0, 0);
 	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,
@@ -1374,6 +1380,15 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
 		set_bit(BTN_RIGHT, input_dev_mouse->keybit);
 	}
 
+	if (sensor->sensor_type == rmi_f11_sensor_touchpad) {
+		set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+		set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+		set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
+		set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
+		set_bit(BTN_TOOL_QUINTTAP, input_dev->keybit);
+	}
+
+
 	return 0;
 
 error_unregister:
-- 
1.8.3.2

