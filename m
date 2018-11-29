From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 07/35] HID: input: Ignore battery reported by Symbol DS4308
Date: Thu, 29 Nov 2018 01:00:41 -0500
Message-ID: <20181129060110.159878-7-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
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
index 3fc8c0d67592..87904d2adadb 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1001,6 +1001,7 @@
 #define USB_VENDOR_ID_SYMBOL		0x05e0
 #define USB_DEVICE_ID_SYMBOL_SCANNER_1	0x0800
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
+#define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bb984cc9753b..d146a9b545ee 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -325,6 +325,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
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
