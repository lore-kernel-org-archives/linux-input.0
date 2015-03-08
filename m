From: Duson Lin <dusonlin@emc.com.tw>
Subject: [PATCH 3/3] Input: elan_i2c - Remove duplicate repeat code
Date: Sun,  8 Mar 2015 16:44:05 +0800
Message-ID: <1425804245-23954-1-git-send-email-dusonlin@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, Duson Lin <dusonlin@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Remove duplicate "repeat--" from function elan_initialize.

Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f24078b..4b970e2 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -198,7 +198,6 @@ static int elan_initialize(struct elan_tp_data *data)
 		if (!error)
 			return 0;
 
-		repeat--;
 		msleep(30);
 	} while (--repeat > 0);
 
-- 
1.7.10.4
