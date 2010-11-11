From: Dan Carpenter <error27@gmail.com>
Subject: [patch] input: pcf8574_keypad: use after input_unregister_device()
Date: Thu, 11 Nov 2010 10:28:30 +0300
Message-ID: <20101111062429.GA3610@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:60252 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0KKH24 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 02:28:56 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Mike Frysinger <vapier@gentoo.org>, Richard Purdie <rpurdie@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

input_unregister_device() is tricky because it frees the argument.  So
in the original code the call to input_set_drvdata(idev, NULL) is a use
after free bug.  The other problem is the input_set_drvdata() makes the 
input_free_device() into a no-op.

The prefered style in input/ is to make input_register_device() the
last function in the probe which can fail.  That way we don't need to
call input_unregister_device().

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 4b42ffc..d0b0e36 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -129,12 +129,6 @@ static int __devinit pcf8574_kp_probe(struct i2c_client *client, const struct i2
 
 	input_set_drvdata(idev, lp);
 
-	ret = input_register_device(idev);
-	if (ret) {
-		dev_err(&client->dev, "input_register_device() failed\n");
-		goto fail_register;
-	}
-
 	lp->laststate = read_state(lp);
 
 	ret = request_threaded_irq(client->irq, NULL, pcf8574_kp_irq_handler,
@@ -142,16 +136,22 @@ static int __devinit pcf8574_kp_probe(struct i2c_client *client, const struct i2
 				   DRV_NAME, lp);
 	if (ret) {
 		dev_err(&client->dev, "IRQ %d is not free\n", client->irq);
-		goto fail_irq;
+		goto fail_free_device;
 	}
 
 	i2c_set_clientdata(client, lp);
+
+	ret = input_register_device(idev);
+	if (ret) {
+		dev_err(&client->dev, "input_register_device() failed\n");
+		goto fail_free_irq;
+	}
+
 	return 0;
 
- fail_irq:
-	input_unregister_device(idev);
- fail_register:
-	input_set_drvdata(idev, NULL);
+ fail_free_irq:
+	free_irq(client->irq, lp);
+ fail_free_device:
 	input_free_device(idev);
  fail_allocate:
 	kfree(lp);
