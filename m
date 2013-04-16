From: =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@bitplanet.net>
Subject: [PATCH RFC] input: Add evdev mute ioctl
Date: Tue, 16 Apr 2013 09:58:17 -0400
Message-ID: <1366120697-25841-1-git-send-email-krh@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:44738 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964878Ab3DPN6Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Apr 2013 09:58:24 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so425542veb.26
        for <linux-input@vger.kernel.org>; Tue, 16 Apr 2013 06:58:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: robert@sixbynine.org, =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@bitplanet.net>

This commit adds a new ioctl to the evdev device: EVIOCMUTE.  The
purpose of this ioctl it to temporarily block event delivery to a
specific evdev client and prevent access to most of the ioctls.

The use case is a setuid helper process for a display server, which
opens input devices and passes the fds to the display server.  On VT
switch away from the server, it should stop reading events from its
evdev input devices.  However, if the display server runs as the user
it can be ptraced or if the server loads user defined modules, the
display server can no longer be trusted to not snoop on the evdev
devices.

The mute ioctl allows the setuid helper to mute evdev devices when
switching away from the VT the server is running on.  The idea is that
the helper listens for the VT switching signals and when VT switch happ=
ens
it notifies the display server, waits for the server to clean up and th=
en
the helper drops drm master (which also requires root), mutes evdev
devices and the acks the VT switch.

Why don't we just use revoke?  The revoke syscall (when it's done) will
work on filenames and shut down all fds open to the device.  This will
break all other processes that listen on evdev devices for legitimate
reasons.  It's the same reason we don't use the EVIOCGRAB ioctl for inp=
ut
devices.  EVIOCMUTE lets the helper mute just the fd it gave to the
display server without affecting anything else potentially using the de=
vice.

Signed-off-by: Kristian H=C3=B8gsberg <krh@bitplanet.net>
---
 drivers/input/evdev.c      | 37 ++++++++++++++++++++++++++++++++++---
 include/uapi/linux/input.h |  1 +
 2 files changed, 35 insertions(+), 3 deletions(-)

This idea comes from work on Wayland and Weston [1], but the setuid hel=
per
should work and is required for a non-root X server to function correct=
ly
as well (ie, do proper vt switching).

Kristian

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index f0f8928..cea6c35 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -48,6 +48,7 @@ struct evdev_client {
 	struct evdev *evdev;
 	struct list_head node;
 	int clkid;
+	int muted;
 	unsigned int bufsize;
 	struct input_event buffer[];
 };
@@ -130,8 +131,9 @@ static void evdev_events(struct input_handle *handl=
e,
 		evdev_pass_values(client, vals, count, time_mono, time_real);
 	else
 		list_for_each_entry_rcu(client, &evdev->client_list, node)
-			evdev_pass_values(client, vals, count,
-					  time_mono, time_real);
+			if (!client->muted)
+				evdev_pass_values(client, vals, count,
+						  time_mono, time_real);
=20
 	rcu_read_unlock();
 }
@@ -674,6 +676,20 @@ static int evdev_handle_mt_request(struct input_de=
v *dev,
 	return 0;
 }
=20
+static int evdev_mute(struct evdev *evdev, struct evdev_client *client=
)
+{
+	client->muted =3D 1;
+
+	return 0;
+}
+
+static int evdev_unmute(struct evdev *evdev, struct evdev_client *clie=
nt)
+{
+	client->muted =3D 0;
+
+	return 0;
+}
+
 static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 			   void __user *p, int compat_mode)
 {
@@ -687,12 +703,27 @@ static long evdev_do_ioctl(struct file *file, uns=
igned int cmd,
 	unsigned int size;
 	int error;
=20
-	/* First we check for fixed-length commands */
+	/* Handle ioctls allowed in muted mode first */
 	switch (cmd) {
+	case EVIOCMUTE:
+		if (!capable(CAP_SYS_ADMIN))
+		    return -EACCES;
+
+		if (p)
+			return evdev_mute(evdev, client);
+		else
+			return evdev_unmute(evdev, client);
=20
 	case EVIOCGVERSION:
 		return put_user(EV_VERSION, ip);
=20
+	default:
+		if (client->muted)
+			return -EACCES;
+	}
+
+	/* Now check for fixed-length commands */
+	switch (cmd) {
 	case EVIOCGID:
 		if (copy_to_user(p, &dev->id, sizeof(struct input_id)))
 			return -EFAULT;
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 935119c..75eda72 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -154,6 +154,7 @@ struct input_keymap_entry {
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
=20
 #define EVIOCSCLOCKID		_IOW('E', 0xa0, int)			/* Set clockid to be use=
d for timestamps */
+#define EVIOCMUTE		_IOW('E', 0xb0, int)			/* Mute event delivery */
=20
 /*
  * Device properties and quirks
--=20
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
