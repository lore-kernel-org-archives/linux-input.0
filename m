From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Added support for pressure on the Stantum multitouch
 panel
Date: Sat, 06 Feb 2010 15:20:03 +0100
Message-ID: <20100206142003.9B86A9520A@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:33283 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab0BFOUE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Feb 2010 09:20:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: chatty@enac.fr

Added pressure handling for Stantum multitouch panels

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN a/drivers/hid/hid-stantum.c b/drivers/hid/hid-stantum.c
--- a/drivers/hid/hid-stantum.c	2010-02-06 15:01:17.000000000 +0100
+++ b/drivers/hid/hid-stantum.c	2010-02-06 15:03:45.000000000 +0100
@@ -16,7 +16,7 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 
-MODULE_VERSION("1.01");
+MODULE_VERSION("1.02");
 MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
 MODULE_DESCRIPTION("Stantum HID multitouch panels");
 MODULE_LICENSE("GPL");
@@ -66,7 +66,6 @@ static int stantum_input_mapping(struct 
 		case HID_DG_DEVICEINDEX:
 		case HID_DG_CONTACTCOUNT:
 		case HID_DG_CONTACTMAX:
-		case HID_DG_TIPPRESSURE:
 			return -1;
 
 		case HID_DG_TIPSWITCH:
@@ -84,6 +83,11 @@ static int stantum_input_mapping(struct 
 			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
 					1, 1, 0, 0);
 			return 1;
+		case HID_DG_TIPPRESSURE:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_PRESSURE);
+			return 1;
+
 		case HID_DG_CONTACTID:
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_TRACKING_ID);
@@ -140,10 +144,7 @@ static void stantum_filter_event(struct 
 	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, wide ? sd->w : sd->h);
 	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, wide ? sd->h : sd->w);
 
-#if 0
-	/* MT_PRESSURE does not exist yet */
 	input_event(input, EV_ABS, ABS_MT_PRESSURE, sd->z);
-#endif
 
 	input_mt_sync(input);
 	sd->valid = false;
