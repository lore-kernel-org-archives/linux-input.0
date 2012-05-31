From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2] input: wacom: Report correct touch contact size for I5/Bamboo
Date: Wed, 30 May 2012 17:08:42 -0700
Message-ID: <1338422922-1461-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39353 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab2EaAIx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 May 2012 20:08:53 -0400
Received: by pbbrp8 with SMTP id rp8so652017pbb.19
        for <linux-input@vger.kernel.org>; Wed, 30 May 2012 17:08:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

This changes how the touch packets for Intuos5 and 3rd-gen Bamboo
are interpreted, so that proper values for the MAJOR and MINOR
axes are reported. Instead of using the amplitude field (data[6]),
we use the size field (data[5]) and do some calculation to
transform it from a scaled-down area into axis lengths.

Note that even though we assume a circular contact, both MAJOR and
MINOR are reported since the resolution of the X and Y axes differ.
---
 Changes from v1:
   * Changed name from "Use touch size for ABS_MT_TOUCH_MAJOR"

   * Also populate ABS_MT_TOUCH_MINOR to avoid some userspace
     assumptions.

   * Experimentally determined the calculations necessary to produce
     proper values instead of simply using the raw value in data[5].

 drivers/input/tablet/wacom_wac.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 004bc1b..940caf3 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -25,6 +25,11 @@
 #define WACOM_INTUOS_RES	100
 #define WACOM_INTUOS3_RES	200
 
+/* Scale factor relating reported contact size to logical contact area.
+ * 2^14/pi is a good approximation on Intuos5 and 3rd-gen Bamboo
+ */
+#define WACOM_CONTACT_AREA_SCALE 5215
+
 static int wacom_penpartner_irq(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
@@ -1036,11 +1041,21 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 	if (touch) {
 		int x = (data[2] << 4) | (data[4] >> 4);
 		int y = (data[3] << 4) | (data[4] & 0x0f);
-		int w = data[6];
+		int a = data[5];
+
+		// "a" is a scaled-down area which we assume is roughly
+		// circular and which can be described as: a*C=(pi*r^2).
+		int x_res = input_abs_get_res(input, ABS_X);
+		int y_res = input_abs_get_res(input, ABS_Y);
+		int logical_diameter  = 2 * int_sqrt(a * WACOM_CONTACT_AREA_SCALE);
+		int physical_diameter = logical_diameter / ((x_res + y_res) / 2);
+		int logical_width  = physical_diameter * x_res;
+		int logical_height = physical_diameter * y_res;
 
 		input_report_abs(input, ABS_MT_POSITION_X, x);
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
-		input_report_abs(input, ABS_MT_TOUCH_MAJOR, w);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, logical_width);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, logical_height);
 	}
 }
 
@@ -1520,7 +1535,9 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_mt_init_slots(input_dev, features->touch_max);
 
 			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-			                     0, 255, 0, 0);
+			                     0, features->x_max, 0, 0);
+			input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
+			                     0, features->y_max, 0, 0);
 
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, features->x_max,
@@ -1625,7 +1642,10 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 				input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MAJOR,
-						     0, 255, 0, 0);
+						     0, features->x_max, 0, 0);
+				input_set_abs_params(input_dev,
+						     ABS_MT_TOUCH_MINOR,
+						     0, features->y_max, 0, 0);
 			}
 
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-- 
1.7.10.2

