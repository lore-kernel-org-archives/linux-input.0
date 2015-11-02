From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH 1/3] evdev: convert input_event to input_event64
Date: Mon,  2 Nov 2015 21:35:37 +0800
Message-ID: <1446471339-25464-2-git-send-email-pingbo.wen@linaro.org>
References: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34648 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbKBNgi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 08:36:38 -0500
Received: by padec8 with SMTP id ec8so40336558pad.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 05:36:38 -0800 (PST)
In-Reply-To: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: y2038@lists.linaro.org, arnd@arndb.de, dmitry.torokhov@gmail.com, WEN Pingbo <pingbo.wen@linaro.org>

struct input_event is not y2038 safe. This patch try to convert it to
input_event64, which replaced timeval with timespec64.

There are many userspace programs, which use input_event to talk with
evdev interface. In order to keep compatible with those binary, we add
a flag (is_input_event64) to indicate which structure is used in current
evdev_client, and do input_event/input_event64 conversion in
input_event_from/to_user().

Userland can get / set is_input_event64 flag via EVIOCGEVENT / EVIOCSEVENT
ioctl command.

According to current situation, we set is_input_event64 to false by
default. So that all old userspace programs will work normally. And
we need another patch to change this option, after most of programs have
moved to new structure.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/evdev.c        | 29 ++++++++-------
 drivers/input/input-compat.c | 88 +++++++++++++++++++++++++++++++++++++-------
 drivers/input/input-compat.h |  9 +++--
 include/uapi/linux/input.h   | 15 ++++++++
 4 files changed, 110 insertions(+), 31 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 08d4964..815487f 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -58,8 +58,9 @@ struct evdev_client {
 	struct list_head node;
 	int clk_type;
 	bool revoked;
+	bool is_input_event64;
 	unsigned int bufsize;
-	struct input_event buffer[];
+	struct input_event64 *buffer;
 };
 
 /* flush queued events of type @type, caller must hold client->buffer_lock */
@@ -68,7 +69,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 	unsigned int i, head, num;
 	unsigned int mask = client->bufsize - 1;
 	bool is_report;
-	struct input_event *ev;
+	struct input_event64 *ev;
 
 	BUG_ON(type == EV_SYN);
 
@@ -110,7 +111,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
-	struct input_event ev;
+	struct input_event64 ev;
 	ktime_t time;
 
 	time = client->clk_type == EV_CLK_REAL ?
@@ -119,7 +120,7 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 				ktime_get() :
 				ktime_get_boottime();
 
-	ev.time = ktime_to_timeval(time);
+	ev.time = ktime_to_timespec64(time);
 	ev.type = EV_SYN;
 	ev.code = SYN_DROPPED;
 	ev.value = 0;
