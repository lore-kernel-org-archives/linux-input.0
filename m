From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC][PATCH 2/2] HID: wiimote: report keys in Accelerometer too
Date: Mon,  4 Jun 2012 21:19:13 +0200
Message-ID: <1338837553-10756-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1338837553-10756-1-git-send-email-giuseppe.bilotta@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55292 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2FDTTj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 15:19:39 -0400
Received: by bkcji2 with SMTP id ji2so3924690bkc.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 12:19:37 -0700 (PDT)
In-Reply-To: <1338837553-10756-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Herrmann <dh.herrmann@googlemail.com>, Vojtech Pavlik <vojtech@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

The main input device registered by the wiimote driver gets classified
as a gamepad because it reports the presence of a BTN_A button. This
results in the detection of a joystick device with 7 buttons and no axes
(thus unusable) when a Wii Remote is connected.

By letting the Accelerometer input device also report buttons, we get it
to be recognized as a 7-buttons, 3-axes gamepad, that can be used on
games with no direct Wii Remote support through the joydev interface.

This approach is currently not perfect: button presses gets reported on
two devices (Remote and Accelerometer), and the main device is still
classified as a gamepad due to the mapping.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 drivers/hid/hid-wiimote-core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index ece9c28..2177dbe 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -741,6 +741,7 @@ static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
 	input_report_abs(wdata->accel, ABS_RX, x - 0x200);
 	input_report_abs(wdata->accel, ABS_RY, y - 0x200);
 	input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
+	report_keys(wdata->accel, wiiproto_keymap, payload);
 	input_sync(wdata->accel);
 }
 
@@ -1096,6 +1097,11 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	input_set_abs_params(wdata->accel, ABS_RY, -500, 500, 2, 4);
 	input_set_abs_params(wdata->accel, ABS_RZ, -500, 500, 2, 4);
 
+	set_bit(EV_KEY, wdata->accel->evbit);
+	for (i = 0; i < WIIPROTO_KEY_COUNT; ++i)
+		set_bit(wiiproto_keymap[i], wdata->accel->keybit);
+
+
 	wdata->ir = input_allocate_device();
 	if (!wdata->ir)
 		goto err_ir;
-- 
1.7.10.rc3.204.g95589

