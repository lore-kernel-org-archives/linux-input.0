From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Input: evdev - Use EBADFD for flush() errors
Date: Wed, 19 Aug 2015 09:38:15 +0200
Message-ID: <1439969895-26163-1-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52065 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbbHSHiW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 03:38:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-input@vger.kernel.org

We've got bug reports showing the old systemd-logind (at least
system-210) aborting unexpectedly, and this turned out to be because
of an invalid error code from close() call to evdev devices.  close()
is supposed to return only either EINTR or EBADFD, while the device
returned ENODEV.  logind was overreacting to it and decided to kill
itself when an unexpected error code was received.  What a tragedy.

The bad error code comes from flush fops, and actually evdev_flush()
returns -ENODEV and else.  This patch papers over it, simply fixing
the error return code to the acceptable values above.

Bugzilla: http://bugzilla.suse.com/show_bug.cgi?id=939834
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/input/evdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 9d35499faca4..28e9efd837e1 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -302,7 +302,7 @@ static int evdev_flush(struct file *file, fl_owner_t id)
 		retval = input_flush_device(&evdev->handle, file);
 
 	mutex_unlock(&evdev->mutex);
-	return retval;
+	return retval < 0 ? -EBADFD : 0;
 }
 
 static void evdev_free(struct device *dev)
-- 
2.5.0

