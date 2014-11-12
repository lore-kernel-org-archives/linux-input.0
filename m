From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] hid: sony: Add support for the third-party SMK PS3 Bluetooth Remote
Date: Wed, 12 Nov 2014 14:52:28 -0500
Message-ID: <1415821948-8468-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:13100 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753331AbaKLTwc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 14:52:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add vid/pid for the SMK branded third-party PS3 Bluetooth remote and enable
support in the hid-sony driver.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 3 +++
 drivers/hid/hid-sony.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 73bd9e2..c8b8691 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1913,6 +1913,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e23ab8b..b2c8a6a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -812,6 +812,9 @@
 #define USB_VENDOR_ID_SKYCABLE			0x1223
 #define	USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER	0x3F07
 
+#define USB_VENDOR_ID_SMK		0x0609
+#define USB_DEVICE_ID_SMK_PS3_BDREMOTE	0x0306
+
 #define USB_VENDOR_ID_SONY			0x054c
 #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
 #define USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE	0x0374
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b6e6102..31e9d25 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2113,6 +2113,9 @@ static const struct hid_device_id sony_devices[] = {
 	/* Logitech Harmony Adapter for PS3 */
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3),
 		.driver_data = PS3REMOTE },
+	/* SMK-Link PS3 BD Remote Control */
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE),
+		.driver_data = PS3REMOTE },
 	/* Sony Dualshock 4 controllers for PS4 */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
 		.driver_data = DUALSHOCK4_CONTROLLER_USB },
-- 
2.1.0

