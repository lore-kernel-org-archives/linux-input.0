From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ar1021 - do not force raising edge IRQ trigger
Date: Thu, 13 Apr 2017 16:49:23 -0700
Message-ID: <20170413234923.GA38321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33041 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdDMXt1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Apr 2017 19:49:27 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-kernel@vger.kernel.org

We should not be forcing edge triggered interrupt, but rather let platform
decide the kind of trigger it needs to use. Also, the driver is not quite
safe with regard to edge-triggered interrupts as it does not try to kick
the controller after requesting/enabling IRQ.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ar1021_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 6797e123925a..6c3c79b7ff51 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -109,7 +109,7 @@ static int ar1021_i2c_probe(struct i2c_client *client,
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, ar1021_i2c_irq,
-					  IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					  IRQF_ONESHOT,
 					  "ar1021_i2c", ar1021);
 	if (error) {
 		dev_err(&client->dev,
-- 
2.12.2.762.g0e3151a226-goog


-- 
Dmitry
