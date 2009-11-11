From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [RFC PATCH 1/2] Input: added 2 new ioctl()s for setting/getting event state
Date: Wed, 11 Nov 2009 12:36:07 +0200
Message-ID: <ac11b18d9fbb22ca88b61d73bc1e47e0068e9a86.1257931659.git.ext-mika.1.westerberg@nokia.com>
References: <1257929573.21596.960.camel@localhost>
 <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20408 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbZKKKk0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 05:40:26 -0500
In-Reply-To: <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Added 2 new ioctl()s for the input layer:

	EVIOCGSTATE - gets input event state from the driver
	EVIOCSSTATE - sets input event state

These ioctls(), when implemented in lower-level driver, can be used
to change state of generated events (for example to disable/enable
those).

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 drivers/input/evdev.c |   19 ++++++++
 drivers/input/input.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/input.h |   44 +++++++++++++++++++
 3 files changed, 178 insertions(+), 0 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index dee6706..7abaf16 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -510,6 +510,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 	struct evdev *evdev = client->evdev;
 	struct input_dev *dev = evdev->handle.dev;
 	struct input_absinfo abs;
+	struct input_event_state st;
 	struct ff_effect effect;
 	int __user *ip = (int __user *)p;
 	int i, t, u, v;
@@ -566,6 +567,24 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 
 		return input_set_keycode(dev, t, v);
 
+	case EVIOCGSTATE:
+		if (copy_from_user(&st, p, sizeof(st)))
+			return -EFAULT;
+
+		error = input_get_event_state(dev, &st);
+		if (error)
+			return error;
+
+		if (copy_to_user(p, &st, sizeof(st)))
+			return -EFAULT;
+
+		return 0;
+
+	case EVIOCSSTATE:
+		if (copy_from_user(&st, p, sizeof(st)))
+			return -EFAULT;
+		return input_set_event_state(dev, &st);
+
 	case EVIOCRMFF:
 		return input_ff_erase(dev, (int)(unsigned long) p, file);
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
index cc763c9..01db55e 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -690,6 +690,121 @@ int input_set_keycode(struct input_dev *dev, int scancode, int keycode)
 }
 EXPORT_SYMBOL(input_set_keycode);
 
