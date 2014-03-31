From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v2 1/3] Input: synaptics-rmi4 - add F11 capabilities for touchpads
Date: Mon, 31 Mar 2014 14:11:05 -0700
Message-ID: <1396300267-5108-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:42348 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbaCaVLM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2014 17:11:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

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
 drivers/input/rmi4/rmi_f11.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 8709abe..92eac8a 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -717,7 +717,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 		if (sensor->data.rel_pos)
 			rmi_f11_rel_pos_report(sensor, i);
 	}
-	input_mt_sync(sensor->input);
+	input_mt_sync_frame(sensor->input);
 	input_sync(sensor->input);
 }
 
@@ -1104,13 +1104,10 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
 	/* We assume touchscreen unless demonstrably a touchpad or specified
 	 * as a touchpad in the platform data
 	 */
-	if (sensor->sensor_type == rmi_f11_sensor_touchpad ||
-			(sensor->sens_query.has_info2 &&
-				!sensor->sens_query.is_clear))
-		input_flags = INPUT_PROP_POINTER;
+	if (sensor->sensor_type == rmi_f11_sensor_touchpad)
+		input_flags = INPUT_MT_POINTER;
 	else
-		input_flags = INPUT_PROP_DIRECT;
-	set_bit(input_flags, input->propbit);
+		input_flags = INPUT_MT_DIRECT;
 
 	if (sensor->axis_align.swap_axes) {
 		int temp = device_x_max;
@@ -1220,11 +1217,20 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		return rc;
 	}
 
+	if (sensor->sens_query.has_info2) {
+		if (sensor->sens_query.is_clear)
+			sensor->sensor_type = rmi_f11_sensor_touchscreen;
+		else
+			sensor->sensor_type = rmi_f11_sensor_touchpad;
+	}
+
 	if (pdata->f11_sensor_data) {
 		sensor->axis_align =
 			pdata->f11_sensor_data->axis_align;
 		sensor->type_a = pdata->f11_sensor_data->type_a;
-		sensor->sensor_type =
+
+		if (sensor->sensor_type == rmi_f11_sensor_default)
+			sensor->sensor_type =
 				pdata->f11_sensor_data->sensor_type;
 	}
 
@@ -1490,6 +1496,7 @@ static struct rmi_function_handler rmi_f11_handler = {
 module_rmi_driver(rmi_f11_handler);
 
 MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
+MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com");
 MODULE_DESCRIPTION("RMI F11 module");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(RMI_DRIVER_VERSION);
-- 
1.8.3.2

