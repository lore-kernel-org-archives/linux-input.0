From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 08/14] Input: elan_i2c - Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date: Mon,  8 Jul 2019 20:33:32 +0800
Message-ID: <20190708123332.11989-1-huangfq.daxian@gmail.com>
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
 drivers/input/mouse/elan_i2c_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 420efaab3860..a8d4f3bd09bf 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1234,9 +1234,8 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(dev, elan_remove_sysfs_groups, data);
+	error = devm_add_action_or_reset(dev, elan_remove_sysfs_groups, data);
 	if (error) {
-		elan_remove_sysfs_groups(data);
 		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
-- 
2.11.0
