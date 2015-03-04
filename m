From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: map telephony usage page
Date: Wed, 4 Mar 2015 14:10:26 -0800
Message-ID: <20150304221026.GA11485@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36743 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbbCDWKb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 17:10:31 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Reilly Grant <reillyg@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Currently HID code maps usages from telephony page into BTN_0, BTN_1, etc
keys which get interpreted by mousedev and userspace as left/right/middle
button clicks, which is not really helpful.

This change adds mappings for usages that have corresponding input event
definitions, and leaves the rest unmapped. This can be changed when
there are userspace consumers for more telephony usages.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c    | 23 +++++++++++++++++++++++
 include/linux/hid.h        |  1 +
 include/uapi/linux/input.h |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9505605..7c882e0 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -708,6 +708,29 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		}
 		break;
 
+	case HID_UP_TELEPHONY:
+		switch (usage->hid & HID_USAGE) {
+		case 0x2f: map_key_clear(KEY_MICMUTE);		break;
+		case 0xb0: map_key_clear(KEY_NUMERIC_0);	break;
+		case 0xb1: map_key_clear(KEY_NUMERIC_1);	break;
+		case 0xb2: map_key_clear(KEY_NUMERIC_2);	break;
+		case 0xb3: map_key_clear(KEY_NUMERIC_3);	break;
+		case 0xb4: map_key_clear(KEY_NUMERIC_4);	break;
+		case 0xb5: map_key_clear(KEY_NUMERIC_5);	break;
+		case 0xb6: map_key_clear(KEY_NUMERIC_6);	break;
+		case 0xb7: map_key_clear(KEY_NUMERIC_7);	break;
+		case 0xb8: map_key_clear(KEY_NUMERIC_8);	break;
+		case 0xb9: map_key_clear(KEY_NUMERIC_9);	break;
+		case 0xba: map_key_clear(KEY_NUMERIC_STAR);	break;
+		case 0xbb: map_key_clear(KEY_NUMERIC_POUND);	break;
+		case 0xbc: map_key_clear(KEY_NUMERIC_A);	break;
+		case 0xbd: map_key_clear(KEY_NUMERIC_B);	break;
+		case 0xbe: map_key_clear(KEY_NUMERIC_C);	break;
+		case 0xbf: map_key_clear(KEY_NUMERIC_D);	break;
+		default: goto ignore;
+		}
+		break;
+
 	case HID_UP_CONSUMER:	/* USB HUT v1.12, pages 75-84 */
 		switch (usage->hid & HID_USAGE) {
 		case 0x000: goto ignore;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 06c4607..6dfe0ee 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -159,6 +159,7 @@ struct hid_item {
 #define HID_UP_LED		0x00080000
 #define HID_UP_BUTTON		0x00090000
 #define HID_UP_ORDINAL		0x000a0000
+#define HID_UP_TELEPHONY	0x000b0000
 #define HID_UP_CONSUMER		0x000c0000
 #define HID_UP_DIGITIZER	0x000d0000
 #define HID_UP_PID		0x000f0000
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 5f4f923..5189d52 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -701,6 +701,10 @@ struct input_keymap_entry {
 #define KEY_NUMERIC_9		0x209
 #define KEY_NUMERIC_STAR	0x20a
 #define KEY_NUMERIC_POUND	0x20b
+#define KEY_NUMERIC_A		0x20c	/* Phone key A - HUT Telephony 0xb9 */
+#define KEY_NUMERIC_B		0x20d
+#define KEY_NUMERIC_C		0x20e
+#define KEY_NUMERIC_D		0x20f
 
 #define KEY_CAMERA_FOCUS	0x210
 #define KEY_WPS_BUTTON		0x211	/* WiFi Protected Setup key */
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