@@ -182,7 +183,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 }
 
 static void __pass_event(struct evdev_client *client,
-			 const struct input_event *event)
+			 const struct input_event64 *event)
 {
 	client->buffer[client->head++] = *event;
 	client->head &= client->bufsize - 1;
@@ -214,13 +215,13 @@ static void evdev_pass_values(struct evdev_client *client,
 {
 	struct evdev *evdev = client->evdev;
 	const struct input_value *v;
-	struct input_event event;
+	struct input_event64 event;
 	bool wakeup = false;
 
 	if (client->revoked)
 		return;
 
-	event.time = ktime_to_timeval(ev_time[client->clk_type]);
+	event.time = ktime_to_timespec64(ev_time[client->clk_type]);
 
 	/* Interrupts are disabled, just acquire the lock. */
 	spin_lock(&client->buffer_lock);
@@ -438,7 +439,7 @@ static int evdev_open(struct inode *inode, struct file *file)
 	struct evdev *evdev = container_of(inode->i_cdev, struct evdev, cdev);
 	unsigned int bufsize = evdev_compute_buffer_size(evdev->handle.dev);
 	unsigned int size = sizeof(struct evdev_client) +
-					bufsize * sizeof(struct input_event);
+					bufsize * sizeof(struct input_event64);
 	struct evdev_client *client;
 	int error;
 
@@ -473,7 +474,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 {
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
-	struct input_event event;
+	struct input_event64 event;
 	int retval = 0;
 
 	if (count != 0 && count < input_event_size())
@@ -490,7 +491,8 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 
 	while (retval + input_event_size() <= count) {
 
-		if (input_event_from_user(buffer + retval, &event)) {
+		if (input_event_from_user(buffer + retval, &event,
+					client->is_input_event64)) {
 			retval = -EFAULT;
 			goto out;
 		}
@@ -506,7 +508,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 }
 
 static int evdev_fetch_next_event(struct evdev_client *client,
-				  struct input_event *event)
+				  struct input_event64 *event)
 {
 	int have_event;
 
@@ -528,7 +530,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 {
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
-	struct input_event event;
+	struct input_event64 event;
 	size_t read = 0;
 	int error;
 
@@ -553,7 +555,8 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 		while (read + input_event_size() <= count &&
 		       evdev_fetch_next_event(client, &event)) {
 
-			if (input_event_to_user(buffer + read, &event))
+			if (input_event_to_user(buffer + read, &event,
+						client->is_input_event64))
 				return -EFAULT;
 
 			read += input_event_size();
diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index 64ca711..9bad69a 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -12,10 +12,30 @@
 #include <asm/uaccess.h>
 #include "input-compat.h"
 
+void input_event_to_event64(const struct input_event *event,
+		struct input_event64 *event64)
+{
+	event64->time.tv_sec = event->time.tv_sec;
+	event64->time.tv_nsec = event->time.tv_usec * NSEC_PER_USEC;
+	event64->type = event->type;
+	event64->code = event->code;
+	event64->value = event->value;
+}
+
+void input_event64_to_event(const struct input_event64 *event64,
+		struct input_event *event)
+{
+	event->time.tv_sec = event64->time.tv_sec;
+	event->time.tv_usec = event64->time.tv_nsec / NSEC_PER_USEC;
+	event->type = event64->type;
+	event->code = event64->code;
+	event->value = event64->value;
+}
+
 #ifdef CONFIG_COMPAT
 
 int input_event_from_user(const char __user *buffer,
-			  struct input_event *event)
+		struct input_event64 *event, bool is_input_event64)
 {
 	if (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) {
 		struct input_event_compat compat_event;
@@ -25,27 +45,37 @@ int input_event_from_user(const char __user *buffer,
 			return -EFAULT;
 
 		event->time.tv_sec = compat_event.time.tv_sec;
-		event->time.tv_usec = compat_event.time.tv_usec;
+		event->time.tv_nsec = compat_event.time.tv_usec * NSEC_PER_USEC;
 		event->type = compat_event.type;
 		event->code = compat_event.code;
 		event->value = compat_event.value;
 
 	} else {
-		if (copy_from_user(event, buffer, sizeof(struct input_event)))
-			return -EFAULT;
+		if (is_input_event64) {
+			if (copy_from_user(event, buffer,
+					sizeof(struct input_event64)))
+				return -EFAULT;
+		} else { /* userland use struct input_event */
+			struct input_event ev;
+
+			if (copy_from_user(&ev, buffer,
+					sizeof(struct input_event)))
+				return -EFAULT;
+			input_event_to_event64(&ev, event);
+		}
 	}
 
 	return 0;
 }
 
 int input_event_to_user(char __user *buffer,
-			const struct input_event *event)
+		const struct input_event64 *event, bool is_input_event64)
 {
 	if (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) {
 		struct input_event_compat compat_event;
 
 		compat_event.time.tv_sec = event->time.tv_sec;
-		compat_event.time.tv_usec = event->time.tv_usec;
+		compat_event.time.tv_usec = event->time.tv_nsec / NSEC_PER_USEC;
 		compat_event.type = event->type;
 		compat_event.code = event->code;
 		compat_event.value = event->value;
@@ -55,8 +85,18 @@ int input_event_to_user(char __user *buffer,
 			return -EFAULT;
 
 	} else {
-		if (copy_to_user(buffer, event, sizeof(struct input_event)))
-			return -EFAULT;
+		if (is_input_event64) {
+			if (copy_to_user(buffer, event,
+					sizeof(struct input_event64)))
+				return -EFAULT;
+		} else { /* userland use struct input_event */
+			struct input_event ev;
+
+			input_event64_to_event(event, &ev);
+			if (copy_to_user(buffer, &ev,
+					sizeof(struct input_event)))
+				return -EFAULT;
+		}
 	}
 
 	return 0;
@@ -100,19 +140,39 @@ int input_ff_effect_from_user(const char __user *buffer, size_t size,
 #else
 
 int input_event_from_user(const char __user *buffer,
-			 struct input_event *event)
+		struct input_event64 *event, bool is_input_event64)
 {
-	if (copy_from_user(event, buffer, sizeof(struct input_event)))
-		return -EFAULT;
+	if (is_input_event64) {
+		if (copy_from_user(event, buffer,
+				sizeof(struct input_event64)))
+			return -EFAULT;
+	} else { /* userland use struct input_event */
+		struct input_event ev;
+
+		if (copy_from_user(&ev, buffer,
+				sizeof(struct input_event)))
+			return -EFAULT;
+		input_event_to_event64(&ev, event);
+	}
 
 	return 0;
 }
 
 int input_event_to_user(char __user *buffer,
-			const struct input_event *event)
+		const struct input_event64 *event, bool is_input_event64)
 {
-	if (copy_to_user(buffer, event, sizeof(struct input_event)))
-		return -EFAULT;
+	if (is_input_event64) {
+		if (copy_to_user(buffer, event,
+				sizeof(struct input_event64)))
+			return -EFAULT;
+	} else { /* userland use struct input_event */
+		struct input_event ev;
+
+		input_event64_to_event(event, &ev);
+		if (copy_to_user(buffer, &ev,
+				sizeof(struct input_event)))
+			return -EFAULT;
+	}
 
 	return 0;
 }
diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
index 148f66f..f770b5d 100644
--- a/drivers/input/input-compat.h
+++ b/drivers/input/input-compat.h
@@ -68,23 +68,24 @@ struct ff_effect_compat {
 static inline size_t input_event_size(void)
 {
 	return (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) ?
-		sizeof(struct input_event_compat) : sizeof(struct input_event);
+		sizeof(struct input_event_compat) :
+		sizeof(struct input_event64);
 }
 
 #else
 
 static inline size_t input_event_size(void)
 {
-	return sizeof(struct input_event);
+	return sizeof(struct input_event64);
 }
 
 #endif /* CONFIG_COMPAT */
 
 int input_event_from_user(const char __user *buffer,
-			 struct input_event *event);
+		struct input_event64 *event, bool is_input_event64);
 
 int input_event_to_user(char __user *buffer,
-			const struct input_event *event);
+		const struct input_event64 *event, bool is_input_event64);
 
 int input_ff_effect_from_user(const char __user *buffer, size_t size,
 			      struct ff_effect *effect);
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 731417c..1e252ff 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -21,6 +21,14 @@
  * The event structure itself
  */
 
+/*
+ * This structure should not use anymore, please
+ * use input_event64 instead. Placing it here is
+ * only for compatibility purpose.
+ *
+ * FIXME: move to input-compat.h if there are no
+ * compatibility issues.
+ */
 struct input_event {
 	struct timeval time;
 	__u16 type;
@@ -28,6 +36,13 @@ struct input_event {
 	__s32 value;
 };
 
+struct input_event64 {
+	struct timespec64 time;
+	__u16 type;
+	__u16 code;
+	__s32 value;
+};
+
 /*
  * Protocol version.
  */
-- 
1.9.1

