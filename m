From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elan_i2c - switch to using devm_device_add_groups()
Date: Sat, 13 Jul 2019 01:46:49 -0700
Message-ID: <20190713084649.GA103402@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, KT Liao <kt.liao@emc.com.tw>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of installing custom devm cleanup action to remove attribute
groups on failure, let's use the dedicated devm API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index d9b103a81a79..b549d032da93 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1138,13 +1138,6 @@ static void elan_disable_regulator(void *_data)
 	regulator_disable(data->vcc);
 }
 
-static void elan_remove_sysfs_groups(void *_data)
-{
-	struct elan_tp_data *data = _data;
-
-	sysfs_remove_groups(&data->client->dev.kobj, elan_sysfs_groups);
-}
-
 static int elan_probe(struct i2c_client *client,
 		      const struct i2c_device_id *dev_id)
 {
@@ -1269,20 +1262,12 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_groups(&dev->kobj, elan_sysfs_groups);
+	error = devm_device_add_groups(dev, elan_sysfs_groups);
 	if (error) {
 		dev_err(dev, "failed to create sysfs attributes: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(dev, elan_remove_sysfs_groups, data);
-	if (error) {
-		elan_remove_sysfs_groups(data);
-		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
-			error);
-		return error;
-	}
-
 	error = input_register_device(data->input);
 	if (error) {
 		dev_err(dev, "failed to register input device: %d\n", error);
-- 
2.22.0.510.g264f2c817a-goog


-- 
Dmitry
