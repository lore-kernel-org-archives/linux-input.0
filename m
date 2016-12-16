From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH 2/2] HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter
Date: Fri, 16 Dec 2016 21:31:30 +0000
Message-ID: <20161216213130.19303-3-tk@the-tk.com>
References: <20161216213130.19303-1-tk@the-tk.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161216213130.19303-1-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Kramkowski <tk@the-tk.com>
List-Id: linux-input@vger.kernel.org

The (1292:4745) Innomedia INNEX GENESIS/ATARI adapter needs
HID_QUIRK_MULTI_INPUT to split the device up into two controllers
instead of inputs from both being merged into one.

This patch depends on patch 1.

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
 drivers/hid/usbhid/hid-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index b3e01c8..b5e013b 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -165,6 +165,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI, HID_QUIRK_MULTI_INPUT },
 
 	{ 0, 0 }
 };
-- 
2.10.2
