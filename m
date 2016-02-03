From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] psmouse: added BYD touchpad driver
Date: Tue, 2 Feb 2016 21:39:12 -0800
Message-ID: <56B19280.5030504@gmail.com>
References: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
 <20160203004153.GA15147@smaug>
 <CAHc7Qt2c4RYohcm7-hACaQUAHx7RDE2hYgq8MJJ8LyyS+Vf2sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHc7Qt2c4RYohcm7-hACaQUAHx7RDE2hYgq8MJJ8LyyS+Vf2sQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

New patch vs 98ee377144935857d8ad5d7d70cdab1da4ede32e on 
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input follows. 
Confirmed builds and works as expected with that kernel branch.

Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
---
diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 9425e0f..a880adb 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -1,337 +1,586 @@
  /*
- * BYD TouchPad PS/2 mouse driver
+ * BYD BTP-10463 touchpad PS/2 mouse driver
   *
- * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
+ * Copyright (C) 2015, Tai Chi Minh Ralph Eastwood
+ * Copyright (C) 2015, Martin Wimpress
+ * Copyright (C) 2015, Jay Kuri
+ * Copyright (C) 2015, Richard Pospesel
   *
   * This program is free software; you can redistribute it and/or modify it
   * under the terms of the GNU General Public License version 2 as 
published by
   * the Free Software Foundation.
+ *
+ * Protocol of BYD Touch Pad reverse-engineered from windows driver:
+ * filename:  "byd touchpad driver - win7, 8, 8.1 - 2.4.1.102.zip"
+ * sha1:      97a0eca8edc482bf9d08ab9509084a514dad4c4b
+ * datasheet: http://bydit.com/userfiles/file/BTP10463-XXX.pdf
+ *
   */
+#include <linux/types.h>
+#include <linux/kernel.h>

-#include <linux/delay.h>
  #include <linux/input.h>
-#include <linux/libps2.h>
  #include <linux/serio.h>
+#include <linux/slab.h>
+#include <linux/libps2.h>

  #include "psmouse.h"
  #include "byd.h"

