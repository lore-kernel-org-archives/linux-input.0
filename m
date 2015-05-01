From: John Horan <knasher@gmail.com>
Subject: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO keyboard
Date: Fri,  1 May 2015 10:17:23 +0100
Message-ID: <1430471843-3455-1-git-send-email-knasher@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33543 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbEAJR2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 May 2015 05:17:28 -0400
Received: by wgin8 with SMTP id n8so86089232wgi.0
        for <linux-input@vger.kernel.org>; Fri, 01 May 2015 02:17:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, John Horan <knasher@gmail.com>

The quirk for swapping the grave and 102nd keys should be applied to the 
APPLE_ALU_ISO keyboard, as they aren't actually swapped.

Signed-off-by: John Horan <knasher@gmail.com>
---
 drivers/hid/hid-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index f822fd2..e4bbfc0 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -441,7 +441,7 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
+		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI),
-- 
2.3.7

