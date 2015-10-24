From: Michele Baldessari <michele@acksyn.org>
Subject: [PATCH] HID: usbhid: Add a quirk for Xin-Mo Dual Arcade
Date: Sat, 24 Oct 2015 17:44:59 +0200
Message-ID: <1445701499-13748-1-git-send-email-michele@acksyn.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Michele Baldessari <michele@acksyn.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Xin-Mo Dual Arcade controller (16c0:05e1) needs this quirk in order
to have the two distinct joysticks working.

Before the change:
$ jstest /dev/input/js0
Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
...
$ jstest /dev/input/js1
jstest: No such file or directory

After the change:
$ jstest /dev/input/js0
Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
...
$ jstest /dev/input/js1
Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
...

Signed-off-by: Michele Baldessari <michele@acksyn.org>
---
 drivers/hid/usbhid/hid-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 1dff8f0015ba..f69049314a2c 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -150,6 +150,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
 	{ 0, 0 }
 };
-- 
2.5.0
