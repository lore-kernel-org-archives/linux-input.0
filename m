From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 07/12] Input: ili210x - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:34 +0900
Message-ID: <20170929203839.7010-8-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:51142 "EHLO
        12.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdI2U52 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:57:28 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 24C7F112CCB
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:40:18 +0200 (CEST)
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the relative sysfs_remove_group and goto label.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ili210x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 6f76eeedf465..03a6aca2941f 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -266,7 +266,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	error = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
+	error = devm_device_add_group(dev, &ili210x_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
 			error);
@@ -276,7 +276,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 	error = input_register_device(priv->input);
 	if (error) {
 		dev_err(dev, "Cannot register input device, err: %d\n", error);
-		goto err_remove_sysfs;
+		goto err_free_irq;
 	}
 
 	device_init_wakeup(dev, 1);
@@ -287,8 +287,6 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 
 	return 0;
 
-err_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
 err_free_irq:
 	free_irq(client->irq, priv);
 err_free_mem:
@@ -301,7 +299,6 @@ static int ili210x_i2c_remove(struct i2c_client *client)
 {
 	struct ili210x *priv = i2c_get_clientdata(client);
 
-	sysfs_remove_group(&client->dev.kobj, &ili210x_attr_group);
 	free_irq(priv->client->irq, priv);
 	cancel_delayed_work_sync(&priv->dwork);
 	input_unregister_device(priv->input);
-- 
2.14.2

