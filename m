From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC PATCH] Wiimote joystick reports no axes
Date: Mon,  4 Jun 2012 10:54:58 +0200
Message-ID: <1338800098-5643-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <CAOxFTcwsVFpN0KcKSbCjCHJ0=0Q+CcSd0UxanWzue0pv5ZSoXA@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34075 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab2FDIzX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 04:55:23 -0400
Received: by wibhn6 with SMTP id hn6so2625285wib.1
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 01:55:22 -0700 (PDT)
In-Reply-To: <CAOxFTcwsVFpN0KcKSbCjCHJ0=0Q+CcSd0UxanWzue0pv5ZSoXA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, linux-input@vger.kernel.org

> Thank you very much. However, these documents don't explain why a
> joystick device is created for the Wii Remote and not for the Wii
> Remote Accelerator.

I've done some more inquiring and discovered that the reason why the
Remote device is handled as a gamepad by the input subsystem is that it
reports a BTN_A, so I can't see a trivial way to prevent this from
happening, besides changing the keymap or blacklisting the device at the
joystick driver level.

On the other hand, this also means that just adding a BTN_A to the Accel
device is sufficient to have it automatically register for the joydev
handler. So my idea to add the buttons to the Accel device is enough to
automatically get a proper joystick device from the wiimote.

> IMO the current interface is quite satisfactory. The only thing that I
> would change is that the Accelerator device should ALSO expose buttons
> (possibly with a different keymap in that case). I have something in
> mind to this end, I should be able to give it a test and submit an RFC
> patch within a couple of days.

I'm attaching to this email a draft patch whose only purpose is to show
how I plan to do things. A proper patched based against the current
driver in the linux tree will follow if you think the idea has merit.

In words, the idea is to:

* refactor the reporting of keys; this allows the reporting to work on
  any exposed input device, by passing the report_keys function the
  inpurt device and a mapping.
* use report_keys() in handler_keys()
* register the keys in the accel device too
* use report_keys() in handler_accel() too

With these changes, there are now two joystick devices created from the
wiimote input devices, and due to the order input devices are
registered, the first one is the one based off the Accelerator input
device (and it has 3 axes and 7 buttons now), and the other is the one
based on the Remote device (and which, ideally, we would like the
joystick handler to skip).

-- 
Giuseppe "Oblomov" Bilotta

diff --git a/driver/hid-wiimote-core.c b/driver/hid-wiimote-core.c
index 745667e..f0e9fc9 100644
--- a/driver/hid-wiimote-core.c
+++ b/driver/hid-wiimote-core.c
@@ -686,30 +686,24 @@ static void wiimote_ir_close(struct input_dev *dev)
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
 
@@ -743,6 +737,7 @@ static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
 	input_report_abs(wdata->accel, ABS_RX, x - 0x200);
 	input_report_abs(wdata->accel, ABS_RY, y - 0x200);
 	input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
+	report_keys(wdata->accel, wiiproto_keymap, payload);
 	input_sync(wdata->accel);
 }
 
@@ -1104,6 +1099,11 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
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
