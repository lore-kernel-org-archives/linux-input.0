From: Michael Rissi <michael.rissi@gmail.com>
Subject: [PATCH] HID: roccat: check cdev_add return values
Date: Fri, 14 Jun 2013 17:16:37 +0200
Message-ID: <1371222997-4933-1-git-send-email-michael.rissi@dectris.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46420 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab3FNPQv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Jun 2013 11:16:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Rissi <michael.rissi@dectris.com>

Return value of cdev_add in hid_roccat.c init was not checked.

Signed-off-by: Michael Rissi <michael.rissi@dectris.com>
---
 drivers/hid/hid-roccat.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index b59b3df..65c4ccfc 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -366,7 +366,7 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	devices[minor] = NULL;
 	mutex_unlock(&devices_lock);
-	
+
 	if (device->open) {
 		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
@@ -426,13 +426,23 @@ static int __init roccat_init(void)
 
 	if (retval < 0) {
 		pr_warn("can't get major number\n");
-		return retval;
+		goto error;
 	}
 
 	cdev_init(&roccat_cdev, &roccat_ops);
-	cdev_add(&roccat_cdev, dev_id, ROCCAT_MAX_DEVICES);
+	retval = cdev_add(&roccat_cdev, dev_id, ROCCAT_MAX_DEVICES);
 
+	if (retval < 0) {
+		pr_warn("cannot add cdev\n");
+		goto cleanup_alloc_chrdev_region;
+	}
 	return 0;
+
+
+ cleanup_alloc_chrdev_region:
+	unregister_chrdev_region(dev_id, ROCCAT_MAX_DEVICES);
+ error:
+	return retval;
 }
 
 static void __exit roccat_exit(void)
-- 
1.7.9.5

