From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/3] hid-input.c: indentation fixes
Date: Mon, 12 Jul 2010 19:28:26 +0200
Message-ID: <1278955708-9428-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:34824 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210Ab0GLR2z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jul 2010 13:28:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7a0d2e4..36c2148 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -199,11 +199,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case HID_GD_MOUSE:
 		case HID_GD_POINTER:  code += 0x110; break;
 		case HID_GD_JOYSTICK:
-				      if (code <= 0xf)
-					      code += BTN_JOYSTICK;
-				      else
-					      code += BTN_TRIGGER_HAPPY;
-				      break;
+				if (code <= 0xf)
+					code += BTN_JOYSTICK;
+				else
+					code += BTN_TRIGGER_HAPPY;
+				break;
 		case HID_GD_GAMEPAD:  code += 0x130; break;
 		default:
 			switch (field->physical) {
@@ -480,7 +480,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 	case HID_UP_LOGIVENDOR:
 		goto ignore;
-	
+
 	case HID_UP_PID:
 		switch (usage->hid & HID_USAGE) {
 		case 0xa4: map_key_clear(BTN_DEAD);	break;
@@ -586,9 +586,9 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 			hat_dir = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
 		if (hat_dir < 0 || hat_dir > 8) hat_dir = 0;
 		input_event(input, usage->type, usage->code    , hid_hat_to_axis[hat_dir].x);
-                input_event(input, usage->type, usage->code + 1, hid_hat_to_axis[hat_dir].y);
-                return;
-        }
+		input_event(input, usage->type, usage->code + 1, hid_hat_to_axis[hat_dir].y);
+		return;
+	}
 
 	if (usage->hid == (HID_UP_DIGITIZER | 0x003c)) { /* Invert */
 		*quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
-- 
1.7.1

