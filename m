From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: pixcir_i2c_ts - allow using with GPIO expanders
Date: Mon,  6 Jul 2015 17:30:08 -0700
Message-ID: <1436229011-29655-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33530 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbbGGAaX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 20:30:23 -0400
In-Reply-To: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Cc: Jianchun Bian <jcbian@pixcir.com.cn>, linux-kernel@vger.kernel.org

We are using threaded interrupt handler and thus are allowed to sleep.
Let's switch over to gpiod_get_value_cansleep() so that we do not get
ugly warnings in case GPIO controller might sleep when accessing GPIO.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 9093aa9..8965d7c 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -171,7 +171,7 @@ static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
 		/* report it */
 		pixcir_ts_report(tsdata, &report);
 
-		if (gpiod_get_value(tsdata->gpio_attb)) {
+		if (gpiod_get_value_cansleep(tsdata->gpio_attb)) {
 			if (report.num_touches) {
 				/*
 				 * Last report with no finger up?
-- 
2.4.3.573.g4eafbef

