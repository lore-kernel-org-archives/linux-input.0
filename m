From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 3/4] input: Deprecate real timestamps beyond year 2106
Date: Tue, 13 Sep 2016 13:10:06 -0700
Message-ID: <1473797406-13286-1-git-send-email-deepa.kernel@gmail.com>
References: <CABeXuvqovKW4hGc+4BNG6q4x30wr45AxptHXnKcon8pMT6CXuA@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34730 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760213AbcIMUK0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 16:10:26 -0400
In-Reply-To: <CABeXuvqovKW4hGc+4BNG6q4x30wr45AxptHXnKcon8pMT6CXuA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org

struct timeval is not y2038 safe.
All usage of timeval in the kernel will be replaced by
y2038 safe structures.

struct input_event maintains time for each input event.
Real time timestamps are not ideal for input as this
time can go backwards as noted in the patch a80b83b7b8
by John Stultz. Hence, having the input_event.time fields
only big enough for monotonic and boot times are
sufficient.

Leave the original input_event as is. This is to maintain
backward compatibility with existing userspace interfaces
that use input_event.
Introduce a new replacement struct raw_input_event.
This replaces timeval with struct input_timeval. This structure
maintains time in __kernel_ulong_t or compat_ulong_t to allow
for architectures to override types as in the case of x32.

The change requires any userspace utilities reading or writing
from event nodes to update their reading format to match
raw_input_event.The changes to the popular libraries will be
posted along with the kernel changes.
The driver version is also updated to reflect the change in
event format.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---

Changes from v1
* Fixed the kbuild error
* Used __KERNEL__ define as per Arnd's suggestion
* Updated comment to indicate the movtivation for
  ulong types as per Arnd's suggestion.

 drivers/input/evdev.c        | 20 +++++++++----------
 drivers/input/input-compat.c | 29 ++++++++++++++-------------
 drivers/input/input-compat.h | 19 +++++++++++-------
 drivers/input/misc/uinput.c  |  6 +++---
 include/linux/uinput.h       |  2 +-
 include/uapi/linux/input.h   | 47 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 35 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index bda2b61..f56188d 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -60,7 +60,7 @@ struct evdev_client {
 	bool revoked;
 	unsigned long *evmasks[EV_CNT];
 	unsigned int bufsize;
-	struct input_event buffer[];
+	struct raw_input_event buffer[];
 };
 
 static size_t evdev_get_mask_cnt(unsigned int type)
@@ -113,7 +113,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 	unsigned int i, head, num;
 	unsigned int mask = client->bufsize - 1;
 	bool is_report;
-	struct input_event *ev;
+	struct raw_input_event *ev;
 
 	BUG_ON(type == EV_SYN);
 
@@ -155,7 +155,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
-	struct input_event ev;
+	struct raw_input_event ev;
 	ktime_t time;
 	struct timespec64 ts;
 
