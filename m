From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Input: synaptics-rmi4 - Make interrupt support in  I2C driver optional
Date: Sun,  2 Oct 2016 10:35:48 -0700
Message-ID: <1475429748-5178-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50579 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcJBRfy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Oct 2016 13:35:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

While interrupt support is necessary for the touchscreen to work as input
device, it is sometimes convenient to be able to instantiate the I2C
transport driver without it, for example for testing and for debugging
functionality which does not rely on interrupt support.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies on top of the previously submitted patch fixing error handling.

 drivers/input/rmi4/rmi_i2c.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 1ebc2c1debae..c1f5ed0bce0b 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -321,9 +321,14 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	if (retval)
 		return retval;
 
-	retval = rmi_i2c_init_irq(client);
-	if (retval < 0)
-		return retval;
+	if (rmi_i2c->irq) {
+		retval = rmi_i2c_init_irq(client);
+		if (retval < 0)
+			return retval;
+	} else {
+		dev_warn(&client->dev,
+			 "No interrupt support, touchscreen will not report input events\n");
+	}
 
 	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
 			client->addr);
-- 
2.5.0

