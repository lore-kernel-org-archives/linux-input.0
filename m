From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3] input: wacom: Report correct touch contact size for I5/Bamboo
Date: Mon, 24 Sep 2012 12:45:46 -0700
Message-ID: <1348515946-1674-1-git-send-email-killertofu@gmail.com>
References: <CAGzDe_Y6RUs7Y29zNEFdf7Oja_wmQtNijY09qSctf9hVzm9pig@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43186 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570Ab2IXTqT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 15:46:19 -0400
Received: by pbbrr4 with SMTP id rr4so7727365pbb.19
        for <linux-input@vger.kernel.org>; Mon, 24 Sep 2012 12:46:19 -0700 (PDT)
In-Reply-To: <CAGzDe_Y6RUs7Y29zNEFdf7Oja_wmQtNijY09qSctf9hVzm9pig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, chris@cnpbagwell.com, pinglinux@gmail.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

This changes how the touch packets for Intuos5 and 3rd-gen Bamboo
are interpreted, so that proper values for the MAJOR and MINOR
axes are reported. Instead of using the amplitude field (data[6]),
we use the size field (data[5]) and do some calculation to
transform it from a scaled-down area into axis lengths.

Note that even though we assume a circular contact, both MAJOR and
MINOR are reported since the resolution of the X and Y axes differ.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Changes from v2:
 * Modified WACOM_CONTACT_AREA_SCALE so that we can calculate the
   width directly, rather than going through an intermediate
   logical_diameter and physical_diameter.

 drivers/input/tablet/wacom_wac.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 532d067..2543169 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -25,6 +25,11 @@
 #define WACOM_INTUOS_RES	100
 #define WACOM_INTUOS3_RES	200
 
+/* Scale factor relating reported contact size to logical contact area.
+ * 2^14/pi is a good approximation on Intuos5 and 3rd-gen Bamboo
+ */
+#define WACOM_CONTACT_AREA_SCALE 2607
+
 static int wacom_penpartner_irq(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
@@ -1043,11 +1048,19 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 	if (touch) {
 		int x = (data[2] << 4) | (data[4] >> 4);
 		int y = (data[3] << 4) | (data[4] & 0x0f);
-		int w = data[6];
+		int a = data[5];
+
+		// "a" is a scaled-down area which we assume is roughly
+		// circular and which can be described as: a=(pi*r^2)/C.
+		int x_res  = input_abs_get_res(input, ABS_X);
+		int y_res  = input_abs_get_res(input, ABS_Y);
+		int width  = 2 * int_sqrt(a * WACOM_CONTACT_AREA_SCALE);
+		int height = width * y_res / x_res;
 
 		input_report_abs(input, ABS_MT_POSITION_X, x);
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
-		input_report_abs(input, ABS_MT_TOUCH_MAJOR, w);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, width);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, height);
 	}
 }
 
@@ -1533,7 +1546,9 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_mt_init_slots(input_dev, features->touch_max);
 
 			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-			                     0, 255, 0, 0);
+			                     0, features->x_max, 0, 0);
+			input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
+			                     0, features->y_max, 0, 0);
 
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, features->x_max,
@@ -1641,7 +1656,10 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
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
1.7.12

