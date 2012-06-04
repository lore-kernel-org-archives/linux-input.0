From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC][PATCH 1/2] HID: wiimote: refactor key reporting
Date: Mon,  4 Jun 2012 21:19:12 +0200
Message-ID: <1338837553-10756-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1338837553-10756-1-git-send-email-giuseppe.bilotta@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51173 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2FDTTf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 15:19:35 -0400
Received: by weyu7 with SMTP id u7so3069303wey.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 12:19:34 -0700 (PDT)
In-Reply-To: <1338837553-10756-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Herrmann <dh.herrmann@googlemail.com>, Vojtech Pavlik <vojtech@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

A Wii Remote is exposed as three distinct input devices, but only the
main one (which is the last registered) reports keys. To allow button
presses to also be reported by other devices, we refactor the key
reporting code out of handler_keys() in its own report_keys() function,
that accepts an abritrary input device and an arbitrary key map.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 drivers/hid/hid-wiimote-core.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 84e2fbe..ece9c28 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -690,30 +690,24 @@ static void wiimote_ir_close(struct input_dev *dev)
 	hid_hw_close(wdata->hdev);
 }
 
+static void report_keys(struct input_dev *input, const __u16 keymap[], const __u8 *payload)
+{
+	input_report_key(input, keymap[WIIPROTO_KEY_LEFT], !!(payload[0] & 0x01));
+	input_report_key(input, keymap[WIIPROTO_KEY_RIGHT], !!(payload[0] & 0x02));
+	input_report_key(input, keymap[WIIPROTO_KEY_DOWN], !!(payload[0] & 0x04));
+	input_report_key(input, keymap[WIIPROTO_KEY_UP], !!(payload[0] & 0x08));
+	input_report_key(input, keymap[WIIPROTO_KEY_PLUS], !!(payload[0] & 0x10));
+	input_report_key(input, keymap[WIIPROTO_KEY_TWO], !!(payload[1] & 0x01));
+	input_report_key(input, keymap[WIIPROTO_KEY_ONE], !!(payload[1] & 0x02));
+	input_report_key(input, keymap[WIIPROTO_KEY_B], !!(payload[1] & 0x04));
+	input_report_key(input, keymap[WIIPROTO_KEY_A], !!(payload[1] & 0x08));
+	input_report_key(input, keymap[WIIPROTO_KEY_MINUS], !!(payload[1] & 0x10));
+	input_report_key(input, keymap[WIIPROTO_KEY_HOME], !!(payload[1] & 0x80));
+}
+
 static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 {
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_LEFT],
-							!!(payload[0] & 0x01));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_RIGHT],
-							!!(payload[0] & 0x02));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_DOWN],
-							!!(payload[0] & 0x04));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_UP],
-							!!(payload[0] & 0x08));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_PLUS],
-							!!(payload[0] & 0x10));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_TWO],
-							!!(payload[1] & 0x01));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_ONE],
-							!!(payload[1] & 0x02));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_B],
-							!!(payload[1] & 0x04));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_A],
-							!!(payload[1] & 0x08));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_MINUS],
-							!!(payload[1] & 0x10));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_HOME],
-							!!(payload[1] & 0x80));
+	report_keys(wdata->input, wiiproto_keymap, payload);
 	input_sync(wdata->input);
 }
 
-- 
1.7.10.rc3.204.g95589

