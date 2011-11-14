From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: migor-ts - use proper client data accessor functions
Date: Mon, 14 Nov 2011 00:33:42 -0800
Message-ID: <1321259623-10887-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1321259623-10887-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34857 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab1KNIds (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:33:48 -0500
Received: by iage36 with SMTP id e36so6966149iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:33:47 -0800 (PST)
In-Reply-To: <1321259623-10887-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/migor_ts.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
index af746b7..704169f 100644
--- a/drivers/input/touchscreen/migor_ts.c
+++ b/drivers/input/touchscreen/migor_ts.c
@@ -143,8 +143,6 @@ static int migor_ts_probe(struct i2c_client *client,
 		goto err0;
 	}
 
-	dev_set_drvdata(&client->dev, priv);
-
 	input = input_allocate_device();
 	if (!input) {
 		dev_err(&client->dev, "Failed to allocate input device.\n");
@@ -183,6 +181,7 @@ static int migor_ts_probe(struct i2c_client *client,
 		goto err2;
 	}
 
+	i2c_set_clientdata(client, priv);
 	device_init_wakeup(&client->dev, 1);
 	return 0;
 
@@ -199,7 +198,7 @@ static int migor_ts_probe(struct i2c_client *client,
 
 static int migor_ts_remove(struct i2c_client *client)
 {
-	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
+	struct migor_ts_priv *priv = i2c_get_clientdata(client);
 
 	free_irq(priv->irq, priv);
 	input_unregister_device(priv->input);
@@ -213,7 +212,7 @@ static int migor_ts_remove(struct i2c_client *client)
 static int migor_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
+	struct migor_ts_priv *priv = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(priv->irq);
@@ -224,7 +223,7 @@ static int migor_ts_suspend(struct device *dev)
 static int migor_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
+	struct migor_ts_priv *priv = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(priv->irq);
-- 
1.7.6.4

