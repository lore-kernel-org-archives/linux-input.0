From: Yongtaek Lee <ytk.lee@samsung.com>
Subject: [PATCH] Input: evdev - Fix incorrect kfree of err_free_client after
 vzalloc
Date: Mon, 23 Jun 2014 10:12:19 +0900
Message-ID: <1403485939-2166-1-git-send-email-ytk.lee@samsung.com>
References: <CANq1E4T3v9DPnj8z7B3Qj0NT98M648r+KDWT7Os4SpbCjNxQ8A@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30174 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbaFWBMw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Jun 2014 21:12:52 -0400
In-reply-to: <CANq1E4T3v9DPnj8z7B3Qj0NT98M648r+KDWT7Os4SpbCjNxQ8A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, dmitry.torokhov@gmail.com, daniels@collabora.com, rientjes@google.com, dh.herrmann@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yongtaek Lee <ytk.lee@samsung.com>

This bug was introduced by commit 92eb77d ("Input: evdev - fall back
to vmalloc for client event buffer").

vzalloc is used to alloc memory as fallback in case of failure
of kzalloc. But err_free_client was not considered on below case.
1. kzalloc fail
2. vzalloc success
3. evdev_open_device fail
4. kfree

So that address checking is needed to call correct free function.

Signed-off-by: Yongtaek Lee <ytk.lee@samsung.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 drivers/input/evdev.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index ce953d8..f60daa0 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -422,7 +422,10 @@ static int evdev_open(struct inode *inode, struct file *file)
 
  err_free_client:
 	evdev_detach_client(evdev, client);
-	kfree(client);
+	if (is_vmalloc_addr(client))
+		vfree(client);
+	else
+		kfree(client);
 	return error;
 }
 
-- 
1.7.1

