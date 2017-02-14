From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH v2 2/2] HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter
Date: Tue, 14 Feb 2017 23:14:33 +0000
Message-ID: <20170214231433.27060-3-tk@the-tk.com>
References: <20170214231433.27060-1-tk@the-tk.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170214231433.27060-1-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Kramkowski <tk@the-tk.com>
List-Id: linux-input@vger.kernel.org

The (1292:4745) Innomedia INNEX GENESIS/ATARI adapter needs
HID_QUIRK_MULTI_INPUT to split the device up into two controllers
instead of inputs from both being merged into one.

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
 drivers/hid/hid-ids.h           | 3 +++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f46f2c5117fa..e6b38fa49709 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -541,6 +541,9 @@
 #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
 #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
 
+#define USB_VENDOR_ID_INNOMEDIA			0x1292
+#define USB_DEVICE_ID_INNEX_GENESIS_ATARI	0x4745
+
 #define USB_VENDOR_ID_ITE               0x048d
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index e9d6cc7cdfc5..b3fe5308b353 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -167,6 +167,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI, HID_QUIRK_MULTI_INPUT },
 
 	{ 0, 0 }
 };
-- 
2.11.0
