From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working
Date: Wed, 17 Jan 2018 21:05:55 +0100
Message-ID: <20180117200555.22990-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeAQUGH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Jan 2018 15:06:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org

The Toshiba Click Mini uses an i2c attached keyboard/touchpad combo
(single i2c_hid device for both) which has a vid:pid of 04F3:0401,
which is also used by a bunch of Elan touchpads which are handled by the
drivers/input/mouse/elan_i2c driver, but that driver deals with pure
touchpads and does not work for a combo device such as the one on the
Toshiba Click Mini.

The combo on the Mini has an ACPI id of ELAN0800, which is not claimed
by the elan_i2c driver, so check for that and if it is found do not ignore
the device. This fixes the keyboard/touchpad combo on the Mini not working
(although with the touchpad in mouse emulation mode).

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-quirks.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 1cf1e9a0d699..ed4b30bbdde3 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -729,7 +729,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
@@ -997,6 +996,17 @@ bool hid_ignore(struct hid_device *hdev)
 		    strncmp(hdev->name, "www.masterkit.ru MA901", 22) == 0)
 			return true;
 		break;
+	case USB_VENDOR_ID_ELAN:
+		/*
+		 * Many Elan devices have a product id of 0x0401 and are handled
+		 * by the elan_i2c input driver. But the ACPI HID ELAN0800 dev
+		 * is not (and cannot be) handled by that driver ->
+		 * Ignore all 0x0401 devs except for the ELAN0800 dev.
+		 */
+		if (hdev->product == 0x0401 &&
+		    strncmp(hdev->name, "ELAN0800", 8) != 0)
+			return true;
+		break;
 	}
 
 	if (hdev->type == HID_TYPE_USBMOUSE &&
-- 
2.14.3

