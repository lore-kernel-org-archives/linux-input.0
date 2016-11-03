From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH v3 1/2] usbhid: Add quirks for Mayflash/Dragonrise GameCube
 and PS3 adapters.
Date: Thu, 3 Nov 2016 19:47:26 +0100
Message-ID: <20161103184726.GA21339@arch-desktop>
References: <cover.1478198451.git.mahasler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33247 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcKCSrc (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Nov 2016 14:47:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id u144so386993wmu.0
        for <linux-input@vger.kernel.org>; Thu, 03 Nov 2016 11:47:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1478198451.git.mahasler@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

All known gamepad adapters by Mayflash (identified as Dragonrise) need HID_QUIRK_MULTI_INPUT to
split them up into four input devices. Without this quirk those adapters are falsely recognized
as tablets. Fixes bug 115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841).

Signed-off-by: Marcel Hasler <mahasler@gmail.com>
---
 drivers/hid/hid-ids.h           | 6 ++++--
 drivers/hid/usbhid/hid-quirks.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6cfb5ca..642e648 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -314,8 +314,10 @@
 #define USB_VENDOR_ID_DMI		0x0c0b
 #define USB_DEVICE_ID_DMI_ENC		0x5fab
 
-#define USB_VENDOR_ID_DRAGONRISE	0x0079
-#define USB_DEVICE_ID_DRAGONRISE_WIIU	0x1800
+#define USB_VENDOR_ID_DRAGONRISE		0x0079
+#define USB_DEVICE_ID_DRAGONRISE_WIIU		0x1800
+#define USB_DEVICE_ID_DRAGONRISE_PS3		0x1801
+#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE	0x1843
 
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 354d49e..05f6f61 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -81,6 +81,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.10.2

