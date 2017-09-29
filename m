From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 09/12] Input: raydium_i2c_ts -  use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:36 +0900
Message-ID: <20170929203839.7010-10-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:41955 "EHLO
        8.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdI2U5f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:57:35 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8A568112B3E
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:40:38 +0200 (CEST)
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the action that cleans the sysfs file when exiting the
driver.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 4f1d3fd5d412..100538d64fff 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -943,13 +943,6 @@ static const struct attribute_group raydium_i2c_attribute_group = {
 	.attrs = raydium_i2c_attributes,
 };
 
-static void raydium_i2c_remove_sysfs_group(void *_data)
-{
-	struct raydium_data *ts = _data;
-
-	sysfs_remove_group(&ts->client->dev.kobj, &raydium_i2c_attribute_group);
-}
-
 static int raydium_i2c_power_on(struct raydium_data *ts)
 {
 	int error;
@@ -1120,7 +1113,7 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&client->dev.kobj,
+	error = devm_device_add_group(&client->dev,
 				   &raydium_i2c_attribute_group);
 	if (error) {
 		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
@@ -1128,15 +1121,6 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(&client->dev,
-				raydium_i2c_remove_sysfs_group, ts);
-	if (error) {
-		raydium_i2c_remove_sysfs_group(ts);
-		dev_err(&client->dev,
-			"Failed to add sysfs cleanup action: %d\n", error);
-		return error;
-	}
-
 	return 0;
 }
 
-- 
2.14.2

