From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: cyapa - switch to using devm_device_add_group
Date: Sat, 13 Jul 2019 01:48:27 -0700
Message-ID: <20190713084827.GA103694@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of installing custom devm cleanup action to remove attribute
groups on failure, let's use the dedicated devm API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/cyapa.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index dfd3873513e4..c675f156948b 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1238,13 +1238,6 @@ static const struct attribute_group cyapa_sysfs_group = {
 	.attrs = cyapa_sysfs_entries,
 };
 
-static void cyapa_remove_sysfs_group(void *data)
-{
-	struct cyapa *cyapa = data;
-
-	sysfs_remove_group(&cyapa->client->dev.kobj, &cyapa_sysfs_group);
-}
-
 static void cyapa_disable_regulator(void *data)
 {
 	struct cyapa *cyapa = data;
@@ -1312,19 +1305,12 @@ static int cyapa_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&dev->kobj, &cyapa_sysfs_group);
+	error = devm_device_add_group(dev, &cyapa_sysfs_group);
 	if (error) {
 		dev_err(dev, "failed to create sysfs entries: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(dev, cyapa_remove_sysfs_group, cyapa);
-	if (error) {
-		cyapa_remove_sysfs_group(cyapa);
-		dev_err(dev, "failed to add sysfs cleanup action: %d\n", error);
-		return error;
-	}
-
 	error = cyapa_prepare_wakeup_controls(cyapa);
 	if (error) {
 		dev_err(dev, "failed to prepare wakeup controls: %d\n", error);
-- 
2.22.0.510.g264f2c817a-goog


-- 
Dmitry
