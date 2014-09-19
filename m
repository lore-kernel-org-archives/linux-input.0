From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] input: clps711x-keypad: Remove cond_resched() call
Date: Fri, 19 Sep 2014 12:29:06 +0400
Message-ID: <1411115346-22034-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback4.mail.ru ([94.100.181.169]:43031 "EHLO
	fallback4.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaISIoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Sep 2014 04:44:16 -0400
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [94.100.177.113])
	by fallback4.mail.ru (mPOP.Fallback_MX) with ESMTP id 31DE033150B
	for <linux-input@vger.kernel.org>; Fri, 19 Sep 2014 12:29:31 +0400 (MSK)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

cond_resched() is not works as expected for clps711x-keypad driver
and cause runtime error.
This patch replaces this call with udelay().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/keyboard/clps711x-keypad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
index 552b65c..650205d 100644
--- a/drivers/input/keyboard/clps711x-keypad.c
+++ b/drivers/input/keyboard/clps711x-keypad.c
@@ -9,13 +9,13 @@
  * (at your option) any later version.
  */
 
+#include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/input-polldev.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/sched.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/clps711x.h>
@@ -54,9 +54,9 @@ static void clps711x_keypad_poll(struct input_polled_dev *dev)
 
 			/* Read twice for protection against fluctuations */
 			do {
-				state = gpiod_get_value_cansleep(data->desc);
-				cond_resched();
-				state1 = gpiod_get_value_cansleep(data->desc);
+				state = gpiod_get_value(data->desc);
+				udelay(5);
+				state1 = gpiod_get_value(data->desc);
 			} while (state != state1);
 
 			if (test_bit(col, data->last_state) != state) {
-- 
1.8.5.5

