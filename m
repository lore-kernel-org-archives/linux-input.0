From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 1/3] HID: hid-sony: Add BT support for Navigation Controller
Date: Wed, 17 Jun 2015 00:08:51 -0600
Message-ID: <1434521333-9035-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39187 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540AbbFQGJ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2015 02:09:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-sony.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 044e96a..a64f862 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1962,6 +1962,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2ce0295..3fba2dca 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2287,6 +2287,8 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = SIXAXIS_CONTROLLER_USB },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER),
+		.driver_data = SIXAXIS_CONTROLLER_BT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER),
 		.driver_data = MOTION_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER),
-- 
2.1.4

