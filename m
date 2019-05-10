From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 1/4] HID: wacom: generic: only switch the mode on devices with LEDs
Date: Fri, 10 May 2019 15:31:16 -0700
Message-ID: <1557527479-9242-2-git-send-email-aaron.skomra@wacom.com>
References: <1557527479-9242-1-git-send-email-aaron.skomra@wacom.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1557527479-9242-1-git-send-email-aaron.skomra@wacom.com>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, pinglinux@gmail.com, jason.gerecke@wacom.com
Cc: Aaron Armstrong Skomra <aaron.skomra@wacom.com>, "# v4 . 11+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Currently, the driver will attempt to set the mode on all
devices with a center button, but some devices with a center
button lack LEDs, and attempting to set the LEDs on devices
without LEDs results in the kernel error message of the form:

"leds input8::wacom-0.1: Setting an LED's brightness failed (-32)"

This is because the generic codepath erroneously assumes that the
BUTTON_CENTER usage indicates that the device has LEDs, the
previously ignored TOUCH_RING_SETTING usage is a more accurate
indication of the existence of LEDs on the device.

Fixes: 10c55cacb8b2 ("HID: wacom: generic: support LEDs")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 3 +++
 drivers/hid/wacom_wac.c | 2 --
 drivers/hid/wacom_wac.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a8633b1437b2..2e3e03df83da 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -307,6 +307,9 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 	wacom_hid_usage_quirk(hdev, field, usage);
 
 	switch (equivalent_usage) {
+	case WACOM_HID_WD_TOUCH_RING_SETTING:
+		wacom->generic_has_leds = true;
+		break;
 	case HID_DG_CONTACTMAX:
 		/* leave touch_max as is if predefined */
 		if (!features->touch_max) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 09b8e4aac82f..10cce2ca6301 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1930,8 +1930,6 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_BUTTONCENTER:
-		wacom->generic_has_leds = true;
-		/* fall through */
 	case WACOM_HID_WD_BUTTONHOME:
 	case WACOM_HID_WD_BUTTONUP:
 	case WACOM_HID_WD_BUTTONDOWN:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 295fd3718caa..f67d871841c0 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -145,6 +145,7 @@
 #define WACOM_HID_WD_OFFSETBOTTOM       (WACOM_HID_UP_WACOMDIGITIZER | 0x0d33)
 #define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
 #define WACOM_HID_WD_DIGITIZERINFO      (WACOM_HID_UP_WACOMDIGITIZER | 0x1013)
+#define WACOM_HID_WD_TOUCH_RING_SETTING (WACOM_HID_UP_WACOMDIGITIZER | 0x1032)
 #define WACOM_HID_UP_G9                 0xff090000
 #define WACOM_HID_G9_PEN                (WACOM_HID_UP_G9 | 0x02)
 #define WACOM_HID_G9_TOUCHSCREEN        (WACOM_HID_UP_G9 | 0x11)
-- 
2.7.4
