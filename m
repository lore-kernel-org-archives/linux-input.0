From: Aaron Bottegal <aaronbottegal@gmail.com>
Subject: [PATCH] HID: corsair: Add K70 Vengeance and K70 RAPIDFIRE to supported devices.
Date: Fri, 22 Dec 2017 03:32:52 -0500
Message-ID: <20171222083252.8643-1-aaronbottegal@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Aaron Bottegal <aaronbottegal@gmail.com>
List-Id: linux-input@vger.kernel.org

K70 Vengence sends garbage keypresses when changing  backlight brightness.
This hooks to the existing corsair driver, which filters out those
invalid keypresses on similar devices in the input mapping code.

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
+	 * Vengence K70 and K70 RAPIDFIRE share product IDs.
+	 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
+            USB_DEVICE_ID_CORSAIR_K70R) },
 	{}
 };
 
-- 
2.15.1
