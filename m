From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 10/14] Input: auo-pixcir-ts - Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date: Mon,  8 Jul 2019 20:33:47 +0800
Message-ID: <20190708123347.12081-1-huangfq.daxian@gmail.com>
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
 drivers/input/touchscreen/auo-pixcir-ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 8e48fbda487a..8e9f3b7b8180 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -602,9 +602,8 @@ static int auo_pixcir_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(&client->dev, auo_pixcir_reset, ts);
+	error = devm_add_action_or_reset(&client->dev, auo_pixcir_reset, ts);
 	if (error) {
-		auo_pixcir_reset(ts);
 		dev_err(&client->dev, "failed to register reset action, %d\n",
 			error);
 		return error;
-- 
2.11.0
