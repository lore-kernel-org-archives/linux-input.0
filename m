From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/18] HID: input: Ignore battery reported by Symbol DS4308
Date: Thu, 29 Nov 2018 01:03:18 -0500
Message-ID: <20181129060331.160224-6-sashal@kernel.org>
References: <20181129060331.160224-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129060331.160224-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Benson Leung <bleung@chromium.org>

[ Upstream commit 0fd791841a6d67af1155a9c3de54dea51220721e ]

The Motorola/Zebra Symbol DS4308-HD is a handheld USB barcode scanner
which does not have a battery, but reports one anyway that always has
capacity 2.

Let's apply the IGNORE quirk to prevent it from being treated like a
power supply so that userspaces don't get confused that this
accessory is almost out of power and warn the user that they need to charge
their wired barcode scanner.

Reported here: https://bugs.chromium.org/p/chromium/issues/detail?id=804720

Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8913f357e78f..6f4c84d824e6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -965,6 +965,7 @@
 #define USB_VENDOR_ID_SYMBOL		0x05e0
 #define USB_DEVICE_ID_SYMBOL_SCANNER_1	0x0800
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
+#define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5ff6dd8147b6..fc7ada26457e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -324,6 +324,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
+		USB_DEVICE_ID_SYMBOL_SCANNER_3),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.17.1
