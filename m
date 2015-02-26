From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/6] HID: uclogic: Set quirks from inside the driver
Date: Thu, 26 Feb 2015 13:57:24 -0500
Message-ID: <1424977049-18648-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

Based on a patch from: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>

Most of the tablets handled by hid-uclogic already use MULTI_INPUT.
For the ones which are not quirked in usbhid/hidquirks, they have a
custom report descriptor which contains only one report per HID
interface. For those tablets HID_QUIRK_MULTI_INPUT is transparent.

According to https://github.com/DIGImend/tablets, the only problematic
tablet currently handled by hid-uclogic is the TWHA60 v3. This tablet
presents different report descriptors from the ones currently quirked.
This is not a problem per se, given that this tablet is not supported
currently in this version (it needs the same command as a Huion to
start forwarding events).

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

no changes in v2

 drivers/hid/hid-uclogic.c       | 27 +++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |  4 ----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index fb8b516..22dccce 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -626,6 +626,32 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int uclogic_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	int rc;
+
+	/*
+	 * libinput requires the pad interface to be on a different node
+	 * than the pen, so use QUIRK_MULTI_INPUT for all tablets.
+	 */
+	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+
+	rc = hid_parse(hdev);
+	if (rc) {
+		hid_err(hdev, "parse failed\n");
+		return rc;
+	}
+
+	rc = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (rc) {
+		hid_err(hdev, "hw start failed\n");
+		return rc;
+	}
+
+	return 0;
+}
+
 static const struct hid_device_id uclogic_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
 				USB_DEVICE_ID_UCLOGIC_TABLET_PF1209) },
@@ -648,6 +674,7 @@ MODULE_DEVICE_TABLE(hid, uclogic_devices);
 static struct hid_driver uclogic_driver = {
 	.name = "uclogic",
 	.id_table = uclogic_devices,
+	.probe = uclogic_probe,
 	.report_fixup = uclogic_report_fixup,
 };
 module_hid_driver(uclogic_driver);
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 989c59a..75ca2de 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -106,12 +106,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWA60, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET, HID_QUIRK_MULTI_INPUT },
-- 
2.1.0
