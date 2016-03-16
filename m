From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: hidraw: switch to using memdup_user
Date: Wed, 16 Mar 2016 16:59:38 -0700
Message-ID: <20160316235938.GA23827@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35897 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935267AbcCPX7n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 19:59:43 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of open-coding memory allocation and copying form user memory
sequence let's use memdup_user().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hidraw.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 9c2d7c2..b9a76e3 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -34,6 +34,7 @@
 #include <linux/hid.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
+#include <linux/string.h>
 
 #include <linux/hidraw.h>
 
@@ -123,7 +124,6 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 
 	dev = hidraw_table[minor]->hid;
 
-
 	if (count > HID_MAX_BUFFER_SIZE) {
 		hid_warn(dev, "pid %d passed too large report\n",
 			 task_pid_nr(current));
@@ -138,17 +138,12 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 		goto out;
 	}
 
-	buf = kmalloc(count * sizeof(__u8), GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
+	buf = memdup_user(buffer, count);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
 		goto out;
 	}
 
-	if (copy_from_user(buf, buffer, count)) {
-		ret = -EFAULT;
-		goto out_free;
-	}
-
 	if ((report_type == HID_OUTPUT_REPORT) &&
 	    !(dev->quirks & HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP)) {
 		ret = hid_hw_output_report(dev, buf, count);
-- 
2.7.0.rc3.207.g0ac5344


-- 
Dmitry
