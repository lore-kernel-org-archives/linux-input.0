From: nolsen@jabra.com
Subject: [PATCH v2] HID: Ignore Jabra HID interface based on firmware version
Date: Wed,  4 Oct 2017 12:29:57 +0200
Message-ID: <1507112997-31588-1-git-send-email-nolsen@jabra.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prime.nsonet.eu ([178.63.75.197]:49500 "EHLO prime.nsonet.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbdJDKaV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 4 Oct 2017 06:30:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, vpalatin@chromium.org, Niels Skou Olsen <nolsen@jabra.com>

From: Niels Skou Olsen <nolsen@jabra.com>

Two Jabra speakerphone devices were added to the ignore list in 2013,
because the device HID interfaces didn't work well with kernel usbhid
driver, and could cause volume key event storm.

See the original commit:
Commit 31b9779cb292 ("HID: ignore Jabra speakerphones HID interface")

Modify hid_lookup_quirk() to consider the firmware version of these two
devices, so that only versions older than a known good version are
ignored.

Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
---
v2: Rebase on patch set "Quirks cleanup and hid-generic niceness", v2
    (http://www.spinics.net/lists/linux-input/msg53428.html)
    Simplify with review suggestions by Benjamin Tissoires
---
 drivers/hid/hid-quirks.c      | 16 ++++++++++++++--
 drivers/hid/usbhid/hid-core.c |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 69a0e0b..1f59e51 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -784,8 +784,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1007) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IMATION, USB_DEVICE_ID_DISC_STAKKA) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_GN9350E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KWORLD, USB_DEVICE_ID_KWORLD_RADIO_FM700) },
@@ -1231,6 +1229,20 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev)
 	    hdev->product <= USB_DEVICE_ID_NCR_LAST)
 		return HID_QUIRK_NO_INIT_REPORTS;
 
+	/* These devices must be ignored if version (bcdDevice) is too old */
+	if (hdev->bus == BUS_USB && hdev->vendor == USB_VENDOR_ID_JABRA) {
+		switch (hdev->product) {
+		case USB_DEVICE_ID_JABRA_SPEAK_410:
+			if (hdev->version < 0x0111)
+				return HID_QUIRK_IGNORE;
+			break;
+		case USB_DEVICE_ID_JABRA_SPEAK_510:
+			if (hdev->version < 0x0214)
+				return HID_QUIRK_IGNORE;
+			break;
+		}
+	}
+
 	mutex_lock(&dquirks_lock);
 	quirk_entry = hid_exists_dquirk(hdev);
 	if (quirk_entry)
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 75dbf04..a5807bc 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1317,6 +1317,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 	hid->bus = BUS_USB;
 	hid->vendor = le16_to_cpu(dev->descriptor.idVendor);
 	hid->product = le16_to_cpu(dev->descriptor.idProduct);
+	hid->version = le16_to_cpu(dev->descriptor.bcdDevice);
 	hid->name[0] = 0;
 	if (intf->cur_altsetting->desc.bInterfaceProtocol ==
 			USB_INTERFACE_PROTOCOL_MOUSE)
-- 
2.7.4

