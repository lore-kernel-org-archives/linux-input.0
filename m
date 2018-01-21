From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: atmel_mxt_ts: Delete error messages for a failed
 memory allocation in two functions
Date: Sun, 21 Jan 2018 22:33:50 +0100
Message-ID: <e6d21a83-6628-66f6-d7ce-bb5bf530faf2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:50013 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeAUVdx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 16:33:53 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 22:25:31 +0100

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db..f38711e9c256 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1507,10 +1507,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 			MXT_INFO_CHECKSUM_SIZE;
 	config_mem_size = data->mem_size - cfg_start_ofs;
 	config_mem = kzalloc(config_mem_size, GFP_KERNEL);
-	if (!config_mem) {
-		dev_err(dev, "Failed to allocate memory\n");
+	if (!config_mem)
 		return -ENOMEM;
-	}
 
 	ret = mxt_prepare_cfg_mem(data, cfg, data_pos, cfg_start_ofs,
 				  config_mem, config_mem_size);
@@ -1612,10 +1610,8 @@ static int mxt_get_object_table(struct mxt_data *data)
 
 	table_size = data->info.object_num * sizeof(struct mxt_object);
 	object_table = kzalloc(table_size, GFP_KERNEL);
-	if (!object_table) {
-		dev_err(&data->client->dev, "Failed to allocate memory\n");
+	if (!object_table)
 		return -ENOMEM;
-	}
 
 	error = __mxt_read_reg(client, MXT_OBJECT_START, table_size,
 			object_table);
@@ -1714,7 +1710,6 @@ static int mxt_get_object_table(struct mxt_data *data)
 	data->msg_buf = kcalloc(data->max_reportid,
 				data->T5_msg_size, GFP_KERNEL);
 	if (!data->msg_buf) {
-		dev_err(&client->dev, "Failed to allocate message buffer\n");
 		error = -ENOMEM;
 		goto free_object_table;
 	}
-- 
2.16.0

