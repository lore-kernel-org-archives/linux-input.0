From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 10/26] Input: synaptics-rmi4 - f11: allow the top software button property to be set
Date: Thu, 5 Nov 2015 15:39:40 -0800
Message-ID: <1446766780-30669-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:65024 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965349AbbKEXjs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 18:39:48 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Currently, in PS/2 we only have the PNPIds list to detect the property.
Unfortunately, it looks like the information is not embeded in the RMI4
protocol either, so allow the Top software buttons property to be set
in the platform data.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 5 +++++
 include/linux/rmi.h          | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 768c199..02e3a6b 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -515,6 +515,7 @@ struct f11_2d_sensor {
 	int pkt_size;
 	u8 sensor_index;
 	u32 type_a;	/* boolean but debugfs API requires u32 */
+	bool topbuttonpad;
 	enum rmi_f11_sensor_type sensor_type;
 	struct input_dev *input;
 	bool unified_input;
@@ -1285,6 +1286,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		sensor->axis_align =
 			pdata->f11_sensor_data->axis_align;
 		sensor->type_a = pdata->f11_sensor_data->type_a;
+		sensor->topbuttonpad = pdata->f11_sensor_data->topbuttonpad;
 
 		if (sensor->sens_query.has_physical_props) {
 			sensor->x_mm = sensor->sens_query.x_sensor_size_mm;
@@ -1409,6 +1411,9 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
 	if (sensor->report_abs)
 		f11_set_abs_params(fn, f11);
 
+	if (sensor->topbuttonpad)
+		set_bit(INPUT_PROP_TOPBUTTONPAD, input_dev->propbit);
+
 	if (sensor->report_rel) {
 		set_bit(EV_REL, input_dev->evbit);
 		set_bit(REL_X, input_dev->relbit);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index b771f41..4ffe9fe 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -93,6 +93,8 @@ enum rmi_f11_sensor_type {
  * available.
  * @disable_report_mask - Force data to not be reported even if it is supported
  * by the firware.
+ * @topbuttonpad - Used with the "5 buttons touchpads" found on the Lenovo 40
+ * series
  */
 struct rmi_f11_sensor_data {
 	struct rmi_f11_2d_axis_alignment axis_align;
@@ -101,6 +103,7 @@ struct rmi_f11_sensor_data {
 	int x_mm;
 	int y_mm;
 	int disable_report_mask;
+	bool topbuttonpad;
 };
 
 /**
-- 
2.1.4

