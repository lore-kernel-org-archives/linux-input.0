From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: edt-ft5x06 - return -EFAULT on copy_to_user() error
Date: Mon, 17 Sep 2012 13:12:52 +0800
Message-ID: <1347858772.8376.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51167 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2IQFNB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 01:13:01 -0400
Received: by oago6 with SMTP id o6so4375423oag.19
        for <linux-input@vger.kernel.org>; Sun, 16 Sep 2012 22:13:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Budig <simon.budig@kernelconcepts.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

copy_to_user() returns the number of bytes remaining, but we want a
negative error code here.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index bf00b32..02e9dab 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -567,7 +567,9 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 
 	read = min_t(size_t, count, tsdata->raw_bufsize - *off);
 	error = copy_to_user(buf, tsdata->raw_buffer + *off, read);
-	if (!error)
+	if (error)
+		error = -EFAULT;
+	else
 		*off += read;
 out:
 	mutex_unlock(&tsdata->mutex);
-- 
1.7.9.5



