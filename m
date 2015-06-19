From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH] pcf8574_keypad: use request_devm_threaded_irq
Date: Fri, 19 Jun 2015 12:35:54 +0200
Message-ID: <1434710154-25834-1-git-send-email-m.grzeschik@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37015 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbbFSKf7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Jun 2015 06:35:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

We can use the devres API here. Remove the extra cleanup codepath.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/input/misc/pcf8574_keypad.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 97f711a..62fcf36 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -131,7 +131,8 @@ static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_i
 
 	lp->laststate = read_state(lp);
 
-	ret = request_threaded_irq(client->irq, NULL, pcf8574_kp_irq_handler,
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+				   NULL, pcf8574_kp_irq_handler,
 				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				   DRV_NAME, lp);
 	if (ret) {
@@ -142,14 +143,12 @@ static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_i
 	ret = input_register_device(idev);
 	if (ret) {
 		dev_err(&client->dev, "input_register_device() failed\n");
-		goto fail_free_irq;
+		goto fail_free_device;
 	}
 
 	i2c_set_clientdata(client, lp);
 	return 0;
 
- fail_free_irq:
-	free_irq(client->irq, lp);
  fail_free_device:
 	input_free_device(idev);
  fail_allocate:
-- 
2.1.4

