From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 2/9] HID: kye: Rename MousePen i608X v2 macro
Date: Tue, 13 Sep 2016 17:08:36 +0300
Message-ID: <20160913140843.25567-3-spbnick@gmail.com>
References: <20160913140843.25567-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35489 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755296AbcIMOJI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:09:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id c131so3168885wmh.2
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 07:09:07 -0700 (PDT)
In-Reply-To: <20160913140843.25567-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Rename the device ID macro for the second version of KYE MousePen i608x
graphics tablet to have "V" in its name to signify that "2" is a
version.

I.e. USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2 ->
     USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2

This also makes applying additional fixes from DIGImend easier.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-core.c          | 2 +-
 drivers/hid/hid-ids.h           | 2 +-
 drivers/hid/hid-kye.c           | 6 +++---
 drivers/hid/usbhid/hid-quirks.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 08f53c7..758619d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1916,7 +1916,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_I405X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4ed9a4f..5963cf1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -565,7 +565,7 @@
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
 #define USB_DEVICE_ID_KYE_EASYPEN_I405X	0x5010
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
-#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2	0x501a
+#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2	0x501a
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
 #define USB_DEVICE_ID_KYE_PENSKETCH_M912	0x5015
 
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index a3b70df..ee5ca1f 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -439,7 +439,7 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		}
 		break;
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 		if (*rsize == MOUSEPEN_I608X_RDESC_ORIG_SIZE) {
 			rdesc = mousepen_i608x_rdesc_fixed;
 			*rsize = sizeof(mousepen_i608x_rdesc_fixed);
@@ -538,7 +538,7 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	switch (id->product) {
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
 		ret = kye_tablet_enable(hdev);
@@ -571,7 +571,7 @@ static const struct hid_device_id kye_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2) },
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index b4b8c6a..ab3a31c 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -143,7 +143,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.9.3

