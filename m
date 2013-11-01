From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 06/13] HID: wiimote: adjust button-mapping to gamepad rules
Date: Fri,  1 Nov 2013 21:16:17 +0100
Message-ID: <1383336984-26601-7-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:58041 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3KAUQx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:16:53 -0400
Received: by mail-ee0-f48.google.com with SMTP id d49so4927eek.7
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:52 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Our gamepad API (./Documentation/input/gamepad.txt) clearly defines rules
how to map buttons for gamepads. A wiimote can easily be used as gamepad
and provides most of the features. Unfortunately, the gamepad API didn't
exist when hid-wiimote was written.

This patch changes the button-mappings to comply to gamepad rules. For
compatibility reasons, we keep the old mappings if legacy-mode was
enabled.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 49 ++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 6b61f01..372fec1 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -48,7 +48,7 @@
  * It uses the shared input device.
  */
 
-static const __u16 wiimod_keys_map[] = {
+static const __u16 wiimod_keys_map_legacy[] = {
 	KEY_LEFT,	/* WIIPROTO_KEY_LEFT */
 	KEY_RIGHT,	/* WIIPROTO_KEY_RIGHT */
 	KEY_UP,		/* WIIPROTO_KEY_UP */
@@ -62,29 +62,48 @@ static const __u16 wiimod_keys_map[] = {
 	BTN_MODE,	/* WIIPROTO_KEY_HOME */
 };
 
+static const __u16 wiimod_keys_map[] = {
+	BTN_DPAD_LEFT,		/* WIIPROTO_KEY_LEFT */
+	BTN_DPAD_RIGHT,		/* WIIPROTO_KEY_RIGHT */
+	BTN_DPAD_UP,		/* WIIPROTO_KEY_UP */
+	BTN_DPAD_DOWN,		/* WIIPROTO_KEY_DOWN */
+	BTN_START,		/* WIIPROTO_KEY_PLUS */
+	BTN_SELECT,		/* WIIPROTO_KEY_MINUS */
+	BTN_TRIGGER_HAPPY1,	/* WIIPROTO_KEY_ONE */
+	BTN_TRIGGER_HAPPY2,	/* WIIPROTO_KEY_TWO */
+	BTN_SOUTH,		/* WIIPROTO_KEY_A */
+	BTN_TR,			/* WIIPROTO_KEY_B */
+	BTN_MODE,		/* WIIPROTO_KEY_HOME */
+};
+
 static void wiimod_keys_in_keys(struct wiimote_data *wdata, const __u8 *keys)
 {
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_LEFT],
+	const __u16 *map = wiimod_keys_map;
+
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY)
+		map = wiimod_keys_map_legacy;
+
+	input_report_key(wdata->input, map[WIIPROTO_KEY_LEFT],
 							!!(keys[0] & 0x01));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_RIGHT],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_RIGHT],
 							!!(keys[0] & 0x02));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_DOWN],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_DOWN],
 							!!(keys[0] & 0x04));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_UP],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_UP],
 							!!(keys[0] & 0x08));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_PLUS],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_PLUS],
 							!!(keys[0] & 0x10));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_TWO],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_TWO],
 							!!(keys[1] & 0x01));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_ONE],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_ONE],
 							!!(keys[1] & 0x02));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_B],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_B],
 							!!(keys[1] & 0x04));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_A],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_A],
 							!!(keys[1] & 0x08));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_MINUS],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_MINUS],
 							!!(keys[1] & 0x10));
-	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_HOME],
+	input_report_key(wdata->input, map[WIIPROTO_KEY_HOME],
 							!!(keys[1] & 0x80));
 	input_sync(wdata->input);
 }
@@ -92,11 +111,15 @@ static void wiimod_keys_in_keys(struct wiimote_data *wdata, const __u8 *keys)
 static int wiimod_keys_probe(const struct wiimod_ops *ops,
 			     struct wiimote_data *wdata)
 {
+	const __u16 *map = wiimod_keys_map;
 	unsigned int i;
 
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY)
+		map = wiimod_keys_map_legacy;
+
 	set_bit(EV_KEY, wdata->input->evbit);
 	for (i = 0; i < WIIPROTO_KEY_COUNT; ++i)
-		set_bit(wiimod_keys_map[i], wdata->input->keybit);
+		set_bit(map[i], wdata->input->keybit);
 
 	return 0;
 }
-- 
1.8.4.1