-#define PS2_Y_OVERFLOW	BIT_MASK(7)
-#define PS2_X_OVERFLOW	BIT_MASK(6)
-#define PS2_Y_SIGN	BIT_MASK(5)
-#define PS2_X_SIGN	BIT_MASK(4)
-#define PS2_ALWAYS_1	BIT_MASK(3)
-#define PS2_MIDDLE	BIT_MASK(2)
-#define PS2_RIGHT	BIT_MASK(1)
-#define PS2_LEFT	BIT_MASK(0)
+#define BYD_MODEL_ID_LEN        2
+#define BYD_CMD_PAIR(c)		((1 << 12) | (c))
+#define BYD_CMD_PAIR_R(r, c)	((1 << 12) | (r << 8) | (c))
+
+/* BYD pad constants */

  /*
- * The touchpad reports gestures in the last byte of each packet. It 
can take
- * any of the following values:
+ * true device resolution is unknown, however experiments show the
+ * resolution is about 111 units/mm
+ * absolute coordinate packets are in the range 0-255 for both X and y
+ * we pick ABS_X/ABS_Y dimensions which are multiples of 256 and in
+ * the right ballpark given the touchpad's physical dimensions and estimate
+ * resolution per spec sheet, device active area dimensions are
+ * 101.6 x 60.1 mm
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
+#define BYD_CONST_PAD_WIDTH                     11264
+#define BYD_CONST_PAD_HEIGHT                    6656
+#define BYD_CONST_PAD_RESOLUTION                111

-int byd_detect(struct psmouse *psmouse, bool set_properties)
+
+/* BYD commands reverse engineered from windows driver */
+
+/*
+ * swipe gesture from off-pad to on-pad
+ *  0 : disable
+ *  1 : enable
+ */
+#define BYD_CMD_SET_OFFSCREEN_SWIPE             0xcc
+/*
+ * tap and drag delay time
+ *  0 : disable
+ *  1 - 8 : least to most delay
+ */
+#define BYD_CMD_SET_TAP_DRAG_DELAY_TIME         0xcf
+/*
+ * physical buttons function mapping
+ *  0 : enable
+ *  4 : normal
+ *  5 : left button custom command
+ *  6 : right button custom command
+ *  8 : disable
+ */
+#define BYD_CMD_SET_PHYSICAL_BUTTONS            0xd0
+/*
+ * absolute mode (1 byte X/Y resolution)
+ *  0 : disable
+ *  2 : enable
+ */
+#define BYD_CMD_SET_ABSOLUTE_MODE               0xd1
+/*
+ * two finger scrolling
+ *  1 : vertical
+ *  2 : horizontal
+ *  3 : vertical + horizontal
+ *  4 : disable
+ */
+#define BYD_CMD_SET_TWO_FINGER_SCROLL           0xd2
+/*
+ * handedness
+ *  1 : right handed
+ *  2 : left handed
+ */
+#define BYD_CMD_SET_HANDEDNESS                  0xd3
+/*
+ * tap to click
+ *  1 : enable
+ *  2 : disable
+ */
+#define BYD_CMD_SET_TAP                         0xd4
+/*
+ * tap and drag
+ *  1 : tap and hold to drag
+ *  2 : tap and hold to drag + lock
+ *  3 : disable
+ */
+#define BYD_CMD_SET_TAP_DRAG                    0xd5
+/*
+ * touch sensitivity
+ *  1 - 7 : least to most sensitive
+ */
+#define BYD_CMD_SET_TOUCH_SENSITIVITY           0xd6
+/*
+ * one finger scrolling
+ *  1 : vertical
+ *  2 : horizontal
+ *  3 : vertical + horizontal
+ *  4 : disable
+ */
+#define BYD_CMD_SET_ONE_FINGER_SCROLL           0xd7
+/*
+ * one finger scrolling function
+ *  1 : free scrolling
+ *  2 : edge motion
+ *  3 : free scrolling + edge motion
+ *  4 : disable
+ */
+#define BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC      0xd8
+/*
+ * sliding speed
+ *  1 - 5 : slowest to fastest
+ */
+#define BYD_CMD_SET_SLIDING_SPEED               0xda
+/*
+ * edge motion
+ *  1 : disable
+ *  2 : enable when dragging
+ *  3 : enable when dragging and pointing
+ */
+#define BYD_CMD_SET_EDGE_MOTION                 0xdb
+/*
+ * left edge region size
+ *  0 - 7 : smallest to largest width
+ */
+#define BYD_CMD_SET_LEFT_EDGE_REGION            0xdc
+/*
+ * top edge region size
+ *  0 - 9 : smallest to largest height
+ */
+#define BYD_CMD_SET_TOP_EDGE_REGION             0xdd
+/*
+ * disregard palm press as clicks
+ *  1 - 6 : smallest to largest
+ */
+#define BYD_CMD_SET_PALM_CHECK                  0xde
+/* right edge region size
+ *  0 - 7 : smallest to largest width
+ */
+#define BYD_CMD_SET_RIGHT_EDGE_REGION           0xdf
+/*
+ * bottom edge region size
+ *  0 - 9 : smallest to largest height
+ */
+#define BYD_CMD_SET_BOTTOM_EDGE_REGION          0xe1
+/*
+ * multitouch gestures
+ *  1 : enable
+ *  2 : disable
+ */
+#define BYD_CMD_SET_MULTITOUCH                  0xe3
+/*
+ * edge motion speed
+ *  0 : control with finger pressure
+ *  1 - 9 : slowest to fastest
+ */
+#define BYD_CMD_SET_EDGE_MOTION_SPEED           0xe4
+/*
+ * two finger scolling function
+ *  0 : free scrolling
+ *  1 : free scrolling (with momentum)
+ *  2 : edge motion
+ *  3 : free scrolling (with momentum) + edge motion
+ *  4 : disable
+ */
+#define BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC      0xe5
+
+/* BYD Packets */
+
+#define BYD_PKT_RELATIVE                        0x00
+#define BYD_PKT_ABSOLUTE                        0xf8
+#define BYD_PKT_PINCH_IN                        0xd8
+#define BYD_PKT_PINCH_OUT                       0x28
+#define BYD_PKT_ROTATE_CLOCKWISE                0x29
+#define BYD_PKT_ROTATE_ANTICLOCKWISE            0xd7
+#define BYD_PKT_TWO_FINGER_SCROLL_RIGHT         0x2a
+#define BYD_PKT_TWO_FINGER_SCROLL_DOWN          0x2b
+#define BYD_PKT_TWO_FINGER_SCROLL_UP            0xd5
+#define BYD_PKT_TWO_FINGER_SCROLL_LEFT          0xd6
+#define BYD_PKT_THREE_FINGER_SWIPE_RIGHT        0x2c
+#define BYD_PKT_THREE_FINGER_SWIPE_DOWN         0x2d
+#define BYD_PKT_THREE_FINGER_SWIPE_UP           0xd3
+#define BYD_PKT_THREE_FINGER_SWIPE_LEFT         0xd4
+#define BYD_PKT_FOUR_FINGER_DOWN                0x33
+#define BYD_PKT_FOUR_FINGER_UP                  0xcd
+#define BYD_PKT_REGION_SCROLL_RIGHT             0x35
+#define BYD_PKT_REGION_SCROLL_DOWN              0x36
+#define BYD_PKT_REGION_SCROLL_UP                0xca
+#define BYD_PKT_REGION_SCROLL_LEFT              0xcb
+#define BYD_PKT_RIGHT_CORNER_CLICK              0xd2
+#define BYD_PKT_LEFT_CORNER_CLICK               0x2e
+#define BYD_PKT_LEFT_AND_RIGHT_CORNER_CLICK     0x2f
+#define BYD_PKT_ONTO_PAD_SWIPE_RIGHT            0x37
+#define BYD_PKT_ONTO_PAD_SWIPE_DOWN             0x30
+#define BYD_PKT_ONTO_PAD_SWIPE_UP               0xd0
+#define BYD_PKT_ONTO_PAD_SWIPE_LEFT             0xc9
+
+struct byd_init_command_pair {
+	uint8_t command;
+	uint8_t  value;
+};
+
+static const struct byd_init_command_pair init_commands[] = {
+	{BYD_CMD_SET_HANDEDNESS, 0x01},
+	{BYD_CMD_SET_PHYSICAL_BUTTONS, 0x04},
+	{BYD_CMD_SET_TAP, 0x02},
+	{BYD_CMD_SET_ONE_FINGER_SCROLL, 0x04},
+	{BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC, 0x04},
+	{BYD_CMD_SET_EDGE_MOTION, 0x01},
+	{BYD_CMD_SET_PALM_CHECK, 0x00},
+	{BYD_CMD_SET_MULTITOUCH, 0x02},
+	{BYD_CMD_SET_TWO_FINGER_SCROLL, 0x04},
+	{BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC, 0x04},
+	{BYD_CMD_SET_LEFT_EDGE_REGION, 0x00},
+	{BYD_CMD_SET_TOP_EDGE_REGION, 0x00},
+	{BYD_CMD_SET_RIGHT_EDGE_REGION, 0x0},
+	{BYD_CMD_SET_BOTTOM_EDGE_REGION, 0x00},
+	{BYD_CMD_SET_ABSOLUTE_MODE, 0x02},
+};
+
+struct byd_model_info {
+	char name[16];
+	char id[BYD_MODEL_ID_LEN];
+};
+
+static struct byd_model_info byd_model_data[] = {
+	{ "BTP10463", { 0x03, 0x64 } }
+};
+
+struct byd_data {
+	struct timer_list timer;
+	int32_t abs_x;
+	int32_t abs_y;
+	uint32_t last_touch_time;
+	uint32_t button_left      : 1;
+	uint32_t button_right     : 1;
+	uint32_t touch            : 1;
+};
+
+static void byd_report_input(struct psmouse *psmouse)
  {
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[4];
+	struct byd_data *priv = (struct byd_data *)psmouse->private;
+	struct input_dev *dev = psmouse->dev;

-	param[0] = 0x03;
-	param[1] = 0x00;
-	param[2] = 0x00;
-	param[3] = 0x00;
+	input_report_abs(dev, ABS_X, priv->abs_x);
+	input_report_abs(dev, ABS_Y, priv->abs_y);
+	input_report_key(dev, BTN_LEFT, priv->button_left);
+	input_report_key(dev, BTN_RIGHT, priv->button_right);
+	input_report_key(dev, BTN_TOUCH, priv->touch);
+	input_report_key(dev, BTN_TOOL_FINGER, priv->touch);

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
+	input_sync(dev);
+}

