From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 05/12] Input: edt-ft5x06 - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:32 +0900
Message-ID: <20170929203839.7010-6-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:37075 "EHLO
        18.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbdI2U5l (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:57:41 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id DE533112CA5
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:39:58 +0200 (CEST)
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
 drivers/input/touchscreen/edt-ft5x06.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 5bf63f76ddda..f879d14f7ffc 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -998,13 +998,13 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&client->dev.kobj, &edt_ft5x06_attr_group);
+	error = devm_device_add_group(&client->dev, &edt_ft5x06_attr_group);
 	if (error)
 		return error;
 
 	error = input_register_device(input);
 	if (error)
-		goto err_remove_attrs;
+		return error;
 
 	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
 	device_init_wakeup(&client->dev, 1);
@@ -1016,10 +1016,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		tsdata->reset_gpio ? desc_to_gpio(tsdata->reset_gpio) : -1);
 
 	return 0;
-
-err_remove_attrs:
-	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
-	return error;
 }
 
 static int edt_ft5x06_ts_remove(struct i2c_client *client)
@@ -1027,7 +1023,6 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
 	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
 	edt_ft5x06_ts_teardown_debugfs(tsdata);
-	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
 
 	return 0;
 }
-- 
2.14.2

