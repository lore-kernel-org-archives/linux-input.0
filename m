From: Richard Pospesel <pospeselr@gmail.com>
Subject: [PATCH] Input: byd - fix issue where generic PS/2 mice are detected as BYD touchpad
Date: Tue, 28 Jun 2016 21:01:18 -0700
Message-ID: <1467172878-25483-1-git-send-email-pospeselr@gmail.com>
References: <20160627213412.GC22620@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33543 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcF2EBe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2016 00:01:34 -0400
Received: by mail-pa0-f68.google.com with SMTP id ts6so3315175pac.0
        for <linux-input@vger.kernel.org>; Tue, 28 Jun 2016 21:01:33 -0700 (PDT)
In-Reply-To: <20160627213412.GC22620@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, chris@diamand.org, phonesyfreakies@gmail.com

The secret handshake used was not sufficient to determine whether the connected
device was actually a BYD touchpad.  Added some restrictions on what the first
byte returned may be (based off of experiments with BYD touchapd).  Moved
subsequent initialization logic from byd_init to tail of byd_detect, and
removed byd_init function.

Fixes bug 1201781.  Tested on laptop with BYD touchpad hardware.

Applied against commit fcd6eb50eadd83f857eac55f99316f1789707cdb

Signed-off-by: Richard Pospesel <pospeselr@gmail.com>

---
diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index ec73f75..92f5556 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -2,6 +2,10 @@
  * BYD TouchPad PS/2 mouse driver
  *
  * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
+ * Copyright (C) 2015 Richard Pospesel
+ * Copyright (C) 2015 Tai Chi Minh Ralph Eastwood
+ * Copyright (C) 2015 Martin Wimpress
+ * Copyright (C) 2015 Jay Kuri
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
@@ -355,7 +359,7 @@ static int byd_reset_touchpad(struct psmouse *psmouse)
 		{ PSMOUSE_CMD_ENABLE, 0 },
 		/*
 		 * BYD-specific initialization, which enables absolute mode and
-		 * (if desired), the touchpad's built-in gesture detection.
+		 * disables the builtin hardware gesture recogniton.
 		 */
 		{ 0x10E2, 0x00 },
 		{ 0x10E0, 0x02 },
@@ -435,6 +439,10 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[4] = {0x03, 0x00, 0x00, 0x00};

+	if (psmouse_reset(psmouse))
+		return -EIO;
+
+	/* 'Secret' handshake */
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
 		return -1;
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
@@ -446,62 +454,68 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return -1;

-	if (param[1] != 0x03 || param[2] != 0x64)
+	/*
+	 * BYD touchpad returns 0x03 for resolution ( 8 count / mm ) and
+	 * 0x64 ( 100 samples / sec ) for sampling rate
+	 * The first byte's value is dependent on the mouse button states:
+	 *  0 : no button pressed
+	 *  1 : right button pressed
+	 *  4 : left button pressed
+	 *  5 : right and left button pressed
+	 */
+	if ((param[0] & 0x05) != param[0] ||
+	    param[1] != 0x03 ||
+	    param[2] != 0x64)
+		return -ENODEV;
+
+	/* Attempt to set BYD unique settings */
+	if (byd_reset_touchpad(psmouse))
 		return -ENODEV;

 	psmouse_dbg(psmouse, "BYD touchpad detected\n");

 	if (set_properties) {
-		psmouse->vendor = "BYD";
-		psmouse->name = "TouchPad";
-	}
+		struct input_dev *dev = psmouse->dev;
+		struct byd_data *priv;

-	return 0;
-}
+		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;

