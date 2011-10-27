From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v2] synaptics: add support for Relative mode
Date: Thu, 27 Oct 2011 17:44:20 +0100 (BST)
Message-ID: <20111027164420.91B1A9D401E@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:31358 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753501Ab1J0Qo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 12:44:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org, djkurtz@google.com

Currently, the synaptics driver puts the device into Absolute mode.
As explained in the synaptics documentation section 3.2, in this mode,
the device sends a continuous stream of packets at the maximum rate
to the host when the user's fingers are near or on the pad or
pressing buttons, and continues streaming for 1 second afterwards.
These packets are even sent when there is no new information to report,
even when they are duplicates of the previous packet.

For embedded systems this is a bit much - it results in a huge
and uninterrupted stream of interrupts at high rate.

This patch adds support for Relative mode, which can be selected as
a new psmouse protocol. In this mode, the device does not send duplicate
packets and acts like a standard PS/2 mouse. However, synaptics-specific
functionality is still available, such as the ability to set the packet
rate, and rather than disabling gestures and taps at the hardware level
unconditionally, a 'synaptics_disable_gesture' sysfs attribute has
been added to allow control of this functionality.

This solves a long standing OLPC issue: synaptics hardware enables
tap to click by default (even in the default relative mode), but we
have found this to be inappropriate for young children and first
time computer users. Enabling the synaptics driver disables tap-to-click,
but we have previously been unable to use this because it also enables
Absolute mode, which is too "spammy" for our desires and actually
overloads our EC with its continuous stream of packets. Now we can enable
the synaptics driver, disabling tap to click while retaining the less
noisy Relative mode.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/psmouse-base.c |    9 ++-
 drivers/input/mouse/psmouse.h      |    2 +
 drivers/input/mouse/synaptics.c    |  172 ++++++++++++++++++++++++++----------
 drivers/input/mouse/synaptics.h    |    5 +
 4 files changed, 141 insertions(+), 47 deletions(-)

v2: make a new psmouse protocol type for Relative mode, suggested by
Dmitry Torokhov.

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 3f74bae..92dbbdd 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -124,7 +124,7 @@ struct psmouse_protocol {
  * relevant events to the input module once full packet has arrived.
  */
 
-static psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
+psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
@@ -811,6 +811,13 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.detect		= synaptics_detect,
 		.init		= synaptics_init,
 	},
