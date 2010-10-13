From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH 3/4] hid-multitouch: added support for Cypress TrueTouch
 panels
Date: Thu, 14 Oct 2010 00:33:34 +0200
Message-ID: <20101013223334.DFF199522F@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:41476 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0JMWdf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:33:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: chatty@enac.fr

Added support for Cypress TrueTouch panels, which detect up to 10 fingers

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN c/drivers/hid/hid-core.c d/drivers/hid/hid-core.c
--- c/drivers/hid/hid-core.c	2010-10-14 01:29:28.009936912 +0200
+++ d/drivers/hid/hid-core.c	2010-10-14 01:27:36.217937105 +0200
@@ -1301,6 +1301,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_TRUETOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
diff -rupN c/drivers/hid/hid-ids.h d/drivers/hid/hid-ids.h
--- c/drivers/hid/hid-ids.h	2010-10-14 01:29:37.273937194 +0200
+++ d/drivers/hid/hid-ids.h	2010-10-14 01:27:06.485936905 +0200
@@ -176,6 +176,7 @@
 #define USB_DEVICE_ID_CYPRESS_BARCODE_1	0xde61
 #define USB_DEVICE_ID_CYPRESS_BARCODE_2	0xde64
 #define USB_DEVICE_ID_CYPRESS_BARCODE_3	0xbca1
+#define USB_DEVICE_ID_CYPRESS_TRUETOUCH	0xc001
 
 #define USB_VENDOR_ID_DEALEXTREAME	0x10c5
 #define USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701	0x819a
diff -rupN c/drivers/hid/hid-multitouch.c d/drivers/hid/hid-multitouch.c
--- c/drivers/hid/hid-multitouch.c	2010-10-14 01:31:48.572936984 +0200
+++ d/drivers/hid/hid-multitouch.c	2010-10-14 01:32:30.914936993 +0200
@@ -57,6 +57,7 @@ struct mt_class {
 /* classes of device behavior */
 #define DUAL1 0
 #define DUAL2 1
+#define CYPRESS 2
 
 /* contact data that only some devices report */
 #define PRESSURE 	(1 << 0)
@@ -77,10 +78,19 @@ static int slot_from_contactnumber(struc
 	return td->curcontact;
 }
 
+static int cypress_compute_slot(struct mt_device *td)
+{
+	if (td->curcontactid != 0 || td->curcontact == 0)
+		return td->curcontactid;
+	else 
+		return -1;
+}
+
 
 struct mt_class mt_classes[] = {
 	/* DUAL1 */		{ slot_from_contactid, 2, -1 },
 	/* DUAL2 */		{ slot_from_contactnumber, 2, -1 },
+	/* CYPRESS */		{ cypress_compute_slot, 10, 3 },
 };
 
 
@@ -379,6 +389,11 @@ static const struct hid_device_id mt_dev
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
 
+	/* Cypress panel */
+	{ .driver_data = CYPRESS,
+		HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
+			USB_DEVICE_ID_CYPRESS_TRUETOUCH) },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mt_devices);
