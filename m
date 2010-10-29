From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hgpk - support GlideSensor and PenTablet modes
Date: Fri, 29 Oct 2010 09:59:55 -0700
Message-ID: <20101029165955.GA26386@core.coreip.homeip.net>
References: <20101006155026.5BB289D401B@zog.reactivated.net>
 <20101014155230.GB10421@core.coreip.homeip.net>
 <AANLkTi=fo9rTfVEdPB46qd=Compjma1XMOKSzqpUQiu3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58546 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0J2RAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Oct 2010 13:00:04 -0400
Received: by iwn10 with SMTP id 10so3924913iwn.19
        for <linux-input@vger.kernel.org>; Fri, 29 Oct 2010 10:00:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=fo9rTfVEdPB46qd=Compjma1XMOKSzqpUQiu3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

Hi Daniel,

On Wed, Oct 20, 2010 at 04:53:32PM +0100, Daniel Drake wrote:
> Hi Dmitry,
> 
> On 14 October 2010 16:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > I think we can do better than that and re-create the device for users
> > ourselves. See drivers/input/mouse/psmouse_base.c::psmouse_attr_set_proto()
> >
> > I would also look into adding a module parameter so that users could
> > specify desired mode on bootup.
> 
> Thanks for your feedback -- all good points and ideas.
> 
> I've addressed it all in the latest patch
> https://patchwork.kernel.org/patch/254381/
> 
> Hoping you can take a look at it soon :)
> 

Sorry for the delay, I did not quite like that we had to adjust the
global mode option to switch the device to the new mode; we should be
able to do it ourselves within the driver instead of punting the task
off to serio_rescan(). Could you please tell me if the patch below (on
top of yours) still works?

Thanks!

-- 
Dmitry


Input: hgpk - apply mode change immediately

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

When changing current device mode, instead of adjusting the global default
mode option and rely on serio_rescan to reinitialize the device do it
ourselves.

Also rename hgpk_initial_mode parameter to simply hgpk_mode.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/hgpk.c |  362 ++++++++++++++++++++++++++------------------
 drivers/input/mouse/hgpk.h |    3 
 2 files changed, 220 insertions(+), 145 deletions(-)


diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 054b28f..5abb915 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -69,13 +69,14 @@ module_param(post_interrupt_delay, int, 0644);
 MODULE_PARM_DESC(post_interrupt_delay,
 	"delay (ms) before recal after recal interrupt detected");
 
-static char *hgpk_initial_mode;
-module_param(hgpk_initial_mode, charp, 0600);
-MODULE_PARM_DESC(hgpk_initial_mode,
-	"initial mode: mouse, glidesensor or pentablet");
+static char hgpk_mode_name[16];
+module_param_string(hgpk_mode, hgpk_mode_name, sizeof(hgpk_mode_name), 0644);
+MODULE_PARM_DESC(hgpk_mode,
+	"default hgpk mode: mouse, glidesensor or pentablet");
 
