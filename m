From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] Input: hgpk - support GlideSensor and PenTablet modes
Date: Wed,  6 Oct 2010 16:50:26 +0100 (BST)
Message-ID: <20101006155026.5BB289D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:53677 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758828Ab0JFPvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Oct 2010 11:51:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org

Add a "hgpk_mode" sysfs attribute that allows selection between 3 options:
Mouse (the existing option), GlideSensor and PenTablet.

GlideSensor is an enhanced protocol for the regular touchpad mode that
additionally reports pressure and uses absolute coordinates. We suspect
that it may be more reliable than mouse mode in some environments.

PenTablet mode puts the touchpad into resistive mode, you must then use
a stylus as an input. We suspect this is the most reliable way to drive
the touchpad.

After changing the mode you must request a rescan for the change to take
effect:
	echo -n rescan > /sys/bus/serio/devices/serio1/drvctl

The GlideSensor and PenTablet devices expose themselves with the
intention of being combined with the synaptics X11 input driver.

Based on earlier work by Paul Fox.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/hgpk.c |  315 +++++++++++++++++++++++++++++++++++++++++---
 drivers/input/mouse/hgpk.h |   11 ++
 2 files changed, 307 insertions(+), 19 deletions(-)

Dmitry: thanks for pointing out that the synaptics X11 driver is no longer
only for synaptics hardware, that was the solution I was missing.

I'll rebase and resubmit the other patches in the original series once
this one has passed review and merge.

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 1d2205b..6115e0d 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -69,6 +69,13 @@ module_param(post_interrupt_delay, int, 0644);
 MODULE_PARM_DESC(post_interrupt_delay,
 	"delay (ms) before recal after recal interrupt detected");
 
+int hgpk_mode = HGPK_MODE_MOUSE;
+static const char * const mode_names[] = {
+	[HGPK_MODE_MOUSE] = "Mouse",
+	[HGPK_MODE_GLIDESENSOR] = "GlideSensor",
+	[HGPK_MODE_PENTABLET] = "PenTablet",
+};
+
 /*
  * When the touchpad gets ultra-sensitive, one can keep their finger 1/2"
  * above the pad and still have it send packets.  This causes a jump cursor
@@ -143,23 +150,137 @@ static void hgpk_spewing_hack(struct psmouse *psmouse,
  * swr/swl are the left/right buttons.
  * x-neg/y-neg are the x and y delta negative bits
  * x-over/y-over are the x and y overflow bits
+ *
+ * ---
+ *
+ * HGPK Advanced Mode - single-mode format
+ *
+ * byte 0(PT):  1    1    0    0    1    1     1     1
+ * byte 0(GS):  1    1    1    1    1    1     1     1
+ * byte 1:      0   x6   x5   x4   x3   x2    x1    x0
+ * byte 2(PT):  0    0   x9   x8   x7    ? pt-dsw    0
+ * byte 2(GS):  0  x10   x9   x8   x7    ? gs-dsw pt-dsw
+ * byte 3:      0   y9   y8   y7    1    0   swr   swl
+ * byte 4:      0   y6   y5   y4   y3   y2    y1    y0
+ * byte 5:      0   z6   z5   z4   z3   z2    z1    z0
+ *
+ * ?'s are not defined in the protocol spec, may vary between models.
+ *
+ * swr/swl are the left/right buttons.
+ *
+ * pt-dsw/gs-dsw indicate that the pt/gs sensor is detecting a
+ * pen/finger
  */
