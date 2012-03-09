From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH] HID: wacom: Add reporting of wheel for Intuos4 WL
Date: Fri,  9 Mar 2012 20:27:42 +0000
Message-ID: <1331324862-15989-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:42311 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030273Ab2CIU2K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Mar 2012 15:28:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: killertofu@gmail.com, pinglinux@gmail.com, jkosina@suse.cz
Cc: linuxwacom-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

This patch adds reporting of ABS_WHEEL event. Raported walues are 0..71
and are related to absolute location of the finger on the wheel.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
Reviewed-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/hid-wacom.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 5c25036..dab7588 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -36,6 +36,7 @@
 struct wacom_data {
 	__u16 tool;
 	__u16 butstate;
+	__u8 whlstate;
 	__u8 features;
 	__u32 id;
 	__u32 serial;
@@ -322,6 +323,23 @@ static void wacom_i4_parse_button_report(struct wacom_data *wdata,
 			struct input_dev *input, unsigned char *data)
 {
 	__u16 new_butstate;
+	__u8 new_whlstate;
+	__u8 sync = 0;
+
+	new_whlstate = data[1];
+	if (new_whlstate != wdata->whlstate) {
+		wdata->whlstate = new_whlstate;
+		if (new_whlstate & 0x80) {
+			input_report_key(input, BTN_TOUCH, 1);
+			input_report_abs(input, ABS_WHEEL, (new_whlstate & 0x7f));
+			input_report_key(input, BTN_TOOL_FINGER, 1);
+		} else {
+			input_report_key(input, BTN_TOUCH, 0);
+			input_report_abs(input, ABS_WHEEL, 0);
+			input_report_key(input, BTN_TOOL_FINGER, 0);
+		}
+		sync = 1;
+	}
 
 	new_butstate = (data[3] << 1) | (data[2] & 0x01);
 	if (new_butstate != wdata->butstate) {
@@ -336,6 +354,10 @@ static void wacom_i4_parse_button_report(struct wacom_data *wdata,
 		input_report_key(input, BTN_7, new_butstate & 0x080);
 		input_report_key(input, BTN_8, new_butstate & 0x100);
 		input_report_key(input, BTN_TOOL_FINGER, 1);
+		sync = 1;
+	}
+
+	if (sync) {
 		input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
 		input_event(input, EV_MSC, MSC_SERIAL, 0xffffffff);
 		input_sync(input);
@@ -512,6 +534,9 @@ static int wacom_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		input_set_abs_params(input, ABS_DISTANCE, 0, 32, 0, 0);
 		break;
 	case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
+		__set_bit(ABS_WHEEL, input->absbit);
+		input_set_abs_params(input, ABS_WHEEL, 0, 71, 0, 0);
+		input_set_capability(input, EV_MSC, MSC_SERIAL);
 		__set_bit(ABS_MISC, input->absbit);
 		__set_bit(BTN_2, input->keybit);
 		__set_bit(BTN_3, input->keybit);
-- 
1.7.6.4

