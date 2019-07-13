From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elan_i2c - switch to using devm_add_action_or_reset()
Date: Sat, 13 Jul 2019 01:47:41 -0700
Message-ID: <20190713084741.GA103533@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, KT Liao <kt.liao@emc.com.tw>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of manually disabling regulators when devm_add_action() fails we can
use devm_add_action_or_reset() which does it for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index b549d032da93..8719da540383 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1187,9 +1187,8 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(dev, elan_disable_regulator, data);
+	error = devm_add_action_or_reset(dev, elan_disable_regulator, data);
 	if (error) {
-		regulator_disable(data->vcc);
 		dev_err(dev, "Failed to add disable regulator action: %d\n",
 			error);
 		return error;
-- 
2.22.0.510.g264f2c817a-goog


-- 
Dmitry