-static int hgpk_mode = HGPK_MODE_MOUSE;
-static const char * const mode_names[] = {
+static int hgpk_default_mode = HGPK_MODE_MOUSE;
+
+static const char * const hgpk_mode_names[] = {
 	[HGPK_MODE_MOUSE] = "Mouse",
 	[HGPK_MODE_GLIDESENSOR] = "GlideSensor",
 	[HGPK_MODE_PENTABLET] = "PenTablet",
@@ -85,13 +86,13 @@ static int hgpk_mode_from_name(const char *buf, int len)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mode_names); i++) {
-		const char *name = mode_names[i];
+	for (i = 0; i < ARRAY_SIZE(hgpk_mode_names); i++) {
+		const char *name = hgpk_mode_names[i];
 		if (strlen(name) == len && !strncasecmp(name, buf, len))
 			return i;
 	}
 
-	return -1;
+	return HGPK_MODE_INVALID;
 }
 
 /*
@@ -193,36 +194,37 @@ static bool hgpk_is_byte_valid(struct psmouse *psmouse, unsigned char *packet)
 {
 	struct hgpk_data *priv = psmouse->private;
 	int pktcnt = psmouse->pktcnt;
-	bool r = true;
+	bool valid;
 
 	switch (priv->mode) {
 	case HGPK_MODE_MOUSE:
-		r = (packet[0] & 0x0C) == 0x08;
-		if (!r)
-			hgpk_dbg(psmouse, "bad data (%d) %02x %02x %02x\n",
-				 psmouse->pktcnt, psmouse->packet[0],
-				 psmouse->packet[1], psmouse->packet[2]);
+		valid = (packet[0] & 0x0C) == 0x08;
 		break;
 
 	case HGPK_MODE_GLIDESENSOR:
+		valid = pktcnt == 1 ?
+			packet[0] == HGPK_GS : packet[pktcnt - 1] & 0x80;
+		break;
+
 	case HGPK_MODE_PENTABLET:
-		/* bytes 2 - 6 should have 0 in the highest bit */
-		if (pktcnt >= 2 && pktcnt <= 6 && (packet[pktcnt - 1] & 0x80))
-			r = false;
-		if (priv->mode == HGPK_MODE_GLIDESENSOR && packet[0] != HGPK_GS)
-			r = false;
-		if (priv->mode == HGPK_MODE_PENTABLET && packet[0] != HGPK_PT)
-			r = false;
-		if (!r)
-			hgpk_dbg(psmouse, "bad data, mode %d (%d) "
-				 "%02x %02x %02x %02x %02x %02x\n",
-				 priv->mode, psmouse->pktcnt,
-				 psmouse->packet[0], psmouse->packet[1],
-				 psmouse->packet[2], psmouse->packet[3],
-				 psmouse->packet[4], psmouse->packet[5]);
+		valid = pktcnt == 1 ?
+			packet[0] == HGPK_PT : packet[pktcnt - 1] & 0x80;
+		break;
+
+	default:
+		valid = false;
 		break;
 	}
-	return r;
+
+	if (!valid)
+		hgpk_dbg(psmouse,
+			 "bad data, mode %d (%d) %02x %02x %02x %02x %02x %02x\n",
+			 priv->mode, pktcnt,
+			 psmouse->packet[0], psmouse->packet[1],
+			 psmouse->packet[2], psmouse->packet[3],
+			 psmouse->packet[4], psmouse->packet[5]);
+
+	return valid;
 }
 
 static void hgpk_process_advanced_packet(struct psmouse *psmouse)
@@ -230,48 +232,49 @@ static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 	struct hgpk_data *priv = psmouse->private;
 	struct input_dev *idev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
+	int down = !!(packet[2] & 2);
 	int left = !!(packet[3] & 1);
 	int right = !!(packet[3] & 2);
 	int x = packet[1] | ((packet[2] & 0x78) << 4);
 	int y = packet[4] | ((packet[3] & 0x70) << 3);
-	int z = packet[5];
-	int down;
 
 	if (priv->mode == HGPK_MODE_GLIDESENSOR) {
 		int pt_down = !!(packet[2] & 1);
 		int finger_down = !!(packet[2] & 2);
+		int z = packet[5];
 
 		input_report_abs(idev, ABS_PRESSURE, z);
-		down = finger_down;
 		if (tpdebug)
-			hgpk_dbg(psmouse, "pd=%d fd=%d ",
-				 pt_down, finger_down);
+			hgpk_dbg(psmouse, "pd=%d fd=%d z=%d",
+				 pt_down, finger_down, z);
 	} else {
-		/* PenTablet mode does not report pressure, so we don't
-		 * report it here */
-		down = !!(packet[2] & 2);
+		/*
+		 * PenTablet mode does not report pressure, so we don't
+		 * report it here
+		 */
 		if (tpdebug)
 			hgpk_dbg(psmouse, "pd=%d ", down);
 	}
 
 	if (tpdebug)
