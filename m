From: Stafford Horne <shorne@gmail.com>
Subject: [PATCH] HID: quirks: Add no_init_reports for AKAI midi controller
Date: Wed, 27 Jan 2016 23:09:37 +0900
Message-ID: <1453903777-11790-1-git-send-email-shorne@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Stafford Horne <shorne@gmail.com>
List-Id: linux-input@vger.kernel.org

The midi controller times-out while initializing reports, this
causes boot to take an extra 10 seconds. The device descriptor
advertises that it has an internal HID device but seems to not
actually do anything useful.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 drivers/hid/hid-ids.h           | 3 +++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b6ff6e7..3dfb166 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -61,6 +61,9 @@
 #define USB_VENDOR_ID_AIREN		0x1a2c
 #define USB_DEVICE_ID_AIREN_SLIMPLUS	0x0002
 
+#define USB_VENDOR_ID_AKAI              0x2011
+#define USB_DEVICE_ID_AKAI_MPKMINI2     0x0715
+
 #define USB_VENDOR_ID_ALCOR		0x058f
 #define USB_DEVICE_ID_ALCOR_USBRS232	0x9720
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 7dd0953..055e740 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -55,6 +55,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },
 
 	{ USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
-- 
2.5.0
