From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] HID: Add mapping for Microsoft Win8 Wireless Radio Controls extensions
Date: Wed, 10 May 2017 17:12:52 +0200
Message-ID: <20170510151253.30324-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbdEJPM6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 May 2017 11:12:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Microsoft has defined some extra HUT codes for the Generic Desktop Page
for Wireless Radio controls, see:

https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management
https://web.archive.org/web/20170509144631/https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management

I've 3 2-in-1 keyboard docks: Dell Venue Pro 11 keyboard dock,
HP pavilion x2 keyboard dock and a PEAQ C1010 keyboard dock which have
a wireless radio toggle hotkey, which uses the 0x000100c6 HUT code
defined in these extensions.

This commit adds a mapping for this key, this makes the rfkill toggle
hotkey work on the Dell Venue Pro 11 and HP Pavilion X2 keyboards,
the PEAQ C1010 keyboard does generate events for the 0x000100c6 HUT
code when pressed, but the reported value is always 0.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-input.c |  9 +++++++++
 include/linux/hid.h     | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d05f903c7614..79aa2f7d0482 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -656,6 +656,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case HID_GD_START:	map_key_clear(BTN_START);	break;
 		case HID_GD_SELECT:	map_key_clear(BTN_SELECT);	break;
 
+		case HID_GD_RFKILL_BTN:
+			/* MS wireless radio ctl extension, also check CA */
+			if (field->application == 0x0001000c) {
+				map_key_clear(KEY_RFKILL);
+				/* We need to simulate the btn release */
+				field->flags |= HID_MAIN_ITEM_RELATIVE;
+				break;
+			}
+
 		default: goto unknown;
 		}
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 28f38e2b8f30..8a259c6ea8a1 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -182,6 +182,12 @@ struct hid_item {
 #define HID_GD_KEYBOARD		0x00010006
 #define HID_GD_KEYPAD		0x00010007
 #define HID_GD_MULTIAXIS	0x00010008
+/*
+ * Microsoft Win8 Wireless Radio Controls extensions CA, see (checked 09052017):
+ * https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management
+ * https://web.archive.org/web/20170509144631/https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/airplane-mode-radio-management
+ */
+#define HID_GD_WIRELESS_RADIO_CTLS	0x0001000c
 #define HID_GD_X		0x00010030
 #define HID_GD_Y		0x00010031
 #define HID_GD_Z		0x00010032
@@ -210,6 +216,10 @@ struct hid_item {
 #define HID_GD_DOWN		0x00010091
 #define HID_GD_RIGHT		0x00010092
 #define HID_GD_LEFT		0x00010093
+/* Microsoft Win8 Wireless Radio Controls CA usage codes */
+#define HID_GD_RFKILL_BTN	0x000100c6
+#define HID_GD_RFKILL_LED	0x000100c7
+#define HID_GD_RFKILL_SWITCH	0x000100c8
 
 #define HID_DC_BATTERYSTRENGTH	0x00060020
 
-- 
2.12.2