-		hgpk_dbg(psmouse, "l=%d r=%d x=%d y=%d z=%d\n",
-			 left, right, x, y, z);
+		hgpk_dbg(psmouse, "l=%d r=%d x=%d y=%d\n", left, right, x, y);
 
 	input_report_key(idev, BTN_TOUCH, down);
 	input_report_key(idev, BTN_LEFT, left);
 	input_report_key(idev, BTN_RIGHT, right);
 
 	/*
-	 * if this packet says that the finger was removed, reset our position
+	 * If this packet says that the finger was removed, reset our position
 	 * tracking so that we don't erroneously detect a jump on next press.
 	 */
 	if (!down)
 		priv->abs_x = priv->abs_y = -1;
 
-	/* Report position if finger/pen is down, but weed out duplicate
+	/*
+	 * Report position if finger/pen is down, but weed out duplicate
 	 * packets (we get quite a few in this mode, and they mess up our
-	 * jump detection */
+	 * jump detection.
+	 */
 	if (down && (x != priv->abs_x || y != priv->abs_y)) {
 
 		/* Don't apply hacks in PT mode, it seems reliable */
@@ -386,6 +389,7 @@ static int hgpk_select_mode(struct psmouse *psmouse)
 		if (ps2_command(ps2dev, NULL, cmd))
 			return -EIO;
 		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -393,6 +397,71 @@ static int hgpk_select_mode(struct psmouse *psmouse)
 	return 0;
 }
 