-static int hgpk_validate_byte(unsigned char *packet)
+static int hgpk_validate_byte(struct psmouse *psmouse, unsigned char *packet)
 {
-	return (packet[0] & 0x0C) != 0x08;
+	struct hgpk_data *priv = psmouse->private;
+	int pktcnt = psmouse->pktcnt;
+	int r = 0;
+
+	switch (priv->mode) {
+	case HGPK_MODE_MOUSE:
+		r = (packet[0] & 0x0C) != 0x08;
+		if (r)
+			hgpk_dbg(psmouse, "bad data (%d) %02x %02x %02x\n",
+				 psmouse->pktcnt, psmouse->packet[0],
+				 psmouse->packet[1], psmouse->packet[2]);
+		break;
+
+	case HGPK_MODE_GLIDESENSOR:
+	case HGPK_MODE_PENTABLET:
+		/* bytes 2 - 6 should have 0 in the highest bit */
+		if (pktcnt >= 2 && pktcnt <= 6 && (packet[pktcnt - 1] & 0x80))
+			r = -1;
+		if (priv->mode == HGPK_MODE_GLIDESENSOR && packet[0] != HGPK_GS)
+			r = -1;
+		if (priv->mode == HGPK_MODE_PENTABLET && packet[0] != HGPK_PT)
+			r = -1;
+		if (r)
+			hgpk_dbg(psmouse, "bad data, mode %d (%d) "
+				 "%02x %02x %02x %02x %02x %02x\n",
+				 priv->mode, psmouse->pktcnt,
+				 psmouse->packet[0], psmouse->packet[1],
+				 psmouse->packet[2], psmouse->packet[3],
+				 psmouse->packet[4], psmouse->packet[5]);
+		break;
+	}
+	return r;
 }
 
