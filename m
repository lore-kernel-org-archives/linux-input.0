From: John Sung <penmount.touch@gmail.com>
Subject: [PATCH] HID: usbhid: quirk for PM1610 and PM1640 Touchscreen.
Date: Fri, 27 Jun 2014 16:22:08 +0800
Message-ID: <1403857328-38892-1-git-send-email-penmount.touch@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penmount.touch@gmail.com
List-Id: linux-input@vger.kernel.org

These device needs to be added to the quirks list with HID_QUIRK_NOGET,
otherwise they will reset upon receiving the get input report requests.

Signed-off-by: John Sung <penmount.touch@gmail.com>
---
 drivers/hid/hid-ids.h           |    2 ++
 drivers/hid/usbhid/hid-quirks.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7370ae3..37af778 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -715,6 +715,8 @@
 
 #define USB_VENDOR_ID_PENMOUNT		0x14e1
 #define USB_DEVICE_ID_PENMOUNT_PCI	0x3500
+#define USB_DEVICE_ID_PENMOUNT_1610	0x1610
+#define USB_DEVICE_ID_PENMOUNT_1640	0x1640
 
 #define USB_VENDOR_ID_PETALYNX		0x18b1
 #define USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE	0x0037
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 13ca192..587d3aa 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -76,6 +76,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2, HID_QUIRK_NO_INIT_REPORTS },
-- 
1.7.9.5
