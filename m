From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 30/33] Input: raydium_i2c_ts - Simplify error return and other changes
Date: Wed, 18 Jan 2017 12:36:47 -0800
Message-ID: <1484771819-13761-1-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59438 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbdARUhK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 15:37:10 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Colin Ian King <colin.king@canonical.com>, Jeffrey Lin <jeffrey.lin@rad-ic.com>, Rob Herring <robh@kernel.org>

Simplify error return if the code returns anyway.
Other relevant changes:
  Replace devm_add_action() with devm_add_action_or_reset()

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace devm_add_action() followed by failure action with
  devm_add_action_or_reset()
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'if (e) return e; return 0;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 2658afa016c9..84507a882fa1 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -741,11 +741,7 @@ static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
 
 	fw_checksum = raydium_calc_chksum(fw->data, fw->size);
 
-	error = raydium_i2c_write_checksum(client, fw->size, fw_checksum);
-	if (error)
-		return error;
-
-	return 0;
+	return raydium_i2c_write_checksum(client, fw->size, fw_checksum);
 }
 
 static int raydium_i2c_fw_update(struct raydium_data *ts)
@@ -831,12 +827,12 @@ static irqreturn_t raydium_i2c_irq(int irq, void *_dev)
 	u16 calc_crc;
 
 	if (ts->boot_mode != RAYDIUM_TS_MAIN)
-		goto out;
+		return IRQ_HANDLED;
 
 	error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
 					 ts->report_data, ts->pkg_size);
 	if (error)
-		goto out;
+		return IRQ_HANDLED;
 
 	fw_crc = get_unaligned_le16(&ts->report_data[ts->report_size]);
 	calc_crc = raydium_calc_chksum(ts->report_data, ts->report_size);
@@ -844,12 +840,11 @@ static irqreturn_t raydium_i2c_irq(int irq, void *_dev)
 		dev_warn(&ts->client->dev,
 			 "%s: invalid packet crc %#04x vs %#04x\n",
 			 __func__, calc_crc, fw_crc);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	raydium_mt_event(ts);
 
-out:
 	return IRQ_HANDLED;
 }
 
@@ -1130,10 +1125,9 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_add_action(&client->dev,
-				raydium_i2c_remove_sysfs_group, ts);
+	error = devm_add_action_or_reset(&client->dev,
+					 raydium_i2c_remove_sysfs_group, ts);
 	if (error) {
-		raydium_i2c_remove_sysfs_group(ts);
 		dev_err(&client->dev,
 			"Failed to add sysfs cleanup action: %d\n", error);
 		return error;
-- 
2.7.4

