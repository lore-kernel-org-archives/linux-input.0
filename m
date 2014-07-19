From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH RESEND 1/5] Input: evdev - add event-mask API
Date: Sat, 19 Jul 2014 15:10:41 +0200
Message-ID: <1405775445-4454-2-git-send-email-dh.herrmann@gmail.com>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35421 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbaGSNLA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2014 09:11:00 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so2033221wiw.0
        for <linux-input@vger.kernel.org>; Sat, 19 Jul 2014 06:10:59 -0700 (PDT)
In-Reply-To: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@google.com>, David Herrmann <dh.herrmann@gmail.com>

Hardware manufacturers group keys in the weirdest way possible. This may
cause a power-key to be grouped together with normal keyboard keys and
thus be reported on the same kernel interface.

However, user-space is often only interested in specific sets of events.
For instance, daemons dealing with system-reboot (like systemd-logind)
listen for KEY_POWER, but are not interested in any main keyboard keys.
Usually, power keys are reported via separate interfaces, however,
some i8042 boards report it in the AT matrix. To avoid waking up those
system daemons on each key-press, we had two ideas:
 - split off KEY_POWER into a separate interface unconditionally
 - allow filtering a specific set of events on evdev FDs

Splitting of KEY_POWER is a rather weird way to deal with this and may
break backwards-compatibility. It is also specific to KEY_POWER and might
be required for other stuff, too. Moreover, we might end up with a huge
set of input-devices just to have them properly split.

Hence, this patchset implements the second idea: An event-mask to specify
which events you're interested in. Two ioctls allow setting this mask for
each event-type. If not set, all events are reported. The type==0 entry is
used same as in EVIOCGBIT to set the actual EV_* mask of filtered events.
This way, you have a two-level filter.

We are heavily forward-compatible to new event-types and event-codes. So
new user-space will be able to run on an old kernel which doesn't know the
given event-codes or event-types.

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/input/evdev.c      | 156 ++++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/input.h |  56 ++++++++++++++++
 2 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index fd325ec..6386882 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -51,10 +51,130 @@ struct evdev_client {
 	struct list_head node;
 	int clkid;
 	bool revoked;
+	unsigned long *evmasks[EV_CNT];
 	unsigned int bufsize;
 	struct input_event buffer[];
 };
 
