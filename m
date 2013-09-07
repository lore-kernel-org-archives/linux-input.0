From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4] Input: evdev - add EVIOCREVOKE ioctl
Date: Sat,  7 Sep 2013 13:00:53 +0200
Message-ID: <1378551653-805-1-git-send-email-dh.herrmann@gmail.com>
References: <1378044450-8327-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:44115 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab3IGLB3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Sep 2013 07:01:29 -0400
Received: by mail-bk0-f45.google.com with SMTP id mx11so1629789bkb.4
        for <linux-input@vger.kernel.org>; Sat, 07 Sep 2013 04:01:27 -0700 (PDT)
In-Reply-To: <1378044450-8327-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <hoegsberg@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

If we have multiple sessions on a system, we normally don't want
background sessions to read input events. Otherwise, it could capture
passwords and more entered by the user on the foreground session. This is
a real world problem as the recent XMir development showed:
  http://mjg59.dreamwidth.org/27327.html

We currently rely on sessions to release input devices when being
deactivated. This relies on trust across sessions. But that's not given on
usual systems. We therefore need a way to control which processes have
access to input devices.

With VTs the kernel simply routed them through the active /dev/ttyX. This
is not possible with evdev devices, though. Moreover, we want to avoid
routing input-devices through some dispatcher-daemon in userspace (which
would add some latency).

This patch introduces EVIOCREVOKE. If called on an evdev fd, this revokes
device-access irrecoverably for that *single* open-file. Hence, once you
call EVIOCREVOKE on any dup()ed fd, all fds for that open-file will be
rather useless now (but still valid compared to close()!). This allows us
to pass fds directly to session-processes from a trusted source. The
source keeps a dup()ed fd and revokes access once the session-process is
no longer active.
Compared to the EVIOCMUTE proposal, we can avoid the CAP_SYS_ADMIN
restriction now as there is no way to revive the fd again. Hence, a user
is free to call EVIOCREVOKE themself to kill the fd.

Additionally, this ioctl allows multi-layer access-control (again compared
to EVIOCMUTE which was limited to one layer via CAP_SYS_ADMIN). A middle
layer can simply request a new open-file from the layer above and pass it
to the layer below. Now each layer can call EVIOCREVOKE on the fds to
revoke access for all layers below, at the expense of one fd per layer.

There's already ongoing experimental user-space work which demonstrates
how it can be used:
  http://lists.freedesktop.org/archives/systemd-devel/2013-August/012897.html

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi Dmitry

Given the recent ABS_*-regression, I wrote a bunch of more aggressive
stress-tests for this. I didn't found any regressions if EVIOCREVOKE is not
used, but one with revoke on an empty queue in evdev_read(). Now fixed. Please
let me know what your plans for this patch are (-next or -rc1?) so we can
schedule accordingly. As a side note, will you attend LPC this year? We have a
bunch of fancy stuff I'd like your opinion on (including
device-properties, device-detection, ABS_* bit extension).

Thanks and cheers
David

 drivers/input/evdev.c      | 37 +++++++++++++++++++++++++++++++------
 include/uapi/linux/input.h |  1 +
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index d2b34fb..b6ded17 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -48,6 +48,7 @@ struct evdev_client {
 	struct evdev *evdev;
 	struct list_head node;
 	int clkid;
+	bool revoked;
 	unsigned int bufsize;
 	struct input_event buffer[];
 };
@@ -164,6 +165,9 @@ static void evdev_pass_values(struct evdev_client *client,
 	struct input_event event;
 	bool wakeup = false;
 
+	if (client->revoked)
+		return;
+
 	event.time = ktime_to_timeval(client->clkid == CLOCK_MONOTONIC ?
 				      mono : real);
 
@@ -240,7 +244,7 @@ static int evdev_flush(struct file *file, fl_owner_t id)
 	if (retval)
 		return retval;
 
-	if (!evdev->exist)
+	if (!evdev->exist || client->revoked)
 		retval = -ENODEV;
 	else
 		retval = input_flush_device(&evdev->handle, file);
@@ -429,7 +433,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 	if (retval)
 		return retval;
 
-	if (!evdev->exist) {
+	if (!evdev->exist || client->revoked) {
 		retval = -ENODEV;
 		goto out;
 	}
@@ -482,7 +486,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 		return -EINVAL;
 
 	for (;;) {
-		if (!evdev->exist)
+		if (!evdev->exist || client->revoked)
 			return -ENODEV;
 
 		if (client->packet_head == client->tail &&
@@ -511,7 +515,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 		if (!(file->f_flags & O_NONBLOCK)) {
 			error = wait_event_interruptible(evdev->wait,
 					client->packet_head != client->tail ||
-					!evdev->exist);
+					!evdev->exist || client->revoked);
 			if (error)
 				return error;
 		}
@@ -529,7 +533,11 @@ static unsigned int evdev_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &evdev->wait, wait);
 
-	mask = evdev->exist ? POLLOUT | POLLWRNORM : POLLHUP | POLLERR;
+	if (evdev->exist && !client->revoked)
+		mask = POLLOUT | POLLWRNORM;
+	else
+		mask = POLLHUP | POLLERR;
+
 	if (client->packet_head != client->tail)
 		mask |= POLLIN | POLLRDNORM;
 
@@ -795,6 +803,17 @@ static int evdev_handle_mt_request(struct input_dev *dev,
 	return 0;
 }
 
+static int evdev_revoke(struct evdev *evdev, struct evdev_client *client,
+			struct file *file)
+{
+	client->revoked = true;
+	evdev_ungrab(evdev, client);
+	input_flush_device(&evdev->handle, file);
+	wake_up_interruptible(&evdev->wait);
+
+	return 0;
+}
+
 static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 			   void __user *p, int compat_mode)
 {
@@ -857,6 +876,12 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		else
 			return evdev_ungrab(evdev, client);
 
+	case EVIOCREVOKE:
+		if (p)
+			return -EINVAL;
+		else
+			return evdev_revoke(evdev, client, file);
+
 	case EVIOCSCLOCKID:
 		if (copy_from_user(&i, p, sizeof(unsigned int)))
 			return -EFAULT;
@@ -1002,7 +1027,7 @@ static long evdev_ioctl_handler(struct file *file, unsigned int cmd,
 	if (retval)
 		return retval;
 
-	if (!evdev->exist) {
+	if (!evdev->exist || client->revoked) {
 		retval = -ENODEV;
 		goto out;
 	}
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 2fb6fae..d61c61c 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -152,6 +152,7 @@ struct input_keymap_entry {
 #define EVIOCGEFFECTS		_IOR('E', 0x84, int)			/* Report number of effects playable at the same time */
 
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
+#define EVIOCREVOKE		_IOW('E', 0x91, int)			/* Revoke device access */
 
 #define EVIOCSCLOCKID		_IOW('E', 0xa0, int)			/* Set clockid to be used for timestamps */
 
-- 
1.8.4

