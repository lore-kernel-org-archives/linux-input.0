From: =?UTF-8?q?Maxime=20Belleng=C3=A9?= <maxime.bellenge@gmail.com>
Subject: [PATCH v2] HID: asus: Add support for Fn keys on Asus ROG G752
Date: Thu,  7 Sep 2017 21:17:28 +0200
Message-ID: <20170907191728.19018-1-maxime.bellenge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Maxime=20Belleng=C3=A9?= <maxime.bellenge@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch adds support for Fn keys on Asus ROG G752 laptop.
The report descriptor is broken so I fixed it.

Tested on an Asus G752VT.
Resent fix white space fixes

Signed-off-by: Maxime Bellengé <maxime.bellenge@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-asus.c | 29 +++++++++++++++++++++++++++++
 drivers/hid/hid-core.c |  2 +-
 drivers/hid/hid-ids.h  |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 50c294be8324..9bc8a0f87e64 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -67,6 +67,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_USE_KBD_BACKLIGHT		BIT(5)
 #define QUIRK_T100_KEYBOARD		BIT(6)
 #define QUIRK_T100CHI			BIT(7)
+#define QUIRK_G752_KEYBOARD		BIT(8)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -670,6 +671,11 @@ static void asus_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+static const __u8 asus_g752_fixed_rdesc[] = {
+        0x19, 0x00,			/*   Usage Minimum (0x00)       */
+        0x2A, 0xFF, 0x00,		/*   Usage Maximum (0xFF)       */
+};
+
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -708,6 +714,27 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc[391] = 0xff;
 		rdesc[402] = 0x00;
 	}
+	if (drvdata->quirks & QUIRK_G752_KEYBOARD &&
+		 *rsize == 75 && rdesc[61] == 0x15 && rdesc[62] == 0x00) {
+		/* report is missing usage mninum and maximum */
+		__u8 *new_rdesc;
+		size_t new_size = *rsize + sizeof(asus_g752_fixed_rdesc);
+
+		new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
+		if (new_rdesc == NULL)
+			return rdesc;
+
+		hid_info(hdev, "Fixing up Asus G752 keyb report descriptor\n");
+		/* copy the valid part */
+		memcpy(new_rdesc, rdesc, 61);
+		/* insert missing part */
+		memcpy(new_rdesc + 61, asus_g752_fixed_rdesc, sizeof(asus_g752_fixed_rdesc));
+		/* copy remaining data */
+		memcpy(new_rdesc + 61 + sizeof(asus_g752_fixed_rdesc), rdesc + 61, *rsize - 61);
+
+		*rsize = new_size;
+		rdesc = new_rdesc;
+	}
 
 	return rdesc;
 }
@@ -721,6 +748,8 @@ static const struct hid_device_id asus_devices[] = {
 		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
+        { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+                USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
 	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9bc91160819b..af31a68da616 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1979,6 +1979,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
+        { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
@@ -3119,4 +3120,3 @@ MODULE_AUTHOR("Andreas Gal");
 MODULE_AUTHOR("Vojtech Pavlik");
 MODULE_AUTHOR("Jiri Kosina");
 MODULE_LICENSE("GPL");
-
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b397a14ab970..1b1fca0560f2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -182,6 +182,7 @@
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
+#define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
 
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
-- 
2.13.5
