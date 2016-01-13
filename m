From: Scott Moreau <oreaus@gmail.com>
Subject: [PATCH 1/2] HID: sony: Add nyko core controller support
Date: Wed, 13 Jan 2016 07:40:42 -0700
Message-ID: <1452696043-18362-1-git-send-email-oreaus@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35736 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbcAMOkr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 09:40:47 -0500
Received: by mail-oi0-f66.google.com with SMTP id e195so19896311oig.2
        for <linux-input@vger.kernel.org>; Wed, 13 Jan 2016 06:40:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: ao2@ao2.it, jkosina@suse.cz, frank.praznik@oh.rr.com, Scott Moreau <oreaus@gmail.com>

This adds rumble and LED support for nyko core controllers
using the sino lite chip vendor:1345 product:3008, for PS3.

Setting operational mode and output reports are the same as
sixaxis but the input report has a different format since the
PS3 accepts HID usb devices. For it to work, an exception is
needed to skip overriding the report descriptor and use the
original one.

Signed-off-by: Scott Moreau <oreaus@gmail.com>
---

For proper functionality, this patch depends on
http://article.gmane.org/gmane.linux.kernel.input/47590

 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 3 +++
 drivers/hid/hid-sony.c | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a69..bcaf96e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2008,6 +2008,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8b78a7f..a6b2dee 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -869,6 +869,9 @@
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
 
+#define USB_VENDOR_ID_SINO_LITE			0x1345
+#define USB_DEVICE_ID_SINO_LITE_CONTROLLER	0x3008
+
 #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST	0x0034
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST	0x0046
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 774cd22..ea13de0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -50,6 +50,7 @@
 #define MOTION_CONTROLLER_BT      BIT(8)
 #define NAVIGATION_CONTROLLER_USB BIT(9)
 #define NAVIGATION_CONTROLLER_BT  BIT(10)
+#define SINO_LITE_CONTROLLER      BIT(11)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -1116,6 +1117,9 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	if (sc->quirks & SINO_LITE_CONTROLLER)
+		return rdesc;
+
 	/*
 	 * Some Sony RF receivers wrongly declare the mouse pointer as a
 	 * a constant non-data variable.
@@ -2458,6 +2462,9 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = DUALSHOCK4_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
 		.driver_data = DUALSHOCK4_CONTROLLER_BT },
+	/* Nyko Core Controller for PS3 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER),
+		.driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
-- 
2.5.0

