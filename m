From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH 1/2] input: qt2160: Fix I2C write function.
Date: Tue, 16 Oct 2012 17:19:30 +0200
Message-ID: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39264 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab2JPPTm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Oct 2012 11:19:42 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so3799194wey.19
        for <linux-input@vger.kernel.org>; Tue, 16 Oct 2012 08:19:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: axel.lin@gmail.com, dmitry.torokhov@gmail.com, Javier Martin <javier.martin@vista-silicon.com>

The previous implementation of qt2160_write() didn't work
properly. Use a similar aproach as qt1070 instead.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/input/keyboard/qt2160.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index e7a5e36..73ea4b0 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -207,23 +207,14 @@ static int __devinit qt2160_read(struct i2c_client *client, u8 reg)
 
 static int __devinit qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 {
-	int error;
-
-	error = i2c_smbus_write_byte(client, reg);
-	if (error) {
-		dev_err(&client->dev,
-			"couldn't send request. Returned %d\n", error);
-		return error;
-	}
+	int ret;
 
-	error = i2c_smbus_write_byte(client, data);
-	if (error) {
+	ret = i2c_smbus_write_byte_data(client, reg, data);
+	if (ret < 0)
 		dev_err(&client->dev,
-			"couldn't write data. Returned %d\n", error);
-		return error;
-	}
+			"couldn't write data. Returned %d\n", ret);
 
-	return error;
+	return ret;
 }
 
 
-- 
1.7.9.5

