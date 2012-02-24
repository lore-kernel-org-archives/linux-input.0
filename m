From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 2/2] HID: wacom: Add serial and id reporting for Wacom Intuos4 WL
Date: Fri, 24 Feb 2012 13:52:32 +0000
Message-ID: <1330091552-9011-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:47462 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752012Ab2BXNwv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 08:52:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, pinglinux@gmail.com, chris@cnpbagwell.com
Cc: linuxwacom-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

This patch implements reporting id and serial number of used tool.
Reported values are the same as for USB on of the driver for wacom Intuos4 WL

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/hid/hid-wacom.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index a793753..49b9178 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -35,6 +35,8 @@ struct wacom_data {
 	__u16 tool;
 	unsigned char butstate;
 	__u8 features;
+	__u32 id;
+	__u32 serial;
 	unsigned char high_speed;
 #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	int battery_capacity;
@@ -318,26 +320,30 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 			struct input_dev *input, unsigned char *data)
 {
 	__u16 x, y, pressure;
-	__u32 id;
 
 	switch (data[1]) {
 	case 0x80: /* Out of proximity report */
 		input_report_key(input, BTN_TOUCH, 0);
 		input_report_abs(input, ABS_PRESSURE, 0);
 		input_report_key(input, wdata->tool, 0);
+		input_report_abs(input, ABS_MISC, 0);
+		input_event(input, EV_MSC, MSC_SERIAL, wdata->serial);
 		wdata->tool = 0;
 		input_sync(input);
 		break;
 	case 0xC2: /* Tool report */
-		id = ((data[2] << 4) | (data[3] >> 4) |
+		wdata->id = ((data[2] << 4) | (data[3] >> 4) |
 			((data[7] & 0x0f) << 20) |
-			((data[8] & 0xf0) << 12)) & 0xfffff;
+			((data[8] & 0xf0) << 12));
+		wdata->serial = ((data[3] & 0x0f) << 28) +
+				(data[4] << 20) + (data[5] << 12) +
+				(data[6] << 4) + (data[7] >> 4);
 
-		switch (id) {
-		case 0x802:
+		switch (wdata->id) {
+		case 0x100802:
 			wdata->tool = BTN_TOOL_PEN;
 			break;
-		case 0x80A:
+		case 0x10080A:
 			wdata->tool = BTN_TOOL_RUBBER;
 			break;
 		}
@@ -356,6 +362,9 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 		input_report_abs(input, ABS_X, x);
 		input_report_abs(input, ABS_Y, y);
 		input_report_abs(input, ABS_PRESSURE, pressure);
+		input_report_abs(input, ABS_MISC, wdata->id);
+		input_event(input, EV_MSC, MSC_SERIAL, wdata->serial);
+		input_report_key(input, wdata->tool, 1);
 		input_sync(input);
 		break;
 	}
-- 
1.7.6.4