-	if (param[1] != 0x03 || param[2] != 0x64)
-		return -ENODEV;
+static void byd_clear_touch(unsigned long data)
+{
+	struct psmouse *psmouse = (struct psmouse *)data;
+	struct byd_data *priv = psmouse->private;

-	psmouse_dbg(psmouse, "BYD touchpad detected\n");
+	serio_pause_rx(psmouse->ps2dev.serio);

-	if (set_properties) {
-		psmouse->vendor = "BYD";
-		psmouse->name = "TouchPad";
-	}
+	priv->touch = 0;
+	/*
+	 * move cursor back to center of pad when we lose touch
+	 * this specifically improves user experiencce when moving
+	 * cursor with one finger, and pressing butoton with other
+	 */
+	priv->abs_x = BYD_CONST_PAD_WIDTH / 2;
+	priv->abs_y = BYD_CONST_PAD_HEIGHT / 2;

-	return 0;
+	byd_report_input(psmouse);
+
+	serio_continue_rx(psmouse->ps2dev.serio);
  }

  static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
  {
-	struct input_dev *dev = psmouse->dev;
-	u8 *pkt = psmouse->packet;
+	struct byd_data *priv = psmouse->private;
+	unsigned char *packet = psmouse->packet;
+	uint32_t now_msecs = jiffies_to_msecs(jiffies);

-	if (psmouse->pktcnt > 0 && !(pkt[0] & PS2_ALWAYS_1)) {
-		psmouse_warn(psmouse, "Always_1 bit not 1. pkt[0] = %02x\n",
-			     pkt[0]);
-		return PSMOUSE_BAD_DATA;
-	}

  	if (psmouse->pktcnt < psmouse->pktsize)
  		return PSMOUSE_GOOD_DATA;

-	/* Otherwise, a full packet has been received */
-	switch (pkt[3]) {
-	case 0: {
-		/* Standard packet */
-		/* Sign-extend if a sign bit is set. */
-		unsigned int signx = pkt[0] & PS2_X_SIGN ? ~0xFF : 0;
-		unsigned int signy = pkt[0] & PS2_Y_SIGN ? ~0xFF : 0;
-		int dx = signx | (int) pkt[1];
-		int dy = signy | (int) pkt[2];
-
-		input_report_rel(psmouse->dev, REL_X, dx);
-		input_report_rel(psmouse->dev, REL_Y, -dy);
-
-		input_report_key(psmouse->dev, BTN_LEFT, pkt[0] & PS2_LEFT);
-		input_report_key(psmouse->dev, BTN_RIGHT, pkt[0] & PS2_RIGHT);
-		input_report_key(psmouse->dev, BTN_MIDDLE, pkt[0] & PS2_MIDDLE);
+#ifdef BYD_DEBUG
+	psmouse_dbg(psmouse, "process: packet = %x %x %x %x\n",
+			packet[0], packet[1], packet[2], packet[3]);
+#endif
+
+	switch (packet[3]) {
+	case BYD_PKT_ABSOLUTE:
+		/* on first touch, use the absolute packet to determine our start 
location */
+		if (priv->touch == 0) {
+			priv->abs_x = packet[1] * (BYD_CONST_PAD_WIDTH / 256);
+			priv->abs_y = (255 - packet[2]) * (BYD_CONST_PAD_HEIGHT / 256);
+
+			/* needed to detect tap */
+			if (now_msecs - priv->last_touch_time > 64) {
+				priv->touch = 1;
+			}
+		}
  		break;
-	}
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
+	case BYD_PKT_RELATIVE:
+		{
+			int32_t rel_x, rel_y;
+
+			/* same as regular PS/2 psmouse protocoal */
+			rel_x = packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 
0x100) : 0;
+			rel_y = packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) 
packet[2] : 0;
+
+			/*
+			 * experiments show relative mouse packets come in increments of
+			 * 1 unit / 11 msecs (regardless of time delta between relative packets)
+			 */
+			priv->abs_x += rel_x * 11;
+			priv->abs_y += rel_y * 11;
+
+			priv->touch = 1;
+		}
  		break;
+	default:
+		/* shoudn't be sending anything else, but ignore just in-case */
+		return PSMOUSE_FULL_PACKET;
+	}

