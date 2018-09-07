From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 7/7] HID: logitech-hidpp: support the G900 over wireless
Date: Fri,  7 Sep 2018 12:34:50 +0200
Message-ID: <20180907103450.13890-8-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The receiver of the G900 is similar to a Unifying one. However,
if we switch the receiver into the DJ mode through hid-logitech-dj,
the reports emitted by the mouse are from a new kind. Instead of finding
out what they are, and given that only one device should be connected
to the receiver, just use hid-logitech-hidpp.

The battery is not yet supported in the kernel, but at least the
input nodes are now named after the mouse.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-ids.h            |  1 +
 drivers/hid/hid-logitech-hidpp.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b366976e928c..f3de8562a92b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -745,6 +745,7 @@
 #define USB_DEVICE_ID_LOGITECH_G700_RECEIVER		0xc531
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2	0xc532
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
+#define USB_DEVICE_ID_LOGITECH_G900_RECEIVER		0xc539
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
 #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0ab7f8b66b83..2e264869b096 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -68,6 +68,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HI_RES_SCROLL_X2120		BIT(27)
 #define HIDPP_QUIRK_HI_RES_SCROLL_X2121		BIT(28)
 #define HIDPP_QUIRK_RECEIVER			BIT(29)
+#define HIDPP_QUIRK_FORCE_OPEN			BIT(30)
 
 /* Convenience constant to check for any high-res support. */
 #define HIDPP_QUIRK_HI_RES_SCROLL	(HIDPP_QUIRK_HI_RES_SCROLL_1P0 | \
@@ -3584,6 +3585,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto hid_hw_start_fail;
 	}
 
+	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OPEN) {
+		ret = hid_hw_open(hdev);
+		if (ret)
+			goto hid_hw_open_fail;
+	}
+
 	return ret;
 
 hid_hw_init_fail:
@@ -3608,6 +3615,9 @@ static void hidpp_remove(struct hid_device *hdev)
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
+	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OPEN)
+		hid_hw_close(hdev);
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
 		hidpp_ff_deinit(hdev);
 
@@ -3674,6 +3684,11 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* G700 over Wireless */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
 	  .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },
+	{ /* G900 over Wireless */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_G900_RECEIVER),
+	  .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING |
+			 HIDPP_QUIRK_FORCE_OPEN},
 
 	{ LDJ_DEVICE(HID_ANY_ID) },
 
-- 
2.14.3
