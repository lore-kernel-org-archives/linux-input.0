From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH] input: wrong irq requested in edt-ft5x06.c
Date: Wed, 19 Sep 2012 16:53:54 +0200
Message-ID: <1348066434-2168-1-git-send-email-sbabic@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpi3.ngi.it ([88.149.128.33]:51399 "EHLO smtpi3.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558Ab2ISPEp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 11:04:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Stefano Babic <sbabic@denx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Guenter Roeck <linux@roeck-us.net>

The probe function checks for integrity the pdata->irq_pin,
but then does not request this line for interrupt.
For this reason, no interrupts are generated.

Tested on a AM3517 board with EP0700M06

Signed-off-by: Stefano Babic <sbabic@denx.de>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Simon Budig <simon.budig@kernelconcepts.de>
CC: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/edt-ft5x06.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index b06a5e3..9608281 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -788,7 +788,8 @@ static int __devinit edt_ft5x06_ts_probe(struct i2c_client *client,
 	input_set_drvdata(input, tsdata);
 	i2c_set_clientdata(client, tsdata);
 
-	error = request_threaded_irq(client->irq, NULL, edt_ft5x06_ts_isr,
+	error = request_threaded_irq(gpio_to_irq(pdata->irq_pin), NULL,
+				     edt_ft5x06_ts_isr,
 				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				     client->name, tsdata);
 	if (error) {
-- 
1.7.9.5

