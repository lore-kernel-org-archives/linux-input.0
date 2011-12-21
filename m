From: john stultz <johnstul@us.ibm.com>
Subject: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Tue, 20 Dec 2011 17:01:43 -0800
Message-ID: <1324429303.30527.92.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:48957 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab1LUBCY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 20:02:24 -0500
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <johnstul@us.ibm.com>;
	Tue, 20 Dec 2011 18:02:23 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBL11iWr121116
	for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 18:01:45 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBL11iio026852
	for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 18:01:44 -0700
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

Hi
	In reviewing the Android patch set, I noticed the following patch from
Arve which looks like it resolves a reasonable issue (events using
CLOCK_REALTIME timestamps, which can jump forwards or backwards via
settimeofday()).

I'm not very familiar with the evdev interface, so I'm not sure if
changing the timestamps to CLOCK_MONOTONIC could cause an ABI problem
with legacy apps. Even so, I wanted to send the patch out for review an=
d
consideration as it seems like a reasonable fix.

thanks
-john



=46rom 20950b728f120cd808965c1a20b024aa79706d8d Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?=3D3D=3D3FUTF-8=3D3Fq=3D3FArve=3D3D20Hj=3D3DC3=3D3D=
B8nnev=3D3DC3=3D3DA5g=3D3F=3D3D?=3D <arve@android.com>
Date: Fri, 2 Dec 2011 13:59:05 +0800
Subject: [PATCH] Input: Use monotonic time for event time stamps.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Since wall time can jump backwards, it cannot be used to determine if o=
ne
event occured before another or for how long a key was pressed.

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/input/evdev.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 4cf2534..ec329b4 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -94,8 +94,11 @@ static void evdev_event(struct input_handle *handle,
 	struct evdev *evdev =3D handle->private;
 	struct evdev_client *client;
 	struct input_event event;
+	struct timespec ts;
=20
-	do_gettimeofday(&event.time);
+	ktime_get_ts(&ts);
+	event.time.tv_sec =3D ts.tv_sec;
+	event.time.tv_usec =3D ts.tv_nsec / NSEC_PER_USEC;
 	event.type =3D type;
 	event.code =3D code;
 	event.value =3D value;
--=20
1.7.3.2.146.gca209



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
