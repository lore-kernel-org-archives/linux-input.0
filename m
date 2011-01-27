From: Alan Ott <alan@signal11.us>
Subject: [PATCH 1/1] hidraw: Replace Confusing += Operator with =
Date: Wed, 26 Jan 2011 22:25:18 -0500
Message-ID: <1296098718-6964-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:58533 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab1A0DZV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Jan 2011 22:25:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id AE6131CCABB3
	for <linux-input@vger.kernel.org>; Wed, 26 Jan 2011 22:25:20 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>

Setting of the return value of hidraw_read() uses the += operator when
= is more appropriate.  There is no case where ret can be anything
other than zero when the assignment is made, making = equivalent to
+= and much more clear.

Signed-off-by: Alan Ott <alan@signal11.us>
---
 drivers/hid/hidraw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 468e87b..66fbcba 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -91,7 +91,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 			ret = -EFAULT;
 			goto out;
 		}
-		ret += len;
+		ret = len;
 
 		kfree(list->buffer[list->tail].value);
 		list->tail = (list->tail + 1) & (HIDRAW_BUFFER_SIZE - 1);
-- 
1.7.0.4


