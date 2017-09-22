From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Extend Flash-Write delay for Elan touch pad
Date: Fri, 22 Sep 2017 13:50:36 +0800
Message-ID: <1506059436-3631-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

Original 20ms delay is a margin timing after a block writing
in FW update flow.

Sometimes it will cause fail during FW-updating if I2C timing delay.
We offten see this issue in rockchip's I2C host.

Extend the delay timing is the safest way to improve it.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
index 80172f2..4db376c 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -587,7 +587,7 @@ static int elan_i2c_write_fw_block(struct i2c_client *client,
 	}
 
 	/* Wait for F/W to update one page ROM data. */
-	msleep(20);
+	msleep(35);
 
 	error = elan_i2c_read_cmd(client, ETP_I2C_IAP_CTRL_CMD, val);
 	if (error) {
-- 
2.7.4