-	case BYD_SCROLLRIGHT:
-	case BYD_2RIGHT:
-		input_report_rel(dev, REL_HWHEEL, 1);
-		break;
+	/* both ABS and REL packets report button states */
+	priv->button_left = packet[0] & 1;
+	priv->button_right = (packet[0] >> 1) & 1;

-	case BYD_ZOOMOUT:
-	case BYD_ZOOMIN:
-	case BYD_3UP:
-	case BYD_3DOWN:
-	case BYD_3LEFT:
-	case BYD_3RIGHT:
-	case BYD_4UP:
-	case BYD_4DOWN:
-		break;
+	byd_report_input(psmouse);

-	default:
-		psmouse_warn(psmouse,
-			     "Unrecognized Z: pkt = %02x %02x %02x %02x\n",
-			     psmouse->packet[0], psmouse->packet[1],
-			     psmouse->packet[2], psmouse->packet[3]);
-		return PSMOUSE_BAD_DATA;
+	/* reset time since last touch */
+	if (priv->touch == 1) {
+		priv->last_touch_time = now_msecs;
+		mod_timer(&priv->timer, jiffies + msecs_to_jiffies(64));
  	}

-	input_sync(dev);
-
  	return PSMOUSE_FULL_PACKET;
  }

-/* Send a sequence of bytes, where each is ACKed before the next is 
sent. */
-static int byd_send_sequence(struct psmouse *psmouse, const u8 *seq, 
size_t len)
+int byd_init(struct psmouse *psmouse)
  {
-	unsigned int i;
+	struct byd_data *priv;
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param[4];
+	int cmd, error = 0;
+	int i = 0;
+
+	/* it needs to be initialised like an intellimouse to get 4-byte 
packets */
+	psmouse_reset(psmouse);
+	param[0] = 200;
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	param[0] = 100;
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	param[0] =  80;
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+
+	if (param[0] != 3)
+		return -1;
+
+#ifdef BYD_DEBUG
+	psmouse_dbg(psmouse, "detect: init sequence\n");
+#endif

-	for (i = 0; i < len; ++i) {
-		if (ps2_command(&psmouse->ps2dev, NULL, seq[i]))
-			return -1;
+	/* activate the mouse to initialise it */
+	psmouse_activate(psmouse);
+
+	/* enter command mode */
+	param[0] = 0x00;
+	if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe2))) {
+		error = -EIO;
+		goto init_fail;
+	}
+#ifdef BYD_DEBUG
+	psmouse_dbg(psmouse, "detect: entered command mode\n");
+#endif
+
+	/* send second identification command */
+	param[0] = 0x02;
+	if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe0))) {
+		error = -EIO;
+		goto init_fail;
  	}
-	return 0;
-}

-/* Keep scrolling after fingers are removed. */
-#define SCROLL_INERTIAL		0x01
-#define SCROLL_NO_INERTIAL	0x02
+	param[0] = 0x01;
+	if (ps2_command(ps2dev, param, BYD_CMD_PAIR_R(4, 0xe0))) {
+		error = -EIO;
+		goto init_fail;
+	}

-/* Clicking can be done by tapping or pressing. */
-#define CLICK_BOTH		0x01
-/* Clicking can only be done by pressing. */
-#define CLICK_PRESS_ONLY	0x02
+#ifdef BYD_DEBUG
+	psmouse_dbg(psmouse, "detect: magic %x %x %x %x\n",
+			param[0], param[1], param[2], param[3]);
+#endif
+
+	/* magic identifier the vendor driver reads */
+	if (param[0] != 0x08 || param[1] != 0x01 ||
+	    param[2] != 0x01 || param[3] != 0x31) {
+#ifdef BYD_DEBUG
+		psmouse_err(psmouse, "unknown magic, expected: 08 01 01 31\n");
+#endif
+		error = -EINVAL;
+		goto init_fail;
+	}

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
+	/*
+	 * send the byd vendor commands
+	 * these appear to be pairs of (command, param)
+	 */
+	for (i = 0; i < ARRAY_SIZE(init_commands); i++) {
+		param[0] = init_commands[i].value;
+		cmd = BYD_CMD_PAIR(init_commands[i].command);
+		if (ps2_command(ps2dev, param, cmd)) {
+			error = -EIO;
+			goto init_fail;
+		}
+	}

-	/* Send a 0x01 command, which should return 4 bytes. */
-	if (ps2_command(&psmouse->ps2dev, param, 0x0401))
-		return -1;
+	/* confirm/finalize the above vender command table */
+	param[0] = 0x00;
+	if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe0))) {
+		error = -EIO;
+		goto init_fail;
+	}

