From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH] usbhid: Add quirk for Mayflash/Dragonrise DolphinBar.
Date: Tue, 20 Dec 2016 22:08:13 +0100
Message-ID: <20161220210813.GA25699@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32997 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757046AbcLTVIU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Dec 2016 16:08:20 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so26734860wmu.0
        for <linux-input@vger.kernel.org>; Tue, 20 Dec 2016 13:08:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

The DolphinBar by Mayflash (identified as Dragonrise) needs HID_QUIRK_MULTI_INPUT to split it up into
four input devices. Without this quirk the adapter is falsely recognized as a tablet. See also bug
115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841).

Signed-off-by: Marcel Hasler <mahasler@gmail.com>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ec277b9..eff818c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -319,6 +319,7 @@
 #define USB_VENDOR_ID_DRAGONRISE		0x0079
 #define USB_DEVICE_ID_DRAGONRISE_WIIU		0x1800
 #define USB_DEVICE_ID_DRAGONRISE_PS3		0x1801
+#define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR	0x1803
 #define USB_DEVICE_ID_DRAGONRISE_GAMECUBE	0x1843
 
 #define USB_VENDOR_ID_DWAV		0x0eef
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index b3e01c8..02fc876 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -83,6 +83,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
-- 
2.10.2

