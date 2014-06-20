From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC] Input: evdev - add new EVIOCGABSRANGE ioctl
Date: Fri, 20 Jun 2014 16:05:49 +0200
Message-ID: <1403273149-29224-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35068 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965909AbaFTOGI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jun 2014 10:06:08 -0400
Received: by mail-wg0-f51.google.com with SMTP id x12so3746514wgg.10
        for <linux-input@vger.kernel.org>; Fri, 20 Jun 2014 07:06:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

When we introduced the slotted MT ABS extensions, we didn't take care to
make SYN_DROPPED recoverable. Imagine a client recevies a SYN_DROPPED and
syncs its current state via EVIOCGABS. It has to call this ioctl for each
and every ABS code separately. Besides being horribly slow, this series
of ioctl-calls is not atomic. The kernel might queue new ABS events while
the client fetches the data.

Now for normal ABS codes this is negligible as ABS values provide absolute
data. That is, there is usually no need to resync ABS codes as we don't
need previous values to interpret the next ABS code. Furthermore, most ABS
codes are also sent pretty frequently so a refresh is usually useless.

However, with the introduction of slotted ABS axes we added a relative
component: ABS_MT_SLOT. If a client syncs all ABS codes via EVIOCGABS
while the kernel has ABS-events and an ABS_MT_SLOT event queued, the
client will think any read ABS-event is for the retrieved SLOT, however,
this is not true as all events until the next ABS_MT_SLOT event are for
the previously active slot:

    Kernel queue is: { ABS_DROPPED,
                       ABS_MT_POSITION_X(slot: 0),
                       ABS_MT_SLOT(slot: 1),
                       ABS_MT_POSITION_X(slot: 1) }
    Client reads ABS_DROPPED from queue.
    Client syncs all ABS values:
      As part of that, client syncs ABS_MT_SLOT, which is 1 in the current
      view of the kernel.
    Client reads ABS_MT_POSITION_X and attributes it to slot 1 instead of
    slot 0, as the slot-value is not explicit.

This is just a simple example how the relative information provided by the
ABS_MT_SLOT axis can be problematic to clients.

Now there are many ways to fix this:
 * Make ABS_MT_SLOT a per-evdev-client attribute. On each
   EVIOCGABS(ABS_MT_SLOT) we can add fake ABS_MT_SLOT events to the queue.
   => Ugly and overkill
 * Flush all ABS events when clients read ABS_MT_SLOT.
   => Ugly hack and client might loose important ABS_MT_* events
 * Provide atomic EVIOCGABS API.
   => Sounds good!

This patch introduces EVIOCGABSRANGE. Unlike EVIOCGABS, this ioctl only
fetches ABS values, rather than the whole "struct input_absinfo" set.
However, the new ioctl can fetch a range of ABS axes atomically and will
flush matching events from the client's receive queue. Moreover, you can
fetch all axes for *all* slots with a single call.

This way, a client can simply run EVIOCGABSRANGE(0, ABS_CNT) and it will
receive a consistent view of the whole ABS state, while the kernel flushes
the receive-buffer for a consistent view.
While most clients probably only need
EVIOCGABSRANGE(ABS_MT_SLOT, ABS_MT_TOOL_y - ABS_MT_SLOT + 1), the ioctl
allows to receive an arbitrary range of axes.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/input/evdev.c      | 180 ++++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/input.h |  42 +++++++++++
 2 files changed, 218 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 6386882..7a25a7a 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -175,8 +175,9 @@ static bool __evdev_is_filtered(struct evdev_client *client,
 	return mask && !test_bit(code, mask);
 }
 
