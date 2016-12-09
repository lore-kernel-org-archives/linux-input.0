From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH 3/4] hid-lenovo: Handle X1 Tablet cover FNLock function
 appropriately
Date: Fri, 9 Dec 2016 16:05:42 +0100
Message-ID: <110694ef-bbad-f211-ac5d-3fe5e10600f2@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:33404 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932763AbcLIPIX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 10:08:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org

The FNLock state is not handled by the X1 tablet cover itself.
There is the need to set the FNLock LED which actually enables
the FNLock state of the cover. This means activating the FNLock LED
will enable FNLock state and FNLock LED.
---
 drivers/hid/hid-lenovo.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 2efd5b0..3ace8c3 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -526,6 +526,29 @@ static void lenovo_led_brightness_set_tpx1cover(struct led_classdev *led_cdev,
 	}
 }
 
+static int lenovo_event_tpx1cover(struct hid_device *hdev,
+		struct hid_field *field, struct hid_usage *usage, __s32 value)
+{
+	int ret = 0;
+
+	if (usage->hid == HID_CP_CONSUMERCONTROL) {
+		if (usage->usage_index == 8 && value == 1) {
+			struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
+
+			if (drv_data && drv_data->led_present) {
+				drv_data->fnlock_state = lenovo_led_brightness_get_tpx1cover(
+						&drv_data->led_fnlock) == LED_OFF ? 1 : 0;
+				lenovo_led_brightness_set_tpx1cover(
+					&drv_data->led_fnlock,
+					drv_data->fnlock_state ? LED_FULL : LED_OFF);
+			}
+		}
+
+	}
+
+	return ret;
+}
+
 static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -533,6 +556,8 @@ static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
 	case USB_DEVICE_ID_LENOVO_CUSBKBD:
 	case USB_DEVICE_ID_LENOVO_CBTKBD:
 		return lenovo_event_cptkbd(hdev, field, usage, value);
+	case USB_DEVICE_ID_LENOVO_X1_COVER:
+		return lenovo_event_tpx1cover(hdev, field, usage, value);
 	default:
 		return 0;
 	}
-- 
1.9.1
