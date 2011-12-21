From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Tue, 20 Dec 2011 19:12:44 -0800
Message-ID: <1324437164.30527.107.camel@work-vm>
References: <1324429303.30527.92.camel@work-vm>
	 <4EF1395E.405@cn.fujitsu.com>
	 <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40491 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1LUDMu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 22:12:50 -0500
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <johnstul@us.ibm.com>;
	Tue, 20 Dec 2011 22:12:50 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBL3CmuO323620
	for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 22:12:48 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBL3Cloe030591
	for <linux-input@vger.kernel.org>; Wed, 21 Dec 2011 01:12:48 -0200
In-Reply-To: <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: gaowanlong@cn.fujitsu.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

On Wed, 2011-12-21 at 10:11 +0800, Daniel Kurtz wrote:
> On Wed, Dec 21, 2011 at 9:41 AM, Wanlong Gao <gaowanlong@cn.fujitsu.c=
om> wrote:
> > On 12/21/2011 09:01 AM, john stultz wrote:
> >
> >> Hi
> >>       In reviewing the Android patch set, I noticed the following =
patch from
> >> Arve which looks like it resolves a reasonable issue (events using
> >> CLOCK_REALTIME timestamps, which can jump forwards or backwards vi=
a
> >> settimeofday()).
> >>
> >> I'm not very familiar with the evdev interface, so I'm not sure if
> >> changing the timestamps to CLOCK_MONOTONIC could cause an ABI prob=
lem
> >> with legacy apps. Even so, I wanted to send the patch out for revi=
ew and
> >> consideration as it seems like a reasonable fix.
>=20
> Maybe you will have more luck this time.  You can read the previous
> thread on this exact topic, here:
> https://lkml.org/lkml/2011/10/3/37
>=20
> The previous attempt got bogged down when people wanted more data on
> use cases and how this patch would promote world peace.  I strongly
> support the concept, but we found other ways to address our major
> concern at the time, so didn't invest more effort to get that patch
> accepted.

Would something more like the following be an acceptable solution?=20

NOTE: This is completely untested and off the cuff (all I know is it
builds). Just wanted to post it here to get some feedback and I'll try
to clean it up and make sure it actually works tomorrow if folks like
it.

Arve: Do you think having an IOCTL switch to set the evdev to monotonic
time would be acceptable for Android?=20

thanks
-john



As noted by Arve and others, since wall time can jump backwards, it
is difficult to use for input because one cannot determine if one
event occurred before another or for how long a key was pressed.

However, the timestamp field is part of the kernel ABI, and cannot
be changed without possibly breaking existing users.

This patch adds a new IOCTL that sets a flag in the evdev_client
struct that will switch the timestamps to CLOCK_MONOTONIC instead
of CLOCK_REALTIME. This allows users of the evdev to specify
which clock id they want the timestamps to use.

The default remains CLOCK_REALTIME.

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@vger.kernel.org
CC: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/input/evdev.c |   21 ++++++++++++++++++++-
 include/linux/input.h |    2 ++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 4cf2534..9069fab 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -46,6 +46,7 @@ struct evdev_client {
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
+	bool use_monotonic;
 	unsigned int bufsize;
 	struct input_event buffer[];
 };
@@ -94,8 +95,12 @@ static void evdev_event(struct input_handle *handle,
 	struct evdev *evdev =3D handle->private;
 	struct evdev_client *client;
 	struct input_event event;
+	ktime_t time_mono, time_real;
+	struct timespec ts;
+
+	time_mono =3D ktime_get();
+	time_real =3D ktime_sub(time_mono, ktime_get_monotonic_offset());
=20
-	do_gettimeofday(&event.time);
 	event.type =3D type;
 	event.code =3D code;
 	event.value =3D value;
@@ -103,6 +108,14 @@ static void evdev_event(struct input_handle *handl=
e,
 	rcu_read_lock();
=20
 	client =3D rcu_dereference(evdev->grab);
+
+	if (client->use_monotonic)
+		ts =3D ktime_to_timespec(time_mono);
+	else
+		ts =3D ktime_to_timespec(time_real);
+	event.time.tv_sec =3D ts.tv_sec;
+	event.time.tv_usec =3D ts.tv_nsec / NSEC_PER_USEC;
+
 	if (client)
 		evdev_pass_event(client, &event);
 	else
@@ -683,6 +696,12 @@ static long evdev_do_ioctl(struct file *file, unsi=
gned int cmd,
 		else
 			return evdev_ungrab(evdev, client);
=20
+	case EVIOCMONTIME:
+		if (copy_from_user(&i, p, sizeof(unsigned int)))
+			return -EFAULT;
+		client->use_monotonic =3D i;
+		return 0;
+
 	case EVIOCGKEYCODE:
 		return evdev_handle_get_keycode(dev, p);
=20
diff --git a/include/linux/input.h b/include/linux/input.h
index 3862e32..245bfcc 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -129,6 +129,8 @@ struct input_keymap_entry {
=20
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
=20
+#define EVIOCMONTIME		_IOW('E', 0xA0, int)			/* Set CLOCK_MONOTONIC Ti=
mestamps */
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