-	if (byd_send_sequence(psmouse, seq2, ARRAY_SIZE(seq2)))
-		return -1;
+	/* exit command mode */
+	param[0] = 0x01;
+	if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe2))) {
+		error = -ENOMEM;
+		goto init_fail;
+	}
+
+	/* alloc space for byd_data */
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		error = -ENOMEM;
+		goto init_fail;
+	}
+
+	/* init struct and timer */
+	memset(priv, 0x00, sizeof(*priv));
+	/* signal touch end after not receiving movement packets for 32 ms */
+	setup_timer(&priv->timer, byd_clear_touch, (unsigned long)psmouse);
+	psmouse->private = priv;
+
+#ifdef BYD_DEBUG
+	psmouse_dbg(psmouse, "detect: exit command mode\n");
+#endif

  	return 0;
+
+init_fail:
+	psmouse_deactivate(psmouse);
+	return error;
  }

-/*
- * Send the set of PS/2 commands required to make it identify as an
- * intellimouse with 4-byte instead of 3-byte packets.
- */
-static int byd_send_intellimouse_sequence(struct psmouse *psmouse)
+static void byd_disconnect(struct psmouse *psmouse)
  {
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	u8 param[4];
-	int i;
-	const struct {
-		u16 command;
-		u8 arg;
-	} seq[] = {
-		{ PSMOUSE_CMD_RESET_BAT, 0 },
-		{ PSMOUSE_CMD_RESET_BAT, 0 },
-		{ PSMOUSE_CMD_GETID, 0 },
-		{ PSMOUSE_CMD_SETSCALE11, 0 },
-		{ PSMOUSE_CMD_SETSCALE11, 0 },
-		{ PSMOUSE_CMD_SETSCALE11, 0 },
-		{ PSMOUSE_CMD_GETINFO, 0 },
-		{ PSMOUSE_CMD_SETRES, 0x03 },
-		{ PSMOUSE_CMD_SETRATE, 0xC8 },
-		{ PSMOUSE_CMD_SETRATE, 0x64 },
-		{ PSMOUSE_CMD_SETRATE, 0x50 },
-		{ PSMOUSE_CMD_GETID, 0 },
-		{ PSMOUSE_CMD_SETRATE, 0xC8 },
-		{ PSMOUSE_CMD_SETRATE, 0xC8 },
-		{ PSMOUSE_CMD_SETRATE, 0x50 },
-		{ PSMOUSE_CMD_GETID, 0 },
-		{ PSMOUSE_CMD_SETRATE, 0x64 },
-		{ PSMOUSE_CMD_SETRES, 0x03 },
-		{ PSMOUSE_CMD_ENABLE, 0 }
-	};
-
-	memset(param, 0, sizeof(param));
-	for (i = 0; i < ARRAY_SIZE(seq); ++i) {
-		param[0] = seq[i].arg;
-		if (ps2_command(ps2dev, param, seq[i].command))
-			return -1;
-	}
+	if (psmouse->private) {
+		struct byd_data *priv = psmouse->private;

-	return 0;
+		del_timer(&priv->timer);
+		kfree(psmouse->private);
+		psmouse->private = NULL;
+	}
  }

-static int byd_reset_touchpad(struct psmouse *psmouse)
+static int byd_reconnect(struct psmouse *psmouse)
  {
-	if (byd_send_intellimouse_sequence(psmouse))
-		return -EIO;
+	if (byd_detect(psmouse, 0)) {
+		return -1;
+	}

-	if (byd_enable(psmouse))
-		return -EIO;
+	if (byd_init(psmouse)) {
+		return -1;
+	}

  	return 0;
  }

-static int byd_reconnect(struct psmouse *psmouse)
+int byd_detect(struct psmouse *psmouse, bool set_properties)
  {
-	int retry = 0, error = 0;
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param[4];
+	int i;

-	psmouse_dbg(psmouse, "Reconnect\n");
-	do {
-		psmouse_reset(psmouse);
-		if (retry)
-			ssleep(1);
-		error = byd_detect(psmouse, 0);
-	} while (error && ++retry < 3);
+	/* reset the mouse */
+	psmouse_reset(psmouse);

-	if (error)
-		return error;
+	/* magic knock - identify the mouse (as per. the datasheet) */
+	param[0] = 0x03;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+	    ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+	    ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+	    ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
+		return -EIO;
+	}

-	psmouse_dbg(psmouse, "Reconnected after %d attempts\n", retry);
+#ifdef BYD_DEBUG
+	psmouse_dbg(psmouse, "detect: model id: %x %x %x\n",
+			param[0], param[1], param[2]);
+#endif
+
+	/*
+	 * match the device - the first byte, param[0], appears to be set
+	 * to some unknown value based on the state of the mouse and cannot
+	 * be used for identification after suspend.
+	 */
+	for (i = 0; i < ARRAY_SIZE(byd_model_data); i++) {
+		if (!memcmp(param + 1, &byd_model_data[i].id, BYD_MODEL_ID_LEN)) {
+			break;
+		}
+	}

