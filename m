From: Raphael Assenat <raph@raphnet.net>
Subject: [PATCH,v2] usbhid: Add a quirk for raphnet multi-gamepad adapters
Date: Sat, 25 Apr 2015 16:30:32 -0400
Message-ID: <20150425203032.GA24785@yggdrasil2.lan.raphnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.196]:57857 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbbDYUai (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Apr 2015 16:30:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

The raphnet.net 4nes4snes and 2nes2snes multi-joystick adapters use a
single HID report descriptor with one report ID per controller. This
has the effect that the inputs of otherwise independent game controllers
get packed in one large joystick device.

With this patch each controller gets its own /dev/input/jsX device, 
which is more natural and less confusing than having all inputs going
to the same place.

Signed-off-by: Raphael Assenat <raph@raphnet.net>

---

v2: Rebased on Linux 4.0

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9c47867..1a57e86 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1028,4 +1028,11 @@
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
 #define USB_DEVICE_ID_RI_KA_WEBMAIL	0x1320	/* Webmail Notifier */
 
+#define USB_VENDOR_ID_MULTIPLE_1781	0x1781
+#define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD	0x0a8d
+
+#define USB_VENDOR_ID_DRACAL_RAPHNET	0x289b
+#define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
+#define USB_DEVICE_ID_RAPHNET_4NES4SNES	0x0003
+
 #endif
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a821277..209ec17 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -136,6 +136,9 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096, HID_QUIRK_NO_INIT_INPUT_REPORTS },
+	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
 
 	{ 0, 0 }
 };
