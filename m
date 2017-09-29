From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 08/12] Input: melfas_mip4 - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:35 +0900
Message-ID: <20170929203839.7010-9-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:48479 "EHLO
        14.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdI2U5f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:57:35 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6325E112CCC
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:40:28 +0200 (CEST)
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>, Sangwon Jee <jeesw@melfas.com>

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the action that cleans the sysfs file when exiting the
driver.

CC: Sangwon Jee <jeesw@melfas.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/melfas_mip4.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 05108c2fea93..6892f0e28918 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1433,13 +1433,6 @@ static const struct attribute_group mip4_attr_group = {
 	.attrs = mip4_attrs,
 };
 
-static void mip4_sysfs_remove(void *_data)
-{
-	struct mip4_ts *ts = _data;
-
-	sysfs_remove_group(&ts->client->dev.kobj, &mip4_attr_group);
-}
-
 static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct mip4_ts *ts;
@@ -1535,21 +1528,13 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
-	error = sysfs_create_group(&client->dev.kobj, &mip4_attr_group);
+	error = devm_device_add_group(&client->dev, &mip4_attr_group);
 	if (error) {
 		dev_err(&client->dev,
 			"Failed to create sysfs attribute group: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(&client->dev, mip4_sysfs_remove, ts);
-	if (error) {
-		mip4_sysfs_remove(ts);
-		dev_err(&client->dev,
-			"Failed to install sysfs remoce action: %d\n", error);
-		return error;
-	}
-
 	return 0;
 }
 
-- 
2.14.2

