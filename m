From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v6 1/1] input: Deprecate real timestamps beyond year 2106
Date: Sat,  6 Jan 2018 16:19:15 -0800
Message-ID: <20180107001915.15287-2-deepa.kernel@gmail.com>
References: <20180107001915.15287-1-deepa.kernel@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45555 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeAGATd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 6 Jan 2018 19:19:33 -0500
In-Reply-To: <20180107001915.15287-1-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peter.hutterer@who-t.net, arnd@arndb.de, y2038@lists.linaro.org

struct timeval is not y2038 safe.
All usage of timeval in the kernel will be replaced by
y2038 safe structures.
The change is also necessary as glibc is introducing support
for 32 bit applications to use 64 bit time_t. Without this
change, many applications would incorrectly interpret values
in the struct input_event.
More details about glibc at
https://sourceware.org/glibc/wiki/Y2038ProofnessDesign .

struct input_event maintains time for each input event.
Real time timestamps are not ideal for input as this
time can go backwards as noted in the patch a80b83b7b8
by John Stultz. Hence, having the input_event.time fields
only big enough for monotonic and boot times are
sufficient.

The change leaves the representation of struct input_event as is
on 64 bit architectures. But uses 2 unsigned long values on 32 bit
machines to support real timestamps until year 2106.
This intentionally breaks the ABI on 32 bit architectures and
compat handling on 64 bit architectures.
This is as per maintainer's preference to introduce compile time errors
rather than run into runtime incompatibilities.

The change requires any 32 bit userspace utilities reading or writing
from event nodes to update their reading format to match the new
input_event. The changes to the popular libraries will be posted once
we agree on the kernel change.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/evdev.c        | 16 ++++++++++++----
 drivers/input/input-compat.c |  8 ++++----
 drivers/input/input-compat.h |  3 ++-
 drivers/input/misc/uinput.c  |  4 ++--
 include/uapi/linux/input.h   | 12 +++++++++++-
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 0193dd4f0452..8a8a905ab886 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -135,7 +135,8 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 			continue;
 		} else if (head != i) {
 			/* move entry to fill the gap */
-			client->buffer[head].time = ev->time;
+			client->buffer[head].input_event_sec = ev->input_event_sec;
+			client->buffer[head].input_event_usec = ev->input_event_usec;
 			client->buffer[head].type = ev->type;
 			client->buffer[head].code = ev->code;
 			client->buffer[head].value = ev->value;
@@ -157,6 +158,7 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
 	struct input_event ev;
 	ktime_t time;
+	struct timespec64 ts;
 
 	time = client->clk_type == EV_CLK_REAL ?
 			ktime_get_real() :
@@ -164,7 +166,9 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 				ktime_get() :
 				ktime_get_boottime();
 
-	ev.time = ktime_to_timeval(time);
+	ts = ktime_to_timespec64(time);
+	ev.input_event_sec = ts.tv_sec;
+	ev.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
 	ev.type = EV_SYN;
 	ev.code = SYN_DROPPED;
 	ev.value = 0;
@@ -241,7 +245,8 @@ static void __pass_event(struct evdev_client *client,
 		 */
 		client->tail = (client->head - 2) & (client->bufsize - 1);
 
-		client->buffer[client->tail].time = event->time;
+		client->buffer[client->tail].input_event_sec = event->input_event_sec;
+		client->buffer[client->tail].input_event_usec = event->input_event_usec;
 		client->buffer[client->tail].type = EV_SYN;
 		client->buffer[client->tail].code = SYN_DROPPED;
 		client->buffer[client->tail].value = 0;
@@ -262,12 +267,15 @@ static void evdev_pass_values(struct evdev_client *client,
 	struct evdev *evdev = client->evdev;
 	const struct input_value *v;
 	struct input_event event;
+	struct timespec64 ts;
 	bool wakeup = false;
 
 	if (client->revoked)
 		return;
 
-	event.time = ktime_to_timeval(ev_time[client->clk_type]);
+	ts = ktime_to_timespec64(ev_time[client->clk_type]);
+	event.input_event_sec = ts.tv_sec;
+	event.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
 
 	/* Interrupts are disabled, just acquire the lock. */
 	spin_lock(&client->buffer_lock);
diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index 2186f71c9fe5..fda8d6d2a268 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -24,8 +24,8 @@ int input_event_from_user(const char __user *buffer,
 				   sizeof(struct input_event_compat)))
 			return -EFAULT;
 
-		event->time.tv_sec = compat_event.time.tv_sec;
-		event->time.tv_usec = compat_event.time.tv_usec;
+		event->input_event_sec = compat_event.sec;
+		event->input_event_usec = compat_event.usec;
 		event->type = compat_event.type;
 		event->code = compat_event.code;
 		event->value = compat_event.value;
@@ -44,8 +44,8 @@ int input_event_to_user(char __user *buffer,
 	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
 		struct input_event_compat compat_event;
 
-		compat_event.time.tv_sec = event->time.tv_sec;
-		compat_event.time.tv_usec = event->time.tv_usec;
+		compat_event.sec = event->input_event_sec;
+		compat_event.usec = event->input_event_usec;
 		compat_event.type = event->type;
 		compat_event.code = event->code;
 		compat_event.value = event->value;
diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
index 1563160a7af3..08cd755e73fd 100644
--- a/drivers/input/input-compat.h
+++ b/drivers/input/input-compat.h
@@ -18,7 +18,8 @@
 #ifdef CONFIG_COMPAT
 
 struct input_event_compat {
-	struct compat_timeval time;
+	compat_ulong_t sec;
+	compat_ulong_t usec;
 	__u16 type;
 	__u16 code;
 	__s32 value;
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 9251765645d1..03d22fc90a45 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -90,8 +90,8 @@ static int uinput_dev_event(struct input_dev *dev,
 	udev->buff[udev->head].code = code;
 	udev->buff[udev->head].value = value;
 	ktime_get_ts64(&ts);
-	udev->buff[udev->head].time.tv_sec = ts.tv_sec;
-	udev->buff[udev->head].time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
+	udev->buff[udev->head].input_event_sec = ts.tv_sec;
+	udev->buff[udev->head].input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
 	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 
 	wake_up_interruptible(&udev->waitq);
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 8c5a0bf6ee35..9c5105ff5cc6 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -21,10 +21,20 @@
 
 /*
  * The event structure itself
+ * Note that __USE_TIME_BITS64 is defined by libc based on
+ * application's request to use 64 bit time_t.
  */
-
 struct input_event {
+#if	(__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)
 	struct timeval time;
+#define input_event_sec time.tv_sec
+#define input_event_usec time.tv_usec
+#else
+	__kernel_ulong_t __sec;
+	__kernel_ulong_t __usec;
+#define input_event_sec  __sec
+#define input_event_usec __usec
+#endif
 	__u16 type;
 	__u16 code;
 	__s32 value;
-- 
2.14.1

