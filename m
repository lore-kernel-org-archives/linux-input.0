From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/3] input - wacom_w8001: use __set_bit to set keybits
Date: Fri, 17 Dec 2010 09:36:41 -0800
Message-ID: <1292607401-22603-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:43646 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0LQRgF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 12:36:05 -0500
Received: by gxk19 with SMTP id 19so520059gxk.11
        for <linux-input@vger.kernel.org>; Fri, 17 Dec 2010 09:36:04 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/touchscreen/wacom_w8001.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 2a0bec1..49bce13 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -374,11 +374,11 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	input_dev->dev.parent = &serio->dev;
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-	input_dev->keybit[BIT_WORD(BTN_TOOL_PEN)] |= BIT_MASK(BTN_TOOL_PEN);
-	input_dev->keybit[BIT_WORD(BTN_TOOL_RUBBER)] |= BIT_MASK(BTN_TOOL_RUBBER);
-	input_dev->keybit[BIT_WORD(BTN_STYLUS)] |= BIT_MASK(BTN_STYLUS);
-	input_dev->keybit[BIT_WORD(BTN_STYLUS2)] |= BIT_MASK(BTN_STYLUS2);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+	__set_bit(BTN_TOOL_PEN, input_dev->keybit);
+	__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+	__set_bit(BTN_STYLUS, input_dev->keybit);
+	__set_bit(BTN_STYLUS2, input_dev->keybit);
 
 	serio_set_drvdata(serio, w8001);
 	err = serio_open(serio, drv);
-- 
1.7.3.3

