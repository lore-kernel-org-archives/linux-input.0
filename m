From: Jeff Farthing <jeff@jfarthing.com>
Subject: [PATCH] HID: microsoft: Add support for Surface Pro 4 Type Cover
Date: Mon, 21 Nov 2016 09:36:21 -0500
Message-ID: <17ae4d35-87fe-2167-0787-7d2f19fd2d65@jfarthing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from so254-17.mailgun.net ([198.61.254.17]:48811 "EHLO
        so254-17.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbcKUOld (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Nov 2016 09:41:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Add support for Surface Pro 4 Type Cover

Signed-off-by: Jeff Farthing <jeff@jfarthing.com>
---
  drivers/hid/hid-core.c          | 4 ++++
  drivers/hid/hid-ids.h           | 2 ++
  drivers/hid/hid-microsoft.c     | 4 ++++
  drivers/hid/usbhid/hid-quirks.c | 2 ++
  4 files changed, 12 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2b89c70..1bbe329 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -727,6 +727,8 @@ static void hid_scan_collection(struct hid_parser 
*parser, unsigned type)
          (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
           hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
           hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
+         hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 ||
+         hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2 ||
           hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP ||
           hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
           hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
@@ -1983,6 +1985,8 @@ static const struct hid_device_id 
hid_have_special_driver[] = {
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
+    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_4) },
+    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2) },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP) },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_3) },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 575aa65..5525965 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -718,6 +718,8 @@
  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4    0x07e4
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2  0x07e8
  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
  #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index c6cd392..5e592f0 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -280,6 +280,10 @@ static const struct hid_device_id ms_devices[] = {
          .driver_data = MS_HIDINPUT },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
          .driver_data = MS_HIDINPUT },
+    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_4),
+        .driver_data = MS_HIDINPUT },
+    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2),
+        .driver_data = MS_HIDINPUT },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP),
          .driver_data = MS_HIDINPUT },
      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 
USB_DEVICE_ID_MS_TYPE_COVER_3),
diff --git a/drivers/hid/usbhid/hid-quirks.c 
b/drivers/hid/usbhid/hid-quirks.c
index e6cfd32..ac43bfc3 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -100,6 +100,8 @@ static const struct hid_blacklist {
      { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2, 
HID_QUIRK_NO_INIT_REPORTS },
      { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, 
HID_QUIRK_NO_INIT_REPORTS },
      { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, 
HID_QUIRK_NO_INIT_REPORTS },
+    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4, 
HID_QUIRK_NO_INIT_REPORTS },
+    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2, 
HID_QUIRK_NO_INIT_REPORTS },
      { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, 
HID_QUIRK_NO_INIT_REPORTS },
      { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP, 
HID_QUIRK_NO_INIT_REPORTS },
      { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, 
HID_QUIRK_NO_INIT_REPORTS },
-- 
2.10.2
