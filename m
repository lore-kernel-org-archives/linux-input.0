From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: [PATCH] Input: Added hovering capability
Date: Fri, 14 Jun 2013 17:56:39 +0900
Message-ID: <1371200199-17718-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39274 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3FNI4t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Jun 2013 04:56:49 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so376525pde.18
        for <linux-input@vger.kernel.org>; Fri, 14 Jun 2013 01:56:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Although BTN_TOOL_PEN and BTN_TOOL_RUBBER function properly, the driver didn't
have hover functionality, so it's been added.
Also, I noticed that "WACOM_RETRY_CNT" was not used, so it was removed.

Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
---
 drivers/input/touchscreen/wacom_i2c.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index bf0d076..7ccaa1b 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -1,7 +1,7 @@
 /*
  * Wacom Penabled Driver for I2C
  *
- * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
+ * Copyright (c) 2011 - 2013 Tatsunosuke Tobita, Wacom.
  * <tobita.tatsunosuke@wacom.co.jp>
  *
  * This program is free software; you can redistribute it
@@ -27,7 +27,6 @@
 #define WACOM_CMD_THROW0	0x05
 #define WACOM_CMD_THROW1	0x00
 #define WACOM_QUERY_SIZE	19
-#define WACOM_RETRY_CNT		100
 
 struct wacom_features {
 	int x_max;
@@ -40,6 +39,8 @@ struct wacom_i2c {
 	struct i2c_client *client;
 	struct input_dev *input;
 	u8 data[WACOM_QUERY_SIZE];
+	bool prox;
+	int tool;
 };
 
 static int wacom_query_device(struct i2c_client *client,
@@ -112,9 +113,14 @@ static irqreturn_t wacom_i2c_irq(int irq, void *dev_id)
 	y = le16_to_cpup((__le16 *)&data[6]);
 	pressure = le16_to_cpup((__le16 *)&data[8]);
 
+	if (!wac_i2c->prox)
+		wac_i2c->tool = (data[3] & 0x0c) ?
+			BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+
+	wac_i2c->prox = data[3] & 0x20;
+
 	input_report_key(input, BTN_TOUCH, tsw || ers);
-	input_report_key(input, BTN_TOOL_PEN, tsw);
-	input_report_key(input, BTN_TOOL_RUBBER, ers);
+	input_report_key(input, wac_i2c->tool, wac_i2c->prox);
 	input_report_key(input, BTN_STYLUS, f1);
 	input_report_key(input, BTN_STYLUS2, f2);
 	input_report_abs(input, ABS_X, x);
-- 
1.7.9.5

