From: Ryan Mallon <rmallon@gmail.com>
Subject: [PATCH 1/2] input: Return the number of bytes written so far on evdev write failure
Date: Wed, 18 Sep 2013 08:55:43 +1000
Message-ID: <1379458544-6508-1-git-send-email-rmallon@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:56646 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3IQWzx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Sep 2013 18:55:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se
Cc: carl@ok-labs.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ryan Mallon <rmallon@gmail.com>

If input_event_from_user() fails in evdev write() and at least one
event has been written successfully then return the number of bytes
written. If no events have been written, then the EFAULT error is
returned.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 drivers/input/evdev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index d2b34fb..b0dec2ba 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -437,7 +437,8 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 	while (retval + input_event_size() <= count) {
 
 		if (input_event_from_user(buffer + retval, &event)) {
-			retval = -EFAULT;
+			if (retval == 0)
+				retval = -EFAULT;
 			goto out;
 		}
 		retval += input_event_size();
-- 
1.7.9.7

