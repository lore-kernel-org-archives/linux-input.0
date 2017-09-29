From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 04/12] Input: atmel_mxt_ts - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:31 +0900
Message-ID: <20170929203839.7010-5-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group.

CC: Nick Dyer <nick@shmanahar.org>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db..e5968f136f08 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3170,7 +3170,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (error)
 		return error;
 
-	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
+	error = devm_device_add_group(&client->dev, &mxt_attr_group);
 	if (error) {
 		dev_err(&client->dev, "Failure %d creating sysfs group\n",
 			error);
@@ -3190,7 +3190,6 @@ static int mxt_remove(struct i2c_client *client)
 	struct mxt_data *data = i2c_get_clientdata(client);
 
 	disable_irq(data->irq);
-	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
 
-- 
2.14.2
