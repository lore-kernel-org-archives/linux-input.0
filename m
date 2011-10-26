From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH resend] synaptics: add support for Relative mode
Date: Wed, 26 Oct 2011 10:25:52 +0100 (BST)
Message-ID: <20111026092552.D47439D401E@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:3088 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932616Ab1JZJ6V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Oct 2011 05:58:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, djkurtz@google.com, pgf@laptop.org

Currently, the synaptics driver puts the device into Absolute mode.
As explained in the synaptics documentation section 3.2, in this mode,
the device sends a continuous stream of packets at the maximum rate
to the host when the user's fingers are near or on the pad or
pressing buttons, and continues streaming for 1 second afterwards.
These packets are even sent when there is no new information to report,
even when they are duplicates of the previous packet.

For embedded systems this is a bit much - it results in a huge
and uninterrupted stream of interrupts at high rate.

This patch adds support for Relative mode, which can be selected through
a sysfs attribute. In this mode, the device does not send duplicate
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
 drivers/input/mouse/psmouse-base.c |    2 +-
 drivers/input/mouse/psmouse.h      |    1 +
 drivers/input/mouse/synaptics.c    |  239 +++++++++++++++++++++++++++++-------
 drivers/input/mouse/synaptics.h    |    4 +
 4 files changed, 200 insertions(+), 46 deletions(-)

Resending after >2weeks with no further feedback.

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 2246843..651dd4b 100644
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
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 593e910..7ceb3ea 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -102,6 +102,7 @@ int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
+psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse);
 
 struct psmouse_attribute {
 	struct device_attribute dattr;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5538fc6..8b8bb8c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -32,6 +32,8 @@
 #include "psmouse.h"
 #include "synaptics.h"
 
+static int synaptics_reconnect(struct psmouse *psmouse);
+
 /*
  * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
  * section 2.3.2, which says that they should be valid regardless of the
@@ -258,19 +260,48 @@ static int synaptics_query_hardware(struct psmouse *psmouse)
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
 
@@ -289,25 +320,6 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
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
@@ -694,13 +706,45 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 /*****************************************************************************
  *	Driver initialization/cleanup functions
  ****************************************************************************/
-static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
+static void set_input_params(struct psmouse *psmouse, struct input_dev *dev,
+			     struct input_dev *old_dev)
 {
+	struct synaptics_data *priv = psmouse->private;
 	int i;
 	int fuzz = SYN_CAP_REDUCED_FILTERING(priv->ext_cap_0c) ?
 			SYN_REDUCED_FILTER_FUZZ : 0;
 
+	if (old_dev) {
+		dev->name = old_dev->name;
+		dev->phys = old_dev->phys;
+		dev->id = old_dev->id;
+		dev->dev.parent = old_dev->dev.parent;
+	}
+
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
@@ -732,20 +776,14 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
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
@@ -770,8 +808,117 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	}
 }
 
+static ssize_t attr_show_absolute(struct psmouse *psmouse, void *data,
+				  char *buf)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	return sprintf(buf, "%c\n", priv->absolute_mode ? '1' : '0');
+}
+
+static ssize_t attr_set_absolute(struct psmouse *psmouse, void *data,
+				 const char *buf, size_t len)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct input_dev *old_dev = psmouse->dev;
+	struct input_dev *new_dev;
+	unsigned long value;
+	int err = -1;
+
+	if (strict_strtoul(buf, 10, &value))
+		return -EINVAL;
+
+	if (value == priv->absolute_mode)
+		return len;
+
+	new_dev = input_allocate_device();
+	if (!new_dev)
+		return -ENOMEM;
+
+	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
+
+	priv->absolute_mode = !!value;
+	if (synaptics_set_mode(psmouse)) {
+		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
+		goto err_try_restore;
+	}
+
+	set_input_params(psmouse, new_dev, psmouse->dev);
+
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+
+	err = input_register_device(new_dev);
+	if (err)
+		goto err_try_restore;
+
+	psmouse->dev = new_dev;
+	input_unregister_device(old_dev);
+
+	return len;
+
+err_try_restore:
+	input_free_device(new_dev);
+	priv->absolute_mode = !value;
+	synaptics_reconnect(psmouse);
+	return err;
+}
+
+PSMOUSE_DEFINE_ATTR(synaptics_absolute_mode, S_IWUSR | S_IRUGO, NULL,
+		    attr_show_absolute, attr_set_absolute);
+
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
+static struct attribute *syn_attributes[] = {
+	&psmouse_attr_synaptics_absolute_mode.dattr.attr,
+	&psmouse_attr_synaptics_disable_gesture.dattr.attr,
+	NULL
+};
+
+static struct attribute_group syn_attribute_group = {
+	.attrs = syn_attributes,
+};
+
 static void synaptics_disconnect(struct psmouse *psmouse)
 {
+	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
+			   &syn_attribute_group);
+
 	synaptics_reset(psmouse);
 	kfree(psmouse->private);
 	psmouse->private = NULL;
@@ -801,16 +948,11 @@ static int synaptics_reconnect(struct psmouse *psmouse)
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
@@ -890,6 +1032,7 @@ void __init synaptics_module_init(void)
 int synaptics_init(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv;
+	int err = -1;
 
 	/*
 	 * The OLPC XO has issues with Synaptics' absolute mode; similarly to
@@ -916,13 +1059,13 @@ int synaptics_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
 
-	if (synaptics_set_absolute_mode(psmouse)) {
-		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
-		goto init_fail;
-	}
+	/* defaults */
+	priv->absolute_mode = 1;
+	if (SYN_ID_DISGEST_SUPPORTED(priv->identity))
+		priv->disable_gesture = 1;
 
-	if (synaptics_set_advanced_gesture_mode(psmouse)) {
-		printk(KERN_ERR "Advanced gesture mode init failed.\n");
+	if (synaptics_set_mode(psmouse)) {
+		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
 		goto init_fail;
 	}
 
@@ -933,7 +1076,7 @@ int synaptics_init(struct psmouse *psmouse)
 		SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
 		priv->model_id, priv->capabilities, priv->ext_cap, priv->ext_cap_0c);
 
-	set_input_params(psmouse->dev, priv);
+	set_input_params(psmouse, psmouse->dev, NULL);
 
 	/*
 	 * Encode touchpad model so that it can be used to set
@@ -945,12 +1088,10 @@ int synaptics_init(struct psmouse *psmouse)
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
 
@@ -968,11 +1109,19 @@ int synaptics_init(struct psmouse *psmouse)
 		psmouse->rate = 40;
 	}
 
+	err = sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
+				   &syn_attribute_group);
+	if (err) {
+		dev_err(&psmouse->ps2dev.serio->dev,
+			"Failed to create sysfs attributes (%d)", err);
+		goto init_fail;
+	}
+
 	return 0;
 
  init_fail:
 	kfree(priv);
-	return -1;
+	return err;
 }
 
 bool synaptics_supported(void)
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index ca040aa..c6e01fa 100644
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
-- 
1.7.6.4

