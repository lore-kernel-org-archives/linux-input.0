From: Richard Pospesel <pospeselr@gmail.com>
Subject: [PATCH] psmouse: added BYD touchpad driver
Date: Sat, 30 Jan 2016 19:26:56 -0800
Message-ID: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33116 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbcAaD05 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2016 22:26:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This adds proper single-touch support for BYD touchpads to the psmouse input
driver.

This patch is against commit b82dde0230439215b55e545880e90337ee16f51a (Merge tag
'please-pull-copy_file_range' of
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux ) of Linus' kernel
branch.

Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
---
 Kconfig        |    9
 Makefile       |    1
 byd.c          |  586 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 byd.h          |   33 +++
 psmouse-base.c |   17 +
 psmouse.h      |    1
 6 files changed, 647 insertions(+)
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 17f97e5..63d5349 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -161,6 +161,15 @@ config MOUSE_PS2_VMMOUSE

   If unsure, say N.

+config MOUSE_PS2_BYD
+ bool "BYD PS/2 protocol extension"
+ depends on MOUSE_PS2
+ help
+  Say Y here if you have a BYD PS/2 touchpad
+  connected to your system.
+
+  If unsure, say N.
+
 config MOUSE_SERIAL
  tristate "Serial mouse"
  select SERIO
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index ee6a6e9..67f22cc 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -37,6 +37,7 @@ psmouse-$(CONFIG_MOUSE_PS2_TRACKPOINT) += trackpoint.o
 psmouse-$(CONFIG_MOUSE_PS2_TOUCHKIT) += touchkit_ps2.o
 psmouse-$(CONFIG_MOUSE_PS2_CYPRESS) += cypress_ps2.o
 psmouse-$(CONFIG_MOUSE_PS2_VMMOUSE) += vmmouse.o
+psmouse-$(CONFIG_MOUSE_PS2_BYD) += byd.o

 elan_i2c-objs := elan_i2c_core.o
 elan_i2c-$(CONFIG_MOUSE_ELAN_I2C_I2C) += elan_i2c_i2c.o
diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
new file mode 100644
index 0000000..a880adb
--- /dev/null
+++ b/drivers/input/mouse/byd.c
@@ -0,0 +1,586 @@
+/*
+ * BYD BTP-10463 touchpad PS/2 mouse driver
+ *
+ * Copyright (C) 2015, Tai Chi Minh Ralph Eastwood
+ * Copyright (C) 2015, Martin Wimpress
+ * Copyright (C) 2015, Jay Kuri
+ * Copyright (C) 2015, Richard Pospesel
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Protocol of BYD Touch Pad reverse-engineered from windows driver:
+ * filename:  "byd touchpad driver - win7, 8, 8.1 - 2.4.1.102.zip"
+ * sha1:      97a0eca8edc482bf9d08ab9509084a514dad4c4b
+ * datasheet: http://bydit.com/userfiles/file/BTP10463-XXX.pdf
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/slab.h>
+#include <linux/libps2.h>
+
+#include "psmouse.h"
+#include "byd.h"
+
+#define BYD_MODEL_ID_LEN        2
+#define BYD_CMD_PAIR(c) ((1 << 12) | (c))
+#define BYD_CMD_PAIR_R(r, c) ((1 << 12) | (r << 8) | (c))
+
+/* BYD pad constants */
+
+/*
+ * true device resolution is unknown, however experiments show the
+ * resolution is about 111 units/mm
+ * absolute coordinate packets are in the range 0-255 for both X and y
+ * we pick ABS_X/ABS_Y dimensions which are multiples of 256 and in
+ * the right ballpark given the touchpad's physical dimensions and estimate
+ * resolution per spec sheet, device active area dimensions are
+ * 101.6 x 60.1 mm
+ */
+
+#define BYD_CONST_PAD_WIDTH                     11264
+#define BYD_CONST_PAD_HEIGHT                    6656
+#define BYD_CONST_PAD_RESOLUTION                111
+
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
+ uint8_t command;
+ uint8_t  value;
+};
+
+static const struct byd_init_command_pair init_commands[] = {
+ {BYD_CMD_SET_HANDEDNESS, 0x01},
+ {BYD_CMD_SET_PHYSICAL_BUTTONS, 0x04},
+ {BYD_CMD_SET_TAP, 0x02},
+ {BYD_CMD_SET_ONE_FINGER_SCROLL, 0x04},
+ {BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC, 0x04},
+ {BYD_CMD_SET_EDGE_MOTION, 0x01},
+ {BYD_CMD_SET_PALM_CHECK, 0x00},
+ {BYD_CMD_SET_MULTITOUCH, 0x02},
+ {BYD_CMD_SET_TWO_FINGER_SCROLL, 0x04},
+ {BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC, 0x04},
+ {BYD_CMD_SET_LEFT_EDGE_REGION, 0x00},
+ {BYD_CMD_SET_TOP_EDGE_REGION, 0x00},
+ {BYD_CMD_SET_RIGHT_EDGE_REGION, 0x0},
+ {BYD_CMD_SET_BOTTOM_EDGE_REGION, 0x00},
+ {BYD_CMD_SET_ABSOLUTE_MODE, 0x02},
+};
+
+struct byd_model_info {
+ char name[16];
+ char id[BYD_MODEL_ID_LEN];
+};
+
+static struct byd_model_info byd_model_data[] = {
+ { "BTP10463", { 0x03, 0x64 } }
+};
+
+struct byd_data {
+ struct timer_list timer;
+ int32_t abs_x;
+ int32_t abs_y;
+ uint32_t last_touch_time;
+ uint32_t button_left      : 1;
+ uint32_t button_right     : 1;
+ uint32_t touch            : 1;
+};
+
+static void byd_report_input(struct psmouse *psmouse)
+{
+ struct byd_data *priv = (struct byd_data *)psmouse->private;
+ struct input_dev *dev = psmouse->dev;
+
+ input_report_abs(dev, ABS_X, priv->abs_x);
+ input_report_abs(dev, ABS_Y, priv->abs_y);
+ input_report_key(dev, BTN_LEFT, priv->button_left);
+ input_report_key(dev, BTN_RIGHT, priv->button_right);
+ input_report_key(dev, BTN_TOUCH, priv->touch);
+ input_report_key(dev, BTN_TOOL_FINGER, priv->touch);
+
+ input_sync(dev);
+}
+
+static void byd_clear_touch(unsigned long data)
+{
+ struct psmouse *psmouse = (struct psmouse *)data;
+ struct byd_data *priv = psmouse->private;
+
+ serio_pause_rx(psmouse->ps2dev.serio);
+
+ priv->touch = 0;
+ /*
+ * move cursor back to center of pad when we lose touch
+ * this specifically improves user experiencce when moving
+ * cursor with one finger, and pressing butoton with other
+ */
+ priv->abs_x = BYD_CONST_PAD_WIDTH / 2;
+ priv->abs_y = BYD_CONST_PAD_HEIGHT / 2;
+
+ byd_report_input(psmouse);
+
+ serio_continue_rx(psmouse->ps2dev.serio);
+}
+
+static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
+{
+ struct byd_data *priv = psmouse->private;
+ unsigned char *packet = psmouse->packet;
+ uint32_t now_msecs = jiffies_to_msecs(jiffies);
+
+
+ if (psmouse->pktcnt < psmouse->pktsize)
+ return PSMOUSE_GOOD_DATA;
+
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "process: packet = %x %x %x %x\n",
+ packet[0], packet[1], packet[2], packet[3]);
+#endif
+
+ switch (packet[3]) {
+ case BYD_PKT_ABSOLUTE:
+ /* on first touch, use the absolute packet to determine our start location */
+ if (priv->touch == 0) {
+ priv->abs_x = packet[1] * (BYD_CONST_PAD_WIDTH / 256);
+ priv->abs_y = (255 - packet[2]) * (BYD_CONST_PAD_HEIGHT / 256);
+
+ /* needed to detect tap */
+ if (now_msecs - priv->last_touch_time > 64) {
+ priv->touch = 1;
+ }
+ }
+ break;
+ case BYD_PKT_RELATIVE:
+ {
+ int32_t rel_x, rel_y;
+
+ /* same as regular PS/2 psmouse protocoal */
+ rel_x = packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0;
+ rel_y = packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0;
+
+ /*
+ * experiments show relative mouse packets come in increments of
+ * 1 unit / 11 msecs (regardless of time delta between relative packets)
+ */
+ priv->abs_x += rel_x * 11;
+ priv->abs_y += rel_y * 11;
+
+ priv->touch = 1;
+ }
+ break;
+ default:
+ /* shoudn't be sending anything else, but ignore just in-case */
+ return PSMOUSE_FULL_PACKET;
+ }
+
+ /* both ABS and REL packets report button states */
+ priv->button_left = packet[0] & 1;
+ priv->button_right = (packet[0] >> 1) & 1;
+
+ byd_report_input(psmouse);
+
+ /* reset time since last touch */
+ if (priv->touch == 1) {
+ priv->last_touch_time = now_msecs;
+ mod_timer(&priv->timer, jiffies + msecs_to_jiffies(64));
+ }
+
+ return PSMOUSE_FULL_PACKET;
+}
+
+int byd_init(struct psmouse *psmouse)
+{
+ struct byd_data *priv;
+ struct ps2dev *ps2dev = &psmouse->ps2dev;
+ unsigned char param[4];
+ int cmd, error = 0;
+ int i = 0;
+
+ /* it needs to be initialised like an intellimouse to get 4-byte packets */
+ psmouse_reset(psmouse);
+ param[0] = 200;
+ ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+ param[0] = 100;
+ ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+ param[0] =  80;
+ ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+ ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+
+ if (param[0] != 3)
+ return -1;
+
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "detect: init sequence\n");
+#endif
+
+ /* activate the mouse to initialise it */
+ psmouse_activate(psmouse);
+
+ /* enter command mode */
+ param[0] = 0x00;
+ if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe2))) {
+ error = -EIO;
+ goto init_fail;
+ }
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "detect: entered command mode\n");
+#endif
+
+ /* send second identification command */
+ param[0] = 0x02;
+ if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe0))) {
+ error = -EIO;
+ goto init_fail;
+ }
+
+ param[0] = 0x01;
+ if (ps2_command(ps2dev, param, BYD_CMD_PAIR_R(4, 0xe0))) {
+ error = -EIO;
+ goto init_fail;
+ }
+
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "detect: magic %x %x %x %x\n",
+ param[0], param[1], param[2], param[3]);
+#endif
+
+ /* magic identifier the vendor driver reads */
+ if (param[0] != 0x08 || param[1] != 0x01 ||
+    param[2] != 0x01 || param[3] != 0x31) {
+#ifdef BYD_DEBUG
+ psmouse_err(psmouse, "unknown magic, expected: 08 01 01 31\n");
+#endif
+ error = -EINVAL;
+ goto init_fail;
+ }
+
+ /*
+ * send the byd vendor commands
+ * these appear to be pairs of (command, param)
+ */
+ for (i = 0; i < ARRAY_SIZE(init_commands); i++) {
+ param[0] = init_commands[i].value;
+ cmd = BYD_CMD_PAIR(init_commands[i].command);
+ if (ps2_command(ps2dev, param, cmd)) {
+ error = -EIO;
+ goto init_fail;
+ }
+ }
+
+ /* confirm/finalize the above vender command table */
+ param[0] = 0x00;
+ if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe0))) {
+ error = -EIO;
+ goto init_fail;
+ }
+
+ /* exit command mode */
+ param[0] = 0x01;
+ if (ps2_command(ps2dev, param, BYD_CMD_PAIR(0xe2))) {
+ error = -ENOMEM;
+ goto init_fail;
+ }
+
+ /* alloc space for byd_data */
+ priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+ if (!priv) {
+ error = -ENOMEM;
+ goto init_fail;
+ }
+
+ /* init struct and timer */
+ memset(priv, 0x00, sizeof(*priv));
+ /* signal touch end after not receiving movement packets for 32 ms */
+ setup_timer(&priv->timer, byd_clear_touch, (unsigned long)psmouse);
+ psmouse->private = priv;
+
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "detect: exit command mode\n");
+#endif
+
+ return 0;
+
+init_fail:
+ psmouse_deactivate(psmouse);
+ return error;
+}
+
+static void byd_disconnect(struct psmouse *psmouse)
+{
+ if (psmouse->private) {
+ struct byd_data *priv = psmouse->private;
+
+ del_timer(&priv->timer);
+ kfree(psmouse->private);
+ psmouse->private = NULL;
+ }
+}
+
+static int byd_reconnect(struct psmouse *psmouse)
+{
+ if (byd_detect(psmouse, 0)) {
+ return -1;
+ }
+
+ if (byd_init(psmouse)) {
+ return -1;
+ }
+
+ return 0;
+}
+
+int byd_detect(struct psmouse *psmouse, bool set_properties)
+{
+ struct ps2dev *ps2dev = &psmouse->ps2dev;
+ unsigned char param[4];
+ int i;
+
+ /* reset the mouse */
+ psmouse_reset(psmouse);
+
+ /* magic knock - identify the mouse (as per. the datasheet) */
+ param[0] = 0x03;
+ if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+    ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+    ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+    ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
+ return -EIO;
+ }
+
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "detect: model id: %x %x %x\n",
+ param[0], param[1], param[2]);
+#endif
+
+ /*
+ * match the device - the first byte, param[0], appears to be set
+ * to some unknown value based on the state of the mouse and cannot
+ * be used for identification after suspend.
+ */
+ for (i = 0; i < ARRAY_SIZE(byd_model_data); i++) {
+ if (!memcmp(param + 1, &byd_model_data[i].id, BYD_MODEL_ID_LEN)) {
+ break;
+ }
+ }
+
+ /* no match found */
+ if (i == ARRAY_SIZE(byd_model_data)) {
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "detect: no match found\n");
+#endif
+ return -EINVAL;
+ } else {
+#ifdef BYD_DEBUG
+ psmouse_dbg(psmouse, "detect: matched %s\n",
+ byd_model_data[i].name);
+#endif
+ }
+
+ if (set_properties) {
+ struct input_dev *dev = psmouse->dev;
+
+ __set_bit(INPUT_PROP_POINTER, dev->propbit);
+
+ /* touchpad */
+ __set_bit(BTN_TOUCH, dev->keybit);
+ __set_bit(BTN_TOOL_FINGER, dev->keybit);
+
+ /* buttons */
+ __set_bit(BTN_LEFT, dev->keybit);
+ __set_bit(BTN_RIGHT, dev->keybit);
+ __clear_bit(BTN_MIDDLE, dev->keybit);
+
+ /* absolute position */
+ __set_bit(EV_ABS, dev->evbit);
+
+ input_set_abs_params(dev, ABS_X, 0, BYD_CONST_PAD_WIDTH, 0, 0);
+ input_set_abs_params(dev, ABS_Y, 0, BYD_CONST_PAD_HEIGHT, 0, 0);
+ input_abs_set_res(dev, ABS_X, BYD_CONST_PAD_RESOLUTION);
+ input_abs_set_res(dev, ABS_Y, BYD_CONST_PAD_RESOLUTION);
+
+ /* no relative support */
+ __clear_bit(EV_REL, dev->evbit);
+ __clear_bit(REL_X, dev->relbit);
+ __clear_bit(REL_Y, dev->relbit);
+
+ psmouse->vendor = "BYD";
+ psmouse->name = "TouchPad";
+ psmouse->protocol_handler = byd_process_byte;
+ psmouse->pktsize = 4;
+ psmouse->private = NULL;
+ psmouse->disconnect = byd_disconnect;
+ psmouse->reconnect = byd_reconnect;
+ }
+
+ return 0;
+}
diff --git a/drivers/input/mouse/byd.h b/drivers/input/mouse/byd.h
new file mode 100644
index 0000000..75e4295
--- /dev/null
+++ b/drivers/input/mouse/byd.h
@@ -0,0 +1,33 @@
+/*
+ * BYD BTP-10463 touchpad PS/2 mouse driver
+ *
+ * Copyright (C) 2015, Tai Chi Minh Ralph Eastwood
+ * Copyright (C) 2015, Martin Wimpress
+ * Copyright (C) 2015, Jay Kuri
+ * Copyright (C) 2016, Richard Pospesel
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef __BYD_H
+#define __BYD_H
+
+#ifdef CONFIG_MOUSE_PS2_BYD
+int byd_detect(struct psmouse *psmouse, bool set_properties);
+int byd_init(struct psmouse *psmouse);
+#else
+static inline int byd_detect(struct psmouse *psmouse,
+      bool set_properties)
+{
+ return -ENOSYS;
+}
+static inline int byd_init(struct psmouse *psmouse)
+{
+ return -ENOSYS;
+}
+
+#endif /* CONFIG_MOUSE_PS2_BYD */
+
+#endif /* !__BYD_H */
diff --git a/drivers/input/mouse/psmouse-base.c
b/drivers/input/mouse/psmouse-base.c
index b9e4ee3..abc2234 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -32,6 +32,7 @@
 #include "lifebook.h"
 #include "trackpoint.h"
 #include "touchkit_ps2.h"
