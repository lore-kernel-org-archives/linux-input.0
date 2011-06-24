From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] Input: ads7846 - cleanup GPIO initialization
Date: Sat, 25 Jun 2011 00:04:53 +0300
Message-ID: <1308949493-16380-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:56115
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752753Ab1FXVFA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 17:05:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>

Use gpio_request_one() instead of multiple gpiolib calls.
This also simplifies error handling a bit.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
This has became possible thanks to Randy Dunlap
c001fb72a7b705f902bdfdd05b5d2408efe6f848 (v3.0-rc4)
(gpio: add GPIOF_ values regardless on kconfig settings)


 drivers/input/touchscreen/ads7846.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 5196861..d507b9b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -967,17 +967,12 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 		ts->get_pendown_state = pdata->get_pendown_state;
 	} else if (gpio_is_valid(pdata->gpio_pendown)) {
 
-		err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
+		err = gpio_request_one(pdata->gpio_pendown, GPIOF_IN,
+				       "ads7846_pendown");
 		if (err) {
-			dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
-				pdata->gpio_pendown);
-			return err;
-		}
-		err = gpio_direction_input(pdata->gpio_pendown);
-		if (err) {
-			dev_err(&spi->dev, "failed to setup pendown GPIO%d\n",
-				pdata->gpio_pendown);
-			gpio_free(pdata->gpio_pendown);
+			dev_err(&spi->dev,
+				"failed to request/setup pendown GPIO%d: %d\n",
+				pdata->gpio_pendown, err);
 			return err;
 		}
 
-- 
1.7.3.4