+	{
+		.type		= PSMOUSE_SYNAPTICS_RELATIVE,
+		.name		= "SynRelPS/2",
+		.alias		= "synaptics-relative",
+		.detect		= synaptics_detect,
+		.init		= synaptics_init_relative,
+	},
 #endif
 #ifdef CONFIG_MOUSE_PS2_ALPS
 	{
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 593e910..736a986 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -85,6 +85,7 @@ enum psmouse_type {
 	PSMOUSE_IMPS,
 	PSMOUSE_IMEX,
 	PSMOUSE_SYNAPTICS,
+	PSMOUSE_SYNAPTICS_RELATIVE,
 	PSMOUSE_ALPS,
 	PSMOUSE_LIFEBOOK,
 	PSMOUSE_TRACKPOINT,
@@ -102,6 +103,7 @@ int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
+psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse);
 
 struct psmouse_attribute {
 	struct device_attribute dattr;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5538fc6..15a200b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -258,19 +258,48 @@ static int synaptics_query_hardware(struct psmouse *psmouse)
 	return 0;
 }
 
-static int synaptics_set_absolute_mode(struct psmouse *psmouse)
+static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
+{
+	static unsigned char param = 0xc8;
+	struct synaptics_data *priv = psmouse->private;
+
+	if (!SYN_CAP_ADV_GESTURE(priv->ext_cap_0c))
+		return 0;
+
+	if (psmouse_sliced_command(psmouse, SYN_QUE_MODEL))
+		return -1;
+	if (ps2_command(&psmouse->ps2dev, &param, PSMOUSE_CMD_SETRATE))
+		return -1;
+
+	/* Advanced gesture mode also sends multi finger data */
+	priv->capabilities |= BIT(1);
+
+	return 0;
+}
+
+static int synaptics_set_mode(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
-	priv->mode = SYN_BIT_ABSOLUTE_MODE;
-	if (SYN_ID_MAJOR(priv->identity) >= 4)
+	priv->mode = 0;
+	if (priv->absolute_mode)
+		priv->mode |= SYN_BIT_ABSOLUTE_MODE;
+	if (priv->disable_gesture)
 		priv->mode |= SYN_BIT_DISABLE_GESTURE;
+	if (psmouse->rate >= 80)
+		priv->mode |= SYN_BIT_HIGH_RATE;
 	if (SYN_CAP_EXTENDED(priv->capabilities))
 		priv->mode |= SYN_BIT_W_MODE;
 
 	if (synaptics_mode_cmd(psmouse, priv->mode))
 		return -1;
 
+	if (priv->absolute_mode &&
+			synaptics_set_advanced_gesture_mode(psmouse)) {
+		printk(KERN_ERR "Advanced gesture mode init failed.\n");
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -289,25 +318,6 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
 	synaptics_mode_cmd(psmouse, priv->mode);
 }
 
-static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
-{
-	static unsigned char param = 0xc8;
-	struct synaptics_data *priv = psmouse->private;
-
-	if (!SYN_CAP_ADV_GESTURE(priv->ext_cap_0c))
-		return 0;
-
-	if (psmouse_sliced_command(psmouse, SYN_QUE_MODEL))
-		return -1;
-	if (ps2_command(&psmouse->ps2dev, &param, PSMOUSE_CMD_SETRATE))
-		return -1;
-
-	/* Advanced gesture mode also sends multi finger data */
-	priv->capabilities |= BIT(1);
-
-	return 0;
-}
-
 /*****************************************************************************
  *	Synaptics pass-through PS/2 port support
  ****************************************************************************/
@@ -694,13 +704,37 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 /*****************************************************************************
  *	Driver initialization/cleanup functions
  ****************************************************************************/
-static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
+static void set_input_params(struct psmouse *psmouse, struct input_dev *dev)
 {
+	struct synaptics_data *priv = psmouse->private;
 	int i;
 	int fuzz = SYN_CAP_REDUCED_FILTERING(priv->ext_cap_0c) ?
 			SYN_REDUCED_FILTER_FUZZ : 0;
 
+	/* Things that apply to both modes */
 	__set_bit(INPUT_PROP_POINTER, dev->propbit);
+	__set_bit(EV_KEY, dev->evbit);
+	__set_bit(BTN_LEFT, dev->keybit);
+	__set_bit(BTN_RIGHT, dev->keybit);
+
+	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+		__set_bit(BTN_MIDDLE, dev->keybit);
+
+	if (!priv->absolute_mode) {
+		/* Relative mode */
+		__set_bit(EV_REL, dev->evbit);
+		__set_bit(REL_X, dev->relbit);
+		__set_bit(REL_Y, dev->relbit);
+
+		/* Relative mode follows standard PS/2 mouse protocol */
+		psmouse->protocol_handler = psmouse_process_byte;
+		psmouse->pktsize = 3;
+		return;
+	}
+
+	/* Absolute mode */
+	psmouse->protocol_handler = synaptics_process_byte;
+	psmouse->pktsize = 6;
 
 	__set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_X,
@@ -732,20 +766,14 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	if (SYN_CAP_PALMDETECT(priv->capabilities))
 		input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 
-	__set_bit(EV_KEY, dev->evbit);
 	__set_bit(BTN_TOUCH, dev->keybit);
 	__set_bit(BTN_TOOL_FINGER, dev->keybit);
-	__set_bit(BTN_LEFT, dev->keybit);
-	__set_bit(BTN_RIGHT, dev->keybit);
 
 	if (SYN_CAP_MULTIFINGER(priv->capabilities)) {
 		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
 		__set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
 	}
 
-	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
-		__set_bit(BTN_MIDDLE, dev->keybit);
-
 	if (SYN_CAP_FOUR_BUTTON(priv->capabilities) ||
 	    SYN_CAP_MIDDLE_BUTTON(priv->capabilities)) {
 		__set_bit(BTN_FORWARD, dev->keybit);
@@ -770,8 +798,49 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	}
 }
 
+static ssize_t attr_show_disable_gesture(struct psmouse *psmouse, void *data,
+					 char *buf)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	return sprintf(buf, "%c\n", priv->disable_gesture ? '1' : '0');
+}
+
+static ssize_t attr_set_disable_gesture(struct psmouse *psmouse, void *data,
+					const char *buf, size_t len)
+{
+	struct synaptics_data *priv = psmouse->private;
+	unsigned long value;
+
+	if (strict_strtoul(buf, 10, &value))
+		return -EINVAL;
+
+	if (!SYN_ID_DISGEST_SUPPORTED(priv->identity))
+		return -EOPNOTSUPP;
+
+	if (value == priv->disable_gesture)
+		return len;
+
+	priv->disable_gesture = !!value;
+	if (value)
+		priv->mode |= SYN_BIT_DISABLE_GESTURE;
+	else
+		priv->mode &= ~SYN_BIT_DISABLE_GESTURE;
+
+	if (synaptics_mode_cmd(psmouse, priv->mode))
+		return -EIO;
+
+	return len;
+}
+
+PSMOUSE_DEFINE_ATTR(synaptics_disable_gesture, S_IWUSR | S_IRUGO, NULL,
+		    attr_show_disable_gesture, attr_set_disable_gesture);
+
 static void synaptics_disconnect(struct psmouse *psmouse)
 {
+	sysfs_remove_file(&psmouse->ps2dev.serio->dev.kobj,
+			  &psmouse_attr_synaptics_disable_gesture.dattr.attr);
+
 	synaptics_reset(psmouse);
 	kfree(psmouse->private);
 	psmouse->private = NULL;
@@ -801,16 +870,11 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 		return -1;
 	}
 
-	if (synaptics_set_absolute_mode(psmouse)) {
+	if (synaptics_set_mode(psmouse)) {
 		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
 		return -1;
 	}
 
-	if (synaptics_set_advanced_gesture_mode(psmouse)) {
-		printk(KERN_ERR "Advanced gesture mode reconnect failed.\n");
-		return -1;
-	}
-
 	if (old_priv.identity != priv->identity ||
 	    old_priv.model_id != priv->model_id ||
 	    old_priv.capabilities != priv->capabilities ||
@@ -887,9 +951,10 @@ void __init synaptics_module_init(void)
 	broken_olpc_ec = dmi_check_system(olpc_dmi_table);
 }
 
-int synaptics_init(struct psmouse *psmouse)
+static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 {
 	struct synaptics_data *priv;
+	int err = -1;
 
 	/*
 	 * The OLPC XO has issues with Synaptics' absolute mode; similarly to
@@ -916,13 +981,12 @@ int synaptics_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
 
-	if (synaptics_set_absolute_mode(psmouse)) {
-		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
-		goto init_fail;
-	}
+	priv->absolute_mode = absolute_mode;
+	if (SYN_ID_DISGEST_SUPPORTED(priv->identity))
+		priv->disable_gesture = 1;
 
-	if (synaptics_set_advanced_gesture_mode(psmouse)) {
-		printk(KERN_ERR "Advanced gesture mode init failed.\n");
+	if (synaptics_set_mode(psmouse)) {
+		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
 		goto init_fail;
 	}
 
@@ -933,7 +997,7 @@ int synaptics_init(struct psmouse *psmouse)
 		SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
 		priv->model_id, priv->capabilities, priv->ext_cap, priv->ext_cap_0c);
 
-	set_input_params(psmouse->dev, priv);
+	set_input_params(psmouse, psmouse->dev);
 
 	/*
 	 * Encode touchpad model so that it can be used to set
@@ -945,12 +1009,10 @@ int synaptics_init(struct psmouse *psmouse)
 	psmouse->model = ((priv->model_id & 0x00ff0000) >> 8) |
 			  (priv->model_id & 0x000000ff);
 
-	psmouse->protocol_handler = synaptics_process_byte;
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 	psmouse->cleanup = synaptics_reset;
-	psmouse->pktsize = 6;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
 
@@ -968,11 +1030,29 @@ int synaptics_init(struct psmouse *psmouse)
 		psmouse->rate = 40;
 	}
 
+	err = sysfs_create_file(&psmouse->ps2dev.serio->dev.kobj,
+				&psmouse_attr_synaptics_disable_gesture.dattr.attr);
+	if (err) {
+		dev_err(&psmouse->ps2dev.serio->dev,
+			"Failed to create disable_gesture attribute (%d)", err);
+		goto init_fail;
+	}
+
 	return 0;
 
  init_fail:
 	kfree(priv);
-	return -1;
+	return err;
+}
+
+int synaptics_init(struct psmouse *psmouse)
+{
+	return __synaptics_init(psmouse, true);
+}
+
+int synaptics_init_relative(struct psmouse *psmouse)
+{
+	return __synaptics_init(psmouse, false);
 }
 
 bool synaptics_supported(void)
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index ca040aa..d13b19c 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -97,6 +97,7 @@
 #define SYN_ID_MINOR(i)			(((i) >> 16) & 0xff)
 #define SYN_ID_FULL(i)			((SYN_ID_MAJOR(i) << 8) | SYN_ID_MINOR(i))
 #define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)
+#define SYN_ID_DISGEST_SUPPORTED(i)	(SYN_ID_MAJOR(i) >= 4)
 
 /* synaptics special commands */
 #define SYN_PS_SET_MODE2		0x14
@@ -144,6 +145,9 @@ struct synaptics_data {
 	unsigned char mode;			/* current mode byte */
 	int scroll;
 
+	unsigned int absolute_mode:1;		/* run in Absolute mode */
+	unsigned int disable_gesture:1;		/* disable gestures */
+
 	struct serio *pt_port;			/* Pass-through serio port */
 
 	struct synaptics_hw_state mt;		/* current gesture packet */
@@ -152,6 +156,7 @@ struct synaptics_data {
 void synaptics_module_init(void);
 int synaptics_detect(struct psmouse *psmouse, bool set_properties);
 int synaptics_init(struct psmouse *psmouse);
+int synaptics_init_relative(struct psmouse *psmouse);
 void synaptics_reset(struct psmouse *psmouse);
 bool synaptics_supported(void);
 
-- 
1.7.6.4

