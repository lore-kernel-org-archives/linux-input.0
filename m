From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Input: zforce_ts - use devm_add_action_or_reset()
Date: Sun,  3 Jul 2016 21:48:46 +0100
Message-ID: <1467578926-32297-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

If devm_add_action() fails we are explicitly calling the cleanup to free
the resources allocated.  Lets use the helper devm_add_action_or_reset()
and return directly in case of error, as we know that the cleanup function
has been already called by the helper if there was any error.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/input/touchscreen/zforce_ts.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 7b3845a..6053e31 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -820,15 +820,12 @@ static int zforce_probe(struct i2c_client *client,
 		udelay(100);
 	}
 
-	ret = devm_add_action(&client->dev, zforce_reset, ts);
+	ret = devm_add_action_or_reset(&client->dev, zforce_reset, ts);
 	if (ret) {
 		dev_err(&client->dev, "failed to register reset action, %d\n",
 			ret);
 
 		/* hereafter the regulator will be disabled by the action */
-		if (!IS_ERR(ts->reg_vdd))
-			regulator_disable(ts->reg_vdd);
-
 		return ret;
 	}
 
-- 
1.9.1
