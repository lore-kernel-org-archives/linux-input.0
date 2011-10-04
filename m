From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 12/12] HID: wiimote: Parse classic controller data
Date: Tue,  4 Oct 2011 15:36:53 +0200
Message-ID: <1317735413-17299-13-git-send-email-dh.herrmann@googlemail.com>
References: <1317735413-17299-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55806 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252Ab1JDNhh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 09:37:37 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so815066wwf.1
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 06:37:36 -0700 (PDT)
In-Reply-To: <1317735413-17299-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Nintendo Classic Controller extension reports lots of keys, two analog sticks
and two analog buttons. We report all data through extension input device to
userspace.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-ext.c |  156 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 8127207..8e3b6ce 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -40,12 +40,42 @@ enum wiiext_type {
 enum wiiext_keys {
 	WIIEXT_KEY_C,
 	WIIEXT_KEY_Z,
+	WIIEXT_KEY_A,
+	WIIEXT_KEY_B,
+	WIIEXT_KEY_X,
+	WIIEXT_KEY_Y,
+	WIIEXT_KEY_ZL,
+	WIIEXT_KEY_ZR,
+	WIIEXT_KEY_PLUS,
+	WIIEXT_KEY_MINUS,
+	WIIEXT_KEY_HOME,
+	WIIEXT_KEY_LEFT,
+	WIIEXT_KEY_RIGHT,
+	WIIEXT_KEY_UP,
+	WIIEXT_KEY_DOWN,
+	WIIEXT_KEY_LT,
+	WIIEXT_KEY_RT,
 	WIIEXT_KEY_COUNT
 };
 
 static __u16 wiiext_keymap[] = {
 	BTN_C,		/* WIIEXT_KEY_C */
 	BTN_Z,		/* WIIEXT_KEY_Z */
+	BTN_A,		/* WIIEXT_KEY_A */
+	BTN_B,		/* WIIEXT_KEY_B */
+	BTN_X,		/* WIIEXT_KEY_X */
+	BTN_Y,		/* WIIEXT_KEY_Y */
+	BTN_TL2,	/* WIIEXT_KEY_ZL */
+	BTN_TR2,	/* WIIEXT_KEY_ZR */
+	KEY_NEXT,	/* WIIEXT_KEY_PLUS */
+	KEY_PREVIOUS,	/* WIIEXT_KEY_MINUS */
+	BTN_MODE,	/* WIIEXT_KEY_HOME */
+	KEY_LEFT,	/* WIIEXT_KEY_LEFT */
+	KEY_RIGHT,	/* WIIEXT_KEY_RIGHT */
+	KEY_UP,		/* WIIEXT_KEY_UP */
+	KEY_DOWN,	/* WIIEXT_KEY_DOWN */
+	BTN_TL,		/* WIIEXT_KEY_LT */
+	BTN_TR,		/* WIIEXT_KEY_RT */
 };
 
 /* diable all extensions */
@@ -374,6 +404,120 @@ static void handler_nunchuck(struct wiimote_ext *ext, const __u8 *payload)
 
 static void handler_classic(struct wiimote_ext *ext, const __u8 *payload)
 {
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
+	if (ext->motionp) {
+		lx = payload[0] & 0x3e;
+		ly = payload[0] & 0x3e;
+	} else {
+		lx = payload[0] & 0x3f;
+		ly = payload[0] & 0x3f;
+	}
+
+	rx = (payload[0] >> 3) & 0x14;
+	rx |= (payload[1] >> 5) & 0x06;
+	rx |= (payload[2] >> 7) & 0x01;
+	ry = payload[2] & 0x1f;
+
+	rt = payload[3] & 0x1f;
+	lt = (payload[2] >> 2) & 0x18;
+	lt |= (payload[3] >> 5) & 0x07;
+
+	rx <<= 1;
+	ry <<= 1;
+	rt <<= 1;
+	lt <<= 1;
+
+	input_report_abs(ext->input, ABS_HAT1X, lx - 0x20);
+	input_report_abs(ext->input, ABS_HAT1Y, ly - 0x20);
+	input_report_abs(ext->input, ABS_HAT2X, rx - 0x20);
+	input_report_abs(ext->input, ABS_HAT2Y, ry - 0x20);
+	input_report_abs(ext->input, ABS_HAT3X, rt - 0x20);
+	input_report_abs(ext->input, ABS_HAT3Y, lt - 0x20);
+
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_RIGHT],
+							!!(payload[4] & 0x80));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_DOWN],
+							!!(payload[4] & 0x40));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_LT],
+							!!(payload[4] & 0x20));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_MINUS],
+							!!(payload[4] & 0x10));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_HOME],
+							!!(payload[4] & 0x08));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_PLUS],
+							!!(payload[4] & 0x04));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_RT],
+							!!(payload[4] & 0x02));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_ZL],
+							!!(payload[5] & 0x80));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_B],
+							!!(payload[5] & 0x40));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_Y],
+							!!(payload[5] & 0x20));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_A],
+							!!(payload[5] & 0x10));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_X],
+							!!(payload[5] & 0x08));
+	input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_ZR],
+							!!(payload[5] & 0x04));
+
+	if (ext->motionp) {
+		input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_UP],
+							!!(payload[0] & 0x01));
+		input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_LEFT],
+							!!(payload[1] & 0x01));
+	} else {
+		input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_UP],
+							!!(payload[5] & 0x01));
+		input_report_key(ext->input, wiiext_keymap[WIIEXT_KEY_LEFT],
+							!!(payload[5] & 0x02));
+	}
+
+	input_sync(ext->input);
 }
 
 /* call this with state.lock spinlock held */
@@ -513,8 +657,20 @@ int wiiext_init(struct wiimote_data *wdata)
 	set_bit(EV_ABS, ext->input->evbit);
 	set_bit(ABS_HAT0X, ext->input->absbit);
 	set_bit(ABS_HAT0Y, ext->input->absbit);
+	set_bit(ABS_HAT1X, ext->input->absbit);
+	set_bit(ABS_HAT1Y, ext->input->absbit);
+	set_bit(ABS_HAT2X, ext->input->absbit);
+	set_bit(ABS_HAT2Y, ext->input->absbit);
+	set_bit(ABS_HAT3X, ext->input->absbit);
+	set_bit(ABS_HAT3Y, ext->input->absbit);
 	input_set_abs_params(ext->input, ABS_HAT0X, -120, 120, 2, 4);
 	input_set_abs_params(ext->input, ABS_HAT0Y, -120, 120, 2, 4);
+	input_set_abs_params(ext->input, ABS_HAT1X, -30, 30, 1, 1);
+	input_set_abs_params(ext->input, ABS_HAT1Y, -30, 30, 1, 1);
+	input_set_abs_params(ext->input, ABS_HAT2X, -30, 30, 1, 1);
+	input_set_abs_params(ext->input, ABS_HAT2Y, -30, 30, 1, 1);
+	input_set_abs_params(ext->input, ABS_HAT3X, -30, 30, 1, 1);
+	input_set_abs_params(ext->input, ABS_HAT3Y, -30, 30, 1, 1);
 	set_bit(ABS_RX, ext->input->absbit);
 	set_bit(ABS_RY, ext->input->absbit);
 	set_bit(ABS_RZ, ext->input->absbit);
-- 
1.7.7

