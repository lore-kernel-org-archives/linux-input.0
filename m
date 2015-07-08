From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: [PATCH v2] HID: cp2112: support large i2c transfers in hid-cp2112
Date: Wed,  8 Jul 2015 03:25:18 -0700
Message-ID: <1436351118-3360-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34146 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934685AbbGHKZ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2015 06:25:29 -0400
Received: by pabvl15 with SMTP id vl15so129462421pab.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2015 03:25:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: borneo.antonio@gmail.com, dbarksdale@uplogix.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: ellen@cumulusnetworks.com

cp2112_i2c_xfer() only reads up to 61 bytes, returning EIO
on longers reads.  The fix is to wrap a loop around
cp2112_read() to pick up all the returned data.

Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
---
This is the updated patch with a check for 0 return from
cp2112_read().  I tested it with a suitable delay in the loop
to trigger the cp2112_raw_event() overrun bug, which must
be fixed before this patch is applied.
---
 drivers/hid/hid-cp2112.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3318de6..e2ffac0 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -509,13 +509,32 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	if (!(msgs->flags & I2C_M_RD))
 		goto finish;
 
-	ret = cp2112_read(dev, msgs->buf, msgs->len);
-	if (ret < 0)
-		goto power_normal;
-	if (ret != msgs->len) {
-		hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
-		ret = -EIO;
-		goto power_normal;
+	for (count = 0; count < msgs->len;) {
+		ret = cp2112_read(dev, msgs->buf + count, msgs->len - count);
+		hid_warn(hdev, "read returned %d for %zd\n",
+			 ret, msgs->len - count);
+		if (ret < 0)
+			goto power_normal;
+		if (ret == 0) {
+			hid_err(hdev, "read returned 0\n");
+			ret = -EIO;
+			goto power_normal;
+		}
+		count += ret;
+		if (count > msgs->len) {
+			/*
+			 * The hardware returned too much data.
+			 * This is mostly harmless because cp2112_read()
+			 * has a limit check so didn't overrun our
+			 * buffer.  Nevertheless, we return an error
+			 * because something is seriously wrong and
+			 * it shouldn't go unnoticed.
+			 */
+			hid_err(hdev, "long read: %d > %zd\n",
+				ret, msgs->len - count + ret);
+			ret = -EIO;
+			goto power_normal;
+		}
 	}
 
 finish:
-- 
1.9.1

