From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Input: evdev - add EVIOCREVOKE ioctl
Date: Tue, 27 Aug 2013 13:25:04 +0200
Message-ID: <1377602704-23301-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:59957 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3H0LZ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Aug 2013 07:25:26 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so2220592eek.11
        for <linux-input@vger.kernel.org>; Tue, 27 Aug 2013 04:25:24 -0700 (PDT)
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
 drivers/input/evdev.c      | 30 +++++++++++++++++++++++++++++-
 include/uapi/linux/input.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index d2b34fb..2ea70ec 100644
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
 
@@ -795,6 +799,15 @@ static int evdev_handle_mt_request(struct input_dev *dev,
 	return 0;
 }
 
+static int evdev_revoke(struct evdev *evdev, struct evdev_client *client,
+			struct file *file)
+{
+	client->revoked = true;
+	input_flush_device(&evdev->handle, file);
+
+	return 0;
+}
+
 static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 			   void __user *p, int compat_mode)
 {
@@ -808,12 +821,27 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 	unsigned int size;
 	int error;
 
-	/* First we check for fixed-length commands */
+	/* First check for ioctls allowed while revoked */
 	switch (cmd) {
 
 	case EVIOCGVERSION:
 		return put_user(EV_VERSION, ip);
 
+	case EVIOCREVOKE:
+		if (p)
+			return -EINVAL;
+		else
+			return evdev_revoke(evdev, client, file);
+
+	default:
+		if (client->revoked)
+			return -EACCES;
+		break;
+	}
+
+	/* Then check for fixed-length commands */
+	switch (cmd) {
+
 	case EVIOCGID:
 		if (copy_to_user(p, &dev->id, sizeof(struct input_id)))
 			return -EFAULT;
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

