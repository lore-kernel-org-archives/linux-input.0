From: Rostislav Lisovy <lisovy@gmail.com>
Subject: [PATCH 1/2] input: edt-ft5x06: Do not hardcode register numbers in code, use #define
Date: Tue, 21 Apr 2015 13:19:52 +0200
Message-ID: <1429615193-16794-1-git-send-email-lisovy@jablotron.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34203 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbDULUK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 07:20:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Budig <simon.budig@kernelconcepts.de>, Daniel Wagener <daniel.wagener@kernelconcepts.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, lisovy@jablotron.cz

Signed-off-by: Rostislav Lisovy <lisovy@jablotron.cz>
---
 drivers/input/touchscreen/edt-ft5x06.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e6aef3e..c938d4b 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -48,6 +48,9 @@
 #define WORK_REGISTER_OFFSET		0x31
 #define WORK_REGISTER_NUM_X		0x33
 #define WORK_REGISTER_NUM_Y		0x34
+#define WORK_REGISTER_FW_ID		0xA6
+#define WORK_REGISTER_FT_ID		0xA8
+#define WORK_REGISTER_FW_VER		0xBB
 
 #define M09_REGISTER_THRESHOLD		0x80
 #define M09_REGISTER_GAIN		0x92
@@ -799,14 +802,16 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	char *p;
 	int error;
 	char *model_name = tsdata->name;
+	u8 cmd;
 
 	/* see what we find if we assume it is a M06 *
 	 * if we get less than EDT_NAME_LEN, we don't want
 	 * to have garbage in there
 	 */
 	memset(rdbuf, 0, sizeof(rdbuf));
-	error = edt_ft5x06_ts_readwrite(client, 1, "\xbb",
-					EDT_NAME_LEN - 1, rdbuf);
+	cmd = WORK_REGISTER_FW_VER;
+	error = edt_ft5x06_ts_readwrite(client, 1, &cmd, EDT_NAME_LEN - 1,
+					rdbuf);
 	if (error)
 		return error;
 
@@ -831,15 +836,15 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 		/* since there are only two versions around (M06, M09) */
 		tsdata->version = M09;
 
-		error = edt_ft5x06_ts_readwrite(client, 1, "\xA6",
-						2, rdbuf);
+		cmd = WORK_REGISTER_FW_ID;
+		error = edt_ft5x06_ts_readwrite(client, 1, &cmd, 2, rdbuf);
 		if (error)
 			return error;
 
 		strlcpy(fw_version, rdbuf, 2);
 
-		error = edt_ft5x06_ts_readwrite(client, 1, "\xA8",
-						1, rdbuf);
+		cmd = WORK_REGISTER_FT_ID;
+		error = edt_ft5x06_ts_readwrite(client, 1, &cmd, 1, rdbuf);
 		if (error)
 			return error;
 
-- 
2.1.0

