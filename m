From: Aleix Roca Nonell <kernelrocks@gmail.com>
Subject: [PATCH] HID: asus: Add support for the ASUS T101HA keyboard dock
Date: Sat, 1 Dec 2018 20:01:53 +0100
Message-ID: <20181201190153.GB4995@arks.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The ASUS T101HA keyboard dock generates HID events using the ASUS vendor
specific UsagePage 0xff31. In consequence, some multimedia keys such as
brightness up and down are not working with hid-generic.

This commit adds the T101HA dock into the supported device list of the
hid-asus driver. It also prevents the dock's integrated touchpad to be
bound with hid-asus given that it is already working fine with
hid-multitouch.

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---

This is my very first kernel patch done in my free time (be aware of the
newbie!!) so please, let me know if I can improve anything and I will
happily do it :)

 drivers/hid/hid-asus.c | 12 ++++++++++++
 drivers/hid/hid-ids.h  |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ab8bd40a77ed..d8b55dca97c6 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -42,6 +42,7 @@ MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
 MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define T100_TPAD_INTF 2
+#define T101HA_TPAD_INTF 2
 
 #define T100CHI_MOUSE_REPORT_ID 0x06
 #define FEATURE_REPORT_ID 0x0d
@@ -70,6 +71,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_T100_KEYBOARD		BIT(6)
 #define QUIRK_T100CHI			BIT(7)
 #define QUIRK_G752_KEYBOARD		BIT(8)
+#define QUIRK_T101HA_DOCK		BIT(9)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -649,6 +651,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret;
 	struct asus_drvdata *drvdata;
 
+	if (id->driver_data & QUIRK_T101HA_DOCK) {
+		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+
+		/* use hid-multitouch for T101HA touchpad */
+		if (intf->altsetting->desc.bInterfaceNumber == T101HA_TPAD_INTF)
+			return -ENODEV;
+	}
+
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (drvdata == NULL) {
 		hid_err(hdev, "Can't alloc Asus descriptor\n");
@@ -830,6 +840,8 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
 	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD), QUIRK_T101HA_DOCK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4206428c0ba2..f1eee2778b70 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -184,6 +184,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD	0x17e0
 #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
 #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
+#define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
-- 
2.19.2
