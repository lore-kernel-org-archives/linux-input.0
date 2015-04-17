From: duson <dusonlin@emc.com.tw>
Subject: [PATCH 6/6] Input: elan_i2c - Add hover detection flag
Date: Fri, 17 Apr 2015 09:56:34 +0800
Message-ID: <E46C75D2-89DF-4483-9225-5817706F6EAC@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:39469 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbDQB4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 21:56:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?big5?B?tsClQMRQ?= <phoenix@emc.com.tw>

When hover event coming, set ABS_MT_DISTANCE as 1, otherwise clear to 0.

Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 6333ba6..da7893f 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -52,6 +52,7 @@
 #define ETP_REPORT_ID_OFFSET	2
 #define ETP_TOUCH_INFO_OFFSET	3
 #define ETP_FINGER_DATA_OFFSET	4
+#define ETP_HOVER_INFO_OFFSET	30
 #define ETP_MAX_REPORT_LEN	34
 
 /* The main device structure */
@@ -725,7 +726,7 @@ static const struct attribute_group *elan_sysfs_groups[] = {
  */
 static void elan_report_contact(struct elan_tp_data *data,
 				int contact_num, bool contact_valid,
-				u8 *finger_data)
+				bool hover_event, u8 *finger_data)
 {
 	struct input_dev *input = data->input;
 	unsigned int pos_x, pos_y;
@@ -769,7 +770,9 @@ static void elan_report_contact(struct elan_tp_data *data,
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
 		input_report_abs(input, ABS_MT_POSITION_X, pos_x);
 		input_report_abs(input, ABS_MT_POSITION_Y, data->max_y - pos_y);
-		input_report_abs(input, ABS_MT_PRESSURE, scaled_pressure);
+		input_report_abs(input, ABS_MT_DISTANCE, hover_event);
+		input_report_abs(input, ABS_MT_PRESSURE,
+				 hover_event ? 0 : scaled_pressure);
 		input_report_abs(input, ABS_TOOL_WIDTH, mk_x);
 		input_report_abs(input, ABS_MT_TOUCH_MAJOR, major);
 		input_report_abs(input, ABS_MT_TOUCH_MINOR, minor);
@@ -785,11 +788,14 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
 	u8 *finger_data = &packet[ETP_FINGER_DATA_OFFSET];
 	int i;
 	u8 tp_info = packet[ETP_TOUCH_INFO_OFFSET];
-	bool contact_valid;
+	u8 hover_info = packet[ETP_HOVER_INFO_OFFSET];
+	bool contact_valid, hover_event;
 
+	hover_event = hover_info & 0x40;
 	for (i = 0; i < ETP_MAX_FINGERS; i++) {
 		contact_valid = tp_info & (1U << (3 + i));
-		elan_report_contact(data, i, contact_valid, finger_data);
+		elan_report_contact(data, i, contact_valid, hover_event,
+				    finger_data);
 
 		if (contact_valid)
 			finger_data += ETP_FINGER_DATA_LEN;
@@ -883,6 +889,7 @@ static int elan_setup_input_device(struct elan_tp_data *data)
 			     ETP_FINGER_WIDTH * max_width, 0, 0);
 	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0,
 			     ETP_FINGER_WIDTH * min_width, 0, 0);
+	input_set_abs_params(input, ABS_MT_DISTANCE, 0, 1, 0, 0);
 
 	data->input = input;
 






