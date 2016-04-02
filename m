From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: hidraw: silence an uninitialized variable warning
Date: Sat, 2 Apr 2016 07:45:01 +0300
Message-ID: <20160402044501.GB11775@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

My static checker complains that "devid" can be uninitialized if
alloc_chrdev_region() fails.  Fix this by moving the error hanling
forward a couple lines.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index b9a76e3..f0e2757 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -582,14 +582,13 @@ int __init hidraw_init(void)
 
 	result = alloc_chrdev_region(&dev_id, HIDRAW_FIRST_MINOR,
 			HIDRAW_MAX_DEVICES, "hidraw");
-
-	hidraw_major = MAJOR(dev_id);
-
 	if (result < 0) {
 		pr_warn("can't get major number\n");
 		goto out;
 	}
 
+	hidraw_major = MAJOR(dev_id);
+
 	hidraw_class = class_create(THIS_MODULE, "hidraw");
 	if (IS_ERR(hidraw_class)) {
 		result = PTR_ERR(hidraw_class);
