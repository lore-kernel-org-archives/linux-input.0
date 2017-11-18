From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: Support the Fujitsu R726 Pad dock using hid-rmi
Date: Fri, 17 Nov 2017 17:21:30 -0800
Message-ID: <1510968090-24764-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:18475
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1423909AbdKRBVq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 20:21:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

The Fujitsu R726 Pad has an optional USB keyboard dock which contains
a Synaptics touchpad. The dock identifies itself as a
Primax Rezel Tablet Keyboard.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 drivers/hid/hid-rmi.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 330ca98..caacbab 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2253,6 +2253,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_RMI)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_REZEL) },
 #endif
 #if IS_ENABLED(CONFIG_HID_ROCCAT)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_ARVO) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index be2e005..81c0915 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1146,6 +1146,7 @@
 #define USB_VENDOR_ID_PRIMAX	0x0461
 #define USB_DEVICE_ID_PRIMAX_MOUSE_4D22	0x4d22
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD	0x4e05
+#define USB_DEVICE_ID_PRIMAX_REZEL	0x4e72
 
 
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index ef241d6..a2731f8 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -724,6 +724,7 @@ static const struct hid_device_id rmi_id[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14),
 		.driver_data = RMI_DEVICE_HAS_PHYS_BUTTONS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_REZEL) },
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_RMI, HID_ANY_ID, HID_ANY_ID) },
 	{ }
 };
-- 
2.7.4

