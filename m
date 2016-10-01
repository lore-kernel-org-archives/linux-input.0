From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/2] Input: synaptics-rmi4 - Fix error handling in I2C transport driver
Date: Fri, 30 Sep 2016 21:04:09 -0700
Message-ID: <1475294650-29059-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35149 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbcJAEEP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Oct 2016 00:04:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Nick Dyer <nick@shmanahar.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Bjorn Andersson <bjorn.andersson@linaro.org>

Instantiating the rmi4 I2C transport driver without interrupts assigned
(for example using manual i2c instantiation from the command line)
caused the driver to fail to load, but it does not clean up its regulator
or transport device registrations. Result is a crash at a later time,
for example when rebooting the system.

Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use devm_add_action to register cleanup functions
    Drop remove function as no longer necessary

 drivers/input/rmi4/rmi_i2c.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 6f2e0e4f0296..1ebc2c1debae 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -221,6 +221,21 @@ static const struct of_device_id rmi_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, rmi_i2c_of_match);
 #endif
 
+static void rmi_i2c_regulator_bulk_disable(void *data)
+{
+	struct rmi_i2c_xport *rmi_i2c = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
+			       rmi_i2c->supplies);
+}
+
+static void rmi_i2c_unregister_transport(void *data)
+{
+	struct rmi_i2c_xport *rmi_i2c = data;
+
+	rmi_unregister_transport_device(&rmi_i2c->xport);
+}
+
 static int rmi_i2c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -264,6 +279,12 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	if (retval < 0)
 		return retval;
 
+	retval = devm_add_action_or_reset(&client->dev,
+					  rmi_i2c_regulator_bulk_disable,
+					  rmi_i2c);
+	if (retval)
+		return retval;
+
 	of_property_read_u32(client->dev.of_node, "syna,startup-delay-ms",
 			     &rmi_i2c->startup_delay);
 
@@ -294,6 +315,11 @@ static int rmi_i2c_probe(struct i2c_client *client,
 			client->addr);
 		return retval;
 	}
+	retval = devm_add_action_or_reset(&client->dev,
+					  rmi_i2c_unregister_transport,
+					  rmi_i2c);
+	if (retval)
+		return retval;
 
 	retval = rmi_i2c_init_irq(client);
 	if (retval < 0)
@@ -304,17 +330,6 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int rmi_i2c_remove(struct i2c_client *client)
-{
-	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
-
-	rmi_unregister_transport_device(&rmi_i2c->xport);
-	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
-			       rmi_i2c->supplies);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int rmi_i2c_suspend(struct device *dev)
 {
@@ -431,7 +446,6 @@ static struct i2c_driver rmi_i2c_driver = {
 	},
 	.id_table	= rmi_id,
 	.probe		= rmi_i2c_probe,
-	.remove		= rmi_i2c_remove,
 };
 
 module_i2c_driver(rmi_i2c_driver);
-- 
2.5.0

