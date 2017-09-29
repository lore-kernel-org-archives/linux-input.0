From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 12/12] Input: wdt87xx_i2c - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:39 +0900
Message-ID: <20170929203839.7010-13-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:46588 "EHLO
        12.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdI2U5f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:57:35 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 97F80112CF5
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:41:05 +0200 (CEST)
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the relative sysfs_remove_group.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index a9132603ab34..b866cc88d942 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -1106,7 +1106,7 @@ static int wdt87xx_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&client->dev.kobj, &wdt87xx_attr_group);
+	error = devm_device_add_group(&client->dev, &wdt87xx_attr_group);
 	if (error) {
 		dev_err(&client->dev, "create sysfs failed: %d\n", error);
 		return error;
@@ -1117,8 +1117,6 @@ static int wdt87xx_ts_probe(struct i2c_client *client,
 
 static int wdt87xx_ts_remove(struct i2c_client *client)
 {
-	sysfs_remove_group(&client->dev.kobj, &wdt87xx_attr_group);
-
 	return 0;
 }
 
-- 
2.14.2

