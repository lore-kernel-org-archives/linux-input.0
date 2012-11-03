From: Johannes Thumshirn <morbidrsa@gmail.com>
Subject: [PATCH] hid-apple.c: Set APPLE_ISO_KEYBOARD at USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO
Date: Sat,  3 Nov 2012 10:43:31 +0100
Message-ID: <1351935811-4911-1-git-send-email-morbidrsa@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54626 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab2KCJo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Nov 2012 05:44:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, morbidrsa@googlemail.com

Set APPLE_ISO_KEYBOARD flag on USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO so we get
the ISO translation on German keyboards for the MacBook4,1 as well.

Signed-off-by: Johannes Thumshirn <morbidrsa@googlemail.com>
---
 drivers/hid/hid-apple.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 06ebdbb..5df5e20 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -439,7 +439,8 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO),
-		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
+			APPLE_ISO_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
 			APPLE_RDESC_JIS },
-- 
1.7.9.5

