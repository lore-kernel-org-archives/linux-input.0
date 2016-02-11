From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] psmouse: added BYD touchpad driver
Date: Wed, 10 Feb 2016 18:58:08 -0800
Message-ID: <56BBF8C0.6050709@gmail.com>
References: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
 <20160203004153.GA15147@smaug>
 <CAHc7Qt3cMu4+qXvruXtY7-GxL=skaUda1c4bfA5DDdNMfOfKGg@mail.gmail.com>
 <20160203085816.GA3307@smaug> <56B23203.3080509@gmail.com>
 <20160203202803.GA18677@smaug> <56B2E703.8000708@gmail.com>
 <20160205185546.GA7505@smaug> <56B691D2.7060902@gmail.com>
 <56B69C3F.9060505@gmail.com> <20160209233617.GA1334@smaug>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35244 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbcBKC6H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2016 21:58:07 -0500
In-Reply-To: <20160209233617.GA1334@smaug>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Ok I think this about covers it.  The line length issues remain, but the script
repors them as warnings so I'm not to worried about it.  Patch follows:
---
Input: BYD: Added proper touch support

Implemented absolute position and touch reporting.  Now BYD touchpads will use 
the synaptics/libinput xorg touchpad drivers.  Added documenatation for all 
known gesture packets and initialization commands.

Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
---
>From c0d0ece9ace3939691831eb20c2a5f01343781f1 Mon Sep 17 00:00:00 2001
From: pospeselr <pospeselr@gmail.com>
Date: Wed, 10 Feb 2016 18:24:00 -0800
Subject: [PATCH] byd changes

