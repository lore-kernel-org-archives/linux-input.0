From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] gpio: adp5588: get value from data out when dir is out
Date: Mon, 10 Feb 2014 12:05:28 -0500
Message-ID: <1392051929-32290-1-git-send-email-jeff.dagenais@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:52045 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaBJRFv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Feb 2014 12:05:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com, dmitry.torokhov@gmail.com, dtor@mail.ru, linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Jean-Francois Dagenais <jeff.dagenais@gmail.com>

As discussed here: http://ez.analog.com/message/35852,
the 5587 revC and 5588 revB spec sheets contain a mistake
in the GPIO_DAT_STATx register description.

According to R.Shnell at ADI, as well as my own
observations, it should read:
"GPIO data status (shows GPIO state when read for inputs)".

This commit changes the get value function accordingly.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/gpio/gpio-adp5588.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index 3f190e6..7d3c8d9 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -67,9 +67,20 @@ static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5588_gpio *dev =
 	    container_of(chip, struct adp5588_gpio, gpio_chip);
+	unsigned bank = ADP5588_BANK(off);
+	unsigned bit = ADP5588_BIT(off);
+	int val;
 
-	return !!(adp5588_gpio_read(dev->client,
-		  GPIO_DAT_STAT1 + ADP5588_BANK(off)) & ADP5588_BIT(off));
+	mutex_lock(&dev->lock);
+
+	if (dev->dir[bank] & bit)
+		val = dev->dat_out[bank];
+	else
+		val = adp5588_gpio_read(dev->client, GPIO_DAT_STAT1 + bank);
+
+	mutex_unlock(&dev->lock);
+
+	return !!(val & bit);
 }
 
 static void adp5588_gpio_set_value(struct gpio_chip *chip,
-- 
1.8.5.3