-	error = byd_reset_touchpad(psmouse);
-	if (error) {
-		psmouse_err(psmouse, "Unable to initialize device\n");
-		return error;
+	/* no match found */
+	if (i == ARRAY_SIZE(byd_model_data)) {
+#ifdef BYD_DEBUG
+		psmouse_dbg(psmouse, "detect: no match found\n");
+#endif
+		return -EINVAL;
+	} else {
+#ifdef BYD_DEBUG
+		psmouse_dbg(psmouse, "detect: matched %s\n",
+				byd_model_data[i].name);
+#endif
  	}

-	return 0;
-}
+	if (set_properties) {
+		struct input_dev *dev = psmouse->dev;

-int byd_init(struct psmouse *psmouse)
-{
-	struct input_dev *dev = psmouse->dev;
+		__set_bit(INPUT_PROP_POINTER, dev->propbit);

-	if (psmouse_reset(psmouse))
-		return -EIO;
+		/* touchpad */
+		__set_bit(BTN_TOUCH, dev->keybit);
+		__set_bit(BTN_TOOL_FINGER, dev->keybit);

-	if (byd_reset_touchpad(psmouse))
-		return -EIO;
+		/* buttons */
+		__set_bit(BTN_LEFT, dev->keybit);
+		__set_bit(BTN_RIGHT, dev->keybit);
+		__clear_bit(BTN_MIDDLE, dev->keybit);
+
+		/* absolute position */
+		__set_bit(EV_ABS, dev->evbit);

-	psmouse->reconnect = byd_reconnect;
-	psmouse->protocol_handler = byd_process_byte;
-	psmouse->pktsize = 4;
-	psmouse->resync_time = 0;
+		input_set_abs_params(dev, ABS_X, 0, BYD_CONST_PAD_WIDTH, 0, 0);
+		input_set_abs_params(dev, ABS_Y, 0, BYD_CONST_PAD_HEIGHT, 0, 0);
+		input_abs_set_res(dev, ABS_X, BYD_CONST_PAD_RESOLUTION);
+		input_abs_set_res(dev, ABS_Y, BYD_CONST_PAD_RESOLUTION);

-	__set_bit(BTN_MIDDLE, dev->keybit);
-	__set_bit(REL_WHEEL, dev->relbit);
-	__set_bit(REL_HWHEEL, dev->relbit);
+		/* no relative support */
+		__clear_bit(EV_REL, dev->evbit);
+		__clear_bit(REL_X, dev->relbit);
+		__clear_bit(REL_Y, dev->relbit);
+
+		psmouse->vendor = "BYD";
+		psmouse->name = "TouchPad";
+		psmouse->protocol_handler = byd_process_byte;
+		psmouse->pktsize = 4;
+		psmouse->private = NULL;
+		psmouse->disconnect = byd_disconnect;
+		psmouse->reconnect = byd_reconnect;
+	}

  	return 0;
  }
diff --git a/drivers/input/mouse/byd.h b/drivers/input/mouse/byd.h
index d6c120c..86b4a0e 100644
--- a/drivers/input/mouse/byd.h
+++ b/drivers/input/mouse/byd.h
@@ -1,11 +1,25 @@
-#ifndef _BYD_H
-#define _BYD_H
+/*
+ * BYD BTP-10463 touchpad PS/2 mouse driver
+ *
+ * Copyright (C) 2015, Tai Chi Minh Ralph Eastwood
+ * Copyright (C) 2015, Martin Wimpress
+ * Copyright (C) 2015, Jay Kuri
+ * Copyright (C) 2016, Richard Pospesel
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as 
published by
+ * the Free Software Foundation.
+ */
+
+#ifndef __BYD_H
+#define __BYD_H

  #ifdef CONFIG_MOUSE_PS2_BYD
  int byd_detect(struct psmouse *psmouse, bool set_properties);
  int byd_init(struct psmouse *psmouse);
  #else
-static inline int byd_detect(struct psmouse *psmouse, bool set_properties)
+static inline int byd_detect(struct psmouse *psmouse,
+				      bool set_properties)
  {
  	return -ENOSYS;
  }
@@ -13,6 +27,7 @@ static inline int byd_init(struct psmouse *psmouse)
  {
  	return -ENOSYS;
  }
+
  #endif /* CONFIG_MOUSE_PS2_BYD */

