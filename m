From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v2 1/4] uinput: Add ioctl for using monotonic/ boot times
Date: Mon, 17 Oct 2016 20:27:30 -0700
Message-ID: <1476761253-13450-2-git-send-email-deepa.kernel@gmail.com>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36335 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbcJRD1w (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Oct 2016 23:27:52 -0400
In-Reply-To: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org

struct timeval which is part of struct input_event to
maintain the event times is not y2038 safe.

Real time timestamps are also not ideal for input_event
as this time can go backwards as noted in the patch
a80b83b7b8 by John Stultz.

Arnd Bergmann suggested deprecating real time and using
monotonic or other timers for all input_event times as a
solution to both the above problems.

Add a new ioctl to let the user dictate the kind of time
to be used for input events. This is similar to the evdev
implementation of the feature. Realtime is still the
default time. This is to maintain backward compatibility.

The structure to maintain input events will be changed
in a different patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 drivers/input/misc/uinput.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/uinput.h      |  1 +
 include/uapi/linux/uinput.h |  3 +++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 92595b9..3d75c5a 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -46,11 +46,26 @@ static int uinput_dev_event(struct input_dev *dev,
 			    unsigned int type, unsigned int code, int value)
 {
 	struct uinput_device	*udev = input_get_drvdata(dev);
+	struct timespec64	ts;
 
 	udev->buff[udev->head].type = type;
 	udev->buff[udev->head].code = code;
 	udev->buff[udev->head].value = value;
-	do_gettimeofday(&udev->buff[udev->head].time);
+
+	switch (udev->clk_type) {
+	case CLOCK_REALTIME:
+		ktime_get_real_ts64(&ts);
+		break;
+	case CLOCK_MONOTONIC:
+		ktime_get_ts64(&ts);
+		break;
+	case CLOCK_BOOTTIME:
+		get_monotonic_boottime64(&ts);
+		break;
+	}
+
+	udev->buff[udev->head].time.tv_sec = ts.tv_sec;
+	udev->buff[udev->head].time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 
 	wake_up_interruptible(&udev->waitq);
@@ -295,6 +310,7 @@ static int uinput_create_device(struct uinput_device *udev)
 	if (error)
 		goto fail2;
 
+	udev->clk_type = CLOCK_REALTIME;
 	udev->state = UIST_CREATED;
 
 	return 0;
@@ -304,6 +320,38 @@ static int uinput_create_device(struct uinput_device *udev)
 	return error;
 }
 
+static int uinput_set_clk_type(struct uinput_device *udev, unsigned int clkid)
+{
+	unsigned int clk_type;
+
+	if (udev->state != UIST_CREATED)
+		return -EINVAL;
+
+	switch (clkid) {
+	/* Realtime clock is only valid until year 2038.*/
+	case CLOCK_REALTIME:
+		clk_type = CLOCK_REALTIME;
+		break;
+	case CLOCK_MONOTONIC:
+		clk_type = CLOCK_MONOTONIC;
+		break;
+	case CLOCK_BOOTTIME:
+		clk_type = CLOCK_BOOTTIME;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (udev->clk_type != clk_type) {
+		udev->clk_type = clk_type;
+
+		/* Flush pending events */
+		uinput_flush_requests(udev);
+	}
+
+	return 0;
+}
+
 static int uinput_open(struct inode *inode, struct file *file)
 {
 	struct uinput_device *newdev;
@@ -787,6 +835,7 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 	char			*phys;
 	const char		*name;
 	unsigned int		size;
+	int			clock_id;
 
 	retval = mutex_lock_interruptible(&udev->mutex);
 	if (retval)
@@ -817,6 +866,11 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 			retval = uinput_dev_setup(udev, p);
 			goto out;
 
+		case UI_SET_CLOCKID:
+			if (copy_from_user(&clock_id, p, sizeof(unsigned int)))
+				return -EFAULT;
+			return uinput_set_clk_type(udev, clock_id);
+
 		/* UI_ABS_SETUP is handled in the variable size ioctls */
 
 		case UI_SET_EVBIT:
diff --git a/include/linux/uinput.h b/include/linux/uinput.h
index 75de43d..6527fb7 100644
--- a/include/linux/uinput.h
+++ b/include/linux/uinput.h
@@ -72,6 +72,7 @@ struct uinput_device {
 	unsigned char		head;
 	unsigned char		tail;
 	struct input_event	buff[UINPUT_BUFFER_SIZE];
+	int			clk_type;
 	unsigned int		ff_effects_max;
 
 	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
index dc652e2..d9494ae 100644
--- a/include/uapi/linux/uinput.h
+++ b/include/uapi/linux/uinput.h
@@ -133,6 +133,9 @@ struct uinput_abs_setup {
  */
 #define UI_ABS_SETUP _IOW(UINPUT_IOCTL_BASE, 4, struct uinput_abs_setup)
 
+/* Set clockid to be used for timestamps */
+#define UI_SET_CLOCKID _IOW(UINPUT_IOCTL_BASE, 5, int)
+
 #define UI_SET_EVBIT		_IOW(UINPUT_IOCTL_BASE, 100, int)
 #define UI_SET_KEYBIT		_IOW(UINPUT_IOCTL_BASE, 101, int)
 #define UI_SET_RELBIT		_IOW(UINPUT_IOCTL_BASE, 102, int)
-- 
2.7.4

