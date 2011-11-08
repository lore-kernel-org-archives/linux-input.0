From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] synaptics: add support for Relative mode
Date: Mon, 7 Nov 2011 22:34:45 -0800
Message-ID: <20111108063445.GB1837@core.coreip.homeip.net>
References: <20111027164420.91B1A9D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57352 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1KHGex (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 01:34:53 -0500
Received: by iage36 with SMTP id e36so201771iag.19
        for <linux-input@vger.kernel.org>; Mon, 07 Nov 2011 22:34:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111027164420.91B1A9D401E@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org, djkurtz@google.com

Hi Daniel,

On Thu, Oct 27, 2011 at 05:44:20PM +0100, Daniel Drake wrote:
> 
> v2: make a new psmouse protocol type for Relative mode, suggested by
> Dmitry Torokhov.
> 

This looks mostly good, just a few comments:

> @@ -85,6 +85,7 @@ enum psmouse_type {
>  	PSMOUSE_IMPS,
>  	PSMOUSE_IMEX,
>  	PSMOUSE_SYNAPTICS,
> +	PSMOUSE_SYNAPTICS_RELATIVE,

We have:

	input_dev->id.product = psmouse->type;

and this is exported to userspace so the new type should be added to the
end of the list.

> +
> +static ssize_t attr_set_disable_gesture(struct psmouse *psmouse, void *data,
> +					const char *buf, size_t len)
> +{
> +	struct synaptics_data *priv = psmouse->private;
> +	unsigned long value;
> +
> +	if (strict_strtoul(buf, 10, &value))
> +		return -EINVAL;
> +
> +	if (!SYN_ID_DISGEST_SUPPORTED(priv->identity))
> +		return -EOPNOTSUPP;
> +

If this facility is not supported we should not even create the
attribute.

> @@ -968,11 +1030,29 @@ int synaptics_init(struct psmouse *psmouse)
>  		psmouse->rate = 40;
>  	}
>  
> +	err = sysfs_create_file(&psmouse->ps2dev.serio->dev.kobj,
> +				&psmouse_attr_synaptics_disable_gesture.dattr.attr);
> +	if (err) {
> +		dev_err(&psmouse->ps2dev.serio->dev,
> +			"Failed to create disable_gesture attribute (%d)", err);
> +		goto init_fail;
> +	}

This attribute does not make sense in absolute mode so we should only
create it when relative mode is requested.

Does the version of the patch below still work for you? Thanks!

-- 
Dmitry

Input: synaptics - add support for Relative mode

From: Daniel Drake <dsd@laptop.org>

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
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |    9 ++
 drivers/input/mouse/psmouse.h      |    2 
 drivers/input/mouse/synaptics.c    |  184 +++++++++++++++++++++++++++---------
 drivers/input/mouse/synaptics.h    |    5 +
 4 files changed, 152 insertions(+), 48 deletions(-)


diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index c7ecb06..f69e860 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -127,7 +127,7 @@ struct psmouse_protocol {
  * relevant events to the input module once full packet has arrived.
  */
 
-static psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
+psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
@@ -819,6 +819,13 @@ static const struct psmouse_protocol psmouse_protocols[] = {
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
index 11a9c6c..6a41709 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -94,6 +94,7 @@ enum psmouse_type {
 	PSMOUSE_HGPK,
 	PSMOUSE_ELANTECH,
 	PSMOUSE_FSP,
+	PSMOUSE_SYNAPTICS_RELATIVE,
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 
@@ -103,6 +104,7 @@ int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
+psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse);
 
 struct psmouse_attribute {
 	struct device_attribute dattr;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c080b82..a3bb49c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -268,19 +268,49 @@ static int synaptics_query_hardware(struct psmouse *psmouse)
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
+
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
+	    synaptics_set_advanced_gesture_mode(psmouse)) {
+		psmouse_err(psmouse, "Advanced gesture mode init failed.\n");
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -299,26 +329,6 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
 	synaptics_mode_cmd(psmouse, priv->mode);
 }
 
-static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
-{
-	static unsigned char param = 0xc8;
-	struct synaptics_data *priv = psmouse->private;
-
-	if (!(SYN_CAP_ADV_GESTURE(priv->ext_cap_0c) ||
-			SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)))
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
@@ -1142,8 +1152,24 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
 	int i;
 
+	/* Things that apply to both modes */
 	__set_bit(INPUT_PROP_POINTER, dev->propbit);
+	__set_bit(EV_KEY, dev->evbit);
+	__set_bit(BTN_LEFT, dev->keybit);
+	__set_bit(BTN_RIGHT, dev->keybit);
 
+	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+		__set_bit(BTN_MIDDLE, dev->keybit);
+
+	if (!priv->absolute_mode) {
+		/* Relative mode */
+		__set_bit(EV_REL, dev->evbit);
+		__set_bit(REL_X, dev->relbit);
+		__set_bit(REL_Y, dev->relbit);
+		return;
+	}
+
+	/* Absolute mode */
 	__set_bit(EV_ABS, dev->evbit);
 	set_abs_position_params(dev, priv, ABS_X, ABS_Y);
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
@@ -1169,20 +1195,14 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
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
@@ -1204,10 +1224,58 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	}
 }
 
+static ssize_t synaptics_show_disable_gesture(struct psmouse *psmouse,
+					      void *data, char *buf)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	return sprintf(buf, "%c\n", priv->disable_gesture ? '1' : '0');
+}
+
+static ssize_t synaptics_set_disable_gesture(struct psmouse *psmouse,
+					     void *data, const char *buf,
+					     size_t len)
+{
+	struct synaptics_data *priv = psmouse->private;
+	unsigned int value;
+	int err;
+
+	err = kstrtouint(buf, 10, &value);
+	if (err)
+		return err;
+
+	if (value > 1)
+		return -EINVAL;
+
+	if (value == priv->disable_gesture)
+		return len;
+
+	priv->disable_gesture = value;
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
+PSMOUSE_DEFINE_ATTR(disable_gesture, S_IWUSR | S_IRUGO, NULL,
+		    synaptics_show_disable_gesture,
+		    synaptics_set_disable_gesture);
+
 static void synaptics_disconnect(struct psmouse *psmouse)
 {
+	struct synaptics_data *priv = psmouse->private;
+
+	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->identity))
+		device_remove_file(&psmouse->ps2dev.serio->dev,
+				   &psmouse_attr_disable_gesture.dattr);
+
 	synaptics_reset(psmouse);
-	kfree(psmouse->private);
+	kfree(priv);
 	psmouse->private = NULL;
 }
 
