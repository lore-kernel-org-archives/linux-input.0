From: Aaron Bottegal <aaronbottegal@gmail.com>
Subject: [PATCH V2] HID: corsair: Add K70 Vengeance and K70 RAPIDFIRE to
Date: Fri, 22 Dec 2017 03:38:14 -0500
Message-ID: <20171222083814.9090-1-aaronbottegal@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46978 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753735AbdLVIi4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Dec 2017 03:38:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Aaron Bottegal <aaronbottegal@gmail.com>

K70 Vengeance sends garbage keypresses when changing  backlight brightness.
This hooks to the existing corsair driver, which filters out those
invalid keypresses on similar devices in the input mapping code.

V2: Fix spelling.

Signed-off-by: Aaron Bottegal <aaronbottegal@gmail.com>
---
 drivers/hid/hid-corsair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 9ba5d98a1180..7aa73c758a64 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -2,11 +2,14 @@
  * HID driver for Corsair devices
  *
  * Supported devices:
+ *  - Vengeance K70 Keyboard
+ *  - K70 RAPIDFIRE Keyboard
  *  - Vengeance K90 Keyboard
  *  - Scimitar PRO RGB Gaming Mouse
  *
  * Copyright (c) 2015 Clement Vuchener
  * Copyright (c) 2017 Oscar Campos
+ * Copyright (c) 2017 Aaron Bottegal
  */
 
 /*
@@ -717,6 +720,11 @@ static const struct hid_device_id corsair_devices[] = {
 			       CORSAIR_USE_K90_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
             USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB) },
+	/*
+	 * Vengeance K70 and K70 RAPIDFIRE share product IDs.
+	 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
+            USB_DEVICE_ID_CORSAIR_K70R) },
 	{}
 };
 
-- 
2.15.1

