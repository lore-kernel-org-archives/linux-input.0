From: Donavan Lance <shvr@fedoraproject.org>
Subject: [PATCH RESEND] HID: Add new Microsoft Type Cover 3 product ID
Date: Mon, 14 Sep 2015 18:05:40 -0400
Message-ID: <BLU436-SMTP188AECF1930F37C9701AD55DF5D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from blu004-omc4s19.hotmail.com ([65.55.111.158]:60612 "EHLO
	BLU004-OMC4S19.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbbINWFn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 18:05:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Adds support for Microsoft Type Cover 3 with 0x07e2 product ID.

Signed-off-by: Donavan Lance <shvr@fedoraproject.org>
---
 drivers/hid/hid-core.c          | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/hid-microsoft.c     | 2 ++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 70a11ac..31ce45d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -725,6 +725,7 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)

        if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
            (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
+            hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
             hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
             hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
             hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
@@ -1928,6 +1929,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
+       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f769208..01bb2fa 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -679,6 +679,7 @@
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 9aa3515..77a2cf3 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -278,6 +278,8 @@ static const struct hid_device_id ms_devices[] = {
                .driver_data = MS_DUPLICATE_USAGES },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3),
                .driver_data = MS_HIDINPUT },
+       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2),
+               .driver_data = MS_HIDINPUT },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
                .driver_data = MS_HIDINPUT },
        { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 1dff8f0..5ef80c8 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -91,6 +91,7 @@ static const struct hid_blacklist {
        { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
        { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
        { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIRK_NO_INIT_REPORTS },
+       { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
        { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
        { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
        { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.4.3