+static size_t evdev_get_mask_cnt(unsigned int type)
+{
+	static size_t counts[EV_CNT] = {
+		/* EV_SYN==0 is EV_CNT, _not_ SYN_CNT, see EVIOCGBIT */
+		[EV_SYN] = EV_CNT,
+		[EV_KEY] = KEY_CNT,
+		[EV_REL] = REL_CNT,
+		[EV_ABS] = ABS_CNT,
+		[EV_MSC] = MSC_CNT,
+		[EV_SW] = SW_CNT,
+		[EV_LED] = LED_CNT,
+		[EV_SND] = SND_CNT,
+		[EV_FF] = FF_CNT,
+	};
+
+	return (type < EV_CNT) ? counts[type] : 0;
+}
+
+/* must be called with evdev-mutex held */
+static int evdev_set_mask(struct evdev_client *client,
+			  unsigned int type,
+			  const void __user *codes,
+			  u32 codes_size)
+{
+	unsigned long flags, *mask, *oldmask;
+	size_t cnt, size;
+
+	/* unknown masks are simply ignored for forward-compat */
+	cnt = evdev_get_mask_cnt(type);
+	if (!cnt)
+		return 0;
+
+	/* we allow 'codes_size > size' for forward-compat */
+	size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
+
+	mask = kzalloc(size, GFP_KERNEL);
+	if (!mask)
+		return -ENOMEM;
+
+	if (copy_from_user(mask, codes, min_t(size_t, codes_size, size))) {
+		kfree(mask);
+		return -EFAULT;
+	}
+
+	spin_lock_irqsave(&client->buffer_lock, flags);
+	oldmask = client->evmasks[type];
+	client->evmasks[type] = mask;
+	spin_unlock_irqrestore(&client->buffer_lock, flags);
+
+	kfree(oldmask);
+
+	return 0;
+}
+
+/* must be called with evdev-mutex held */
+static int evdev_get_mask(struct evdev_client *client,
+			  unsigned int type,
+			  void __user *codes,
+			  u32 codes_size)
+{
+	unsigned long *mask;
+	size_t cnt, size, min, i;
+	u8 __user *out;
+
+	/* we allow unknown types and 'codes_size > size' for forward-compat */
+	cnt = evdev_get_mask_cnt(type);
+	size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
+	min = min_t(size_t, codes_size, size);
+
+	if (cnt > 0) {
+		mask = client->evmasks[type];
+		if (mask) {
+			if (copy_to_user(codes, mask, min))
+				return -EFAULT;
+		} else {
+			/* fake mask with all bits set */
+			out = (u8 __user*)codes;
+			for (i = 0; i < min; ++i) {
+				if (put_user((u8)0xff,  out + i))
+					return -EFAULT;
+			}
+		}
+	}
+
+	codes = (u8*)codes + min;
+	codes_size -= min;
+
+	if (codes_size > 0 && clear_user(codes, codes_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+/* requires the buffer lock to be held */
+static bool __evdev_is_filtered(struct evdev_client *client,
+				unsigned int type,
+				unsigned int code)
+{
+	unsigned long *mask;
+	size_t cnt;
+
+	/* EV_SYN and unknown codes are never filtered */
+	if (type == EV_SYN || type >= EV_CNT)
+		return false;
+
+	/* first test whether the type is filtered */
+	mask = client->evmasks[0];
+	if (mask && !test_bit(type, mask))
+		return true;
+
+	/* unknown values are never filtered */
+	cnt = evdev_get_mask_cnt(type);
+	if (!cnt || code >= cnt)
+		return false;
+
+	mask = client->evmasks[type];
+	return mask && !test_bit(code, mask);
+}
+
 /* flush queued events of type @type, caller must hold client->buffer_lock */
 static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 {
@@ -177,12 +297,21 @@ static void evdev_pass_values(struct evdev_client *client,
 	spin_lock(&client->buffer_lock);
 
 	for (v = vals; v != vals + count; v++) {
+		if (__evdev_is_filtered(client, v->type, v->code))
+			continue;
+
+		if (v->type == EV_SYN && v->code == SYN_REPORT) {
+			/* drop empty SYN_REPORT */
+			if (client->packet_head == client->head)
+				continue;
+
+			wakeup = true;
+		}
+
 		event.type = v->type;
 		event.code = v->code;
 		event.value = v->value;
 		__pass_event(client, &event);
-		if (v->type == EV_SYN && v->code == SYN_REPORT)
-			wakeup = true;
 	}
 
 	spin_unlock(&client->buffer_lock);
@@ -365,6 +494,7 @@ static int evdev_release(struct inode *inode, struct file *file)
 {
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
+	unsigned int i;
 
 	mutex_lock(&evdev->mutex);
 	evdev_ungrab(evdev, client);
@@ -372,6 +502,9 @@ static int evdev_release(struct inode *inode, struct file *file)
 
 	evdev_detach_client(evdev, client);
 
+	for (i = 0; i < EV_CNT; ++i)
+		kfree(client->evmasks[i]);
+
 	if (is_vmalloc_addr(client))
 		vfree(client);
 	else
@@ -811,6 +944,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 	struct evdev *evdev = client->evdev;
 	struct input_dev *dev = evdev->handle.dev;
 	struct input_absinfo abs;
+	struct input_mask mask;
 	struct ff_effect effect;
 	int __user *ip = (int __user *)p;
 	unsigned int i, t, u, v;
@@ -872,6 +1006,24 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		else
 			return evdev_revoke(evdev, client, file);
 
+	case EVIOCGMASK:
+		if (copy_from_user(&mask, p, sizeof(mask)))
+			return -EFAULT;
+
+		return evdev_get_mask(client,
+				      mask.type,
+				      (void*)(long)mask.codes_ptr,
+				      mask.codes_size);
+
+	case EVIOCSMASK:
+		if (copy_from_user(&mask, p, sizeof(mask)))
+			return -EFAULT;
+
+		return evdev_set_mask(client,
+				      mask.type,
+				      (const void*)(long)mask.codes_ptr,
+				      mask.codes_size);
+
 	case EVIOCSCLOCKID:
 		if (copy_from_user(&i, p, sizeof(unsigned int)))
 			return -EFAULT;
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 19df18c..f6ace0e 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -97,6 +97,12 @@ struct input_keymap_entry {
 	__u8  scancode[32];
 };
 
+struct input_mask {
+	__u32 type;
+	__u32 codes_size;
+	__u64 codes_ptr;
+};
+
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
 #define EVIOCGREP		_IOR('E', 0x03, unsigned int[2])	/* get repeat settings */
@@ -154,6 +160,56 @@ struct input_keymap_entry {
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
 #define EVIOCREVOKE		_IOW('E', 0x91, int)			/* Revoke device access */
 
+/**
+ * EVIOCGMASK - Retrieve current event-mask
+ *
+ * This retrieves the current event-mask for a specific event-type. The
+ * argument must be of type "struct input_mask" and specifies the event-type to
+ * query, the receive buffer and the size of the receive buffer.
+ *
+ * The event-mask is a per-client mask that specifies which events are forwarded
+ * to the client. Each event-code is represented by a single bit in the
+ * event-mask. If the bit is set, the event is passed to the client normally.
+ * Otherwise, the event is filtered and and will never be queued on the
+ * client's receive buffer.
+ * Event-masks do not affect global state of an input-device. They only affect
+ * the open-file they're applied on. Each open-file (i.e, file-description) can
+ * have a different event-mask.
+ *
+ * The default event-mask for a client has all bits set, i.e. all events are
+ * forwarded to the client. If a kernel is queried for an unknown event-type
+ * or if the receive buffer is larger than the number of event-codes known to
+ * the kernel, the kernel returns all zeroes for those codes.
+ *
+ * At maximum, codes_size bytes are copied.
+ *
+ * This ioctl may fail with ENODEV in case the file is revoked, EFAULT
+ * if the receive-buffer points to invalid memory, or EINVAL if the kernel
+ * does not implement the ioctl.
+ */
+#define EVIOCGMASK		_IOR('E', 0x92, struct input_mask)	/* Get event-masks */
+
+/**
+ * EVIOCSMASK - Set event-mask
+ *
+ * This is the counterpart to EVIOCGMASK. Instead of receiving the current
+ * event-mask, this changes the client's event-mask for a specific type. See
+ * EVIOCGMASK for a description of event-masks and the argument-type.
+ *
+ * This ioctl provides full forward-compatibility. If the passed event-type is
+ * unknown to the kernel, or if the number of codes is bigger than known to the
+ * kernel, the ioctl is still accepted and applied. However, any unknown codes
+ * are left untouched and stay cleared. That means, the kernel always filters
+ * unknown codes regardless of what the client requests.
+ * If the new mask doesn't cover all known event-codes, all remaining codes are
+ * automatically cleared and thus filtered.
+ *
+ * This ioctl may fail with ENODEV in case the file is revoked. EFAULT is
+ * returned if the receive-buffer points to invalid memory. EINVAL is returned
+ * if the kernel does not implement the ioctl.
+ */
+#define EVIOCSMASK		_IOW('E', 0x93, struct input_mask)	/* Set event-masks */
+
 #define EVIOCSCLOCKID		_IOW('E', 0xa0, int)			/* Set clockid to be used for timestamps */
 
 /*
-- 
2.0.2