-static void hgpk_process_packet(struct psmouse *psmouse)
+static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 {
-	struct input_dev *dev = psmouse->dev;
+	struct hgpk_data *priv = psmouse->private;
+	struct input_dev *idev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
-	int x, y, left, right;
+	int left = !!(packet[3] & 1);
+	int right = !!(packet[3] & 2);
+	int x = packet[1] | ((packet[2] & 0x78) << 4);
+	int y = packet[4] | ((packet[3] & 0x70) << 3);
+	int z = packet[5];
+	int down;
+
+	if (priv->mode == HGPK_MODE_GLIDESENSOR) {
+		int pt_down = !!(packet[2] & 1);
+		int finger_down = !!(packet[2] & 2);
+
+		BUG_ON(packet[0] == HGPK_PT);
+		input_report_abs(idev, ABS_PRESSURE, z);
+		down = finger_down;
+		if (tpdebug)
+			hgpk_dbg(psmouse, "pd=%d fd=%d ",
+				 pt_down, finger_down);
+	} else {
+		BUG_ON(packet[0] == HGPK_GS);
+		down = !!(packet[2] & 2);
+		if (tpdebug)
+			hgpk_dbg(psmouse, "pd=%d ", down);
+	}
 
-	left = packet[0] & 1;
-	right = (packet[0] >> 1) & 1;
+	if (tpdebug)
+		hgpk_dbg(psmouse, "l=%d r=%d x=%d y=%d z=%d\n",
+			 left, right, x, y, z);
 
-	x = packet[1] - ((packet[0] << 4) & 0x100);
-	y = ((packet[0] << 3) & 0x100) - packet[2];
+	input_report_key(idev, BTN_TOUCH, down);
+	input_report_key(idev, BTN_LEFT, left);
+	input_report_key(idev, BTN_RIGHT, right);
+
+	/*
+	 * if this packet says that the finger was removed, reset our position
+	 * tracking so that we don't erroneously detect a jump on next press.
+	 */
+	if (!down)
+		priv->abs_x = priv->abs_y = -1;
+
+	/* Report position if finger/pen is down, but weed out duplicate
+	 * packets (we get quite a few in this mode, and they mess up our
+	 * jump detection */
+	if (down && (x != priv->abs_x || y != priv->abs_y)) {
+
+		/* Don't apply hacks in PT mode, it seems reliable */
+		if (priv->mode != HGPK_MODE_PENTABLET && priv->abs_x != -1) {
+			hgpk_jumpy_hack(psmouse,
+					priv->abs_x - x, priv->abs_y - y);
+			hgpk_spewing_hack(psmouse, left, right,
+					  priv->abs_x - x, priv->abs_y - y);
+		}
+
+		input_report_abs(idev, ABS_X, x);
+		input_report_abs(idev, ABS_Y, y);
+		priv->abs_x = x;
+		priv->abs_y = y;
+	}
+
+	input_sync(idev);
+}
+
+static void hgpk_process_simple_packet(struct psmouse *psmouse)
+{
+	struct input_dev *dev = psmouse->dev;
+	unsigned char *packet = psmouse->packet;
+	int left = packet[0] & 1;
+	int right = (packet[0] >> 1) & 1;
+	int x = packet[1] - ((packet[0] << 4) & 0x100);
+	int y = ((packet[0] << 3) & 0x100) - packet[2];
 
 	hgpk_jumpy_hack(psmouse, x, y);
 	hgpk_spewing_hack(psmouse, left, right, x, y);
@@ -180,15 +301,14 @@ static psmouse_ret_t hgpk_process_byte(struct psmouse *psmouse)
 {
 	struct hgpk_data *priv = psmouse->private;
 
-	if (hgpk_validate_byte(psmouse->packet)) {
-		hgpk_dbg(psmouse, "%s: (%d) %02x %02x %02x\n",
-				__func__, psmouse->pktcnt, psmouse->packet[0],
-				psmouse->packet[1], psmouse->packet[2]);
+	if (hgpk_validate_byte(psmouse, psmouse->packet))
 		return PSMOUSE_BAD_DATA;
-	}
 
 	if (psmouse->pktcnt >= psmouse->pktsize) {
-		hgpk_process_packet(psmouse);
+		if (priv->mode == HGPK_MODE_MOUSE)
+			hgpk_process_simple_packet(psmouse);
+		else
+			hgpk_process_advanced_packet(psmouse);
 		return PSMOUSE_FULL_PACKET;
 	}
 
@@ -210,6 +330,59 @@ static psmouse_ret_t hgpk_process_byte(struct psmouse *psmouse)
 	return PSMOUSE_GOOD_DATA;
 }
 
+static int hgpk_select_mode(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	struct hgpk_data *priv = psmouse->private;
+	int i;
+	int cmd;
+
+	/*
+	 * 4 disables to enable advanced mode
+	 * then 3 0xf2 bytes as the preamble for GS/PT selection
+	 */
+	const int advanced_init[] = {
+		PSMOUSE_CMD_DISABLE, PSMOUSE_CMD_DISABLE,
+		PSMOUSE_CMD_DISABLE, PSMOUSE_CMD_DISABLE,
+		0xf2, 0xf2, 0xf2,
+	};
+
+	switch (priv->mode) {
+	case HGPK_MODE_MOUSE:
+		psmouse->pktsize = 3;
+		break;
+
+	case HGPK_MODE_GLIDESENSOR:
+	case HGPK_MODE_PENTABLET:
+		psmouse->pktsize = 6;
+
+		/* Switch to 'Advanced mode.', four disables in a row. */
+		for (i = 0; i < ARRAY_SIZE(advanced_init); i++)
+			if (ps2_command(ps2dev, NULL, advanced_init[i]))
+				return -EIO;
+
+		/* select between GlideSensor (mouse) or PenTablet */
+		if (priv->mode == HGPK_MODE_GLIDESENSOR)
+			cmd = PSMOUSE_CMD_SETSCALE11;
+		else
+			cmd = PSMOUSE_CMD_SETSCALE21;
+
+		if (ps2_command(ps2dev, NULL, cmd))
+			return -EIO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void reset_hack_state(struct psmouse *psmouse)
+{
+	struct hgpk_data *priv = psmouse->private;
+	priv->abs_x = priv->abs_y = -1;
+}
+
 static int hgpk_force_recalibrate(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -236,6 +409,13 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 	/* according to ALPS, 150mS is required for recalibration */
 	msleep(150);
 
+	if (hgpk_select_mode(psmouse)) {
+		hgpk_err(psmouse, "failed to select mode\n");
+		return -1;
+	}
+
+	reset_hack_state(psmouse);
+
 	/* XXX: If a finger is down during this delay, recalibration will
 	 * detect capacitance incorrectly.  This is a hardware bug, and
 	 * we don't have a good way to deal with it.  The 2s window stuff
@@ -290,6 +470,13 @@ static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
 
 		psmouse_reset(psmouse);
 
+		if (hgpk_select_mode(psmouse)) {
+			hgpk_err(psmouse, "Failed to select mode!\n");
+			return -1;
+		}
+
+		reset_hack_state(psmouse);
+
 		/* should be all set, enable the touchpad */
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
@@ -328,7 +515,12 @@ static int hgpk_reconnect(struct psmouse *psmouse)
 			return 0;
 
 	psmouse_reset(psmouse);
+	if (hgpk_select_mode(psmouse)) {
+		hgpk_err(psmouse, "Failed to select mode!\n");
+		return -1;
+	}
 
+	reset_hack_state(psmouse);
 	return 0;
 }
 
@@ -366,6 +558,35 @@ static ssize_t hgpk_set_powered(struct psmouse *psmouse, void *data,
 __PSMOUSE_DEFINE_ATTR(powered, S_IWUSR | S_IRUGO, NULL,
 		      hgpk_show_powered, hgpk_set_powered, false);
 
+static ssize_t attr_show_mode(struct psmouse *psmouse, void *data, char *buf)
+{
+	return sprintf(buf, "%s\n", mode_names[hgpk_mode]);
+}
+
+static ssize_t attr_set_mode(struct psmouse *psmouse, void *data,
+			     const char *buf, size_t len)
+{
+	int i;
+	int new_mode = -1;
+
+	for (i = 0; i < ARRAY_SIZE(mode_names); i++) {
+		const char *name = mode_names[i];
+		if (strlen(name) == len && !strncasecmp(name, buf, len)) {
+			new_mode = i;
+			break;
+		}
+	}
+
+	if (new_mode == -1)
+		return -EINVAL;
+
+	hgpk_mode = new_mode;
+	return len;
+}
+
+__PSMOUSE_DEFINE_ATTR(hgpk_mode, S_IWUSR | S_IRUGO, NULL,
+		      attr_show_mode, attr_set_mode, 0);
+
 static ssize_t hgpk_trigger_recal_show(struct psmouse *psmouse,
 		void *data, char *buf)
 {
@@ -401,6 +622,8 @@ static void hgpk_disconnect(struct psmouse *psmouse)
 
 	device_remove_file(&psmouse->ps2dev.serio->dev,
 			   &psmouse_attr_powered.dattr);
+	device_remove_file(&psmouse->ps2dev.serio->dev,
+			   &psmouse_attr_hgpk_mode.dattr);
 
 	if (psmouse->model >= HGPK_MODEL_C)
 		device_remove_file(&psmouse->ps2dev.serio->dev,
@@ -424,6 +647,8 @@ static void hgpk_recalib_work(struct work_struct *work)
 
 static int hgpk_register(struct psmouse *psmouse)
 {
+	struct hgpk_data *priv = psmouse->private;
+	struct input_dev *idev = psmouse->dev;
 	int err;
 
 	/* register handlers */
@@ -431,13 +656,45 @@ static int hgpk_register(struct psmouse *psmouse)
 	psmouse->poll = hgpk_poll;
 	psmouse->disconnect = hgpk_disconnect;
 	psmouse->reconnect = hgpk_reconnect;
-	psmouse->pktsize = 3;
 
 	/* Disable the idle resync. */
 	psmouse->resync_time = 0;
 	/* Reset after a lot of bad bytes. */
 	psmouse->resetafter = 1024;
 
+	if (priv->mode != HGPK_MODE_MOUSE) {
+		__set_bit(EV_ABS, idev->evbit);
+		__set_bit(EV_KEY, idev->evbit);
+		__set_bit(BTN_TOUCH, idev->keybit);
+		__set_bit(BTN_TOOL_FINGER, idev->keybit);
+		__set_bit(BTN_LEFT, idev->keybit);
+		__set_bit(BTN_RIGHT, idev->keybit);
+		__clear_bit(EV_REL, idev->evbit);
+		__clear_bit(REL_X, idev->relbit);
+		__clear_bit(REL_Y, idev->relbit);
+	}
+
+	if (priv->mode == HGPK_MODE_GLIDESENSOR) {
+		/* GlideSensor has pressure sensor, PenTablet does not */
+		input_set_abs_params(idev, ABS_PRESSURE, 0, 15, 0, 0);
+
+		/* From device specs */
+		input_set_abs_params(idev, ABS_X, 0, 399, 0, 0);
+		input_set_abs_params(idev, ABS_Y, 0, 290, 0, 0);
+
+		/* Calculated by hand based on usable size (52mm x 38mm) */
+		input_abs_set_res(idev, ABS_X, 8);
+		input_abs_set_res(idev, ABS_Y, 8);
+	} else if (priv->mode == HGPK_MODE_PENTABLET) {
+		/* From device specs */
+		input_set_abs_params(idev, ABS_X, 0, 999, 0, 0);
+		input_set_abs_params(idev, ABS_Y, 5, 239, 0, 0);
+
+		/* Calculated by hand based on usable size (156mm x 38mm) */
+		input_abs_set_res(idev, ABS_X, 6);
+		input_abs_set_res(idev, ABS_Y, 8);
+	}
+
 	err = device_create_file(&psmouse->ps2dev.serio->dev,
 				 &psmouse_attr_powered.dattr);
 	if (err) {
@@ -445,6 +702,13 @@ static int hgpk_register(struct psmouse *psmouse)
 		return err;
 	}
 
+	err = device_create_file(&psmouse->ps2dev.serio->dev,
+				 &psmouse_attr_hgpk_mode.dattr);
+	if (err) {
+		hgpk_err(psmouse, "Failed creating 'hgpk_mode' sysfs node\n");
+		goto err_remove_powered;
+	}
+
 	/* C-series touchpads added the recalibrate command */
 	if (psmouse->model >= HGPK_MODEL_C) {
 		err = device_create_file(&psmouse->ps2dev.serio->dev,
@@ -452,13 +716,19 @@ static int hgpk_register(struct psmouse *psmouse)
 		if (err) {
 			hgpk_err(psmouse,
 				"Failed creating 'recalibrate' sysfs node\n");
-			device_remove_file(&psmouse->ps2dev.serio->dev,
-					&psmouse_attr_powered.dattr);
-			return err;
+			goto err_remove_mode;
 		}
 	}
 
 	return 0;
+
+err_remove_mode:
+	device_remove_file(&psmouse->ps2dev.serio->dev,
+			   &psmouse_attr_hgpk_mode.dattr);
+err_remove_powered:
+	device_remove_file(&psmouse->ps2dev.serio->dev,
+			   &psmouse_attr_powered.dattr);
+	return err;
 }
 
 int hgpk_init(struct psmouse *psmouse)
@@ -473,12 +743,19 @@ int hgpk_init(struct psmouse *psmouse)
 	psmouse->private = priv;
 	priv->psmouse = psmouse;
 	priv->powered = true;
+	priv->mode = hgpk_mode;
 	INIT_DELAYED_WORK(&priv->recalib_wq, hgpk_recalib_work);
 
 	err = psmouse_reset(psmouse);
 	if (err)
 		goto init_fail;
 
+	err = hgpk_select_mode(psmouse);
+	if (err)
+		goto init_fail;
+
+	reset_hack_state(psmouse);
+
 	err = hgpk_register(psmouse);
 	if (err)
 		goto init_fail;
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index d61cfd3..430f29f 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -5,6 +5,9 @@
 #ifndef _HGPK_H
 #define _HGPK_H
 
+#define HGPK_GS		0xff       /* The GlideSensor */
+#define HGPK_PT		0xcf       /* The PenTablet */
+
 enum hgpk_model_t {
 	HGPK_MODEL_PREA = 0x0a,	/* pre-B1s */
 	HGPK_MODEL_A = 0x14,	/* found on B1s, PT disabled in hardware */
@@ -13,12 +16,20 @@ enum hgpk_model_t {
 	HGPK_MODEL_D = 0x50,	/* C1, mass production */
 };
 
+enum hgpk_mode {
+	HGPK_MODE_MOUSE,
+	HGPK_MODE_GLIDESENSOR,
+	HGPK_MODE_PENTABLET,
+};
+
 struct hgpk_data {
 	struct psmouse *psmouse;
+	int mode;
 	bool powered;
 	int count, x_tally, y_tally;	/* hardware workaround stuff */
 	unsigned long recalib_window;
 	struct delayed_work recalib_wq;
+	int abs_x, abs_y;
 };
 
 #define hgpk_dbg(psmouse, format, arg...)		\
-- 
1.7.2.3

