From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] input: hid-microsoft: Add support for scrollwheel and special keypad keys
Date: Wed, 29 Jan 2014 17:57:43 +0100
Message-ID: <1391014664-2642-4-git-send-email-hdegoede@redhat.com>
References: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbaA2Q5z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 11:57:55 -0500
In-Reply-To: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The Microsoft Office keyboard has a scrollwheel as well as some special keys
above the keypad which are handled through the custom MS usage page, this
commit adds support for these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-core.c      |  1 +
 drivers/hid/hid-ids.h       |  1 +
 drivers/hid/hid-microsoft.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 253fe23..fe5fa34 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1778,6 +1778,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_USB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f9304cb..c4f5147 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -603,6 +603,7 @@
 
 #define USB_VENDOR_ID_MICROSOFT		0x045e
 #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b
+#define USB_DEVICE_ID_MS_OFFICE_KB	0x0048
 #define USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0 0x009d
 #define USB_DEVICE_ID_MS_NE4K		0x00db
 #define USB_DEVICE_ID_MS_NE4K_JP	0x00dc
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a161afd..992252b 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -68,6 +68,26 @@ static int ms_ergonomy_kb_quirk(struct hid_input *hi, struct hid_usage *usage,
 	switch (usage->hid & HID_USAGE) {
 	case 0xfd06: ms_map_key_clear(KEY_CHAT);	break;
 	case 0xfd07: ms_map_key_clear(KEY_PHONE);	break;
+	case 0xff00:
+		/* Special keypad keys */
+		ms_map_key_clear(KEY_KPEQUAL);
+		set_bit(KEY_KPLEFTPAREN, input->keybit);
+		set_bit(KEY_KPRIGHTPAREN, input->keybit);
+		break;
+	case 0xff01:
+		/* Scroll wheel */
+		hid_map_usage_clear(hi, usage, bit, max, EV_REL, REL_WHEEL);
+		break;
+	case 0xff02:
+		/*
+		 * This byte contains a copy of the modifier keys byte of a
+		 * standard hid keyboard report, as send by interface 0
+		 * (this usage is found on interface 1).
+		 *
+		 * This byte only gets send when another key in the same report
+		 * changes state, and as such is useless, ignore it.
+		 */
+		return -1;
 	case 0xff05:
 		set_bit(EV_REP, input->evbit);
 		ms_map_key_clear(KEY_F13);
@@ -136,14 +156,39 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct input_dev *input;
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
 			!usage->type)
 		return 0;
 
+	input = field->hidinput->input;
+
 	/* Handling MS keyboards special buttons */
+	if (quirks & MS_ERGONOMY && usage->hid == (HID_UP_MSVENDOR | 0xff00)) {
+		/* Special keypad keys */
+		input_report_key(input, KEY_KPEQUAL, value & 0x01);
+		input_report_key(input, KEY_KPLEFTPAREN, value & 0x02);
+		input_report_key(input, KEY_KPRIGHTPAREN, value & 0x04);
+		return 1;
+	}
+
+	if (quirks & MS_ERGONOMY && usage->hid == (HID_UP_MSVENDOR | 0xff01)) {
+		/* Scroll wheel */
+		int step = ((value & 0x60) >> 5) + 1;
+
+		switch (value & 0x1f) {
+		case 0x01:
+			input_report_rel(input, REL_WHEEL, step);
+			break;
+		case 0x1f:
+			input_report_rel(input, REL_WHEEL, -step);
+			break;
+		}
+		return 1;
+	}
+
 	if (quirks & MS_ERGONOMY && usage->hid == (HID_UP_MSVENDOR | 0xff05)) {
-		struct input_dev *input = field->hidinput->input;
 		static unsigned int last_key = 0;
 		unsigned int key = 0;
 		switch (value) {
@@ -196,6 +241,8 @@ err_free:
 static const struct hid_device_id ms_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV),
 		.driver_data = MS_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB),
+		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K),
 		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K_JP),
-- 
1.8.4.2

