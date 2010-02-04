From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] HID: use multi input quirk for TouchPack touchscreen
Date: Thu,  4 Feb 2010 13:36:24 -0200
Message-ID: <1265297785-1906-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: don@syst.com.br
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This device generates ABS_Z and ABS_RX events, while it should be
generating ABS_X and ABS_Y instead. Using the MULTI_INPUT quirk solves
this issue.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Signed-off-by: Daniel Oliveira Nascimento <don@syst.com.br>
---
 drivers/hid/hid-ids.h           |    3 +++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e99485f..ba39103 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -398,6 +398,9 @@
 
 #define USB_VENDOR_ID_THRUSTMASTER	0x044f
 
+#define USB_VENDOR_ID_TOUCHPACK		0x1bfd
+#define USB_DEVIDE_ID_TOUCHPAK_RTS	0x1688
+
 #define USB_VENDOR_ID_TOPMAX		0x0663
 #define USB_DEVICE_ID_TOPMAX_COBRAPAD	0x0103
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index edc598d..b89717d 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -45,6 +45,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ USB_VENDOR_ID_PLAYDOTCOM, USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },
 
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
-- 
1.6.6.1
