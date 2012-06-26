From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 13/21 v5] Input: atmel_mxt_ts - read ID information block in one i2c transaction
Date: Tue, 26 Jun 2012 14:57:01 +0800
Message-ID: <1340693829-18665-14-git-send-email-djkurtz@chromium.org>
References: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f74.google.com ([209.85.214.74]:38175 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab2FZG5U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 02:57:20 -0400
Received: by bkty5 with SMTP id y5so286115bkt.1
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 23:57:19 -0700 (PDT)
In-Reply-To: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>

Reading the whole info block in one i2c transaction speeds up driver
probe significantly, especially on slower i2c busses.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   26 +++-----------------------
 1 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c16fd9c..07e0238 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -36,6 +36,7 @@
 #define MXT_FW_NAME		"maxtouch.fw"
 
 /* Registers */
+#define MXT_INFO		0x00
 #define MXT_FAMILY_ID		0x00
 #define MXT_VARIANT_ID		0x01
 #define MXT_VERSION		0x02
@@ -759,32 +760,11 @@ static int mxt_get_info(struct mxt_data *data)
 	struct i2c_client *client = data->client;
 	struct mxt_info *info = &data->info;
 	int error;
-	u8 val;
-
-	error = mxt_read_reg(client, MXT_FAMILY_ID, &val);
-	if (error)
-		return error;
-	info->family_id = val;
-
-	error = mxt_read_reg(client, MXT_VARIANT_ID, &val);
-	if (error)
-		return error;
-	info->variant_id = val;
-
-	error = mxt_read_reg(client, MXT_VERSION, &val);
-	if (error)
-		return error;
-	info->version = val;
-
-	error = mxt_read_reg(client, MXT_BUILD, &val);
-	if (error)
-		return error;
-	info->build = val;
 
-	error = mxt_read_reg(client, MXT_OBJECT_NUM, &val);
+	/* Read 7-byte info block starting at address 0 */
+	error = __mxt_read_reg(client, MXT_INFO, sizeof(*info), info);
 	if (error)
 		return error;
-	info->object_num = val;
 
 	return 0;
 }
-- 
1.7.7.3

