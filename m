From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v1] HID: cp2112: support large i2c transfers in hid-cp2112
Date: Wed, 17 Jun 2015 17:34:16 -0700
Message-ID: <1434587656-2359-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-input@vger.kernel.org

cp2112_i2c_xfer() only reads up to 61 bytes, returning EIO
on longers reads.  The fix is to wrap a loop around
cp2112_read() to pick up all the returned data.

Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
This is like the previous patch but with the controversial
part left out.
---
 drivers/hid/hid-cp2112.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3318de6..5a72819 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -509,13 +509,25 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
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
+		if (ret < 0)
+			goto power_normal;
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
1.7.10.4
