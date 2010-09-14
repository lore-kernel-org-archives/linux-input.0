From: Philipp Merkel <mail@philmerk.de>
Subject: [PATCH] Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 14 Sep 2010 17:08:39 +0200
Message-ID: <1284476919.3732.10.camel@PhEeeTab>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.planet-school.de ([194.116.187.5]:38732 "EHLO
	turboconrad.planet-school.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751555Ab0INPPV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 11:15:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chatty@enac.fr
Cc: linux-input@vger.kernel.org

This patch fixes three problems with the eGalax/DWAV multi-touch
screen found in the Eee PC T101MT:

1) While there is a dedicated multitouch driver for the screen
   (hid-egalax.c), the MULTI_INPUT quirk is also applied, preventing
   the hid-egalax driver from working. This patch removes the quirk
   so the hid-egalax driver can handle the device correctly.
2) The x and y coordinates sent by the screen in multi-touch mode are
   shifted by three bits from the events sent in single-touch mode, thus
   the coordinates are out of range, leading to the pointer being stuck
   in the bottom-right corner if no additional calibration is applied
   (e.g. in the X evdev driver). This patch shifts the coordinates back.
   This does not decrease accuracy as the last three bits of the "wrong"
   coordinates are always 0.
3) Only multi-touch pressure events are sent, single touch emulation is
   missing pressure information. This patch adds single-touch
   ABS_PRESSURE events. 

Signed-off-by: Philipp Merkel <mail@philmerk.de>

diff -ru a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
--- a/drivers/hid/usbhid/hid-quirks.c	2010-08-27 18:41:20.000000000 +0200
+++ b/drivers/hid/usbhid/hid-quirks.c	2010-08-27 18:42:07.000000000 +0200
@@ -33,7 +33,6 @@
 	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },

diff -ru a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
--- a/drivers/hid/hid-egalax.c	2010-08-27 18:48:17.851442000 +0200
+++ b/drivers/hid/hid-egalax.c	2010-08-29 11:26:02.385106000 +0200
@@ -31,7 +31,7 @@
 	bool first;		/* is this the first finger in the frame? */
 	bool valid;		/* valid finger data, or just placeholder? */
 	bool activity;		/* at least one active finger previously? */
-	__u16 lastx, lasty;	/* latest valid (x, y) in the frame */
+	__u16 lastx, lasty, lastz;	/* latest valid (x, y, z) in the frame */
 };
 
 static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -79,6 +79,10 @@
 		case HID_DG_TIPPRESSURE:
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
+			/* touchscreen emulation */
+			input_set_abs_params(hi->input, ABS_PRESSURE,
+						field->logical_minimum,
+						field->logical_maximum, 0, 0);
 			return 1;
 		}
 		return 0;
@@ -109,8 +113,8 @@
 	if (td->valid) {
 		/* emit multitouch events */
 		input_event(input, EV_ABS, ABS_MT_TRACKING_ID, td->id);
-		input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
-		input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
+		input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x >> 3);
+		input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y >> 3);
 		input_event(input, EV_ABS, ABS_MT_PRESSURE, td->z);
 
 		input_mt_sync(input);
@@ -121,6 +125,7 @@
 		 */
 		td->lastx = td->x;
 		td->lasty = td->y;
+		td->lastz = td->z;
 	}
 
 	/*
@@ -129,8 +134,9 @@
 	 * the oldest on the panel, the one we want for single touch
 	 */
 	if (!td->first && td->activity) {
-		input_event(input, EV_ABS, ABS_X, td->lastx);
-		input_event(input, EV_ABS, ABS_Y, td->lasty);
+		input_event(input, EV_ABS, ABS_X, td->lastx >> 3);
+		input_event(input, EV_ABS, ABS_Y, td->lasty >> 3);
+ 		input_event(input, EV_ABS, ABS_PRESSURE, td->lastz);
 	}
 
 	if (!td->valid) {


