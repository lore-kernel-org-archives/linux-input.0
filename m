From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH 2/2] hid-mf: Add force feedback support for Mayflash
 DolphinBar and GameCube adapters.
Date: Sat, 7 Jan 2017 12:11:07 +0100
Message-ID: <20170107111107.GA20674@arch-desktop>
References: <20170107110926.GA14173@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34576 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031972AbdAGLLN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 7 Jan 2017 06:11:13 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so10376863wmi.1
        for <linux-input@vger.kernel.org>; Sat, 07 Jan 2017 03:11:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170107110926.GA14173@arch-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

The Mayflash DolphinBar and GameCube adapters have been tested and confirmed to work using the hid-mf driver.

Signed-off-by: Marcel Hasler <mahasler@gmail.com>
---
 drivers/hid/hid-core.c |  3 +++
 drivers/hid/hid-mf.c   | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cff060b56da9..54e98ff7090d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1887,6 +1887,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0011) },
 #if IS_ENABLED(CONFIG_HID_MAYFLASH)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE2) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_WN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_FA) },
diff --git a/drivers/hid/hid-mf.c b/drivers/hid/hid-mf.c
index d9090765a6e5..03f10516131d 100644
--- a/drivers/hid/hid-mf.c
+++ b/drivers/hid/hid-mf.c
@@ -6,12 +6,14 @@
  *
  * Tested with:
  * 0079:1801 "DragonRise Inc. Mayflash PS3 Game Controller Adapter"
+ * 0079:1803 "DragonRise Inc. Mayflash Wireless Sensor DolphinBar"
+ * 0079:1843 "DragonRise Inc. Mayflash GameCube Game Controller Adapter"
+ * 0079:1844 "DragonRise Inc. Mayflash GameCube Game Controller Adapter (v04)"
  *
  * The following adapters probably work too, but need to be tested:
  * 0079:1800 "DragonRise Inc. Mayflash WIIU Game Controller Adapter"
- * 0079:1843 "DragonRise Inc. Mayflash GameCube Game Controller Adapter"
  *
- * Copyright (c) 2016 Marcel Hasler <mahasler@gmail.com>
+ * Copyright (c) 2016-2017 Marcel Hasler <mahasler@gmail.com>
  */
 
 /*
@@ -125,8 +127,8 @@ static int mf_probe(struct hid_device *hid, const struct hid_device_id *id)
 
 	dev_dbg(&hid->dev, "Mayflash HID hardware probe...\n");
 
-	/* Split device into four inputs */
-	hid->quirks |= HID_QUIRK_MULTI_INPUT;
+	/* Apply quirks as needed */
+	hid->quirks |= id->driver_data;
 
 	error = hid_parse(hid);
 	if (error) {
@@ -151,7 +153,14 @@ static int mf_probe(struct hid_device *hid, const struct hid_device_id *id)
 }
 
 static const struct hid_device_id mf_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3),  },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3),
+		.driver_data = HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR),
+		.driver_data = HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1),
+		.driver_data = HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE2),
+		.driver_data = 0 }, /* No quirk required */
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, mf_devices);
-- 
2.11.0

