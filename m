From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 33/33] Input: sx8654 - Drop unnecessary call to i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 12:36:50 -0800
Message-ID: <1484771819-13761-4-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484771819-13761-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484771819-13761-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

There is no call to i2c_get_clientdata() or dev_get_drvdata().
Drop the unnecessary call to i2c_set_clientdata().
Other relevant changes:
  Simplify error return

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'if (e) return e; return 0;' with 'return e;'
- Drop i2c_set_clientdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/sx8654.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 642f4a53de50..c6ce3352da21 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -89,7 +89,7 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 	dev_dbg(&sx8654->client->dev, "irqsrc = 0x%x", irqsrc);
 
 	if (irqsrc < 0)
-		goto out;
+		return IRQ_HANDLED;
 
 	if (irqsrc & IRQ_PENRELEASE) {
 		dev_dbg(&sx8654->client->dev, "pen release interrupt");
@@ -103,11 +103,11 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 
 		retval = i2c_master_recv(sx8654->client, data, sizeof(data));
 		if (retval != sizeof(data))
-			goto out;
+			return IRQ_HANDLED;
 
 		/* invalid data */
 		if (unlikely(data[0] & 0x80 || data[2] & 0x80))
-			goto out;
+			return IRQ_HANDLED;
 
 		x = ((data[0] & 0xf) << 8) | (data[1]);
 		y = ((data[2] & 0xf) << 8) | (data[3]);
@@ -120,7 +120,6 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 		dev_dbg(&sx8654->client->dev, "point(%4d,%4d)\n", x, y);
 	}
 
-out:
 	return IRQ_HANDLED;
 }
 
@@ -249,12 +248,7 @@ static int sx8654_probe(struct i2c_client *client,
 	/* Disable the IRQ, we'll enable it in sx8654_open() */
 	disable_irq(client->irq);
 
-	error = input_register_device(sx8654->input);
-	if (error)
-		return error;
-
-	i2c_set_clientdata(client, sx8654);
-	return 0;
+	return input_register_device(sx8654->input);
 }
 
 #ifdef CONFIG_OF
-- 
2.7.4
