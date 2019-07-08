From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 07/14] Input: cyapa - Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date: Mon,  8 Jul 2019 20:33:23 +0800
Message-ID: <20190708123323.11943-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: linux-input@vger.kernel.org

devm_add_action_or_reset() is introduced as a helper function which 
internally calls devm_add_action(). If devm_add_action() fails 
then it will execute the action mentioned and return the error code.
This reduce source code size (avoid writing the action twice) 
and reduce the likelyhood of bugs.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/input/mouse/cyapa.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index dfd3873513e4..e1d9ab558ecf 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -840,10 +840,9 @@ static int cyapa_prepare_wakeup_controls(struct cyapa *cyapa)
 			return error;
 		}
 
-		error = devm_add_action(dev,
+		error = devm_add_action_or_reset(dev,
 				cyapa_remove_power_wakeup_group, cyapa);
 		if (error) {
-			cyapa_remove_power_wakeup_group(cyapa);
 			dev_err(dev, "failed to add power cleanup action: %d\n",
 				error);
 			return error;
@@ -957,9 +956,8 @@ static int cyapa_start_runtime(struct cyapa *cyapa)
 		return error;
 	}
 
-	error = devm_add_action(dev, cyapa_remove_power_runtime_group, cyapa);
+	error = devm_add_action_or_reset(dev, cyapa_remove_power_runtime_group, cyapa);
 	if (error) {
-		cyapa_remove_power_runtime_group(cyapa);
 		dev_err(dev,
 			"failed to add power runtime cleanup action: %d\n",
 			error);
@@ -1298,9 +1296,8 @@ static int cyapa_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(dev, cyapa_disable_regulator, cyapa);
+	error = devm_add_action_or_reset(dev, cyapa_disable_regulator, cyapa);
 	if (error) {
-		cyapa_disable_regulator(cyapa);
 		dev_err(dev, "failed to add disable regulator action: %d\n",
 			error);
 		return error;
@@ -1318,9 +1315,8 @@ static int cyapa_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(dev, cyapa_remove_sysfs_group, cyapa);
+	error = devm_add_action_or_reset(dev, cyapa_remove_sysfs_group, cyapa);
 	if (error) {
-		cyapa_remove_sysfs_group(cyapa);
 		dev_err(dev, "failed to add sysfs cleanup action: %d\n", error);
 		return error;
 	}
-- 
2.11.0
