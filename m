From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: usbhid: fix more Mayflash adapters
 (HID_QUIRK_MULTI_INPUT)
Date: Mon, 12 Dec 2016 16:23:05 -0800
Message-ID: <20161213002305.GA30732@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35745 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbcLMAXJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 19:23:09 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Rodland <andrew@cleverdomain.org>, robert.de.rooy@gmail.com, mahasler@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andrew Rodland <andrew@cleverdomain.org>

Add "Mayflash GameCube Controller Adapter for Wii U and PC USB" and
"Mayflash PS3 Game Controller Adapter" to the list of devices needing
HID_QUIRK_MULTI_INPUT. These devices have 4 controller ports, and without
the quirk they all become one very large joystock device. With the quirk
they're recognized as 4 separate joysticks.

Signed-off-by: Andrew Rodland <andrew@cleverdomain.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=115841
[dtor: picked up Andrew's patch, added the PS3 controller data from
 bugzilla info]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-ids.h           | 2 ++
 drivers/hid/usbhid/hid-quirks.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 575aa65..63824f1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -317,6 +317,8 @@
 
 #define USB_VENDOR_ID_DRAGONRISE	0x0079
 #define USB_DEVICE_ID_DRAGONRISE_WIIU	0x1800
+#define USB_DEVICE_ID_DRAGONRISE_PS3	0x1801
+#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE	0x1843
 
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index e6cfd32..6f8736a 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -81,6 +81,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE, HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