@@ -1234,17 +1302,11 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 		return -1;
 	}
 
-	if (synaptics_set_absolute_mode(psmouse)) {
+	if (synaptics_set_mode(psmouse)) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
 		return -1;
 	}
 
-	if (synaptics_set_advanced_gesture_mode(psmouse)) {
-		psmouse_err(psmouse,
-			    "Advanced gesture mode reconnect failed.\n");
-		return -1;
-	}
-
 	if (old_priv.identity != priv->identity ||
 	    old_priv.model_id != priv->model_id ||
 	    old_priv.capabilities != priv->capabilities ||
@@ -1321,9 +1383,10 @@ void __init synaptics_module_init(void)
 	broken_olpc_ec = dmi_check_system(olpc_dmi_table);
 }
 
-int synaptics_init(struct psmouse *psmouse)
+static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 {
 	struct synaptics_data *priv;
+	int err = -1;
 
 	/*
 	 * The OLPC XO has issues with Synaptics' absolute mode; similarly to
@@ -1351,13 +1414,12 @@ int synaptics_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
 
-	if (synaptics_set_absolute_mode(psmouse)) {
-		psmouse_err(psmouse, "Unable to initialize device.\n");
-		goto init_fail;
-	}
+	priv->absolute_mode = absolute_mode;
+	if (SYN_ID_DISGEST_SUPPORTED(priv->identity))
+		priv->disable_gesture = true;
 
-	if (synaptics_set_advanced_gesture_mode(psmouse)) {
-		psmouse_err(psmouse, "Advanced gesture mode init failed.\n");
+	if (synaptics_set_mode(psmouse)) {
+		psmouse_err(psmouse, "Unable to initialize device.\n");
 		goto init_fail;
 	}
 
@@ -1382,12 +1444,19 @@ int synaptics_init(struct psmouse *psmouse)
 	psmouse->model = ((priv->model_id & 0x00ff0000) >> 8) |
 			  (priv->model_id & 0x000000ff);
 
-	psmouse->protocol_handler = synaptics_process_byte;
+	if (absolute_mode) {
+		psmouse->protocol_handler = synaptics_process_byte;
+		psmouse->pktsize = 6;
+	} else {
+		/* Relative mode follows standard PS/2 mouse protocol */
+		psmouse->protocol_handler = psmouse_process_byte;
+		psmouse->pktsize = 3;
+	}
+
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 	psmouse->cleanup = synaptics_reset;
-	psmouse->pktsize = 6;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
 
@@ -1406,11 +1475,32 @@ int synaptics_init(struct psmouse *psmouse)
 		psmouse->rate = 40;
 	}
 
+	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->identity)) {
+		err = device_create_file(&psmouse->ps2dev.serio->dev,
+					 &psmouse_attr_disable_gesture.dattr);
+		if (err) {
+			psmouse_err(psmouse,
+				    "Failed to create disable_gesture attribute (%d)",
+				    err);
+			goto init_fail;
+		}
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
index 622aea8..fd26ccc 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -100,6 +100,7 @@
 #define SYN_ID_MINOR(i)			(((i) >> 16) & 0xff)
 #define SYN_ID_FULL(i)			((SYN_ID_MAJOR(i) << 8) | SYN_ID_MINOR(i))
 #define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)
+#define SYN_ID_DISGEST_SUPPORTED(i)	(SYN_ID_MAJOR(i) >= 4)
 
 /* synaptics special commands */
 #define SYN_PS_SET_MODE2		0x14
@@ -159,6 +160,9 @@ struct synaptics_data {
 	unsigned char mode;			/* current mode byte */
 	int scroll;
 
+	bool absolute_mode;			/* run in Absolute mode */
+	bool disable_gesture;			/* disable gestures */
+
 	struct serio *pt_port;			/* Pass-through serio port */
 
 	struct synaptics_mt_state mt_state;	/* Current mt finger state */
@@ -175,6 +179,7 @@ struct synaptics_data {
 void synaptics_module_init(void);
 int synaptics_detect(struct psmouse *psmouse, bool set_properties);
 int synaptics_init(struct psmouse *psmouse);
+int synaptics_init_relative(struct psmouse *psmouse);
 void synaptics_reset(struct psmouse *psmouse);
 bool synaptics_supported(void);
 
