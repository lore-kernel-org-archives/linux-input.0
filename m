From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 10:42:00 +0100
Message-ID: <1296121320-8946-1-git-send-email-jacmet@sunsite.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64085 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab1A0JmQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 04:42:16 -0500
Received: by wwa36 with SMTP id 36so1951343wwa.1
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 01:42:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il
Cc: Peter Korsgaard <jacmet@sunsite.dk>

As was recently brought up on the busybox list
(http://lists.busybox.net/pipermail/busybox/2011-January/074565.html),
evdev_write doesn't properly check the count argument, which will
lead to a return value > count on partial writes if the remaining bytes
are accessible - Causing userspace confusion.

Fix it by only handling each full input_event structure, similar to how
it is done in evdev_read.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/input/evdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c8471a2..61fa24e 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -330,7 +330,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 		goto out;
 	}
 
-	while (retval < count) {
+	while ((retval + input_event_size()) <= count) {
 
 		if (input_event_from_user(buffer + retval, &event)) {
 			retval = -EFAULT;
-- 
1.7.2.3