-/* flush queued events of type @type, caller must hold client->buffer_lock */
-static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
+/* flush queued, matching events, caller must hold client->buffer_lock */
+static void __evdev_flush_queue(struct evdev_client *client, unsigned int type,
+				unsigned int code_first, unsigned int code_last)
 {
 	unsigned int i, head, num;
 	unsigned int mask = client->bufsize - 1;
@@ -195,7 +196,9 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 		ev = &client->buffer[i];
 		is_report = ev->type == EV_SYN && ev->code == SYN_REPORT;
 
-		if (ev->type == type) {
+		if (ev->type == type &&
+		    ev->code >= code_first &&
+		    ev->code <= code_last) {
 			/* drop matched entry */
 			continue;
 		} else if (is_report && !num) {
@@ -786,6 +789,172 @@ static int handle_eviocgbit(struct input_dev *dev,
 	return bits_to_user(bits, len, size, p, compat_mode);
 }
 
+static inline void free_absrange(s32 **pages, size_t page_cnt)
+{
+	if (page_cnt > 1) {
+		while (page_cnt > 0) {
+			if (!pages[--page_cnt])
+				break;
+			__free_page(virt_to_page(pages[page_cnt]));
+		}
+		kfree(pages);
+	} else if (page_cnt == 1) {
+		kfree(pages);
+	}
+}
+
+static inline s32 *absrange_ptr(s32 **pages, size_t page_cnt, size_t slots,
+				size_t i_code, size_t j_slot)
+{
+	size_t idx, off;
+
+	idx = (i_code * slots + j_slot) / (PAGE_SIZE / sizeof(s32));
+	off = (i_code * slots + j_slot) % (PAGE_SIZE / sizeof(s32));
+
+	if (page_cnt == 1)
+		return &((s32*)pages)[off];
+	else
+		return &pages[idx][off];
+}
+
+static inline ssize_t fetch_absrange(struct evdev_client *client,
+				     struct input_dev *dev, size_t start,
+				     size_t count, size_t slots, s32 ***out)
+{
+	size_t size, page_cnt, i, j;
+	unsigned long flags;
+	s32 **pages;
+
+	/*
+	 * Fetch data atomically from the device and flush buffers. We need to
+	 * allocate a temporary buffer as copy_to_user() is not allowed while
+	 * holding spinlocks. However, to-be-copied data might be huge and
+	 * high-order allocations should be avoided. Therefore, do the
+	 * page-allocation manually.
+	 */
+
+	BUILD_BUG_ON(PAGE_SIZE % sizeof(s32) != 0);
+
+	size = sizeof(s32) * count * slots;
+	page_cnt = DIV_ROUND_UP(size, PAGE_SIZE);
+	if (page_cnt < 1) {
+		return 0;
+	} else if (page_cnt == 1) {
+		pages = kzalloc(size, GFP_TEMPORARY);
+		if (!pages)
+			return -ENOMEM;
+	} else {
+		pages = kzalloc(sizeof(*pages) * page_cnt, GFP_TEMPORARY);
+		if (!pages)
+			return -ENOMEM;
+
+		for (i = 0; i < page_cnt; ++i) {
+			pages[i] = (void*)get_zeroed_page(GFP_TEMPORARY);
+			if (!pages[i]) {
+				free_absrange(pages, page_cnt);
+				return -ENOMEM;
+			}
+		}
+	}
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	spin_lock(&client->buffer_lock);
+
+	for (i = 0; i < count; ++i) {
+		__u16 code;
+		bool is_mt;
+
+		code = start + i;
+		is_mt = input_is_mt_value(code);
+		if (is_mt && !dev->mt)
+			continue;
+
+		for (j = 0; j < slots; ++j) {
+			__s32 v;
+
+			if (is_mt)
+				v = input_mt_get_value(&dev->mt->slots[j],
+						       code);
+			else
+				v = dev->absinfo[code].value;
+
+			*absrange_ptr(pages, page_cnt, slots, i, j) = v;
+
+			if (!is_mt)
+				break;
+		}
+	}
+
+	spin_unlock(&client->buffer_lock);
+	__evdev_flush_queue(client, EV_ABS, start, start + count - 1);
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	*out = pages;
+	return page_cnt;
+}
+
+static int evdev_handle_get_absrange(struct evdev_client *client,
+				     struct input_dev *dev,
+				     struct input_absrange __user *p)
+{
+	size_t slots, code, count, i, j;
+	struct input_absrange absbuf;
+	s32 **vals = NULL;
+	ssize_t val_cnt;
+	s32 __user *b;
+	int retval;
+
+	if (!dev->absinfo)
+		return -EINVAL;
+	if (copy_from_user(&absbuf, p, sizeof(absbuf)))
+		return -EFAULT;
+
+	slots = min_t(size_t, dev->mt ? dev->mt->num_slots : 1, absbuf.slots);
+	code = min_t(size_t, absbuf.code, ABS_CNT);
+	count = min_t(size_t, absbuf.count, ABS_CNT);
+
+	/* first fetch data atomically from device */
+
+	if (code + count > ABS_CNT)
+		count = ABS_CNT - code;
+
+	if (!slots || !count) {
+		val_cnt = 0;
+	} else {
+		val_cnt = fetch_absrange(client, dev, code, count,
+					 slots, &vals);
+		if (val_cnt < 0)
+			return val_cnt;
+	}
+
+	/* now copy data to user-space */
+
+	b = (void __user*)(unsigned long)absbuf.buffer;
+	for (i = 0; i < absbuf.count; ++i) {
+		for (j = 0; j < absbuf.slots; ++j, ++b) {
+			s32 v;
+
+			if (i >= count || j >= slots)
+				v = 0;
+			else
+				v = *absrange_ptr(vals, val_cnt, slots, i, j);
+
+			if (put_user(v, b)) {
+				retval = -EFAULT;
+				goto out;
+			}
+		}
+	}
+
+	retval = 0;
+
+out:
+	free_absrange(vals, val_cnt);
+	if (retval < 0)
+		evdev_queue_syn_dropped(client);
+	return retval;
+}
+
 static int evdev_handle_get_keycode(struct input_dev *dev, void __user *p)
 {
 	struct input_keymap_entry ke = {
@@ -889,7 +1058,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
 
 	spin_unlock(&dev->event_lock);
 
-	__evdev_flush_queue(client, type);
+	__evdev_flush_queue(client, type, 0, UINT_MAX);
 
 	spin_unlock_irq(&client->buffer_lock);
 
@@ -1006,6 +1175,9 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		else
 			return evdev_revoke(evdev, client, file);
 
+	case EVIOCGABSRANGE:
+		return evdev_handle_get_absrange(client, dev, p);
+
 	case EVIOCGMASK:
 		if (copy_from_user(&mask, p, sizeof(mask)))
 			return -EFAULT;
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index f6ace0e..32a6443 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -210,6 +210,48 @@ struct input_mask {
  */
 #define EVIOCSMASK		_IOW('E', 0x93, struct input_mask)	/* Set event-masks */
 
+struct input_absrange {
+	__u16 slots;
+	__u16 code;
+	__u32 count;
+	__u64 buffer;
+};
+
+/**
+ * EVIOCGABSRANGE - Fetch range of ABS values
+ *
+ * This fetches the current values of a range of ABS codes atomically. The range
+ * of codes to fetch and the buffer-types are passed as "struct input_absrange",
+ * which has the following fields:
+ *      slots: Number of MT slots to fetch data for.
+ *       code: First ABS axis to query.
+ *      count: Number of ABS axes to query starting at @code.
+ *     buffer: Pointer to a receive buffer where to store the fetched ABS
+ *             values. This buffer must be an array of __s32 with at least
+ *             (@slots * @code) elements. The buffer is interpreted as two
+ *             dimensional __s32 array, declared as: __s32[slots][codes]
+ *
+ * Compared to EVIOCGABS this ioctl allows to retrieve a range of ABS codes
+ * atomically regarding any concurrent buffer modifications. Furthermore, any
+ * pending events for codes that were retrived via this call are flushed from
+ * the client's receive buffer. But unlike EVIOCGABS, this ioctl only returns
+ * the current value of an axis, rather than the whole "struct input_absinfo"
+ * set. All fields of "struct input_absinfo" except for the value are constant,
+ * though.
+ *
+ * The kernel's current view of the ABS axes is copied into the provided buffer.
+ * If an ABS axis is not enabled on the device, its value will be zero. Also, if
+ * an axis is not a slotted MT-axis, values for all but the first slot will be
+ * 0. If @slots is greater than the actual number of slots provided by the
+ * device, values for all slots higher than that will be 0.
+ *
+ * This call may fail with -EINVAL if the kernel doesn't support this call or
+ * the arguments are invalid, with -ENODEV if access was revoked, -ENOMEM if the
+ * kernel couldn't allocate temporary buffers for data-copy or -EFAULT if the
+ * passed pointer was invalid.
+ */
+#define EVIOCGABSRANGE		_IOR('E', 0x94, struct input_absrange)
+
 #define EVIOCSCLOCKID		_IOW('E', 0xa0, int)			/* Set clockid to be used for timestamps */
 
 /*
-- 
2.0.0

