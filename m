From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Added support for the new 3M multitouch 22" display
Date: Sun, 11 Apr 2010 14:51:24 +0200
Message-ID: <20100411125124.D2C72951EF@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:43559 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0DKMv1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 08:51:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: dsuljic@mmm.com, chatty@enac.fr

Now support the 22" display and its updated firmware, including touch
width and height.

The number of touches can now go up to 60, and our single touch emulation
will fail when there are more than 6-7 touches; further work is needed on
this.

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN a/drivers/hid/hid-3m-pct.c b/drivers/hid/hid-3m-pct.c
--- a/drivers/hid/hid-3m-pct.c	2010-03-20 02:17:57.000000000 +0100
+++ b/drivers/hid/hid-3m-pct.c	2010-04-11 15:15:30.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  HID driver for 3M PCT multitouch panels
  *
- *  Copyright (c) 2009 Stephane Chatty <chatty@enac.fr>
+ *  Copyright (c) 2009-2010 Stephane Chatty <chatty@enac.fr>
  *
  */
 
@@ -24,7 +24,7 @@ MODULE_LICENSE("GPL");
 #include "hid-ids.h"
 
 struct mmm_finger {
-	__s32 x, y;
+	__s32 x, y, w, h;
 	__u8 rank;
 	bool touch, valid;
 };
@@ -81,7 +81,18 @@ static int mmm_input_mapping(struct hid_
 			/* touchscreen emulation */
 			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
 			return 1;
+		case HID_DG_WIDTH:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TOUCH_MAJOR);
+			return 1;
+		case HID_DG_HEIGHT:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TOUCH_MINOR);
+			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
+					1, 1, 0, 0);
+			return 1;
 		case HID_DG_CONTACTID:
+			field->logical_maximum = 59;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_TRACKING_ID);
 			return 1;
@@ -127,9 +138,15 @@ static void mmm_filter_event(struct mmm_
 			/* this finger is just placeholder data, ignore */
 		} else if (f->touch) {
 			/* this finger is on the screen */
+			int wide = (f->w > f->h);
 			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, i);
 			input_event(input, EV_ABS, ABS_MT_POSITION_X, f->x);
 			input_event(input, EV_ABS, ABS_MT_POSITION_Y, f->y);
+			input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR,
+						wide ? f->w : f->h);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR,
+						wide ? f->h : f->w);
 			input_mt_sync(input);
 			/*
 			 * touchscreen emulation: maintain the age rank
@@ -196,6 +213,14 @@ static int mmm_event(struct hid_device *
 		case HID_DG_CONFIDENCE:
 			md->valid = value;
 			break;
+		case HID_DG_WIDTH:
+			if (md->valid)
+				md->f[md->curid].w = value;
+			break;
+		case HID_DG_HEIGHT:
+			if (md->valid)
+				md->f[md->curid].h = value;
+			break;
 		case HID_DG_CONTACTID:
 			if (md->valid) {
 				md->curid = value;
@@ -254,6 +279,7 @@ static void mmm_remove(struct hid_device
 
 static const struct hid_device_id mmm_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M1968) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M2256) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mmm_devices);
@@ -286,5 +312,4 @@ static void __exit mmm_exit(void)
 
 module_init(mmm_init);
 module_exit(mmm_exit);
-MODULE_LICENSE("GPL");
 
diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2010-04-11 15:06:34.000000000 +0200
+++ b/drivers/hid/hid-core.c	2010-04-11 14:49:32.000000000 +0200
@@ -1251,6 +1251,7 @@ EXPORT_SYMBOL_GPL(hid_disconnect);
 /* a list of devices for which there is a specialized driver on HID bus */
 static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M1968) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M2256) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_X5_005D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
diff -rupN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2010-04-11 15:06:47.000000000 +0200
+++ b/drivers/hid/hid-ids.h	2010-04-11 14:50:34.000000000 +0200
@@ -20,6 +20,7 @@
 
 #define USB_VENDOR_ID_3M		0x0596
 #define USB_DEVICE_ID_3M1968		0x0500
+#define USB_DEVICE_ID_3M2256		0x0502
 
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