-int byd_init(struct psmouse *psmouse)
-{
-	struct input_dev *dev = psmouse->dev;
-	struct byd_data *priv;
-
-	if (psmouse_reset(psmouse))
-		return -EIO;
-
-	if (byd_reset_touchpad(psmouse))
-		return -EIO;
+		setup_timer(
+			&priv->timer,
+			byd_clear_touch,
+			(unsigned long) psmouse);

-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	setup_timer(&priv->timer, byd_clear_touch, (unsigned long) psmouse);
-
-	psmouse->private = priv;
-	psmouse->disconnect = byd_disconnect;
-	psmouse->reconnect = byd_reconnect;
-	psmouse->protocol_handler = byd_process_byte;
-	psmouse->pktsize = 4;
-	psmouse->resync_time = 0;
-
-	__set_bit(INPUT_PROP_POINTER, dev->propbit);
-	/* Touchpad */
-	__set_bit(BTN_TOUCH, dev->keybit);
-	__set_bit(BTN_TOOL_FINGER, dev->keybit);
-	/* Buttons */
-	__set_bit(BTN_LEFT, dev->keybit);
-	__set_bit(BTN_RIGHT, dev->keybit);
-	__clear_bit(BTN_MIDDLE, dev->keybit);
-
-	/* Absolute position */
-	__set_bit(EV_ABS, dev->evbit);
-	input_set_abs_params(dev, ABS_X, 0, BYD_PAD_WIDTH, 0, 0);
-	input_set_abs_params(dev, ABS_Y, 0, BYD_PAD_HEIGHT, 0, 0);
-	input_abs_set_res(dev, ABS_X, BYD_PAD_RESOLUTION);
-	input_abs_set_res(dev, ABS_Y, BYD_PAD_RESOLUTION);
-	/* No relative support */
-	__clear_bit(EV_REL, dev->evbit);
-	__clear_bit(REL_X, dev->relbit);
-	__clear_bit(REL_Y, dev->relbit);
+		psmouse->private = priv;
+		psmouse->vendor = "BYD";
+		psmouse->name = "TouchPad";
+		psmouse->disconnect = byd_disconnect;
+		psmouse->reconnect = byd_reconnect;
+		psmouse->protocol_handler = byd_process_byte;
+		psmouse->pktsize = 4;
+		psmouse->resync_time = 0;
+
+		__set_bit(INPUT_PROP_POINTER, dev->propbit);
+		/* Touchpad */
+		__set_bit(BTN_TOUCH, dev->keybit);
+		__set_bit(BTN_TOOL_FINGER, dev->keybit);
+		/* Buttons */
+		__set_bit(BTN_LEFT, dev->keybit);
+		__set_bit(BTN_RIGHT, dev->keybit);
+		__clear_bit(BTN_MIDDLE, dev->keybit);
+
+		/* Absolute position */
+		__set_bit(EV_ABS, dev->evbit);
+		input_set_abs_params(dev, ABS_X, 0, BYD_PAD_WIDTH, 0, 0);
+		input_set_abs_params(dev, ABS_Y, 0, BYD_PAD_HEIGHT, 0, 0);
+		input_abs_set_res(dev, ABS_X, BYD_PAD_RESOLUTION);
+		input_abs_set_res(dev, ABS_Y, BYD_PAD_RESOLUTION);
+		/* No relative support */
+		__clear_bit(EV_REL, dev->evbit);
+		__clear_bit(REL_X, dev->relbit);
+		__clear_bit(REL_Y, dev->relbit);
+	}

 	return 0;
-}
+}
\ No newline at end of file
diff --git a/drivers/input/mouse/byd.h b/drivers/input/mouse/byd.h
index d6c120c..810d19e 100644
--- a/drivers/input/mouse/byd.h
+++ b/drivers/input/mouse/byd.h
@@ -3,16 +3,11 @@

 #ifdef CONFIG_MOUSE_PS2_BYD
 int byd_detect(struct psmouse *psmouse, bool set_properties);
-int byd_init(struct psmouse *psmouse);
 #else
 static inline int byd_detect(struct psmouse *psmouse, bool set_properties)
 {
 	return -ENOSYS;
 }
-static inline int byd_init(struct psmouse *psmouse)
-{
-	return -ENOSYS;
-}
 #endif /* CONFIG_MOUSE_PS2_BYD */

 #endif /* _BYD_H */
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 5784e20..5750a10 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -849,7 +849,6 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.name		= "BYDPS/2",
 		.alias		= "byd",
 		.detect		= byd_detect,
-		.init		= byd_init,
 	},
 #endif
 	{
