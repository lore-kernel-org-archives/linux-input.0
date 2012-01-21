From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH] Input: Add ioctl to block suspend while event queue is not empty.
Date: Fri, 20 Jan 2012 18:24:16 -0800
Message-ID: <1327112659-31145-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64653 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab2AUCYl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jan 2012 21:24:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-pm@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>, Chase Douglas <chase.douglas@canonical.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org

Add an ioctl, EVIOCSSUSPENDBLOCK, to block suspend while the event
queue is not empty. This allows userspace code to process input
events while the device appears to be asleep.

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 drivers/input/evdev.c |   63 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 include/linux/input.h |    3 ++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 76457d5..e212757 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -43,6 +43,7 @@ struct evdev_client {
 	unsigned int tail;
 	unsigned int packet_head; /* [future] position of the first element o=
f next packet */
 	spinlock_t buffer_lock; /* protects access to buffer, head and tail *=
/
+	struct wakeup_source *wakeup_source;
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
@@ -75,10 +76,14 @@ static void evdev_pass_event(struct evdev_client *c=
lient,
 		client->buffer[client->tail].value =3D 0;
=20
 		client->packet_head =3D client->tail;
+		if (client->wakeup_source)
+			__pm_relax(client->wakeup_source);
 	}
=20
 	if (event->type =3D=3D EV_SYN && event->code =3D=3D SYN_REPORT) {
 		client->packet_head =3D client->head;
+		if (client->wakeup_source)
+			__pm_stay_awake(client->wakeup_source);
 		kill_fasync(&client->fasync, SIGIO, POLL_IN);
 	}
=20
@@ -255,6 +260,10 @@ static int evdev_release(struct inode *inode, stru=
ct file *file)
 	mutex_unlock(&evdev->mutex);
=20
 	evdev_detach_client(evdev, client);
+	if (client->wakeup_source) {
+		__pm_relax(client->wakeup_source);
+		wakeup_source_unregister(client->wakeup_source);
+	}
 	kfree(client);
=20
 	evdev_close_device(evdev);
@@ -373,6 +382,9 @@ static int evdev_fetch_next_event(struct evdev_clie=
nt *client,
 	if (have_event) {
 		*event =3D client->buffer[client->tail++];
 		client->tail &=3D client->bufsize - 1;
+		if (client->wakeup_source &&
+		    client->packet_head =3D=3D client->tail)
+			__pm_relax(client->wakeup_source);
 	}
=20
 	spin_unlock_irq(&client->buffer_lock);
@@ -623,6 +635,48 @@ static int evdev_handle_set_keycode_v2(struct inpu=
t_dev *dev, void __user *p)
 	return input_set_keycode(dev, &ke);
 }
=20
+static int evdev_enable_suspend_block(struct evdev *evdev,
+				      struct evdev_client *client)
+{
+	struct wakeup_source *ws;
+	char name[28];
+
+	if (client->wakeup_source)
+		return 0;
+
+	snprintf(name, sizeof(name), "%s-%d",
+		 dev_name(&evdev->dev), task_tgid_vnr(current));
+
+	ws =3D wakeup_source_register(name);
+	if (!ws)
+		return -ENOMEM;
+
+	spin_lock_irq(&client->buffer_lock);
+	client->wakeup_source =3D ws;
+	if (client->packet_head !=3D client->tail)
+		__pm_stay_awake(client->wakeup_source);
+	spin_unlock_irq(&client->buffer_lock);
+	return 0;
+}
+
+static int evdev_disable_suspend_block(struct evdev *evdev,
+				       struct evdev_client *client)
+{
+	struct wakeup_source *ws;
+
+	spin_lock_irq(&client->buffer_lock);
+	ws =3D client->wakeup_source;
+	client->wakeup_source =3D NULL;
+	spin_unlock_irq(&client->buffer_lock);
+
+	if (ws) {
+		__pm_relax(ws);
+		wakeup_source_unregister(ws);
+	}
+
+	return 0;
+}
+
 static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 			   void __user *p, int compat_mode)
 {
@@ -696,6 +750,15 @@ static long evdev_do_ioctl(struct file *file, unsi=
gned int cmd,
=20
 	case EVIOCSKEYCODE_V2:
 		return evdev_handle_set_keycode_v2(dev, p);
+
+	case EVIOCGSUSPENDBLOCK:
+		return put_user(!!client->wakeup_source, ip);
+
+	case EVIOCSSUSPENDBLOCK:
+		if (p)
+			return evdev_enable_suspend_block(evdev, client);
+		else
+			return evdev_disable_suspend_block(evdev, client);
 	}
=20
 	size =3D _IOC_SIZE(cmd);
diff --git a/include/linux/input.h b/include/linux/input.h
index 3862e32..daf0177 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -129,6 +129,9 @@ struct input_keymap_entry {
=20
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
=20
+#define EVIOCGSUSPENDBLOCK	_IOR('E', 0x91, int)			/* get suspend block=
 enable */
+#define EVIOCSSUSPENDBLOCK	_IOW('E', 0x91, int)			/* set suspend block=
 enable */
+
 /*
  * Device properties and quirks
  */
--=20
1.7.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
