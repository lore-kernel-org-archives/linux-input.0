From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Prevent breaking of FW updating from unexpected signal
Date: Tue, 23 May 2017 22:32:02 +0800
Message-ID: <1495549922-4589-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:24303 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935873AbdEWOb3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2017 10:31:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw

Use wait_for_completion_timeout to prevent breaking of FW updating from unexpected signal

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
index 3be75c6e..34356c7 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -619,7 +619,7 @@ static int elan_i2c_finish_fw_update(struct i2c_client *client,
 
 	error = elan_i2c_write_cmd(client, ETP_I2C_STAND_CMD, ETP_I2C_RESET);
 	if (!error)
-		ret = wait_for_completion_interruptible_timeout(completion,
+		ret = wait_for_completion_timeout(completion,
 							msecs_to_jiffies(300));
 	disable_irq(client->irq);
 
-- 
2.7.4