+static void hgpk_setup_input_device(struct input_dev *input,
+				    struct input_dev *old_input,
+				    enum hgpk_mode mode)
+{
+	if (old_input) {
+		input->name = old_input->name;
+		input->phys = old_input->phys;
+		input->id = old_input->id;
+		input->dev.parent = old_input->dev.parent;
+	}
+
+	memset(input->evbit, 0, sizeof(input->evbit));
+	memset(input->relbit, 0, sizeof(input->relbit));
+	memset(input->keybit, 0, sizeof(input->keybit));
+
+	/* All modes report left and right buttons */
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(BTN_LEFT, input->keybit);
+	__set_bit(BTN_RIGHT, input->keybit);
+
+	switch (mode) {
+	case HGPK_MODE_MOUSE:
+		__set_bit(EV_REL, input->evbit);
+		__set_bit(REL_X, input->relbit);
+		__set_bit(REL_Y, input->relbit);
+		break;
+
+	case HGPK_MODE_GLIDESENSOR:
+		__set_bit(BTN_TOUCH, input->keybit);
+		__set_bit(BTN_TOOL_FINGER, input->keybit);
+
+		__set_bit(EV_ABS, input->evbit);
+
+		/* GlideSensor has pressure sensor, PenTablet does not */
+		input_set_abs_params(input, ABS_PRESSURE, 0, 15, 0, 0);
+
+		/* From device specs */
+		input_set_abs_params(input, ABS_X, 0, 399, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, 290, 0, 0);
+
+		/* Calculated by hand based on usable size (52mm x 38mm) */
+		input_abs_set_res(input, ABS_X, 8);
+		input_abs_set_res(input, ABS_Y, 8);
+		break;
+
+	case HGPK_MODE_PENTABLET:
+		__set_bit(BTN_TOUCH, input->keybit);
+		__set_bit(BTN_TOOL_FINGER, input->keybit);
+
+		__set_bit(EV_ABS, input->evbit);
+
+		/* From device specs */
+		input_set_abs_params(input, ABS_X, 0, 999, 0, 0);
+		input_set_abs_params(input, ABS_Y, 5, 239, 0, 0);
+
+		/* Calculated by hand based on usable size (156mm x 38mm) */
+		input_abs_set_res(input, ABS_X, 6);
+		input_abs_set_res(input, ABS_Y, 8);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
 static void hgpk_reset_hack_state(struct psmouse *psmouse)
 {
 	struct hgpk_data *priv = psmouse->private;
@@ -400,11 +469,43 @@ static void hgpk_reset_hack_state(struct psmouse *psmouse)
 	priv->abs_x = priv->abs_y = -1;
 }
 
+static int hgpk_reset_device(struct psmouse *psmouse, bool recalibrate)
+{
+	int err;
+
+	psmouse_reset(psmouse);
+
+	if (recalibrate) {
+		struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+		/* send the recalibrate request */
+		if (ps2_command(ps2dev, NULL, 0xf5) ||
+		    ps2_command(ps2dev, NULL, 0xf5) ||
+		    ps2_command(ps2dev, NULL, 0xe6) ||
+		    ps2_command(ps2dev, NULL, 0xf5)) {
+			return -1;
+		}
+
+		/* according to ALPS, 150mS is required for recalibration */
+		msleep(150);
+	}
+
+	err = hgpk_select_mode(psmouse);
+	if (err) {
+		hgpk_err(psmouse, "failed to select mode\n");
+		return err;
+	}
+
+	hgpk_reset_hack_state(psmouse);
+
+	return 0;
+}
+
 static int hgpk_force_recalibrate(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	struct hgpk_data *priv = psmouse->private;
-	int r;
+	int err;
 
 	/* C-series touchpads added the recalibrate command */
 	if (psmouse->model < HGPK_MODEL_C)
@@ -414,28 +515,12 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
 	/* start by resetting the device */
-	psmouse_reset(psmouse);
-
-	/* send the recalibrate request */
-	if (ps2_command(ps2dev, NULL, 0xf5) ||
-	    ps2_command(ps2dev, NULL, 0xf5) ||
-	    ps2_command(ps2dev, NULL, 0xe6) ||
-	    ps2_command(ps2dev, NULL, 0xf5)) {
-		return -1;
-	}
-
-	/* according to ALPS, 150mS is required for recalibration */
-	msleep(150);
-
-	r = hgpk_select_mode(psmouse);
-	if (r) {
-		hgpk_err(psmouse, "failed to select mode\n");
-		return r;
-	}
-
-	hgpk_reset_hack_state(psmouse);
+	err = hgpk_reset_device(psmouse, true);
+	if (err)
+		return err;
 
-	/* XXX: If a finger is down during this delay, recalibration will
+	/*
+	 * XXX: If a finger is down during this delay, recalibration will
 	 * detect capacitance incorrectly.  This is a hardware bug, and
 	 * we don't have a good way to deal with it.  The 2s window stuff
 	 * (below) is our best option for now.
@@ -446,12 +531,13 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 
-	/* After we recalibrate, we shouldn't get any packets for 2s.  If
+	/*
+	 * After we recalibrate, we shouldn't get any packets for 2s.  If
 	 * we do, it's likely that someone's finger was on the touchpad.
 	 * If someone's finger *was* on the touchpad, it's probably
 	 * miscalibrated.  So, we should schedule another recalibration
 	 */
-	priv->recalib_window = jiffies +  msecs_to_jiffies(recal_guard_time);
+	priv->recalib_window = jiffies + msecs_to_jiffies(recal_guard_time);
 
 	return 0;
 }
@@ -465,7 +551,7 @@ static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	int timeo;
-	int r;
+	int err;
 
 	/* Added on D-series touchpads */
 	if (psmouse->model < HGPK_MODEL_D)
@@ -488,16 +574,12 @@ static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
 			msleep(50);
 		}
 
-		psmouse_reset(psmouse);
-
-		r = hgpk_select_mode(psmouse);
-		if (r) {
-			hgpk_err(psmouse, "Failed to select mode!\n");
-			return r;
+		err = hgpk_reset_device(psmouse, false);
+		if (err) {
+			hgpk_err(psmouse, "Failed to reset device!\n");
+			return err;
 		}
 
-		hgpk_reset_hack_state(psmouse);
-
 		/* should be all set, enable the touchpad */
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
@@ -527,25 +609,17 @@ static int hgpk_poll(struct psmouse *psmouse)
 
 static int hgpk_reconnect(struct psmouse *psmouse)
 {
-	int r;
-
-	/* During suspend/resume the ps2 rails remain powered.  We don't want
+	/*
+	 * During suspend/resume the ps2 rails remain powered.  We don't want
 	 * to do a reset because it's flush data out of buffers; however,
-	 * earlier prototypes (B1) had some brokenness that required a reset. */
+	 * earlier prototypes (B1) had some brokenness that required a reset.
+	 */
 	if (olpc_board_at_least(olpc_board(0xb2)))
 		if (psmouse->ps2dev.serio->dev.power.power_state.event !=
 				PM_EVENT_ON)
 			return 0;
 
-	psmouse_reset(psmouse);
-	r = hgpk_select_mode(psmouse);
-	if (r) {
-		hgpk_err(psmouse, "Failed to select mode!\n");
-		return -1;
-	}
-
-	hgpk_reset_hack_state(psmouse);
-	return 0;
+	return hgpk_reset_device(psmouse, false);
 }
 
 static ssize_t hgpk_show_powered(struct psmouse *psmouse, void *data, char *buf)
@@ -584,24 +658,58 @@ __PSMOUSE_DEFINE_ATTR(powered, S_IWUSR | S_IRUGO, NULL,
 
 static ssize_t attr_show_mode(struct psmouse *psmouse, void *data, char *buf)
 {
-	return sprintf(buf, "%s\n", mode_names[hgpk_mode]);
+	struct hgpk_data *priv = psmouse->private;
+
+	return sprintf(buf, "%s\n", hgpk_mode_names[priv->mode]);
 }
 
 static ssize_t attr_set_mode(struct psmouse *psmouse, void *data,
 			     const char *buf, size_t len)
 {
-	int new_mode = hgpk_mode_from_name(buf, len);
+	struct hgpk_data *priv = psmouse->private;
+	enum hgpk_mode old_mode = priv->mode;
+	enum hgpk_mode new_mode = hgpk_mode_from_name(buf, len);
+	struct input_dev *old_dev = psmouse->dev;
+	struct input_dev *new_dev;
+	int err;
 
-	if (new_mode == -1)
+	if (new_mode == HGPK_MODE_INVALID)
 		return -EINVAL;
 
-	hgpk_mode = new_mode;
-	serio_rescan(psmouse->ps2dev.serio);
+	if (old_mode == new_mode)
+		return len;
+
+	new_dev = input_allocate_device();
+	if (!new_dev)
+		return -ENOMEM;
+
+	/* Switch device into the new mode */
+	priv->mode = new_mode;
+	err = hgpk_reset_device(psmouse, false);
+	if (err)
+		goto err_try_restore;
+
+	hgpk_setup_input_device(new_dev, old_dev, new_mode);
+
+	err = input_register_device(new_dev);
+	if (err)
+		goto err_try_restore;
+
+	psmouse->dev = new_dev;
+	input_unregister_device(old_dev);
+
 	return len;
+
+err_try_restore:
+	input_free_device(new_dev);
+	priv->mode = old_mode;
+	hgpk_reset_device(psmouse, false);
+
+	return err;
 }
 
-__PSMOUSE_DEFINE_ATTR(hgpk_mode, S_IWUSR | S_IRUGO, NULL,
-		      attr_show_mode, attr_set_mode, 0);
+PSMOUSE_DEFINE_ATTR(hgpk_mode, S_IWUSR | S_IRUGO, NULL,
+		    attr_show_mode, attr_set_mode);
 
 static ssize_t hgpk_trigger_recal_show(struct psmouse *psmouse,
 		void *data, char *buf)
@@ -664,7 +772,6 @@ static void hgpk_recalib_work(struct work_struct *work)
 static int hgpk_register(struct psmouse *psmouse)
 {
 	struct hgpk_data *priv = psmouse->private;
-	struct input_dev *idev = psmouse->dev;
 	int err;
 
 	/* register handlers */
@@ -678,38 +785,7 @@ static int hgpk_register(struct psmouse *psmouse)
 	/* Reset after a lot of bad bytes. */
 	psmouse->resetafter = 1024;
 
-	if (priv->mode != HGPK_MODE_MOUSE) {
-		__set_bit(EV_ABS, idev->evbit);
-		__set_bit(EV_KEY, idev->evbit);
-		__set_bit(BTN_TOUCH, idev->keybit);
-		__set_bit(BTN_TOOL_FINGER, idev->keybit);
-		__set_bit(BTN_LEFT, idev->keybit);
-		__set_bit(BTN_RIGHT, idev->keybit);
-		__clear_bit(EV_REL, idev->evbit);
-		__clear_bit(REL_X, idev->relbit);
-		__clear_bit(REL_Y, idev->relbit);
-	}
-
-	if (priv->mode == HGPK_MODE_GLIDESENSOR) {
-		/* GlideSensor has pressure sensor, PenTablet does not */
-		input_set_abs_params(idev, ABS_PRESSURE, 0, 15, 0, 0);
-
-		/* From device specs */
-		input_set_abs_params(idev, ABS_X, 0, 399, 0, 0);
-		input_set_abs_params(idev, ABS_Y, 0, 290, 0, 0);
-
-		/* Calculated by hand based on usable size (52mm x 38mm) */
-		input_abs_set_res(idev, ABS_X, 8);
-		input_abs_set_res(idev, ABS_Y, 8);
-	} else if (priv->mode == HGPK_MODE_PENTABLET) {
-		/* From device specs */
-		input_set_abs_params(idev, ABS_X, 0, 999, 0, 0);
-		input_set_abs_params(idev, ABS_Y, 5, 239, 0, 0);
-
-		/* Calculated by hand based on usable size (156mm x 38mm) */
-		input_abs_set_res(idev, ABS_X, 6);
-		input_abs_set_res(idev, ABS_Y, 8);
-	}
+	hgpk_setup_input_device(psmouse->dev, NULL, priv->mode);
 
 	err = device_create_file(&psmouse->ps2dev.serio->dev,
 				 &psmouse_attr_powered.dattr);
@@ -750,28 +826,25 @@ err_remove_powered:
 int hgpk_init(struct psmouse *psmouse)
 {
 	struct hgpk_data *priv;
-	int err = -ENOMEM;
+	int err;
 
 	priv = kzalloc(sizeof(struct hgpk_data), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		err = -ENOMEM;
 		goto alloc_fail;
+	}
 
 	psmouse->private = priv;
+
 	priv->psmouse = psmouse;
 	priv->powered = true;
-	priv->mode = hgpk_mode;
+	priv->mode = hgpk_default_mode;
 	INIT_DELAYED_WORK(&priv->recalib_wq, hgpk_recalib_work);
 
-	err = psmouse_reset(psmouse);
-	if (err)
-		goto init_fail;
-
-	err = hgpk_select_mode(psmouse);
+	err = hgpk_reset_device(psmouse, false);
 	if (err)
 		goto init_fail;
 
-	hgpk_reset_hack_state(psmouse);
-
 	err = hgpk_register(psmouse);
 	if (err)
 		goto init_fail;
@@ -827,10 +900,11 @@ int hgpk_detect(struct psmouse *psmouse, bool set_properties)
 
 void hgpk_module_init(void)
 {
-	if (hgpk_initial_mode) {
-		int mode = hgpk_mode_from_name(hgpk_initial_mode,
-					       strlen(hgpk_initial_mode));
-		if (mode != -1)
-			hgpk_mode = mode;
+	hgpk_default_mode = hgpk_mode_from_name(hgpk_mode_name,
+						strlen(hgpk_mode_name));
+	if (hgpk_default_mode == HGPK_MODE_INVALID) {
+		hgpk_default_mode = HGPK_MODE_MOUSE;
+		strlcpy(hgpk_mode_name, hgpk_mode_names[HGPK_MODE_MOUSE],
+			sizeof(hgpk_mode_name));
 	}
 }
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index 46aaeee..01c983b 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -20,11 +20,12 @@ enum hgpk_mode {
 	HGPK_MODE_MOUSE,
 	HGPK_MODE_GLIDESENSOR,
 	HGPK_MODE_PENTABLET,
+	HGPK_MODE_INVALID
 };
 
 struct hgpk_data {
 	struct psmouse *psmouse;
-	int mode;
+	enum hgpk_mode mode;
 	bool powered;
 	int count, x_tally, y_tally;	/* hardware workaround stuff */
 	unsigned long recalib_window;
