From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 2/6] hid: sony: Add the product ID for the Sony Motion Controller
Date: Tue,  5 May 2015 20:47:29 -0400
Message-ID: <1430873253-11765-3-git-send-email-frank.praznik@oh.rr.com>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:61115 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755018AbbEFAt5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 20:49:57 -0400
In-Reply-To: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

Adds the PID for the Sony motion controller to the hardware ID list.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 722a925..2cb9ac7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1961,6 +1961,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41f167e..14fcb11 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -851,6 +851,7 @@
 #define USB_DEVICE_ID_SONY_PS3_BDREMOTE		0x0306
 #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
+#define USB_DEVICE_ID_SONY_MOTION_CONTROLLER	0x03d5
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
-- 
2.1.0

