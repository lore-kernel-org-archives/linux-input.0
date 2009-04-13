From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 1/3] input: add ABS_PRESSURE to da9034 touchscreen
Date: Mon, 13 Apr 2009 12:08:33 +0800
Message-ID: <f17812d70904122108r7b951b95o45ad9735722d8e7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:45565 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbZDMEIf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2009 00:08:35 -0400
Received: by qyk16 with SMTP id 16so3776899qyk.33
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2009 21:08:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Bin Yang <bin.yang@marvell.com>

>From 509bb071200cfe582199ba3ce2533e81949f42f0 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Mon, 13 Apr 2009 10:52:59 +0800
Subject: [PATCH 1/3] input: add ABS_PRESSURE to da9034 touchscreen

Signed-off-by: Bin Yang <bin.yang@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/touchscreen/da9034-ts.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/da9034-ts.c
b/drivers/input/touchscreen/da9034-ts.c
index fa67d78..eac2905 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -127,9 +127,10 @@ static inline void report_pen_down(struct
da9034_touch *touch)
 	if (touch->y_inverted)
 		y = 1024 - y;

+	input_report_key(touch->input_dev, BTN_TOUCH, 1);
 	input_report_abs(touch->input_dev, ABS_X, x);
 	input_report_abs(touch->input_dev, ABS_Y, y);
-	input_report_key(touch->input_dev, BTN_TOUCH, 1);
+	input_report_abs(touch->input_dev, ABS_PRESSURE, 255);

 	input_sync(touch->input_dev);
 }
@@ -137,6 +138,7 @@ static inline void report_pen_down(struct
da9034_touch *touch)
 static inline void report_pen_up(struct da9034_touch *touch)
 {
 	input_report_key(touch->input_dev, BTN_TOUCH, 0);
+	input_report_abs(touch->input_dev, ABS_PRESSURE, 0);
 	input_sync(touch->input_dev);
 }

@@ -332,6 +334,7 @@ static int __devinit da9034_touch_probe(struct
platform_device *pdev)
 	__set_bit(ABS_Y, input_dev->absbit);
 	input_set_abs_params(input_dev, ABS_X, 0, 1023, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, 1023, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 255, 0, 0);

 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
-- 
1.6.0.4
