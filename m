From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 16/21] HID: wiimote: add Classic Controller extension
Date: Sat, 13 Apr 2013 12:47:57 +0200
Message-ID: <1365850082-3585-17-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:56957 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKsz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:55 -0400
Received: by mail-ee0-f43.google.com with SMTP id e50so1626123eek.16
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:54 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Add a new extension module for the classic controller so we get hotplug
support for this device. It is mostly the same as the old static classic
controller parser.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    |   6 +
 drivers/hid/hid-wiimote-modules.c | 279 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   1 +
 3 files changed, 286 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 39a65e0..6f930f1 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -435,6 +435,8 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 
 	if (rmem[4] == 0x00 && rmem[5] == 0x00)
 		return WIIMOTE_EXT_NUNCHUK;
+	if (rmem[4] == 0x01 && rmem[5] == 0x01)
+		return WIIMOTE_EXT_CLASSIC_CONTROLLER;
 	if (rmem[4] == 0x04 && rmem[5] == 0x02)
 		return WIIMOTE_EXT_BALANCE_BOARD;
 
@@ -469,6 +471,9 @@ static bool wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
 
 	/* map MP with correct pass-through mode */
 	switch (exttype) {
+	case WIIMOTE_EXT_CLASSIC_CONTROLLER:
+		wmem = 0x07;
+		break;
 	case WIIMOTE_EXT_NUNCHUK:
 		wmem = 0x05;
 		break;
@@ -1012,6 +1017,7 @@ static const char *wiimote_exttype_names[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NONE] = "None",
 	[WIIMOTE_EXT_UNKNOWN] = "Unknown",
 	[WIIMOTE_EXT_NUNCHUK] = "Nintendo Wii Nunchuk",
+	[WIIMOTE_EXT_CLASSIC_CONTROLLER] = "Nintendo Wii Classic Controller",
 	[WIIMOTE_EXT_BALANCE_BOARD] = "Nintendo Wii Balance Board",
 };
 
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index e4bcc09..a1a4438 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -986,6 +986,284 @@ static const struct wiimod_ops wiimod_nunchuk = {
 };
 
 /*
+ * Classic Controller
+ * Another official extension from Nintendo. It provides a classic
+ * gamecube-like controller that can be hotplugged on the Wii Remote.
+ * It has several hardware buttons and switches that are all reported via
+ * a normal extension device.
+ */
+
+enum wiimod_classic_keys {
+	WIIMOD_CLASSIC_KEY_A,
+	WIIMOD_CLASSIC_KEY_B,
+	WIIMOD_CLASSIC_KEY_X,
+	WIIMOD_CLASSIC_KEY_Y,
+	WIIMOD_CLASSIC_KEY_ZL,
+	WIIMOD_CLASSIC_KEY_ZR,
+	WIIMOD_CLASSIC_KEY_PLUS,
+	WIIMOD_CLASSIC_KEY_MINUS,
+	WIIMOD_CLASSIC_KEY_HOME,
+	WIIMOD_CLASSIC_KEY_LEFT,
+	WIIMOD_CLASSIC_KEY_RIGHT,
+	WIIMOD_CLASSIC_KEY_UP,
+	WIIMOD_CLASSIC_KEY_DOWN,
+	WIIMOD_CLASSIC_KEY_LT,
+	WIIMOD_CLASSIC_KEY_RT,
+	WIIMOD_CLASSIC_KEY_NUM,
+};
+
+static const __u16 wiimod_classic_map[] = {
+	BTN_A,		/* WIIMOD_CLASSIC_KEY_A */
+	BTN_B,		/* WIIMOD_CLASSIC_KEY_B */
+	BTN_X,		/* WIIMOD_CLASSIC_KEY_X */
+	BTN_Y,		/* WIIMOD_CLASSIC_KEY_Y */
+	BTN_TL2,	/* WIIMOD_CLASSIC_KEY_ZL */
+	BTN_TR2,	/* WIIMOD_CLASSIC_KEY_ZR */
+	KEY_NEXT,	/* WIIMOD_CLASSIC_KEY_PLUS */
+	KEY_PREVIOUS,	/* WIIMOD_CLASSIC_KEY_MINUS */
+	BTN_MODE,	/* WIIMOD_CLASSIC_KEY_HOME */
+	KEY_LEFT,	/* WIIMOD_CLASSIC_KEY_LEFT */
+	KEY_RIGHT,	/* WIIMOD_CLASSIC_KEY_RIGHT */
+	KEY_UP,		/* WIIMOD_CLASSIC_KEY_UP */
+	KEY_DOWN,	/* WIIMOD_CLASSIC_KEY_DOWN */
+	BTN_TL,		/* WIIMOD_CLASSIC_KEY_LT */
+	BTN_TR,		/* WIIMOD_CLASSIC_KEY_RT */
+};
+
+static void wiimod_classic_in_ext(struct wiimote_data *wdata, const __u8 *ext)
+{
+	__s8 rx, ry, lx, ly, lt, rt;
+
+	/*   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    1   | RX <5:4>  |              LX <5:0>             |
+	 *    2   | RX <3:2>  |              LY <5:0>             |
+	 *   -----+-----+-----+-----+-----------------------------+
+	 *    3   |RX<1>| LT <5:4>  |         RY <5:1>            |
+	 *   -----+-----+-----------+-----------------------------+
+	 *    4   |     LT <3:1>    |         RT <5:1>            |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    5   | BDR | BDD | BLT | B-  | BH  | B+  | BRT |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    6   | BZL | BB  | BY  | BA  | BX  | BZR | BDL | BDU |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 * All buttons are 0 if pressed
+	 * RX and RY are right analog stick
+	 * LX and LY are left analog stick
+	 * LT is left trigger, RT is right trigger
+	 * BLT is 0 if left trigger is fully pressed
+	 * BRT is 0 if right trigger is fully pressed
+	 * BDR, BDD, BDL, BDU form the D-Pad with right, down, left, up buttons
+	 * BZL is left Z button and BZR is right Z button
+	 * B-, BH, B+ are +, HOME and - buttons
+	 * BB, BY, BA, BX are A, B, X, Y buttons
+	 * LSB of RX, RY, LT, and RT are not transmitted and always 0.
+	 *
+	 * With motionp enabled it changes slightly to this:
+	 *   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    1   | RX <4:3>  |          LX <5:1>           | BDU |
+	 *    2   | RX <2:1>  |          LY <5:1>           | BDL |
+	 *   -----+-----+-----+-----+-----------------------+-----+
+	 *    3   |RX<0>| LT <4:3>  |         RY <4:0>            |
+	 *   -----+-----+-----------+-----------------------------+
+	 *    4   |     LT <2:0>    |         RT <4:0>            |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    5   | BDR | BDD | BLT | B-  | BH  | B+  | BRT | EXT |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    6   | BZL | BB  | BY  | BA  | BX  | BZR |  0  |  0  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 * Only the LSBs of LX and LY are lost. BDU and BDL are moved, the rest
+	 * is the same as before.
+	 */
+
+	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
+		lx = ext[0] & 0x3e;
+		ly = ext[0] & 0x3e;
+	} else {
+		lx = ext[0] & 0x3f;
+		ly = ext[0] & 0x3f;
+	}
+
+	rx = (ext[0] >> 3) & 0x14;
+	rx |= (ext[1] >> 5) & 0x06;
+	rx |= (ext[2] >> 7) & 0x01;
+	ry = ext[2] & 0x1f;
+
+	rt = ext[3] & 0x1f;
+	lt = (ext[2] >> 2) & 0x18;
+	lt |= (ext[3] >> 5) & 0x07;
+
+	rx <<= 1;
+	ry <<= 1;
+	rt <<= 1;
+	lt <<= 1;
+
+	input_report_abs(wdata->extension.input, ABS_HAT1X, lx - 0x20);
+	input_report_abs(wdata->extension.input, ABS_HAT1Y, ly - 0x20);
+	input_report_abs(wdata->extension.input, ABS_HAT2X, rx - 0x20);
+	input_report_abs(wdata->extension.input, ABS_HAT2Y, ry - 0x20);
+	input_report_abs(wdata->extension.input, ABS_HAT3X, rt - 0x20);
+	input_report_abs(wdata->extension.input, ABS_HAT3Y, lt - 0x20);
+
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_RIGHT],
+			 !!(ext[4] & 0x80));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_DOWN],
+			 !!(ext[4] & 0x40));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_LT],
+			 !!(ext[4] & 0x20));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_MINUS],
+			 !!(ext[4] & 0x10));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_HOME],
+			 !!(ext[4] & 0x08));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_PLUS],
+			 !!(ext[4] & 0x04));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_RT],
+			 !!(ext[4] & 0x02));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_ZL],
+			 !!(ext[5] & 0x80));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_B],
+			 !!(ext[5] & 0x40));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_Y],
+			 !!(ext[5] & 0x20));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_A],
+			 !!(ext[5] & 0x10));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_X],
+			 !!(ext[5] & 0x08));
+	input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_ZR],
+			 !!(ext[5] & 0x04));
+
+	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
+		input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_UP],
+			 !!(ext[0] & 0x01));
+		input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_LEFT],
+			 !!(ext[1] & 0x01));
+	} else {
+		input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_UP],
+			 !!(ext[5] & 0x01));
+		input_report_key(wdata->extension.input,
+			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_LEFT],
+			 !!(ext[5] & 0x02));
+	}
+
+	input_sync(wdata->extension.input);
+}
+
+static int wiimod_classic_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_EXT_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_classic_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags &= ~WIIPROTO_FLAG_EXT_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static int wiimod_classic_probe(const struct wiimod_ops *ops,
+				struct wiimote_data *wdata)
+{
+	int ret, i;
+
+	wdata->extension.input = input_allocate_device();
+	if (!wdata->extension.input)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->extension.input, wdata);
+	wdata->extension.input->open = wiimod_classic_open;
+	wdata->extension.input->close = wiimod_classic_close;
+	wdata->extension.input->dev.parent = &wdata->hdev->dev;
+	wdata->extension.input->id.bustype = wdata->hdev->bus;
+	wdata->extension.input->id.vendor = wdata->hdev->vendor;
+	wdata->extension.input->id.product = wdata->hdev->product;
+	wdata->extension.input->id.version = wdata->hdev->version;
+	wdata->extension.input->name = WIIMOTE_NAME " Classic Controller";
+
+	set_bit(EV_KEY, wdata->extension.input->evbit);
+	for (i = 0; i < WIIMOD_CLASSIC_KEY_NUM; ++i)
+		set_bit(wiimod_classic_map[i],
+			wdata->extension.input->keybit);
+
+	set_bit(EV_ABS, wdata->extension.input->evbit);
+	set_bit(ABS_HAT1X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT1Y, wdata->extension.input->absbit);
+	set_bit(ABS_HAT2X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT2Y, wdata->extension.input->absbit);
+	set_bit(ABS_HAT3X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT3Y, wdata->extension.input->absbit);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT1X, -30, 30, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT1Y, -30, 30, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT2X, -30, 30, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT2Y, -30, 30, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT3X, -30, 30, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT3Y, -30, 30, 1, 1);
+
+	ret = input_register_device(wdata->extension.input);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	input_free_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+	return ret;
+}
+
+static void wiimod_classic_remove(const struct wiimod_ops *ops,
+				  struct wiimote_data *wdata)
+{
+	if (!wdata->extension.input)
+		return;
+
+	input_unregister_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+}
+
+static const struct wiimod_ops wiimod_classic = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_classic_probe,
+	.remove = wiimod_classic_remove,
+	.in_ext = wiimod_classic_in_ext,
+};
+
+/*
  * Balance Board Extension
  * The Nintendo Wii Balance Board provides four hardware weight sensor plus a
  * single push button. No other peripherals are available. However, the
@@ -1224,5 +1502,6 @@ const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NONE] = &wiimod_dummy,
 	[WIIMOTE_EXT_UNKNOWN] = &wiimod_dummy,
 	[WIIMOTE_EXT_NUNCHUK] = &wiimod_nunchuk,
+	[WIIMOTE_EXT_CLASSIC_CONTROLLER] = &wiimod_classic,
 	[WIIMOTE_EXT_BALANCE_BOARD] = &wiimod_bboard,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 6b6e821..324d442 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -81,6 +81,7 @@ enum wiimote_exttype {
 	WIIMOTE_EXT_NONE,
 	WIIMOTE_EXT_UNKNOWN,
 	WIIMOTE_EXT_NUNCHUK,
+	WIIMOTE_EXT_CLASSIC_CONTROLLER,
 	WIIMOTE_EXT_BALANCE_BOARD,
 	WIIMOTE_EXT_NUM,
 };
-- 
1.8.2.1