-#endif /* _BYD_H */
+#endif /* __BYD_H */
diff --git a/drivers/input/mouse/psmouse-base.c 
b/drivers/input/mouse/psmouse-base.c
index 39d1bec..5784e20 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -846,7 +846,7 @@ static const struct psmouse_protocol 
psmouse_protocols[] = {
  #ifdef CONFIG_MOUSE_PS2_BYD
  	{
  		.type		= PSMOUSE_BYD,
-		.name		= "BydPS/2",
+		.name		= "BYDPS/2",
  		.alias		= "byd",
  		.detect		= byd_detect,
  		.init		= byd_init,


On 02/02/2016 05:46 PM, Richard Pospesel wrote:
> Hi Chris,
>
> Reporting absolute position allows the synaptics and libinput xorg
> drivers to treat the BYD touchpad as a touchpad, rather than a mouse.
> This allows edge scrolling, tap to click, natural scrolling and any
> other location based single touch gesture to work.
>
> I opted to completely disable the hardware multitouch gesture
> recognition (including two finger scroll) for a couple of reasons:
>
> 1.  time delta between gesture packets was very large resulting in a
> rather jerky scrolling experience, especially compared to touchpad with
> real multitouch reporting.
> 2.  Reporting absolute position and touch support enables the users to
> configure the touchpad in the touchpad settings section of gnome,
> cinnamon, etc because those applets configure synaptics and libinput.
> Otherwise xorg thinks it's just a mouse.
> 3.  Enabling multitouch gesture recognition results in the mouse cursor
> freezing up when the user uses two fingers, one to move the mouse cursor
> and another to click.  This is because movement packets stop getting
> sent while a gesture (such as pinch, rotate, etc) is being detected
> and/or reported.  Disabling all hardware gesture detection, including
> two finger scroll, provides the most fluid user experience.
>
> Regarding serio_pause_rx(), I was following a pattern similar to another
> touchpad driver in psmouse.  That whole callback mechanism is required
> to report the touch had ended, since the BYD hardware only sends packets
> when a touch is occurring.  Is there a better way?
>
> I'll try to rebase and post an updated patch tonight.
>
> best,
> Richard
>
> On Feb 2, 2016 4:41 PM, "Chris Diamand" <chris@diamand.org
> <mailto:chris@diamand.org>> wrote:
>  >
>  > Hi Richard,
>  >
>  > > This adds proper single-touch support for BYD touchpads to the
> psmouse input
>  > > driver.
>  >
>  > I posted a driver for the same touchpad a few weeks ago, which has
> been merged
>  > into linux-next. There's some stuff in this patch which is missing in
> my driver
>  > though, so we should definitely try and include that, and I'm very
> curious
>  > about the pseudo-absolute mode.
>  >
>  > > This patch is against commit
> b82dde0230439215b55e545880e90337ee16f51a (Merge tag
>  > > 'please-pull-copy_file_range' of
>  > > git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux
> <http://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux> ) of Linus'
> kernel
>  > > branch.
>  >
>  > Can you rebase against
>  > 'git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> <http://git.kernel.org/pub/scm/linux/kernel/git/dtor/input>'?
>  >
>  > > +/* BYD commands reverse engineered from windows driver */
>  > > +
>  > > +/*
>  > > + * swipe gesture from off-pad to on-pad
>  > > + *  0 : disable
>  > > + *  1 : enable
>  > > + */
>  > > +#define BYD_CMD_SET_OFFSCREEN_SWIPE             0xcc
>  > > +/*
>  > > + * tap and drag delay time
>  > > + *  0 : disable
>  > > + *  1 - 8 : least to most delay
>  > > + */
>  > > +#define BYD_CMD_SET_TAP_DRAG_DELAY_TIME         0xcf
>  > > +/*
>  > > + * physical buttons function mapping
>  > > + *  0 : enable
>  > > + *  4 : normal
>  > > + *  5 : left button custom command
>  > > + *  6 : right button custom command
>  > > + *  8 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_PHYSICAL_BUTTONS            0xd0
>  > > +/*
>  > > + * absolute mode (1 byte X/Y resolution)
>  > > + *  0 : disable
>  > > + *  2 : enable
>  > > + */
>  > > +#define BYD_CMD_SET_ABSOLUTE_MODE               0xd1
>  > > +/*
>  > > + * two finger scrolling
>  > > + *  1 : vertical
>  > > + *  2 : horizontal
>  > > + *  3 : vertical + horizontal
>  > > + *  4 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_TWO_FINGER_SCROLL           0xd2
>  > > +/*
>  > > + * handedness
>  > > + *  1 : right handed
>  > > + *  2 : left handed
>  > > + */
>  > > +#define BYD_CMD_SET_HANDEDNESS                  0xd3
>  > > +/*
>  > > + * tap to click
>  > > + *  1 : enable
>  > > + *  2 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_TAP                         0xd4
>  > > +/*
>  > > + * tap and drag
>  > > + *  1 : tap and hold to drag
>  > > + *  2 : tap and hold to drag + lock
>  > > + *  3 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_TAP_DRAG                    0xd5
>  > > +/*
>  > > + * touch sensitivity
>  > > + *  1 - 7 : least to most sensitive
>  > > + */
>  > > +#define BYD_CMD_SET_TOUCH_SENSITIVITY           0xd6
>  > > +/*
>  > > + * one finger scrolling
>  > > + *  1 : vertical
>  > > + *  2 : horizontal
>  > > + *  3 : vertical + horizontal
>  > > + *  4 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_ONE_FINGER_SCROLL           0xd7
>  > > +/*
>  > > + * one finger scrolling function
>  > > + *  1 : free scrolling
>  > > + *  2 : edge motion
>  > > + *  3 : free scrolling + edge motion
>  > > + *  4 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC      0xd8
>  > > +/*
>  > > + * sliding speed
>  > > + *  1 - 5 : slowest to fastest
>  > > + */
>  > > +#define BYD_CMD_SET_SLIDING_SPEED               0xda
>  > > +/*
>  > > + * edge motion
>  > > + *  1 : disable
>  > > + *  2 : enable when dragging
>  > > + *  3 : enable when dragging and pointing
>  > > + */
>  > > +#define BYD_CMD_SET_EDGE_MOTION                 0xdb
>  > > +/*
>  > > + * left edge region size
>  > > + *  0 - 7 : smallest to largest width
>  > > + */
>  > > +#define BYD_CMD_SET_LEFT_EDGE_REGION            0xdc
>  > > +/*
>  > > + * top edge region size
>  > > + *  0 - 9 : smallest to largest height
>  > > + */
>  > > +#define BYD_CMD_SET_TOP_EDGE_REGION             0xdd
>  > > +/*
>  > > + * disregard palm press as clicks
>  > > + *  1 - 6 : smallest to largest
>  > > + */
>  > > +#define BYD_CMD_SET_PALM_CHECK                  0xde
>  > > +/* right edge region size
>  > > + *  0 - 7 : smallest to largest width
>  > > + */
>  > > +#define BYD_CMD_SET_RIGHT_EDGE_REGION           0xdf
>  > > +/*
>  > > + * bottom edge region size
>  > > + *  0 - 9 : smallest to largest height
>  > > + */
>  > > +#define BYD_CMD_SET_BOTTOM_EDGE_REGION          0xe1
>  > > +/*
>  > > + * multitouch gestures
>  > > + *  1 : enable
>  > > + *  2 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_MULTITOUCH                  0xe3
>  > > +/*
>  > > + * edge motion speed
>  > > + *  0 : control with finger pressure
>  > > + *  1 - 9 : slowest to fastest
>  > > + */
>  > > +#define BYD_CMD_SET_EDGE_MOTION_SPEED           0xe4
>  > > +/*
>  > > + * two finger scolling function
>  > > + *  0 : free scrolling
>  > > + *  1 : free scrolling (with momentum)
>  > > + *  2 : edge motion
>  > > + *  3 : free scrolling (with momentum) + edge motion
>  > > + *  4 : disable
>  > > + */
>  > > +#define BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC      0xe5
>  >
>  > These are definitely worth merging into the existing driver - I never
> got the
>  > time to figure out all of the different settings.
>  >
>  > > +
>  > > +struct byd_data {
>  > > + struct timer_list timer;
>  > > + int32_t abs_x;
>  > > + int32_t abs_y;
>  > > + uint32_t last_touch_time;
>  > > + uint32_t button_left      : 1;
>  > > + uint32_t button_right     : 1;
>  > > + uint32_t touch            : 1;
>  > > +};
>  > > +
>  >
>  > It looks like whatever email client you used has broken the
> formatting - when
>  > you resend, can you use something which will preserve whitespace
> properly? See
>  > 'Documentation/email-clients.txt'.
>  >
>  > > +static void byd_report_input(struct psmouse *psmouse)
>  > > +{
>  > > + struct byd_data *priv = (struct byd_data *)psmouse->private;
>  > > + struct input_dev *dev = psmouse->dev;
>  > > +
>  > > + input_report_abs(dev, ABS_X, priv->abs_x);
>  > > + input_report_abs(dev, ABS_Y, priv->abs_y);
>  > > + input_report_key(dev, BTN_LEFT, priv->button_left);
>  > > + input_report_key(dev, BTN_RIGHT, priv->button_right);
>  > > + input_report_key(dev, BTN_TOUCH, priv->touch);
>  > > + input_report_key(dev, BTN_TOOL_FINGER, priv->touch);
>  > > +
>  > > + input_sync(dev);
>  > > +}
>  >
>  > Could you explain generally why you're reporting in absolute mode? What
>  > advantage does it have over using relative reporting and turning off the
>  > absolute packets in the touchpad init sequence?
>  >
>  > > +
>  > > +static void byd_clear_touch(unsigned long data)
>  > > +{
>  > > + struct psmouse *psmouse = (struct psmouse *)data;
>  > > + struct byd_data *priv = psmouse->private;
>  > > +
>  > > + serio_pause_rx(psmouse->ps2dev.serio);
>  > > +
>  > > + priv->touch = 0;
>  > > + /*
>  > > + * move cursor back to center of pad when we lose touch
>  > > + * this specifically improves user experiencce when moving
>  > > + * cursor with one finger, and pressing butoton with other
>  > > + */
>  > > + priv->abs_x = BYD_CONST_PAD_WIDTH / 2;
>  > > + priv->abs_y = BYD_CONST_PAD_HEIGHT / 2;
>  > > +
>  > > + byd_report_input(psmouse);
>  >
>  > serio_pause_rx() takes a spinlock - might be worth checking that
>  > byd_report_input() doesn't do anything that might sleep.
>  >
>  > > + switch (packet[3]) {
>  > > + case BYD_PKT_ABSOLUTE:
>  > > + /* on first touch, use the absolute packet to determine our start
> location */
>  > > + if (priv->touch == 0) {
>  > > + priv->abs_x = packet[1] * (BYD_CONST_PAD_WIDTH / 256);
>  > > + priv->abs_y = (255 - packet[2]) * (BYD_CONST_PAD_HEIGHT / 256);
>  > > +
>  > > + /* needed to detect tap */
>  > > + if (now_msecs - priv->last_touch_time > 64) {
>  > > + priv->touch = 1;
>  > > + }
>  > > + }
>  > > + break;
>  > > + case BYD_PKT_RELATIVE:
>  > > + {
>  > > + int32_t rel_x, rel_y;
>  > > +
>  > > + /* same as regular PS/2 psmouse protocoal */
>  > > + rel_x = packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) &
> 0x100) : 0;
>  > > + rel_y = packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int)
> packet[2] : 0;
>  > > +
>  > > + /*
>  > > + * experiments show relative mouse packets come in increments of
>  > > + * 1 unit / 11 msecs (regardless of time delta between relative
> packets)
>  > > + */
>  > > + priv->abs_x += rel_x * 11;
>  > > + priv->abs_y += rel_y * 11;
>  > > +
>  > > + priv->touch = 1;
>  > > + }
>  >
>  > So can this not handle gestures/multitouch?
>  >
>  > Cheers!
>  > Chris
>
