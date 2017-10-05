From: simon.budig@kernelconcepts.de
Subject: [PATCH 1/3] edt-ft5x06: fix reset pin behaviour
Date: Thu,  5 Oct 2017 17:35:06 +0200
Message-ID: <20171005153508.32127-1-simon.budig@kernelconcepts.de>
References: <1507217501.7345.9.camel@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:11630 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdJEPkd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 11:40:33 -0400
In-Reply-To: <1507217501.7345.9.camel@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Simon Budig <simon.budig@kernelconcepts.de>

From: Simon Budig <simon.budig@kernelconcepts.de>

For some reason the reset pin no longer gets toggeled when initializing
the touch. Fix that and restore the old behaviour.

Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
---
 drivers/input/touchscreen/edt-ft5x06.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 5bf63f7..867a61e 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -936,8 +936,12 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	if (tsdata->reset_gpio) {
 		usleep_range(5000, 6000);
-		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
+		/* note that the reset pin needs to be registered as
+		 * active low in the devicetree.
+		 */
+		gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
 		msleep(300);
+		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
 	}
 
 	input = devm_input_allocate_device(&client->dev);
-- 
2.1.4

