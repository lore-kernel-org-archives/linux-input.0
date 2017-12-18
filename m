From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v5 1/3] uinput: Use monotonic times for uinput timestamps.
Date: Sun, 17 Dec 2017 21:18:42 -0800
Message-ID: <20171218051844.10193-2-deepa.kernel@gmail.com>
References: <20171218051844.10193-1-deepa.kernel@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40384 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757884AbdLRFTb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Dec 2017 00:19:31 -0500
In-Reply-To: <20171218051844.10193-1-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peter.hutterer@who-t.net, arnd@arndb.de, y2038@lists.linaro.org

struct timeval which is part of struct input_event to
maintain the event times is not y2038 safe.

Real time timestamps are also not ideal for input_event
as this time can go backwards as noted in the patch
a80b83b7b8 by John Stultz.

The patch switches the timestamps to use monotonic time
from realtime time. This is assuming no one is using
absolute times from these timestamps.

The structure to maintain input events will be changed
in a different patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/misc/uinput.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 91df0df15e68..9251765645d1 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -84,11 +84,14 @@ static int uinput_dev_event(struct input_dev *dev,
 			    unsigned int type, unsigned int code, int value)
 {
 	struct uinput_device	*udev = input_get_drvdata(dev);
+	struct timespec64	ts;
 
 	udev->buff[udev->head].type = type;
 	udev->buff[udev->head].code = code;
 	udev->buff[udev->head].value = value;
-	do_gettimeofday(&udev->buff[udev->head].time);
+	ktime_get_ts64(&ts);
+	udev->buff[udev->head].time.tv_sec = ts.tv_sec;
+	udev->buff[udev->head].time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 
 	wake_up_interruptible(&udev->waitq);
-- 
2.14.1

