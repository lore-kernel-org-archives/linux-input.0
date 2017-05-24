From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Clean INT stats in FW updating for old Elan touchpad
Date: Wed, 24 May 2017 17:43:39 +0800
Message-ID: <1495619019-28981-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:50839 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936633AbdEXJnC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 May 2017 05:43:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw

Some old touchapd FWs have interrupt issue after FW updating.
Use reading 34 bytes before IC reset command to clean INT stauts
The modification has been tested in some chromebook system
It should not affect general touchpad in Linux system.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_i2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
index 3be75c6e..842f852 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -612,7 +612,14 @@ static int elan_i2c_finish_fw_update(struct i2c_client *client,
 	long ret;
 	int error;
 	int len;
-	u8 buffer[ETP_I2C_INF_LENGTH];
+	u8 buffer[ETP_I2C_REPORT_LEN];
+
+	len = i2c_master_recv(client, buffer, ETP_I2C_REPORT_LEN);
+	if (len != ETP_I2C_REPORT_LEN) {
+		error = len < 0 ? len : -EIO;
+		dev_warn(dev, "failed to read I2C data after FW WDT reset: %d (%d)\n",
+			error, len);
+	}
 
 	reinit_completion(completion);
 	enable_irq(client->irq);
-- 
2.7.4

