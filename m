From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH] Input: Add infrastrucutre for selecting clockid for event time stamps.
Date: Mon,  9 Jan 2012 15:21:12 -0800
Message-ID: <1326151272-29507-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:57441 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209Ab2AIXWW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 18:22:22 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <jstultz@us.ibm.com>;
	Mon, 9 Jan 2012 16:22:21 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q09NLUxX142230
	for <linux-input@vger.kernel.org>; Mon, 9 Jan 2012 16:21:31 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q09NLS7o022686
	for <linux-input@vger.kernel.org>; Mon, 9 Jan 2012 16:21:30 -0700
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: John Stultz <john.stultz@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@google.com>, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Brian Swetland <swetland@google.com>, Colin Cross <ccross@android.com>, Dima Zavin <dima@android.com>

Ok. Now that Android and ChromeOS folks have commented on it,
I wanted to go ahead and submit this for inclusion.

The only change from the previous version is that it includes
Danial's suggested ktime_to_timeval() simplificiation.

Let me know if there are any other thoughts/comments.

thanks
-john


As noted by Arve and others, since wall time can jump backwards, it
is difficult to use for input because one cannot determine if one
event occured before another or for how long a key was pressed.

However, the timestamp field is part of the kernel ABI, and cannot
be changed without possibly breaking existing users.

This patch adds a new IOCTL that allows a clockid to be set in
the evdev_client struct that will specify which time base to
use for event timestamps (ie: CLOCK_MONOTONIC instead
of CLOCK_REALTIME).

=46or now we only support CLOCK_MONOTONIC and CLOCK_REALTIME, but
in the future we could support other clockids if appropriate.

The default remains CLOCK_REALTIME, so we don't change the ABI.

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Daniel Kurtz <djkurtz@google.com>
CC: linux-input@vger.kernel.org
CC: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
CC: Brian Swetland <swetland@google.com>
CC: Colin Cross <ccross@android.com>
CC: Dima Zavin <dima@android.com>
Reviewed-by: Daniel Kurtz <djkurtz@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/input/evdev.c |   30 ++++++++++++++++++++++++++----
 include/linux/input.h |    2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 4cf2534..de8f8f1 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -46,6 +46,7 @@ struct evdev_client {
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
+	int timestamp_clkid;
 	unsigned int bufsize;
 	struct input_event buffer[];
 };
@@ -54,8 +55,16 @@ static struct evdev *evdev_table[EVDEV_MINORS];
 static DEFINE_MUTEX(evdev_table_mutex);
=20
 static void evdev_pass_event(struct evdev_client *client,
-			     struct input_event *event)
+			     struct input_event *event,
+			     ktime_t mono, ktime_t real)
 {
+	struct timespec ts;
+
+	if (client->timestamp_clkid =3D=3D CLOCK_MONOTONIC)
+		event->time =3D ktime_to_timeval(mono);
+	else
+		event->time =3D ktime_to_timeval(real);
+
 	/* Interrupts are disabled, just acquire the lock. */
 	spin_lock(&client->buffer_lock);
=20
@@ -94,8 +103,11 @@ static void evdev_event(struct input_handle *handle=
,
 	struct evdev *evdev =3D handle->private;
 	struct evdev_client *client;
 	struct input_event event;
+	ktime_t time_mono, time_real;
+
+	time_mono =3D ktime_get();
+	time_real =3D ktime_sub(time_mono, ktime_get_monotonic_offset());
=20
-	do_gettimeofday(&event.time);
 	event.type =3D type;
 	event.code =3D code;
 	event.value =3D value;
@@ -103,11 +115,12 @@ static void evdev_event(struct input_handle *hand=
le,
 	rcu_read_lock();
=20
 	client =3D rcu_dereference(evdev->grab);
+
 	if (client)
-		evdev_pass_event(client, &event);
+		evdev_pass_event(client, &event, time_mono, time_real);
 	else
 		list_for_each_entry_rcu(client, &evdev->client_list, node)
-			evdev_pass_event(client, &event);
+			evdev_pass_event(client, &event, time_mono, time_real);
=20
 	rcu_read_unlock();
=20
@@ -683,6 +696,15 @@ static long evdev_do_ioctl(struct file *file, unsi=
gned int cmd,
 		else
 			return evdev_ungrab(evdev, client);
=20
+	case EVIOCCLOCKID:
+		if (copy_from_user(&i, p, sizeof(unsigned int)))
+			return -EFAULT;
+		if ((i =3D=3D CLOCK_MONOTONIC) || (i =3D=3D CLOCK_REALTIME)) {
+			client->timestamp_clkid =3D i;
+			return 0;
+		}
+		return -EINVAL;
+
 	case EVIOCGKEYCODE:
 		return evdev_handle_get_keycode(dev, p);
=20
diff --git a/include/linux/input.h b/include/linux/input.h
index 3862e32..9618e14 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -129,6 +129,8 @@ struct input_keymap_entry {
=20
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
=20
+#define EVIOCCLOCKID		_IOW('E', 0xA0, int)			/* Set clockid to be used=
 for timestamps */
+
 /*
  * Device properties and quirks
  */
--=20
1.7.3.2.146.gca209

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
