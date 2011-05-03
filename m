From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] input: ads7846: fix gpio_pendown configuration
Date: Tue,  3 May 2011 19:02:53 +0300
Message-ID: <1304438573-7692-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:48922
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751680Ab1ECQC7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 3 May 2011 12:02:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>

The pendown gpio was requested but not configured for input.
Request and configure it in one shot.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/input/touchscreen/ads7846.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index c24946f..bf067aa 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -956,7 +956,8 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 		ts->get_pendown_state = pdata->get_pendown_state;
 	} else if (gpio_is_valid(pdata->gpio_pendown)) {
 
-		err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
+		err = gpio_request_one(pdata->gpio_pendown, GPIOF_IN,
+				       "ads7846_pendown");
 		if (err) {
 			dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
 				pdata->gpio_pendown);
-- 
1.7.3.4

