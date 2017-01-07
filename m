From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH 1/2] hid: Add a new device ID for updated Mayflash/Dragonrise
 GameCube adapter.
Date: Sat, 7 Jan 2017 12:10:37 +0100
Message-ID: <20170107111037.GA17413@arch-desktop>
References: <20170107110926.GA14173@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36527 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031972AbdAGLKn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 7 Jan 2017 06:10:43 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so10417338wma.3
        for <linux-input@vger.kernel.org>; Sat, 07 Jan 2017 03:10:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170107110926.GA14173@arch-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

The Mayflash GameCube adapter has received a firmware update which, among other things, changes the device's PID. It also fixes enumeration, therefore the updated firmware no longer requires HID_QUIRK_MULTI_INPUT.

Signed-off-by: Marcel Hasler <mahasler@gmail.com>
---
 drivers/hid/hid-ids.h           | 3 ++-
 drivers/hid/usbhid/hid-quirks.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 54bd22dc1411..23cb33c36663 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -320,7 +320,8 @@
 #define USB_DEVICE_ID_DRAGONRISE_WIIU		0x1800
 #define USB_DEVICE_ID_DRAGONRISE_PS3		0x1801
 #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR	0x1803
-#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE	0x1843
+#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE1	0x1843
+#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE2	0x1844
 
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index e9d6cc7cdfc5..54b641efd939 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -84,7 +84,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.11.0

