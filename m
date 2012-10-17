From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] Input: edt-ft5x06 - convert to use simple_open()
Date: Wed, 17 Oct 2012 16:29:23 +0800
Message-ID: <CAPgLHd_P7=SeFYvC8EepyNy7Lm-NUTBokTpMDhFVbS_sfhx+UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47532 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab2JQI3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 04:29:23 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1862424qcr.19
        for <linux-input@vger.kernel.org>; Wed, 17 Oct 2012 01:29:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

This removes an open coded simple_open() function and
replaces file operations references to the function
with simple_open() instead.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/touchscreen/edt-ft5x06.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 099d144..d9c6007 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -491,14 +491,6 @@ static int edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
 DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
 			edt_ft5x06_debugfs_mode_set, "%llu\n");
 
-static int edt_ft5x06_debugfs_raw_data_open(struct inode *inode,
-					    struct file *file)
-{
-	file->private_data = inode->i_private;
-
-	return 0;
-}
-
 static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 				char __user *buf, size_t count, loff_t *off)
 {
@@ -579,7 +571,7 @@ out:
 
 
 static const struct file_operations debugfs_raw_data_fops = {
-	.open = edt_ft5x06_debugfs_raw_data_open,
+	.open = simple_open,
 	.read = edt_ft5x06_debugfs_raw_data_read,
 };
 


