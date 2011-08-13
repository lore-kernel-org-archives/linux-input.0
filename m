From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/5] input: wacom - remove pressure for touch devices
Date: Fri, 12 Aug 2011 17:08:29 -0700
Message-ID: <1313194109-4987-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43150 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1HMAGw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 20:06:52 -0400
Received: by gxk21 with SMTP id 21so2319628gxk.19
        for <linux-input@vger.kernel.org>; Fri, 12 Aug 2011 17:06:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Touch devices do not report valid pressure or capacitance.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |   14 --------------
 drivers/input/tablet/wacom_wac.c |    6 +++---
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 449c0a4..36001eb 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -228,13 +228,6 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 							get_unaligned_le16(&report[i + 3]);
 						i += 4;
 					}
-				} else if (usage == WCM_DIGITIZER) {
-					/* max pressure isn't reported
-					features->pressure_max = (unsigned short)
-							(report[i+4] << 8  | report[i + 3]);
-					*/
-					features->pressure_max = 255;
-					i += 4;
 				}
 				break;
 
@@ -290,13 +283,6 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 				pen = 1;
 				i++;
 				break;
-
-			case HID_USAGE_UNDEFINED:
-				if (usage == WCM_DESKTOP && finger) /* capacity */
-					features->pressure_max =
-						get_unaligned_le16(&report[i + 3]);
-				i += 4;
-				break;
 			}
 			break;
 
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c1c2f7b..3eccf21 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -818,7 +818,6 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 				x <<= 5;
 				y <<= 5;
 			}
-			input_report_abs(input, ABS_MT_PRESSURE, p);
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
 		}
@@ -1056,10 +1055,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			     features->x_fuzz, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, features->y_max,
 			     features->y_fuzz, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max,
-			     features->pressure_fuzz, 0);
 
 	if (features->device_type == BTN_TOOL_PEN) {
+		input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max,
+			     features->pressure_fuzz, 0);
+
 		/* penabled devices have fixed resolution for each model */
 		input_abs_set_res(input_dev, ABS_X, features->x_resolution);
 		input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
-- 
1.7.6