@@ -232,7 +232,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 }
 
 static void __pass_event(struct evdev_client *client,
-			 const struct input_event *event)
+			 const struct raw_input_event *event)
 {
 	client->buffer[client->head++] = *event;
 	client->head &= client->bufsize - 1;
@@ -264,7 +264,7 @@ static void evdev_pass_values(struct evdev_client *client,
 {
 	struct evdev *evdev = client->evdev;
 	const struct input_value *v;
-	struct input_event event;
+	struct raw_input_event event;
 	struct timespec64 ts;
 	bool wakeup = false;
 
@@ -504,7 +504,7 @@ static int evdev_open(struct inode *inode, struct file *file)
 	struct evdev *evdev = container_of(inode->i_cdev, struct evdev, cdev);
 	unsigned int bufsize = evdev_compute_buffer_size(evdev->handle.dev);
 	unsigned int size = sizeof(struct evdev_client) +
-					bufsize * sizeof(struct input_event);
+				bufsize * sizeof(struct raw_input_event);
 	struct evdev_client *client;
 	int error;
 
@@ -539,7 +539,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 {
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
-	struct input_event event;
+	struct raw_input_event event;
 	int retval = 0;
 
 	if (count != 0 && count < input_event_size())
@@ -572,7 +572,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 }
 
 static int evdev_fetch_next_event(struct evdev_client *client,
-				  struct input_event *event)
+				  struct raw_input_event *event)
 {
 	int have_event;
 
@@ -594,7 +594,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 {
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
-	struct input_event event;
+	struct raw_input_event event;
 	size_t read = 0;
 	int error;
 
@@ -1080,7 +1080,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 
 	case EVIOCGVERSION:
-		return put_user(EV_VERSION, ip);
+		return put_user(EV_VERSION_1_2, ip);
 
 	case EVIOCGID:
 		if (copy_to_user(p, &dev->id, sizeof(struct input_id)))
diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index d84d20b..b58d35c 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -15,13 +15,13 @@
 #ifdef CONFIG_COMPAT
 
 int input_event_from_user(const char __user *buffer,
-			  struct input_event *event)
+			  struct raw_input_event *event)
 {
-	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
-		struct input_event_compat compat_event;
+	if (in_compat_syscall()) {
+		struct raw_input_event_compat compat_event;
 
 		if (copy_from_user(&compat_event, buffer,
-				   sizeof(struct input_event_compat)))
+				   sizeof(struct raw_input_event_compat)))
 			return -EFAULT;
 
 		event->time.tv_sec = compat_event.time.tv_sec;
@@ -31,7 +31,8 @@ int input_event_from_user(const char __user *buffer,
 		event->value = compat_event.value;
 
 	} else {
-		if (copy_from_user(event, buffer, sizeof(struct input_event)))
+		if (copy_from_user(event, buffer,
+				   sizeof(struct raw_input_event)))
 			return -EFAULT;
 	}
 
@@ -39,10 +40,10 @@ int input_event_from_user(const char __user *buffer,
 }
 
 int input_event_to_user(char __user *buffer,
-			const struct input_event *event)
+			const struct raw_input_event *event)
 {
-	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
-		struct input_event_compat compat_event;
+	if (in_compat_syscall()) {
+		struct raw_input_event_compat compat_event;
 
 		compat_event.time.tv_sec = event->time.tv_sec;
 		compat_event.time.tv_usec = event->time.tv_usec;
@@ -51,11 +52,11 @@ int input_event_to_user(char __user *buffer,
 		compat_event.value = event->value;
 
 		if (copy_to_user(buffer, &compat_event,
-				 sizeof(struct input_event_compat)))
+				 sizeof(struct raw_input_event_compat)))
 			return -EFAULT;
 
 	} else {
-		if (copy_to_user(buffer, event, sizeof(struct input_event)))
+		if (copy_to_user(buffer, event, sizeof(struct raw_input_event)))
 			return -EFAULT;
 	}
 
@@ -100,18 +101,18 @@ int input_ff_effect_from_user(const char __user *buffer, size_t size,
 #else
 
 int input_event_from_user(const char __user *buffer,
-			 struct input_event *event)
+			 struct raw_input_event *event)
 {
-	if (copy_from_user(event, buffer, sizeof(struct input_event)))
+	if (copy_from_user(event, buffer, sizeof(struct raw_input_event)))
 		return -EFAULT;
 
 	return 0;
 }
 
 int input_event_to_user(char __user *buffer,
-			const struct input_event *event)
+			const struct raw_input_event *event)
 {
-	if (copy_to_user(buffer, event, sizeof(struct input_event)))
+	if (copy_to_user(buffer, event, sizeof(struct raw_input_event)))
 		return -EFAULT;
 
 	return 0;
diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
index 1563160..c18132d 100644
--- a/drivers/input/input-compat.h
+++ b/drivers/input/input-compat.h
@@ -17,8 +17,13 @@
 
 #ifdef CONFIG_COMPAT
 
-struct input_event_compat {
-	struct compat_timeval time;
+struct input_timeval_compat {
+	compat_ulong_t tv_sec;
+	compat_ulong_t tv_usec;
+};
+
+struct raw_input_event_compat {
+	struct input_timeval_compat time;
 	__u16 type;
 	__u16 code;
 	__s32 value;
@@ -55,24 +60,24 @@ struct ff_effect_compat {
 
 static inline size_t input_event_size(void)
 {
-	return (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) ?
-		sizeof(struct input_event_compat) : sizeof(struct input_event);
+	return in_compat_syscall() ? sizeof(struct raw_input_event_compat) :
+				     sizeof(struct raw_input_event);
 }
 
 #else
 
 static inline size_t input_event_size(void)
 {
-	return sizeof(struct input_event);
+	return sizeof(struct raw_input_event);
 }
 
 #endif /* CONFIG_COMPAT */
 
 int input_event_from_user(const char __user *buffer,
-			 struct input_event *event);
+			 struct raw_input_event *event);
 
 int input_event_to_user(char __user *buffer,
-			const struct input_event *event);
+			const struct raw_input_event *event);
 
 int input_ff_effect_from_user(const char __user *buffer, size_t size,
 			      struct ff_effect *effect);
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index ae22927..993bd24 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -564,7 +564,7 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
 static ssize_t uinput_inject_events(struct uinput_device *udev,
 				    const char __user *buffer, size_t count)
 {
-	struct input_event ev;
+	struct raw_input_event ev;
 	size_t bytes = 0;
 
 	if (count != 0 && count < input_event_size())
@@ -610,7 +610,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
 }
 
 static bool uinput_fetch_next_event(struct uinput_device *udev,
-				    struct input_event *event)
+				    struct raw_input_event *event)
 {
 	bool have_event;
 
@@ -630,7 +630,7 @@ static bool uinput_fetch_next_event(struct uinput_device *udev,
 static ssize_t uinput_events_to_user(struct uinput_device *udev,
 				     char __user *buffer, size_t count)
 {
-	struct input_event event;
+	struct raw_input_event event;
 	size_t read = 0;
 
 	while (read + input_event_size() <= count &&
diff --git a/include/linux/uinput.h b/include/linux/uinput.h
index 6527fb7..d1accb3 100644
--- a/include/linux/uinput.h
+++ b/include/linux/uinput.h
@@ -71,7 +71,7 @@ struct uinput_device {
 	unsigned char		ready;
 	unsigned char		head;
 	unsigned char		tail;
-	struct input_event	buff[UINPUT_BUFFER_SIZE];
+	struct raw_input_event	buff[UINPUT_BUFFER_SIZE];
 	int			clk_type;
 	unsigned int		ff_effects_max;
 
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index e794f7b..60d5869 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -22,6 +22,29 @@
  * The event structure itself
  */
 
+/* The time structure for y2038 safe raw_input_event.
+ * The fields use unsigned types to extend times until
+ * year 2106 rather than 2038.
+ */
+struct input_timeval {
+	__kernel_ulong_t tv_sec;
+	__kernel_ulong_t tv_usec;
+};
+
+struct raw_input_event {
+	struct input_timeval time;
+	__u16 type;
+	__u16 code;
+	__s32 value;
+};
+
+#ifndef __KERNEL__
+
+/* Userspace structure.
+ * Definition maintained here for userspace that is not yet updated to use
+ * struct raw_input_event.
+ * Not to be used anywhere within the kernel.
+ */
 struct input_event {
 	struct timeval time;
 	__u16 type;
@@ -29,11 +52,35 @@ struct input_event {
 	__s32 value;
 };
 
+
+static inline void
+raw_input_to_input_event(struct raw_input_event *raw, struct input_event *ev)
+{
+	ev->time.tv_sec = raw->time.tv_sec;
+	ev->time.tv_usec = raw->time.tv_usec;
+	ev->type = raw->type;
+	ev->code = raw->code;
+	ev->value = raw->value;
+}
+
+static inline void
+input_to_raw_event(struct input_event *ev, struct raw_input_event *raw)
+{
+	raw->time.tv_sec = ev->time.tv_sec;
+	raw->time.tv_usec = ev->time.tv_usec;
+	raw->type = ev->type;
+	raw->code = ev->code;
+	raw->value = ev->value;
+}
+
+#endif
+
 /*
  * Protocol version.
  */
 
 #define EV_VERSION		0x010001
+#define EV_VERSION_1_2          0x010002
 
 /*
  * IOCTLs (0x00 - 0x7f)
-- 
2.7.4

