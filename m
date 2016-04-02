From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: roccat: silence an uninitialized variable warning
Date: Sat, 2 Apr 2016 07:44:32 +0300
Message-ID: <20160402044432.GA11775@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37879 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcDBEoy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Apr 2016 00:44:54 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

My static checker complains because we use "dev_id" before we check for
errors so it could be uninitialized.  Fix this by moving the error
handling forward a couple lines.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 65c4ccfc..76d06cf 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -421,14 +421,13 @@ static int __init roccat_init(void)
 
 	retval = alloc_chrdev_region(&dev_id, ROCCAT_FIRST_MINOR,
 			ROCCAT_MAX_DEVICES, "roccat");
-
-	roccat_major = MAJOR(dev_id);
-
 	if (retval < 0) {
 		pr_warn("can't get major number\n");
 		goto error;
 	}
 
+	roccat_major = MAJOR(dev_id);
+
 	cdev_init(&roccat_cdev, &roccat_ops);
 	retval = cdev_add(&roccat_cdev, dev_id, ROCCAT_MAX_DEVICES);
 
