From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 7/8] Input: Block suspend while event queue is not empty.
Date: Fri, 21 May 2010 15:46:54 -0700
Message-ID: <1274482015-30899-8-git-send-email-arve@android.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
 <1274482015-30899-2-git-send-email-arve@android.com>
 <1274482015-30899-3-git-send-email-arve@android.com>
 <1274482015-30899-4-git-send-email-arve@android.com>
 <1274482015-30899-5-git-send-email-arve@android.com>
 <1274482015-30899-6-git-send-email-arve@android.com>
 <1274482015-30899-7-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274482015-30899-7-git-send-email-arve@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?q?M=C3=A1rton=20N=C3=A9meth?= <nm127@freemail.hu>, Sven Neumann <s.neumann@raumfeld.com>, Tero Saarni <tero.saarni@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that will=
 block
suspend while the event queue is not empty. This allows userspace code =
to
process input events while the device appears to be asleep.

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 drivers/input/evdev.c |   22 ++++++++++++++++++++++
 include/linux/input.h |    3 +++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 2ee6c7a..bff2247 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -20,6 +20,7 @@
 #include <linux/input.h>
 #include <linux/major.h>
 #include <linux/device.h>
+#include <linux/suspend.h>
 #include "input-compat.h"
=20
 struct evdev {
@@ -43,6 +44,8 @@ struct evdev_client {
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
+	struct suspend_blocker suspend_blocker;
+	bool use_suspend_blocker;
 };
=20
 static struct evdev *evdev_table[EVDEV_MINORS];
@@ -55,6 +58,8 @@ static void evdev_pass_event(struct evdev_client *cli=
ent,
 	 * Interrupts are disabled, just acquire the lock
 	 */
 	spin_lock(&client->buffer_lock);
+	if (client->use_suspend_blocker)
+		suspend_block(&client->suspend_blocker);
 	client->buffer[client->head++] =3D *event;
 	client->head &=3D EVDEV_BUFFER_SIZE - 1;
 	spin_unlock(&client->buffer_lock);
@@ -234,6 +239,8 @@ static int evdev_release(struct inode *inode, struc=
t file *file)
 	mutex_unlock(&evdev->mutex);
=20
 	evdev_detach_client(evdev, client);
+	if (client->use_suspend_blocker)
+		suspend_blocker_unregister(&client->suspend_blocker);
 	kfree(client);
=20
 	evdev_close_device(evdev);
@@ -335,6 +342,8 @@ static int evdev_fetch_next_event(struct evdev_clie=
nt *client,
 	if (have_event) {
 		*event =3D client->buffer[client->tail++];
 		client->tail &=3D EVDEV_BUFFER_SIZE - 1;
+		if (client->use_suspend_blocker && client->head =3D=3D client->tail)
+			suspend_unblock(&client->suspend_blocker);
 	}
=20
 	spin_unlock_irq(&client->buffer_lock);
@@ -585,6 +594,19 @@ static long evdev_do_ioctl(struct file *file, unsi=
gned int cmd,
 		else
 			return evdev_ungrab(evdev, client);
=20
+	case EVIOCGSUSPENDBLOCK:
+		return put_user(client->use_suspend_blocker, ip);
+
+	case EVIOCSSUSPENDBLOCK:
+		spin_lock_irq(&client->buffer_lock);
+		if (!client->use_suspend_blocker && p)
+			suspend_blocker_init(&client->suspend_blocker, "evdev");
+		else if (client->use_suspend_blocker && !p)
+			suspend_blocker_unregister(&client->suspend_blocker);
+		client->use_suspend_blocker =3D !!p;
+		spin_unlock_irq(&client->buffer_lock);
+		return 0;
+
 	default:
=20
 		if (_IOC_TYPE(cmd) !=3D 'E')
diff --git a/include/linux/input.h b/include/linux/input.h
index 7ed2251..b2d93b4 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -82,6 +82,9 @@ struct input_absinfo {
=20
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
=20
+#define EVIOCGSUSPENDBLOCK	_IOR('E', 0x91, int)			/* get suspend block=
 enable */
+#define EVIOCSSUSPENDBLOCK	_IOW('E', 0x91, int)			/* set suspend block=
 enable */
+
 /*
  * Event types
  */
--=20
1.6.5.1
