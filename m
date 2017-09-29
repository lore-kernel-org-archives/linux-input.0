From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 11/12] Input: tsc200x-core - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:38 +0900
Message-ID: <20170929203839.7010-12-andi@etezian.org>
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
remove the relative sysfs_remove_group and goto label.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/tsc200x-core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 88ea5e1b72ae..caec24265d78 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -559,7 +559,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		return error;
 
 	dev_set_drvdata(dev, ts);
-	error = sysfs_create_group(&dev->kobj, &tsc200x_attr_group);
+	error = devm_device_add_group(dev, &tsc200x_attr_group);
 	if (error) {
 		dev_err(dev,
 			"Failed to create sysfs attributes, err: %d\n", error);
@@ -570,14 +570,12 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 	if (error) {
 		dev_err(dev,
 			"Failed to register input device, err: %d\n", error);
-		goto err_remove_sysfs;
+		goto disable_regulator;
 	}
 
 	irq_set_irq_wake(irq, 1);
 	return 0;
 
-err_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
 disable_regulator:
 	regulator_disable(ts->vio);
 	return error;
@@ -588,8 +586,6 @@ int tsc200x_remove(struct device *dev)
 {
 	struct tsc200x *ts = dev_get_drvdata(dev);
 
-	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
-
 	regulator_disable(ts->vio);
 
 	return 0;
-- 
2.14.2
