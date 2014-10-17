From: Olivier Gay <ogay@logitech.com>
Subject: [PATCH] HID: add keyboard input assist hid usages
Date: Sat, 18 Oct 2014 01:53:39 +0200
Message-ID: <1413590019-1829-1-git-send-email-ogay@logitech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aob139.obsmtp.com ([74.125.149.251]:56612 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751342AbaJRAAT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2014 20:00:19 -0400
Received: by mail-lb0-f171.google.com with SMTP id z12so1485683lbi.16
        for <linux-input@vger.kernel.org>; Fri, 17 Oct 2014 17:00:17 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>, Olivier Gay <ogay@logitech.com>

Add keyboard input assist controls usages from approved
hid usage table request HUTTR42:
http://www.usb.org/developers/hidpage/HUTRR42c.pdf

Signed-off-by: Olivier Gay <ogay@logitech.com>
---

Hi all,

this patch adds some currently missing hid usages to the
hid system.

Best regards,

Olivier

 drivers/hid/hid-debug.c    | 6 ++++++
 drivers/hid/hid-input.c    | 7 +++++++
 include/uapi/linux/input.h | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 84c3cb1..8bf61d2 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -946,6 +946,12 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
 	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
 	[KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
+	[KEY_KBDINPUTASSIST_PREV] = "KbdInputAssistPrev",
+	[KEY_KBDINPUTASSIST_NEXT] = "KbdInputAssistNext",
+	[KEY_KBDINPUTASSIST_PREVGROUP] = "KbdInputAssistPrevGroup",
+	[KEY_KBDINPUTASSIST_NEXTGROUP] = "KbdInputAssistNextGroup",
+	[KEY_KBDINPUTASSIST_ACCEPT] = "KbdInputAssistAccept",
+	[KEY_KBDINPUTASSIST_CANCEL] = "KbdInputAssistCancel",
 };
 
 static const char *relatives[REL_MAX + 1] = {
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2df7fdd..56c6c30 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -862,6 +862,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
 		case 0x28c: map_key_clear(KEY_SEND);		break;
 
+		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
+		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
+		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
+		case 0x2ca: map_key_clear(KEY_KBDINPUTASSIST_NEXTGROUP);		break;
+		case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
+		case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
+
 		default:    goto ignore;
 		}
 		break;
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 19df18c..9be8c13 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -738,6 +738,13 @@ struct input_keymap_entry {
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
 
+#define KEY_KBDINPUTASSIST_PREV		0x260
+#define KEY_KBDINPUTASSIST_NEXT		0x261
+#define KEY_KBDINPUTASSIST_PREVGROUP		0x262
+#define KEY_KBDINPUTASSIST_NEXTGROUP		0x263
+#define KEY_KBDINPUTASSIST_ACCEPT		0x264
+#define KEY_KBDINPUTASSIST_CANCEL		0x265
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
-- 
1.9.0