---
 drivers/input/mouse/byd.c          | 577 ++++++++++++++++++++++++-------------
 drivers/input/mouse/psmouse-base.c |   2 +-
 2 files changed, 378 insertions(+), 201 deletions(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 9425e0f..4c388ed 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -2,20 +2,32 @@
  * BYD TouchPad PS/2 mouse driver
  *
  * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
+ * Copyright (C) 2015 Richard Pospesel <pospeselr@gmail.com>
+ * Copyright (C) 2015 Tai Chi Minh Ralph Eastwood
+ * Copyright (C) 2015 Martin Wimpress
+ * Copyright (C) 2015 Jay Kuri
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
+ *
+ * Protocol of BYD Touch Pad reverse-engineered from windows driver:
+ * filename:  "byd touchpad driver - win7, 8, 8.1 - 2.4.1.102.zip"
+ * md5:       0d5e4660b98fca9587a0df212fca3048
+ * sha1:      97a0eca8edc482bf9d08ab9509084a514dad4c4b
+ * datasheet: http://bydit.com/userfiles/file/BTP10463-XXX.pdf
  */
 
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/libps2.h>
 #include <linux/serio.h>
+#include <linux/slab.h>
 
 #include "psmouse.h"
 #include "byd.h"
 
+/* PS2 Bits */
 #define PS2_Y_OVERFLOW	BIT_MASK(7)
 #define PS2_X_OVERFLOW	BIT_MASK(6)
 #define PS2_Y_SIGN	BIT_MASK(5)
@@ -26,69 +38,246 @@
 #define PS2_LEFT	BIT_MASK(0)
 
 /*
- * The touchpad reports gestures in the last byte of each packet. It can take
- * any of the following values:
+ * BYD pad constants
  */
 
-/* One-finger scrolling in one of the edge scroll zones. */
-#define BYD_SCROLLUP		0xCA
-#define BYD_SCROLLDOWN		0x36
-#define BYD_SCROLLLEFT		0xCB
-#define BYD_SCROLLRIGHT		0x35
-/* Two-finger scrolling. */
-#define BYD_2DOWN		0x2B
-#define BYD_2UP			0xD5
-#define BYD_2LEFT		0xD6
-#define BYD_2RIGHT		0x2A
-/* Pinching in or out. */
-#define BYD_ZOOMOUT		0xD8
-#define BYD_ZOOMIN		0x28
-/* Three-finger swipe. */
-#define BYD_3UP			0xD3
-#define BYD_3DOWN		0x2D
-#define BYD_3LEFT		0xD4
-#define BYD_3RIGHT		0x2C
-/* Four-finger swipe. */
-#define BYD_4UP			0xCD
-#define BYD_4DOWN		0x33
+/*
+ * True device resolution is unknown, however experiments show the
+ * resolution is about 111 units/mm.
+ * Absolute coordinate packets are in the range 0-255 for both X and Y
+ * we pick ABS_X/ABS_Y dimensions which are multiples of 256 and in
+ * the right ballpark given the touchpad's physical dimensions and estimate
+ * resolution per spec sheet, device active area dimensions are
+ * 101.6 x 60.1 mm.
+ */
+#define BYD_PAD_WIDTH		11264
+#define BYD_PAD_HEIGHT		6656
+#define BYD_PAD_RESOLUTION	111
 
-int byd_detect(struct psmouse *psmouse, bool set_properties)
-{
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[4];
+/*
+ * Given the above dimensions, relative packets velocity is in multiples of
+ * 1 unit / 11 milliseconds.  We use this dt to estimate distance traveled
+ */
+#define BYD_DT			11
+/* Time in milliseconds used to timeout various touch events */
+#define BYD_TOUCH_TIMEOUT	64
 
-	param[0] = 0x03;
-	param[1] = 0x00;
-	param[2] = 0x00;
-	param[3] = 0x00;
+/* BYD commands reverse engineered from windows driver */
 
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
-		return -1;
-
-	if (param[1] != 0x03 || param[2] != 0x64)
-		return -ENODEV;
+/*
+ * Swipe gesture from off-pad to on-pad
+ *  0 : disable
+ *  1 : enable
+ */
+#define BYD_CMD_SET_OFFSCREEN_SWIPE		0x10cc
+/*
+ * Tap and drag delay time
+ *  0 : disable
+ *  1 - 8 : least to most delay
+ */
+#define BYD_CMD_SET_TAP_DRAG_DELAY_TIME		0x10cf
+/*
+ * Physical buttons function mapping
+ *  0 : enable
+ *  4 : normal
+ *  5 : left button custom command
+ *  6 : right button custom command
+ *  8 : disable
+ */
+#define BYD_CMD_SET_PHYSICAL_BUTTONS		0x10d0
+/*
+ * Absolute mode (1 byte X/Y resolution)
+ *  0 : disable
+ *  2 : enable
+ */
+#define BYD_CMD_SET_ABSOLUTE_MODE		0x10d1
+/*
+ * Two finger scrolling
+ *  1 : vertical
+ *  2 : horizontal
+ *  3 : vertical + horizontal
+ *  4 : disable
+ */
+#define BYD_CMD_SET_TWO_FINGER_SCROLL		0x10d2
+/*
+ * Handedness
+ *  1 : right handed
+ *  2 : left handed
+ */
+#define BYD_CMD_SET_HANDEDNESS			0x10d3
+/*
+ * Tap to click
+ *  1 : enable
+ *  2 : disable
+ */
+#define BYD_CMD_SET_TAP				0x10d4
+/*
+ * Tap and drag
+ *  1 : tap and hold to drag
+ *  2 : tap and hold to drag + lock
+ *  3 : disable
+ */
+#define BYD_CMD_SET_TAP_DRAG			0x10d5
+/*
+ * Touch sensitivity
+ *  1 - 7 : least to most sensitive
+ */
+#define BYD_CMD_SET_TOUCH_SENSITIVITY		0x10d6
+/*
+ * One finger scrolling
+ *  1 : vertical
+ *  2 : horizontal
+ *  3 : vertical + horizontal
+ *  4 : disable
+ */
+#define BYD_CMD_SET_ONE_FINGER_SCROLL		0x10d7
+/*
+ * One finger scrolling function
+ *  1 : free scrolling
+ *  2 : edge motion
+ *  3 : free scrolling + edge motion
+ *  4 : disable
+ */
+#define BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC	0x10d8
+/*
+ * Sliding speed
+ *  1 - 5 : slowest to fastest
+ */
+#define BYD_CMD_SET_SLIDING_SPEED		0x10da
+/*
+ * Edge motion
+ *  1 : disable
+ *  2 : enable when dragging
+ *  3 : enable when dragging and pointing
+ */
+#define BYD_CMD_SET_EDGE_MOTION			0x10db
+/*
+ * Left edge region size
+ *  0 - 7 : smallest to largest width
+ */
+#define BYD_CMD_SET_LEFT_EDGE_REGION		0x10dc
+/*
+ * Top edge region size
+ *  0 - 9 : smallest to largest height
+ */
+#define BYD_CMD_SET_TOP_EDGE_REGION		0x10dd
+/*
+ * Disregard palm press as clicks
+ *  1 - 6 : smallest to largest
+ */
+#define BYD_CMD_SET_PALM_CHECK			0x10de
+/*
+ * Right edge region size
+ *  0 - 7 : smallest to largest width
+ */
+#define BYD_CMD_SET_RIGHT_EDGE_REGION		0x10df
+/*
+ * Bottom edge region size
+ *  0 - 9 : smallest to largest height
+ */
+#define BYD_CMD_SET_BOTTOM_EDGE_REGION		0x10e1
+/*
+ * Multitouch gestures
+ *  1 : enable
+ *  2 : disable
+ */
+#define BYD_CMD_SET_MULTITOUCH			0x10e3
+/*
+ * Edge motion speed
+ *  0 : control with finger pressure
+ *  1 - 9 : slowest to fastest
+ */
+#define BYD_CMD_SET_EDGE_MOTION_SPEED		0x10e4
+/*
+ * Two finger scolling function
+ *  0 : free scrolling
+ *  1 : free scrolling (with momentum)
+ *  2 : edge motion
+ *  3 : free scrolling (with momentum) + edge motion
+ *  4 : disable
+ */
+#define BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC	0x10e5
 
-	psmouse_dbg(psmouse, "BYD touchpad detected\n");
+/*
+ * The touchpad generates a mixture of absolute and relative packets, indicated
+ * by the the last byte of each packet being set to one of the following:
+ */
+#define BYD_PACKET_ABSOLUTE			0xf8
+#define BYD_PACKET_RELATIVE			0x00
+/* Multitouch gesture packets */
+#define BYD_PACKET_PINCH_IN			0xd8
+#define BYD_PACKET_PINCH_OUT			0x28
+#define BYD_PACKET_ROTATE_CLOCKWISE		0x29
+#define BYD_PACKET_ROTATE_ANTICLOCKWISE		0xd7
+#define BYD_PACKET_TWO_FINGER_SCROLL_RIGHT	0x2a
+#define BYD_PACKET_TWO_FINGER_SCROLL_DOWN	0x2b
+#define BYD_PACKET_TWO_FINGER_SCROLL_UP		0xd5
+#define BYD_PACKET_TWO_FINGER_SCROLL_LEFT	0xd6
+#define BYD_PACKET_THREE_FINGER_SWIPE_RIGHT	0x2c
+#define BYD_PACKET_THREE_FINGER_SWIPE_DOWN	0x2d
+#define BYD_PACKET_THREE_FINGER_SWIPE_UP	0xd3
+#define BYD_PACKET_THREE_FINGER_SWIPE_LEFT	0xd4
+#define BYD_PACKET_FOUR_FINGER_DOWN		0x33
+#define BYD_PACKET_FOUR_FINGER_UP		0xcd
+#define BYD_PACKET_REGION_SCROLL_RIGHT		0x35
+#define BYD_PACKET_REGION_SCROLL_DOWN		0x36
+#define BYD_PACKET_REGION_SCROLL_UP		0xca
+#define BYD_PACKET_REGION_SCROLL_LEFT		0xcb
+#define BYD_PACKET_RIGHT_CORNER_CLICK		0xd2
+#define BYD_PACKET_LEFT_CORNER_CLICK		0x2e
+#define BYD_PACKET_LEFT_AND_RIGHT_CORNER_CLICK	0x2f
+#define BYD_PACKET_ONTO_PAD_SWIPE_RIGHT		0x37
+#define BYD_PACKET_ONTO_PAD_SWIPE_DOWN		0x30
+#define BYD_PACKET_ONTO_PAD_SWIPE_UP		0xd0
+#define BYD_PACKET_ONTO_PAD_SWIPE_LEFT		0xc9
+
+struct byd_data {
+	struct timer_list timer;
+	s32 abs_x;
+	s32 abs_y;
+	u32 last_touch_time;
+	bool btn_left  : 1;
+	bool btn_right : 1;
+	bool touch     : 1;
+};
+
+static void byd_report_input(struct psmouse *psmouse)
+{
+	struct byd_data *priv = psmouse->private;
+	struct input_dev *dev = psmouse->dev;
 
-	if (set_properties) {
-		psmouse->vendor = "BYD";
-		psmouse->name = "TouchPad";
-	}
+	input_report_abs(dev, ABS_X, priv->abs_x);
+	input_report_abs(dev, ABS_Y, priv->abs_y);
+	input_report_key(dev, BTN_LEFT, priv->btn_left);
+	input_report_key(dev, BTN_RIGHT, priv->btn_right);
+	input_report_key(dev, BTN_TOUCH, priv->touch);
+	input_report_key(dev, BTN_TOOL_FINGER, priv->touch);
+	input_sync(dev);
+}
 
-	return 0;
+static void byd_clear_touch(unsigned long data)
+{
+	struct psmouse *psmouse = (struct psmouse *)data;
+	struct byd_data *priv = psmouse->private;
+
+	serio_pause_rx(psmouse->ps2dev.serio);
+	priv->touch = false;
+	/*
+	 * Move cursor back to center of pad when we lose touch - this
+	 * specifically improves user experience when moving cursor with one
+	 * finger, and pressing a button with another.
+	 */
+	priv->abs_x = BYD_PAD_WIDTH / 2;
+	priv->abs_y = BYD_PAD_HEIGHT / 2;
+	byd_report_input(psmouse);
+
+	serio_continue_rx(psmouse->ps2dev.serio);
 }
 
 static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
 {
-	struct input_dev *dev = psmouse->dev;
+	struct byd_data *priv = psmouse->private;
+	u32 now_msecs = jiffies_to_msecs(jiffies);
 	u8 *pkt = psmouse->packet;
 
 	if (psmouse->pktcnt > 0 && !(pkt[0] & PS2_ALWAYS_1)) {
@@ -102,53 +291,33 @@ static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
 
 	/* Otherwise, a full packet has been received */
 	switch (pkt[3]) {
-	case 0: {
+	case BYD_PACKET_ABSOLUTE:
+		/* Only use absolute packets for the start of movement. */
+		if (!priv->touch) {
+			priv->abs_x = pkt[1] * (BYD_PAD_WIDTH / 256);
+			priv->abs_y = (255 - pkt[2]) *
+				      (BYD_PAD_HEIGHT / 256);
+
+			/* needed to detect tap */
+			if (now_msecs - priv->last_touch_time > BYD_TOUCH_TIMEOUT)
+				priv->touch = true;
+		}
+		break;
+	case BYD_PACKET_RELATIVE: {
 		/* Standard packet */
 		/* Sign-extend if a sign bit is set. */
-		unsigned int signx = pkt[0] & PS2_X_SIGN ? ~0xFF : 0;
-		unsigned int signy = pkt[0] & PS2_Y_SIGN ? ~0xFF : 0;
-		int dx = signx | (int) pkt[1];
-		int dy = signy | (int) pkt[2];
+		u32 signx = pkt[0] & PS2_X_SIGN ? ~0xFF : 0;
+		u32 signy = pkt[0] & PS2_Y_SIGN ? ~0xFF : 0;
+		s32 dx = signx | (int) pkt[1];
+		s32 dy = signy | (int) pkt[2];
 
-		input_report_rel(psmouse->dev, REL_X, dx);
-		input_report_rel(psmouse->dev, REL_Y, -dy);
+		/* Update position based on velocity */
+		priv->abs_x += dx * BYD_DT;
+		priv->abs_y -= dy * BYD_DT;
 
-		input_report_key(psmouse->dev, BTN_LEFT, pkt[0] & PS2_LEFT);
-		input_report_key(psmouse->dev, BTN_RIGHT, pkt[0] & PS2_RIGHT);
-		input_report_key(psmouse->dev, BTN_MIDDLE, pkt[0] & PS2_MIDDLE);
+		priv->touch = true;
 		break;
 	}
-
-	case BYD_SCROLLDOWN:
-	case BYD_2DOWN:
-		input_report_rel(dev, REL_WHEEL, -1);
-		break;
-
-	case BYD_SCROLLUP:
-	case BYD_2UP:
-		input_report_rel(dev, REL_WHEEL, 1);
-		break;
-
-	case BYD_SCROLLLEFT:
-	case BYD_2LEFT:
-		input_report_rel(dev, REL_HWHEEL, -1);
-		break;
-
-	case BYD_SCROLLRIGHT:
-	case BYD_2RIGHT:
-		input_report_rel(dev, REL_HWHEEL, 1);
-		break;
-
-	case BYD_ZOOMOUT:
-	case BYD_ZOOMIN:
-	case BYD_3UP:
-	case BYD_3DOWN:
-	case BYD_3LEFT:
-	case BYD_3RIGHT:
-	case BYD_4UP:
-	case BYD_4DOWN:
-		break;
-
 	default:
 		psmouse_warn(psmouse,
 			     "Unrecognized Z: pkt = %02x %02x %02x %02x\n",
@@ -157,134 +326,76 @@ static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
 		return PSMOUSE_BAD_DATA;
 	}
 
-	input_sync(dev);
+	priv->btn_left = pkt[0] & PS2_LEFT;
+	priv->btn_right = pkt[0] & PS2_RIGHT;
 
-	return PSMOUSE_FULL_PACKET;
-}
-
-/* Send a sequence of bytes, where each is ACKed before the next is sent. */
-static int byd_send_sequence(struct psmouse *psmouse, const u8 *seq, size_t len)
-{
-	unsigned int i;
+	byd_report_input(psmouse);
 
-	for (i = 0; i < len; ++i) {
-		if (ps2_command(&psmouse->ps2dev, NULL, seq[i]))
-			return -1;
+	/* Reset time since last touch. */
+	if (priv->touch) {
+		priv->last_touch_time = now_msecs;
+		mod_timer(&priv->timer, jiffies + msecs_to_jiffies(BYD_TOUCH_TIMEOUT));
 	}
-	return 0;
-}
-
-/* Keep scrolling after fingers are removed. */
-#define SCROLL_INERTIAL		0x01
-#define SCROLL_NO_INERTIAL	0x02
-
-/* Clicking can be done by tapping or pressing. */
-#define CLICK_BOTH		0x01
-/* Clicking can only be done by pressing. */
-#define CLICK_PRESS_ONLY	0x02
-
-static int byd_enable(struct psmouse *psmouse)
-{
-	const u8 seq1[] = { 0xE2, 0x00, 0xE0, 0x02, 0xE0 };
-	const u8 seq2[] = {
-		0xD3, 0x01,
-		0xD0, 0x00,
-		0xD0, 0x04,
-		/* Whether clicking is done by tapping or pressing. */
-		0xD4, CLICK_PRESS_ONLY,
-		0xD5, 0x01,
-		0xD7, 0x03,
-		/* Vertical and horizontal one-finger scroll zone inertia. */
-		0xD8, SCROLL_INERTIAL,
-		0xDA, 0x05,
-		0xDB, 0x02,
-		0xE4, 0x05,
-		0xD6, 0x01,
-		0xDE, 0x04,
-		0xE3, 0x01,
-		0xCF, 0x00,
-		0xD2, 0x03,
-		/* Vertical and horizontal two-finger scrolling inertia. */
-		0xE5, SCROLL_INERTIAL,
-		0xD9, 0x02,
-		0xD9, 0x07,
-		0xDC, 0x03,
-		0xDD, 0x03,
-		0xDF, 0x03,
-		0xE1, 0x03,
-		0xD1, 0x00,
-		0xCE, 0x00,
-		0xCC, 0x00,
-		0xE0, 0x00,
-		0xE2, 0x01
-	};
-	u8 param[4];
-
-	if (byd_send_sequence(psmouse, seq1, ARRAY_SIZE(seq1)))
-		return -1;
 
-	/* Send a 0x01 command, which should return 4 bytes. */
-	if (ps2_command(&psmouse->ps2dev, param, 0x0401))
-		return -1;
-
-	if (byd_send_sequence(psmouse, seq2, ARRAY_SIZE(seq2)))
-		return -1;
-
-	return 0;
+	return PSMOUSE_FULL_PACKET;
 }
 
-/*
- * Send the set of PS/2 commands required to make it identify as an
- * intellimouse with 4-byte instead of 3-byte packets.
- */
-static int byd_send_intellimouse_sequence(struct psmouse *psmouse)
+static int byd_reset_touchpad(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[4];
-	int i;
+	size_t i;
+
 	const struct {
 		u16 command;
 		u8 arg;
 	} seq[] = {
-		{ PSMOUSE_CMD_RESET_BAT, 0 },
-		{ PSMOUSE_CMD_RESET_BAT, 0 },
-		{ PSMOUSE_CMD_GETID, 0 },
-		{ PSMOUSE_CMD_SETSCALE11, 0 },
-		{ PSMOUSE_CMD_SETSCALE11, 0 },
-		{ PSMOUSE_CMD_SETSCALE11, 0 },
-		{ PSMOUSE_CMD_GETINFO, 0 },
-		{ PSMOUSE_CMD_SETRES, 0x03 },
+		/*
+		 * Intellimouse initialization sequence, to get 4-byte instead
+		 * of 3-byte packets.
+		 */
 		{ PSMOUSE_CMD_SETRATE, 0xC8 },
 		{ PSMOUSE_CMD_SETRATE, 0x64 },
 		{ PSMOUSE_CMD_SETRATE, 0x50 },
 		{ PSMOUSE_CMD_GETID, 0 },
-		{ PSMOUSE_CMD_SETRATE, 0xC8 },
-		{ PSMOUSE_CMD_SETRATE, 0xC8 },
-		{ PSMOUSE_CMD_SETRATE, 0x50 },
-		{ PSMOUSE_CMD_GETID, 0 },
-		{ PSMOUSE_CMD_SETRATE, 0x64 },
-		{ PSMOUSE_CMD_SETRES, 0x03 },
-		{ PSMOUSE_CMD_ENABLE, 0 }
+		{ PSMOUSE_CMD_ENABLE, 0 },
+		/*
+		 * BYD-specific initialization, which enables absolute mode and
+		 * (if desired), the touchpad's built-in gesture detection.
+		 */
+		{ 0x10E2, 0x00 },
+		{ 0x10E0, 0x02 },
+		/* The touchpad should reply with 4 seemingly-random bytes */
+		{ 0x14E0, 0x01 },
+		/* Pairs of parameters and values. */
+		{ BYD_CMD_SET_HANDEDNESS, 0x01 },
+		{ BYD_CMD_SET_PHYSICAL_BUTTONS, 0x04 },
+		{ BYD_CMD_SET_TAP, 0x02 },
+		{ BYD_CMD_SET_ONE_FINGER_SCROLL, 0x04 },
+		{ BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC, 0x04 },
+		{ BYD_CMD_SET_EDGE_MOTION, 0x01 },
+		{ BYD_CMD_SET_PALM_CHECK, 0x00 },
+		{ BYD_CMD_SET_MULTITOUCH, 0x02 },
+		{ BYD_CMD_SET_TWO_FINGER_SCROLL, 0x04 },
+		{ BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC, 0x04 },
+		{ BYD_CMD_SET_LEFT_EDGE_REGION, 0x00 },
+		{ BYD_CMD_SET_TOP_EDGE_REGION, 0x00 },
+		{ BYD_CMD_SET_RIGHT_EDGE_REGION, 0x00 },
+		{ BYD_CMD_SET_BOTTOM_EDGE_REGION, 0x00 },
+		{ BYD_CMD_SET_ABSOLUTE_MODE, 0x02 },
+		/* Finalize initialization. */
+		{ 0x10E0, 0x00 },
+		{ 0x10E2, 0x01 },
 	};
 
-	memset(param, 0, sizeof(param));
 	for (i = 0; i < ARRAY_SIZE(seq); ++i) {
+		memset(param, 0, sizeof(param));
 		param[0] = seq[i].arg;
 		if (ps2_command(ps2dev, param, seq[i].command))
-			return -1;
-	}
-
-	return 0;
-}
-
-static int byd_reset_touchpad(struct psmouse *psmouse)
-{
-	if (byd_send_intellimouse_sequence(psmouse))
-		return -EIO;
-
-	if (byd_enable(psmouse))
-		return -EIO;
+			return -EIO;
 
+	}
+	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 	return 0;
 }
 
@@ -314,9 +425,50 @@ static int byd_reconnect(struct psmouse *psmouse)
 	return 0;
 }
 
+static void byd_disconnect(struct psmouse *psmouse)
+{
+	struct byd_data *priv = psmouse->private;
+
+	if (priv) {
+		del_timer(&priv->timer);
+		kfree(psmouse->private);
+		psmouse->private = NULL;
+	}
+}
+
+int byd_detect(struct psmouse *psmouse, bool set_properties)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
+
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+		return -1;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+		return -1;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+		return -1;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+		return -1;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+		return -1;
+
+	if (param[1] != 0x03 || param[2] != 0x64)
+		return -ENODEV;
+
+	psmouse_dbg(psmouse, "BYD touchpad detected\n");
+
+	if (set_properties) {
+		psmouse->vendor = "BYD";
+		psmouse->name = "TouchPad";
+	}
+
+	return 0;
+}
+
 int byd_init(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
+	struct byd_data *priv;
 
 	if (psmouse_reset(psmouse))
 		return -EIO;
@@ -324,14 +476,39 @@ int byd_init(struct psmouse *psmouse)
 	if (byd_reset_touchpad(psmouse))
 		return -EIO;
 
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	memset(priv, 0, sizeof(*priv));
+	setup_timer(&priv->timer, byd_clear_touch, (unsigned long) psmouse);
+
+	psmouse->private = priv;
+	psmouse->disconnect = byd_disconnect;
 	psmouse->reconnect = byd_reconnect;
 	psmouse->protocol_handler = byd_process_byte;
 	psmouse->pktsize = 4;
 	psmouse->resync_time = 0;
 
-	__set_bit(BTN_MIDDLE, dev->keybit);
-	__set_bit(REL_WHEEL, dev->relbit);
-	__set_bit(REL_HWHEEL, dev->relbit);
+	__set_bit(INPUT_PROP_POINTER, dev->propbit);
+	/* Touchpad */
+	__set_bit(BTN_TOUCH, dev->keybit);
+	__set_bit(BTN_TOOL_FINGER, dev->keybit);
+	/* Buttons */
+	__set_bit(BTN_LEFT, dev->keybit);
+	__set_bit(BTN_RIGHT, dev->keybit);
+	__clear_bit(BTN_MIDDLE, dev->keybit);
+
+	/* Absolute position */
+	__set_bit(EV_ABS, dev->evbit);
+	input_set_abs_params(dev, ABS_X, 0, BYD_PAD_WIDTH, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, BYD_PAD_HEIGHT, 0, 0);
+	input_abs_set_res(dev, ABS_X, BYD_PAD_RESOLUTION);
+	input_abs_set_res(dev, ABS_Y, BYD_PAD_RESOLUTION);
+	/* No relative support */
+	__clear_bit(EV_REL, dev->evbit);
+	__clear_bit(REL_X, dev->relbit);
+	__clear_bit(REL_Y, dev->relbit);
 
 	return 0;
 }
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 39d1bec..5784e20 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -846,7 +846,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 #ifdef CONFIG_MOUSE_PS2_BYD
 	{
 		.type		= PSMOUSE_BYD,
-		.name		= "BydPS/2",
+		.name		= "BYDPS/2",
 		.alias		= "byd",
 		.detect		= byd_detect,
 		.init		= byd_init,
-- 
2.6.4




On 02/09/2016 03:36 PM, Chris Diamand wrote:
> Hi Richard,
> 
> The patch applies! So your email client is working at last :)
> 
> Looks good, just some style issues to fix now.
> 
>> Updated BYD driver to report absolute coordinates and single-touch events.   
>>
>> Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
>> ---o
> 
> I think the commit message needs to follow some style guidelines as
> well. Something like:
> 
> Input: byd - report absolute coordinates
>             <blank line>
> More details...
> 
> Also can you use `git format-patch' to create your patches? That'll
> include your name and email so people can commit the patch directly
> with `git am'.
> 
>> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
>> index 9425e0f..2900a3d 100644
>> --- a/drivers/input/mouse/byd.c
>> +++ b/drivers/input/mouse/byd.c
>> @@ -2,20 +2,32 @@
>>   * BYD TouchPad PS/2 mouse driver
>>   *
>>   * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
>> + * Copyright (C) 2015 Richard Pospesel
>> + * Copyright (C) 2015 Tai Chi Minh Ralph Eastwood
>> + * Copyright (C) 2015 Martin Wimpress
>> + * Copyright (C) 2015 Jay Kuri
>>   *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms of the GNU General Public License version 2 as published by
>>   * the Free Software Foundation.
>> + *
>> + * Protocol of BYD Touch Pad reverse-engineered from windows driver:
>> + * filename:  "byd touchpad driver - win7, 8, 8.1 - 2.4.1.102.zip"
>> + * md5:       0d5e4660b98fca9587a0df212fca3048
>> + * sha1:      97a0eca8edc482bf9d08ab9509084a514dad4c4b
>> + * datasheet: http://bydit.com/userfiles/file/BTP10463-XXX.pdf
>>   */
>>  
>>  #include <linux/delay.h>
>>  #include <linux/input.h>
>>  #include <linux/libps2.h>
>>  #include <linux/serio.h>
>> +#include <linux/slab.h>
>>  
>>  #include "psmouse.h"
>>  #include "byd.h"
>>  
>> +/* PS2 Bits */
>>  #define PS2_Y_OVERFLOW	BIT_MASK(7)
>>  #define PS2_X_OVERFLOW	BIT_MASK(6)
>>  #define PS2_Y_SIGN	BIT_MASK(5)
>> @@ -26,69 +38,246 @@
>>  #define PS2_LEFT	BIT_MASK(0)
>>  
>>  /*
>> - * The touchpad reports gestures in the last byte of each packet. It can take
>> - * any of the following values:
>> + * BYD pad constants
>>   */
>>  
>> -/* One-finger scrolling in one of the edge scroll zones. */
>> -#define BYD_SCROLLUP		0xCA
>> -#define BYD_SCROLLDOWN		0x36
>> -#define BYD_SCROLLLEFT		0xCB
>> -#define BYD_SCROLLRIGHT		0x35
>> -/* Two-finger scrolling. */
>> -#define BYD_2DOWN		0x2B
>> -#define BYD_2UP			0xD5
>> -#define BYD_2LEFT		0xD6
>> -#define BYD_2RIGHT		0x2A
>> -/* Pinching in or out. */
>> -#define BYD_ZOOMOUT		0xD8
>> -#define BYD_ZOOMIN		0x28
>> -/* Three-finger swipe. */
>> -#define BYD_3UP			0xD3
>> -#define BYD_3DOWN		0x2D
>> -#define BYD_3LEFT		0xD4
>> -#define BYD_3RIGHT		0x2C
>> -/* Four-finger swipe. */
>> -#define BYD_4UP			0xCD
>> -#define BYD_4DOWN		0x33
>> +/*
>> + * True device resolution is unknown, however experiments show the
>> + * resolution is about 111 units/mm.
>> + * Absolute coordinate packets are in the range 0-255 for both X and Y
>> + * we pick ABS_X/ABS_Y dimensions which are multiples of 256 and in
>> + * the right ballpark given the touchpad's physical dimensions and estimate
>> + * resolution per spec sheet, device active area dimensions are
>> + * 101.6 x 60.1 mm.
>> + */
>> +#define BYD_PAD_WIDTH	    11264
>> +#define BYD_PAD_HEIGHT      6656
>> +#define BYD_PAD_RESOLUTION  111
>>  
>> -int byd_detect(struct psmouse *psmouse, bool set_properties)
>> -{
>> -	struct ps2dev *ps2dev = &psmouse->ps2dev;
>> -	unsigned char param[4];
>> +/*
>> + * Given the above dimensions, relative packets velocity is in multiples of
>> + * 1 unit / 11 milliseconds.  We use this dt to estimate distance traveled
>> + */
>> +#define BYD_DT              11
>> +/* Time in milliseconds used to timeout various touch events */
>> +#define BYD_TOUCH_TIMEOUT   64
>>  
>> -	param[0] = 0x03;
>> -	param[1] = 0x00;
>> -	param[2] = 0x00;
>> -	param[3] = 0x00;
>> +/* BYD commands reverse engineered from windows driver */
>>  
>> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> -		return -1;
>> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> -		return -1;
>> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> -		return -1;
>> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> -		return -1;
>> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
>> -		return -1;
>> -
>> -	if (param[1] != 0x03 || param[2] != 0x64)
>> -		return -ENODEV;
>> +/*
>> + * Swipe gesture from off-pad to on-pad
>> + *  0 : disable
>> + *  1 : enable
>> + */
>> +#define BYD_CMD_SET_OFFSCREEN_SWIPE        0x10cc
>> +/*
>> + * Tap and drag delay time
>> + *  0 : disable
>> + *  1 - 8 : least to most delay
>> + */
>> +#define BYD_CMD_SET_TAP_DRAG_DELAY_TIME    0x10cf
>> +/*
>> + * Physical buttons function mapping
>> + *  0 : enable
>> + *  4 : normal
>> + *  5 : left button custom command
>> + *  6 : right button custom command
>> + *  8 : disable
>> + */
>> +#define BYD_CMD_SET_PHYSICAL_BUTTONS       0x10d0
>> +/*
>> + * Absolute mode (1 byte X/Y resolution)
>> + *  0 : disable
>> + *  2 : enable
>> + */
>> +#define BYD_CMD_SET_ABSOLUTE_MODE          0x10d1
>> +/*
>> + * Two finger scrolling
>> + *  1 : vertical
>> + *  2 : horizontal
>> + *  3 : vertical + horizontal
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_TWO_FINGER_SCROLL      0x10d2
>> +/*
>> + * Handedness
>> + *  1 : right handed
>> + *  2 : left handed
>> + */
>> +#define BYD_CMD_SET_HANDEDNESS             0x10d3
>> +/*
>> + * Tap to click
>> + *  1 : enable
>> + *  2 : disable
>> + */
>> +#define BYD_CMD_SET_TAP                    0x10d4
>> +/*
>> + * Tap and drag
>> + *  1 : tap and hold to drag
>> + *  2 : tap and hold to drag + lock
>> + *  3 : disable
>> + */
>> +#define BYD_CMD_SET_TAP_DRAG               0x10d5
>> +/*
>> + * Touch sensitivity
>> + *  1 - 7 : least to most sensitive
>> + */
>> +#define BYD_CMD_SET_TOUCH_SENSITIVITY      0x10d6
>> +/*
>> + * One finger scrolling
>> + *  1 : vertical
>> + *  2 : horizontal
>> + *  3 : vertical + horizontal
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_ONE_FINGER_SCROLL      0x10d7
>> +/*
>> + * One finger scrolling function
>> + *  1 : free scrolling
>> + *  2 : edge motion
>> + *  3 : free scrolling + edge motion
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC 0x10d8
>> +/*
>> + * Sliding speed
>> + *  1 - 5 : slowest to fastest
>> + */
>> +#define BYD_CMD_SET_SLIDING_SPEED          0x10da
>> +/*
>> + * Edge motion
>> + *  1 : disable
>> + *  2 : enable when dragging
>> + *  3 : enable when dragging and pointing
>> + */
>> +#define BYD_CMD_SET_EDGE_MOTION            0x10db
>> +/*
>> + * Left edge region size
>> + *  0 - 7 : smallest to largest width
>> + */
>> +#define BYD_CMD_SET_LEFT_EDGE_REGION       0x10dc
>> +/*
>> + * Top edge region size
>> + *  0 - 9 : smallest to largest height
>> + */
>> +#define BYD_CMD_SET_TOP_EDGE_REGION        0x10dd
>> +/*
>> + * Disregard palm press as clicks
>> + *  1 - 6 : smallest to largest
>> + */
>> +#define BYD_CMD_SET_PALM_CHECK             0x10de
>> +/*
>> + * Right edge region size
>> + *  0 - 7 : smallest to largest width
>> + */
>> +#define BYD_CMD_SET_RIGHT_EDGE_REGION      0x10df
>> +/*
>> + * Bottom edge region size
>> + *  0 - 9 : smallest to largest height
>> + */
>> +#define BYD_CMD_SET_BOTTOM_EDGE_REGION     0x10e1
>> +/*
>> + * Multitouch gestures
>> + *  1 : enable
>> + *  2 : disable
>> + */
>> +#define BYD_CMD_SET_MULTITOUCH             0x10e3
>> +/*
>> + * Edge motion speed
>> + *  0 : control with finger pressure
>> + *  1 - 9 : slowest to fastest
>> + */
>> +#define BYD_CMD_SET_EDGE_MOTION_SPEED      0x10e4
>> +/*
>> + * Two finger scolling function
>> + *  0 : free scrolling
>> + *  1 : free scrolling (with momentum)
>> + *  2 : edge motion
>> + *  3 : free scrolling (with momentum) + edge motion
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC 0x10e5
>>  
>> -	psmouse_dbg(psmouse, "BYD touchpad detected\n");
>> +/*
>> + * The touchpad generates a mixture of absolute and relative packets, indicated
>> + * by the the last byte of each packet being set to one of the following:
>> + */
>> +#define BYD_PACKET_ABSOLUTE                    0xF8
>> +#define BYD_PACKET_RELATIVE                    0x00
>> +/* Multitouch gesture packets */
>> +#define BYD_PACKET_PINCH_IN                    0xd8
>> +#define BYD_PACKET_PINCH_OUT                   0x28
>> +#define BYD_PACKET_ROTATE_CLOCKWISE            0x29
>> +#define BYD_PACKET_ROTATE_ANTICLOCKWISE        0xd7
>> +#define BYD_PACKET_TWO_FINGER_SCROLL_RIGHT     0x2a
>> +#define BYD_PACKET_TWO_FINGER_SCROLL_DOWN      0x2b
>> +#define BYD_PACKET_TWO_FINGER_SCROLL_UP        0xd5
>> +#define BYD_PACKET_TWO_FINGER_SCROLL_LEFT      0xd6
>> +#define BYD_PACKET_THREE_FINGER_SWIPE_RIGHT    0x2c
>> +#define BYD_PACKET_THREE_FINGER_SWIPE_DOWN     0x2d
>> +#define BYD_PACKET_THREE_FINGER_SWIPE_UP       0xd3
>> +#define BYD_PACKET_THREE_FINGER_SWIPE_LEFT     0xd4
>> +#define BYD_PACKET_FOUR_FINGER_DOWN            0x33
>> +#define BYD_PACKET_FOUR_FINGER_UP              0xcd
>> +#define BYD_PACKET_REGION_SCROLL_RIGHT         0x35
>> +#define BYD_PACKET_REGION_SCROLL_DOWN          0x36
>> +#define BYD_PACKET_REGION_SCROLL_UP            0xca
>> +#define BYD_PACKET_REGION_SCROLL_LEFT          0xcb
>> +#define BYD_PACKET_RIGHT_CORNER_CLICK          0xd2
>> +#define BYD_PACKET_LEFT_CORNER_CLICK           0x2e
>> +#define BYD_PACKET_LEFT_AND_RIGHT_CORNER_CLICK 0x2f
>> +#define BYD_PACKET_ONTO_PAD_SWIPE_RIGHT        0x37
>> +#define BYD_PACKET_ONTO_PAD_SWIPE_DOWN         0x30
>> +#define BYD_PACKET_ONTO_PAD_SWIPE_UP           0xd0
>> +#define BYD_PACKET_ONTO_PAD_SWIPE_LEFT         0xc9
> 
> Hmm. There aren't aligned to a multiple of 8. Can they be?
> 
> Also, re. using tabs or spaces for these - I personally have no
> particular preference, and I looked around other drivers and couldn't
> find any particular pattern. But: when Dmitry applied my patch, he
> changed my spaces to tabs. So we should probably go with that :)
> 
>> +
>> +struct byd_data {
>> +	struct timer_list timer;
>> +	s32 abs_x;
>> +	s32 abs_y;
>> +	u32 last_touch_time;
>> +	bool btn_left  : 1;
>> +	bool btn_right : 1;
>> +	bool touch     : 1;
>> +};
>> +
>> +static void byd_report_input(struct psmouse *psmouse)
>> +{
>> +	struct byd_data *priv = psmouse->private;
>> +	struct input_dev *dev = psmouse->dev;
>>  
>> -	if (set_properties) {
>> -		psmouse->vendor = "BYD";
>> -		psmouse->name = "TouchPad";
>> -	}
>> +	input_report_abs(dev, ABS_X, priv->abs_x);
>> +	input_report_abs(dev, ABS_Y, priv->abs_y);
>> +	input_report_key(dev, BTN_LEFT, priv->btn_left);
>> +	input_report_key(dev, BTN_RIGHT, priv->btn_right);
>> +	input_report_key(dev, BTN_TOUCH, priv->touch);
>> +	input_report_key(dev, BTN_TOOL_FINGER, priv->touch);
>> +	input_sync(dev);
>> +}
>>  
>> -	return 0;
>> +static void byd_clear_touch(unsigned long data)
>> +{
>> +	struct psmouse *psmouse = (struct psmouse*)data;
> 
> According to checkpatch.pl, needs a space between `psmouse' and `*':
> 
>     (struct psmouse *)
> 
> FYI - there's a script, `scripts/checkpatch.pl', which checks for
> style violations - if you run it on your patch it'll pick up stuff
> like this.
> 
>> +	struct byd_data *priv = psmouse->private;
>> +
>> +	serio_pause_rx(psmouse->ps2dev.serio);
>> +	priv->touch = false;
>> +	/*
>> +	 * Move cursor back to center of pad when we lose touch - this
>> +	 * specifically improves user experience when moving cursor with one
>> +	 * finger, and pressing a button with another.
>> +	 */
>> +	priv->abs_x = BYD_PAD_WIDTH / 2;
>> +	priv->abs_y = BYD_PAD_HEIGHT / 2;
>> +	byd_report_input(psmouse);
>> +
>> +	serio_continue_rx(psmouse->ps2dev.serio);
>>  }
>>  
>>  static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
>>  {
>> -	struct input_dev *dev = psmouse->dev;
>> +	struct byd_data *priv = psmouse->private;
>> +	u32 now_msecs = jiffies_to_msecs(jiffies);
>>  	u8 *pkt = psmouse->packet;
>>  
>>  	if (psmouse->pktcnt > 0 && !(pkt[0] & PS2_ALWAYS_1)) {
>> @@ -102,53 +291,33 @@ static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
>>  
>>  	/* Otherwise, a full packet has been received */
>>  	switch (pkt[3]) {
>> -	case 0: {
>> +	case BYD_PACKET_ABSOLUTE:
>> +		/* Only use absolute packets for the start of movement. */
>> +		if (!priv->touch) {
>> +			priv->abs_x = pkt[1] * (BYD_PAD_WIDTH / 256);
>> +			priv->abs_y = (255 - pkt[2]) *
>> +				      (BYD_PAD_HEIGHT / 256);
>> +
>> +			/* needed to detect tap */
>> +			if (now_msecs - priv->last_touch_time > BYD_TOUCH_TIMEOUT)
> 
> Line too long (according to checkpatch).
> 
>> +				priv->touch = true;
>> +		}
>> +		break;
>> +	case BYD_PACKET_RELATIVE: {
>>  		/* Standard packet */
>>  		/* Sign-extend if a sign bit is set. */
>> -		unsigned int signx = pkt[0] & PS2_X_SIGN ? ~0xFF : 0;
>> -		unsigned int signy = pkt[0] & PS2_Y_SIGN ? ~0xFF : 0;
>> -		int dx = signx | (int) pkt[1];
>> -		int dy = signy | (int) pkt[2];
>> +		u32 signx = pkt[0] & PS2_X_SIGN ? ~0xFF : 0;
>> +		u32 signy = pkt[0] & PS2_Y_SIGN ? ~0xFF : 0;
>> +		s32 dx = signx | (int) pkt[1];
>> +		s32 dy = signy | (int) pkt[2];
>>  
>> -		input_report_rel(psmouse->dev, REL_X, dx);
>> -		input_report_rel(psmouse->dev, REL_Y, -dy);
>> +		/* Update position based on velocity */
>> +		priv->abs_x += dx * BYD_DT;
>> +		priv->abs_y -= dy * BYD_DT;
>>  
>> -		input_report_key(psmouse->dev, BTN_LEFT, pkt[0] & PS2_LEFT);
>> -		input_report_key(psmouse->dev, BTN_RIGHT, pkt[0] & PS2_RIGHT);
>> -		input_report_key(psmouse->dev, BTN_MIDDLE, pkt[0] & PS2_MIDDLE);
>> +		priv->touch = true;
>>  		break;
>>  	}
>> -
>> -	case BYD_SCROLLDOWN:
>> -	case BYD_2DOWN:
>> -		input_report_rel(dev, REL_WHEEL, -1);
>> -		break;
>> -
>> -	case BYD_SCROLLUP:
>> -	case BYD_2UP:
>> -		input_report_rel(dev, REL_WHEEL, 1);
>> -		break;
>> -
>> -	case BYD_SCROLLLEFT:
>> -	case BYD_2LEFT:
>> -		input_report_rel(dev, REL_HWHEEL, -1);
>> -		break;
>> -
>> -	case BYD_SCROLLRIGHT:
>> -	case BYD_2RIGHT:
>> -		input_report_rel(dev, REL_HWHEEL, 1);
>> -		break;
>> -
>> -	case BYD_ZOOMOUT:
>> -	case BYD_ZOOMIN:
>> -	case BYD_3UP:
>> -	case BYD_3DOWN:
>> -	case BYD_3LEFT:
>> -	case BYD_3RIGHT:
>> -	case BYD_4UP:
>> -	case BYD_4DOWN:
>> -		break;
>> -
>>  	default:
>>  		psmouse_warn(psmouse,
>>  			     "Unrecognized Z: pkt = %02x %02x %02x %02x\n",
>> @@ -157,134 +326,76 @@ static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
>>  		return PSMOUSE_BAD_DATA;
>>  	}
>>  
>> -	input_sync(dev);
>> +	priv->btn_left = pkt[0] & PS2_LEFT;
>> +	priv->btn_right = pkt[0] & PS2_RIGHT;
>>  
>> -	return PSMOUSE_FULL_PACKET;
>> -}
>> -
>> -/* Send a sequence of bytes, where each is ACKed before the next is sent. */
>> -static int byd_send_sequence(struct psmouse *psmouse, const u8 *seq, size_t len)
>> -{
>> -	unsigned int i;
>> +	byd_report_input(psmouse);
>>  
>> -	for (i = 0; i < len; ++i) {
>> -		if (ps2_command(&psmouse->ps2dev, NULL, seq[i]))
>> -			return -1;
>> +	/* Reset time since last touch. */
>> +	if (priv->touch) {
>> +		priv->last_touch_time = now_msecs;
>> +		mod_timer(&priv->timer, jiffies + msecs_to_jiffies(BYD_TOUCH_TIMEOUT));
> 
> Line too long (according to checkpatch).
> 
>>  	}
>> -	return 0;
>> -}
>> -
>> -/* Keep scrolling after fingers are removed. */
>> -#define SCROLL_INERTIAL		0x01
>> -#define SCROLL_NO_INERTIAL	0x02
>> -
>> -/* Clicking can be done by tapping or pressing. */
>> -#define CLICK_BOTH		0x01
>> -/* Clicking can only be done by pressing. */
>> -#define CLICK_PRESS_ONLY	0x02
>> -
>> -static int byd_enable(struct psmouse *psmouse)
>> -{
>> -	const u8 seq1[] = { 0xE2, 0x00, 0xE0, 0x02, 0xE0 };
>> -	const u8 seq2[] = {
>> -		0xD3, 0x01,
>> -		0xD0, 0x00,
>> -		0xD0, 0x04,
>> -		/* Whether clicking is done by tapping or pressing. */
>> -		0xD4, CLICK_PRESS_ONLY,
>> -		0xD5, 0x01,
>> -		0xD7, 0x03,
>> -		/* Vertical and horizontal one-finger scroll zone inertia. */
>> -		0xD8, SCROLL_INERTIAL,
>> -		0xDA, 0x05,
>> -		0xDB, 0x02,
>> -		0xE4, 0x05,
>> -		0xD6, 0x01,
>> -		0xDE, 0x04,
>> -		0xE3, 0x01,
>> -		0xCF, 0x00,
>> -		0xD2, 0x03,
>> -		/* Vertical and horizontal two-finger scrolling inertia. */
>> -		0xE5, SCROLL_INERTIAL,
>> -		0xD9, 0x02,
>> -		0xD9, 0x07,
>> -		0xDC, 0x03,
>> -		0xDD, 0x03,
>> -		0xDF, 0x03,
>> -		0xE1, 0x03,
>> -		0xD1, 0x00,
>> -		0xCE, 0x00,
>> -		0xCC, 0x00,
>> -		0xE0, 0x00,
>> -		0xE2, 0x01
>> -	};
>> -	u8 param[4];
>> -
>> -	if (byd_send_sequence(psmouse, seq1, ARRAY_SIZE(seq1)))
>> -		return -1;
>>  
>> -	/* Send a 0x01 command, which should return 4 bytes. */
>> -	if (ps2_command(&psmouse->ps2dev, param, 0x0401))
>> -		return -1;
>> -
>> -	if (byd_send_sequence(psmouse, seq2, ARRAY_SIZE(seq2)))
>> -		return -1;
>> -
>> -	return 0;
>> +	return PSMOUSE_FULL_PACKET;
>>  }
>>  
>> -/*
>> - * Send the set of PS/2 commands required to make it identify as an
>> - * intellimouse with 4-byte instead of 3-byte packets.
>> - */
>> -static int byd_send_intellimouse_sequence(struct psmouse *psmouse)
>> +static int byd_reset_touchpad(struct psmouse *psmouse)
>>  {
>>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
>>  	u8 param[4];
>> -	int i;
>> +	size_t i;
>> +
>>  	const struct {
>>  		u16 command;
>>  		u8 arg;
>>  	} seq[] = {
>> -		{ PSMOUSE_CMD_RESET_BAT, 0 },
>> -		{ PSMOUSE_CMD_RESET_BAT, 0 },
>> -		{ PSMOUSE_CMD_GETID, 0 },
>> -		{ PSMOUSE_CMD_SETSCALE11, 0 },
>> -		{ PSMOUSE_CMD_SETSCALE11, 0 },
>> -		{ PSMOUSE_CMD_SETSCALE11, 0 },
>> -		{ PSMOUSE_CMD_GETINFO, 0 },
>> -		{ PSMOUSE_CMD_SETRES, 0x03 },
>> +		/*
>> +		 * Intellimouse initialization sequence, to get 4-byte instead
>> +		 * of 3-byte packets.
>> +		 */
>>  		{ PSMOUSE_CMD_SETRATE, 0xC8 },
>>  		{ PSMOUSE_CMD_SETRATE, 0x64 },
>>  		{ PSMOUSE_CMD_SETRATE, 0x50 },
>>  		{ PSMOUSE_CMD_GETID, 0 },
>> -		{ PSMOUSE_CMD_SETRATE, 0xC8 },
>> -		{ PSMOUSE_CMD_SETRATE, 0xC8 },
>> -		{ PSMOUSE_CMD_SETRATE, 0x50 },
>> -		{ PSMOUSE_CMD_GETID, 0 },
>> -		{ PSMOUSE_CMD_SETRATE, 0x64 },
>> -		{ PSMOUSE_CMD_SETRES, 0x03 },
>> -		{ PSMOUSE_CMD_ENABLE, 0 }
>> +		{ PSMOUSE_CMD_ENABLE, 0 },
>> +		/*
>> +		 * BYD-specific initialization, which enables absolute mode and
>> +		 * (if desired), the touchpad's built-in gesture detection.
>> +		 */
>> +		{ 0x10E2, 0x00 },
>> +		{ 0x10E0, 0x02 },
>> +		/* The touchpad should reply with 4 seemingly-random bytes */
>> +		{ 0x14E0, 0x01 },
>> +		/* Pairs of parameters and values. */
>> +		{ BYD_CMD_SET_HANDEDNESS, 0x01 },
>> +		{ BYD_CMD_SET_PHYSICAL_BUTTONS, 0x04 },
>> +		{ BYD_CMD_SET_TAP, 0x02 },
>> +		{ BYD_CMD_SET_ONE_FINGER_SCROLL, 0x04 },
>> +		{ BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC, 0x04 },
>> +		{ BYD_CMD_SET_EDGE_MOTION, 0x01 },
>> +		{ BYD_CMD_SET_PALM_CHECK, 0x00 },
>> +		{ BYD_CMD_SET_MULTITOUCH, 0x02 },
>> +		{ BYD_CMD_SET_TWO_FINGER_SCROLL, 0x04 },
>> +		{ BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC, 0x04 },
>> +		{ BYD_CMD_SET_LEFT_EDGE_REGION, 0x00 },
>> +		{ BYD_CMD_SET_TOP_EDGE_REGION, 0x00 },
>> +		{ BYD_CMD_SET_RIGHT_EDGE_REGION, 0x00 },
>> +		{ BYD_CMD_SET_BOTTOM_EDGE_REGION, 0x00 },
>> +		{ BYD_CMD_SET_ABSOLUTE_MODE, 0x02 },
>> +		/* Finalize initialization. */
>> +		{ 0x10E0, 0x00 },
>> +		{ 0x10E2, 0x01 },
>>  	};
>>  
>> -	memset(param, 0, sizeof(param));
>>  	for (i = 0; i < ARRAY_SIZE(seq); ++i) {
>> +		memset(param, 0, sizeof(param));
>>  		param[0] = seq[i].arg;
>>  		if (ps2_command(ps2dev, param, seq[i].command))
>> -			return -1;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -static int byd_reset_touchpad(struct psmouse *psmouse)
>> -{
>> -	if (byd_send_intellimouse_sequence(psmouse))
>> -		return -EIO;
>> -
>> -	if (byd_enable(psmouse))
>> -		return -EIO;
>> +			return -EIO;
>>  
>> +	}
>> +	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
>>  	return 0;
>>  }
>>  
>> @@ -314,9 +425,50 @@ static int byd_reconnect(struct psmouse *psmouse)
>>  	return 0;
>>  }
>>  
>> +static void byd_disconnect(struct psmouse *psmouse)
>> +{
>> +	struct byd_data *priv = psmouse->private;
>> +
>> +	if (priv) {
>> +		del_timer(&priv->timer);
>> +		kfree(psmouse->private);
>> +		psmouse->private = NULL;
>> +	}
>> +}
>> +
>> +int byd_detect(struct psmouse *psmouse, bool set_properties)
>> +{
>> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
>> +
>> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +		return -1;
>> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +		return -1;
>> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +		return -1;
>> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +		return -1;
>> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
>> +		return -1;
>> +
>> +	if (param[1] != 0x03 || param[2] != 0x64)
>> +		return -ENODEV;
>> +
>> +	psmouse_dbg(psmouse, "BYD touchpad detected\n");
>> +
>> +	if (set_properties) {
>> +		psmouse->vendor = "BYD";
>> +		psmouse->name = "TouchPad";
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  int byd_init(struct psmouse *psmouse)
>>  {
>>  	struct input_dev *dev = psmouse->dev;
>> +	struct byd_data *priv;
>>  
>>  	if (psmouse_reset(psmouse))
>>  		return -EIO;
>> @@ -324,14 +476,39 @@ int byd_init(struct psmouse *psmouse)
>>  	if (byd_reset_touchpad(psmouse))
>>  		return -EIO;
>>  
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	memset(priv, 0, sizeof(*priv));
>> +	setup_timer(&priv->timer, byd_clear_touch, (unsigned long) psmouse);
>> +
>> +	psmouse->private = priv;
>> +	psmouse->disconnect = byd_disconnect;
>>  	psmouse->reconnect = byd_reconnect;
>>  	psmouse->protocol_handler = byd_process_byte;
>>  	psmouse->pktsize = 4;
>>  	psmouse->resync_time = 0;
>>  
>> -	__set_bit(BTN_MIDDLE, dev->keybit);
>> -	__set_bit(REL_WHEEL, dev->relbit);
>> -	__set_bit(REL_HWHEEL, dev->relbit);
>> +	__set_bit(INPUT_PROP_POINTER, dev->propbit);
>> +	/* Touchpad */
>> +	__set_bit(BTN_TOUCH, dev->keybit);
>> +	__set_bit(BTN_TOOL_FINGER, dev->keybit);
>> +	/* Buttons */
>> +	__set_bit(BTN_LEFT, dev->keybit);
>> +	__set_bit(BTN_RIGHT, dev->keybit);
>> +	__clear_bit(BTN_MIDDLE, dev->keybit);
>> +
>> +	/* Absolute position */
>> +	__set_bit(EV_ABS, dev->evbit);
>> +	input_set_abs_params(dev, ABS_X, 0, BYD_PAD_WIDTH, 0, 0);
>> +	input_set_abs_params(dev, ABS_Y, 0, BYD_PAD_HEIGHT, 0, 0);
>> +	input_abs_set_res(dev, ABS_X, BYD_PAD_RESOLUTION);
>> +	input_abs_set_res(dev, ABS_Y, BYD_PAD_RESOLUTION);
>> +	/* No relative support */
>> +	__clear_bit(EV_REL, dev->evbit);
>> +	__clear_bit(REL_X, dev->relbit);
>> +	__clear_bit(REL_Y, dev->relbit);
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
>> index 39d1bec..5784e20 100644
>> --- a/drivers/input/mouse/psmouse-base.c
>> +++ b/drivers/input/mouse/psmouse-base.c
>> @@ -846,7 +846,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>>  #ifdef CONFIG_MOUSE_PS2_BYD
>>  	{
>>  		.type		= PSMOUSE_BYD,
>> -		.name		= "BydPS/2",
>> +		.name		= "BYDPS/2",
>>  		.alias		= "byd",
>>  		.detect		= byd_detect,
>>  		.init		= byd_init,
> 
> Cheers,
> Chris
> 