+/**
+ * input_validate_event_state - validates event state
+ * @dev: input device whose event state is being validated
+ * @st: input event state which is to be validated
+ *
+ * This function checks whether contents of given event state
+ * structure (@st) is valid for @dev (i.e it is supported).
+ * Returns 0 when @st is valid, negative error otherwise.
+ *
+ * Function accesses internals of @dev so make sure that
+ * @dev->event_lock is locked.
+ */
+static int input_validate_event_state(struct input_dev *dev,
+				      const struct input_event_state *st)
+{
+	unsigned long *bits;
+	unsigned int max;
+
+	BUG_ON(st == NULL);
+
+	/* for now, we support only EV_KEY and EV_SW */
+	switch (st->type) {
+	case EV_KEY:
+		bits = dev->keybit;
+		max = KEY_MAX;
+		break;
+	case EV_SW:
+		bits = dev->swbit;
+		max = SW_MAX;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!is_event_supported(st->code, bits, max))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * input_get_event_state - gets current state of given input event
+ * @dev: device whose event state is being get
+ * @st: buffer where event state is stored
+ *
+ * This function is used to get state of given event.  Event is identified
+ * by {@st->code, @st->type} tuple.  On success function returns 0, negative
+ * error in case of failure.
+ */
+int input_get_event_state(struct input_dev *dev,
+			  struct input_event_state *st)
+{
+	unsigned long flags;
+	int error;
+
+	if (dev->get_event_state == NULL)
+		return -ENOTTY;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+
+	error = input_validate_event_state(dev, st);
+	if (error)
+		goto out;
+
+	error = dev->get_event_state(dev, st);
+out:
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	return error;
+
+}
+EXPORT_SYMBOL(input_get_event_state);
+
+/**
+ * input_set_event_state - sets state of given input event
+ * @dev: device which event is being set
+ * @st: new event state
+ *
+ * Input event state is controlled by this function.  Caller must pass valid
+ * @st to the function (@st->code, @st->type and @st->state should be correct).
+ * For example one can disable input event (if this is supported by underlying
+ * driver by doing following:
+ *      new_state->state = EVENT_STATE_DISABLE;
+ * 	error = input_set_event_state(dev, new_state);
+ * 	if (error)
+ *		...
+ * Function calls the actual implementation function provided by the driver
+ * with @dev->event_lock locked so it cannot sleep.
+ *
+ * If function fails, returns negative error number or 0 on success.
+ */
+int input_set_event_state(struct input_dev *dev,
+			  const struct input_event_state *st)
+{
+	unsigned long flags;
+	int error;
+
+	if (dev->set_event_state == NULL)
+		return -ENOTTY;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+
+	error = input_validate_event_state(dev, st);
+	if (error)
+		goto out;
+
+	error = dev->set_event_state(dev, st);
+out:
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	return error;
+
+}
+EXPORT_SYMBOL(input_set_event_state);
+
 #define MATCH_BIT(bit, max) \
 		for (i = 0; i < BITS_TO_LONGS(max); i++) \
 			if ((id->bit[i] & dev->bit[i]) != id->bit[i]) \
diff --git a/include/linux/input.h b/include/linux/input.h
index 9a04e26..0230c29 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -56,6 +56,37 @@ struct input_absinfo {
 	__s32 resolution;
 };
 
+/**
+ * struct input_event_state - struct used to set/get input event state
+ * @type: input event type (EV_KEY, EV_SW, ..) [user supplied]
+ * @code: input event code [user supplied]
+ * @state: state of the input event (see EVENT_STATE_* below)
+ * @pad: zero padding
+ *
+ * Generated events can have state if underlying event driver supports it.
+ * This way it is possible for example to ask hardware to disable given
+ * event from generating interrupts.  In future there might be some other
+ * states event can have (currently only enable/disable is supported).
+ *
+ * This structure is passed to lower-level input event driver to change
+ * @state of given input event.  Event is identified by {@type, @code} tuple.
+ *
+ * See functions:
+ *	input_get_event_state()
+ *	input_set_event_state()
+ *
+ * for more information.
+ */
+struct input_event_state {
+	__u16	type;
+	__u16	code;
+	__u8	state;
+	__u8	pad[3];
+};
+
+#define EVENT_STATE_DISABLE	0	/* event is disabled */
+#define EVENT_STATE_ENABLE	1	/* event is enabled */
+
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
 #define EVIOCGREP		_IOR('E', 0x03, int[2])			/* get repeat settings */
@@ -67,6 +98,9 @@ struct input_absinfo {
 #define EVIOCGPHYS(len)		_IOC(_IOC_READ, 'E', 0x07, len)		/* get physical location */
 #define EVIOCGUNIQ(len)		_IOC(_IOC_READ, 'E', 0x08, len)		/* get unique identifier */
 
+#define EVIOCGSTATE		_IOR('E', 0x10, struct input_event_state) /* get event state */
+#define EVIOCSSTATE		_IOW('E', 0x11, struct input_event_state) /* set event state */
+
 #define EVIOCGKEY(len)		_IOC(_IOC_READ, 'E', 0x18, len)		/* get global keystate */
 #define EVIOCGLED(len)		_IOC(_IOC_READ, 'E', 0x19, len)		/* get all LEDs */
 #define EVIOCGSND(len)		_IOC(_IOC_READ, 'E', 0x1a, len)		/* get all sounds status */
@@ -1024,6 +1058,8 @@ struct ff_effect {
  *	sparse keymaps. If not supplied default mechanism will be used
  * @getkeycode: optional method to retrieve current keymap. If not supplied
  *	default mechanism will be used
+ * @get_event_state: optional method to retrieve state of single event
+ * @set_event_state: optional method to alter state of single event
  * @ff: force feedback structure associated with the device if device
  *	supports force feedback effects
  * @repeat_key: stores key code of the last key pressed; used to implement
@@ -1095,6 +1131,10 @@ struct input_dev {
 	void *keycode;
 	int (*setkeycode)(struct input_dev *dev, int scancode, int keycode);
 	int (*getkeycode)(struct input_dev *dev, int scancode, int *keycode);
+	int (*get_event_state)(struct input_dev *dev,
+			       struct input_event_state *st);
+	int (*set_event_state)(struct input_dev *dev,
+			       const struct input_event_state *st);
 
 	struct ff_device *ff;
 
@@ -1357,6 +1397,10 @@ static inline void input_set_abs_params(struct input_dev *dev, int axis, int min
 
 int input_get_keycode(struct input_dev *dev, int scancode, int *keycode);
 int input_set_keycode(struct input_dev *dev, int scancode, int keycode);
+int input_get_event_state(struct input_dev *dev,
+			  struct input_event_state *st);
+int input_set_event_state(struct input_dev *dev,
+			  const struct input_event_state *st);
 
 extern struct class input_class;
 
-- 
1.5.6.5