+#include "byd.h"
 #include "elantech.h"
 #include "sentelic.h"
 #include "cypress_ps2.h"
@@ -842,6 +843,15 @@ static const struct psmouse_protocol
psmouse_protocols[] = {
  .init = vmmouse_init,
  },
 #endif
+#ifdef CONFIG_MOUSE_PS2_BYD
+ {
+ .type = PSMOUSE_BYD,
+ .name = "BYDPS/2",
+ .alias = "byd",
+ .detect = byd_detect,
+ .init       = byd_init,
+ },
+#endif
  {
  .type = PSMOUSE_AUTO,
  .name = "auto",
@@ -1089,6 +1099,13 @@ static int psmouse_extensions(struct psmouse *psmouse,
  return PSMOUSE_ELANTECH;
  }

+ /* Try BYD touchpad. */
+ if (max_proto > PSMOUSE_IMEX &&
+ psmouse_try_protocol(psmouse, PSMOUSE_BYD,
+ &max_proto, set_properties, true)) {
+ return PSMOUSE_BYD;
+ }
+
  if (max_proto > PSMOUSE_IMEX) {
  if (psmouse_try_protocol(psmouse, PSMOUSE_GENPS,
  &max_proto, set_properties, true))
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index ad5a5a1..e0ca6cd 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -104,6 +104,7 @@ enum psmouse_type {
  PSMOUSE_CYPRESS,
  PSMOUSE_FOCALTECH,
  PSMOUSE_VMMOUSE,
+ PSMOUSE_BYD,
  PSMOUSE_AUTO /* This one should always be last */
 };
