From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Input: synaptics-rmi4 - Fix error handling in I2C transport driver
Date: Wed, 28 Sep 2016 17:37:06 -0700
Message-ID: <1475109426-23644-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50315 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbcI2AhQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 20:37:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Duggan <aduggan@synaptics.com>

Instantiating the rmi4 I2C transport driver without interrupts assigned
(for example using manual i2c instantiation from the command line)
caused the driver to fail to load, but it does not clean up its
regulator or transport device registrations. Result is a crash at a later
time, for example when rebooting the system.

Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")
Fixes: fdf51604f104 ("Input: synaptics-rmi4 - add I2C transport driver")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/rmi4/rmi_i2c.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 6f2e0e4f0296..d57b227ccd25 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -285,23 +285,30 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	retval = rmi_set_page(rmi_i2c, 0);
 	if (retval) {
 		dev_err(&client->dev, "Failed to set page select to 0.\n");
-		return retval;
+		goto error_disable;
 	}
 
 	retval = rmi_register_transport_device(&rmi_i2c->xport);
 	if (retval) {
 		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
 			client->addr);
-		return retval;
+		goto error_disable;
 	}
 
 	retval = rmi_i2c_init_irq(client);
 	if (retval < 0)
-		return retval;
+		goto error_unregister;
 
 	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
 			client->addr);
 	return 0;
+
+error_unregister:
+	rmi_unregister_transport_device(&rmi_i2c->xport);
+error_disable:
+	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
+			       rmi_i2c->supplies);
+	return retval;
 }
 
 static int rmi_i2c_remove(struct i2c_client *client)
-- 
2.5.0

