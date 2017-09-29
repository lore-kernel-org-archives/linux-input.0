From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 10/12] Input: rohm_bu21023 - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:37 +0900
Message-ID: <20170929203839.7010-11-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the action that cleans the sysfs file when exiting the
driver.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/rohm_bu21023.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index eeaf6ff03597..bda0500c9b57 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -1103,13 +1103,6 @@ static void rohm_ts_close(struct input_dev *input_dev)
 	ts->initialized = false;
 }
 
-static void rohm_ts_remove_sysfs_group(void *_dev)
-{
-	struct device *dev = _dev;
-
-	sysfs_remove_group(&dev->kobj, &rohm_ts_attr_group);
-}
-
 static int rohm_bu21023_i2c_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
@@ -1180,20 +1173,12 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&dev->kobj, &rohm_ts_attr_group);
+	error = devm_device_add_group(dev, &rohm_ts_attr_group);
 	if (error) {
 		dev_err(dev, "failed to create sysfs group: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(dev, rohm_ts_remove_sysfs_group, dev);
-	if (error) {
-		rohm_ts_remove_sysfs_group(dev);
-		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
-			error);
-		return error;
-	}
-
 	return error;
 }
 
-- 
2.14.2
