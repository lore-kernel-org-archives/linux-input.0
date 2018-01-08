From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH v2 1/2] HID: i2c-hid: fix size check and type usage
Date: Mon,  8 Jan 2018 10:41:40 +0800
Message-ID: <20180108024141.10590-1-aaron.ma@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46946 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeAHClt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 7 Jan 2018 21:41:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, aaron.ma@canonical.com

When convert char array with signed int, if the inbuf[x] is negative then
upper bits will be set to 1. Fix this by using u8 instead of char.

ret_size has to be at least 3, hid_input_report use it after minus 2 bytes.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index e054ee43c1e2..d17d1950392b 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -144,10 +144,10 @@ struct i2c_hid {
 						   * register of the HID
 						   * descriptor. */
 	unsigned int		bufsize;	/* i2c buffer size */
-	char			*inbuf;		/* Input buffer */
-	char			*rawbuf;	/* Raw Input buffer */
-	char			*cmdbuf;	/* Command buffer */
-	char			*argsbuf;	/* Command arguments buffer */
+	u8			*inbuf;		/* Input buffer */
+	u8			*rawbuf;	/* Raw Input buffer */
+	u8			*cmdbuf;	/* Command buffer */
+	u8			*argsbuf;	/* Command arguments buffer */
 
 	unsigned long		flags;		/* device flags */
 	unsigned long		quirks;		/* Various quirks */
@@ -455,7 +455,8 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
-	int ret, ret_size;
+	int ret;
+	u32 ret_size;
 	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
 
 	if (size > ihid->bufsize)
@@ -480,7 +481,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
 
-	if (ret_size > size) {
+	if ((ret_size > size) || (ret_size <= 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
-- 
2.14.3

