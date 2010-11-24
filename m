From: Simon Wood <simon@mungewell.org>
Subject: [PATCH] USB HID Add support for F430 Force Feedback Wheel
Date: Tue, 23 Nov 2010 22:49:43 -0700
Message-ID: <1290577783-5756-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:33655 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0KXFuT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 00:50:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: aorefice77@gmail.com, ospite@studenti.unina.it, Simon Wood <simon@mungewell.org>

This patch adds USB IDs to enable force feedback on the Thrustmaster
F430 wheel.

Antonio did the work, I just converted to git patch to include in Kernel.

Reported by: "Antonio Orefice" <aorefice77@gmail.com>
Signed-off by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-tmff.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 515345b..88cb04e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1386,6 +1386,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb653) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED2, USB_DEVICE_ID_TOPSEED2_RF_COMBO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TWINHAN, USB_DEVICE_ID_TWINHAN_IR_REMOTE) },
diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index 15434c8..25be4e1 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -256,6 +256,8 @@ static const struct hid_device_id tm_devices[] = {
 		.driver_data = (unsigned long)ff_joystick },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654),	/* FGT Force Feedback Wheel */
 		.driver_data = (unsigned long)ff_joystick },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a),	/* F430 Force Feedback Wheel */
+		.driver_data = (unsigned long)ff_joystick },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, tm_devices);
-- 
1.7.0.4

