From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [PATCH] Input: atmel_mxt_ts: Configuration data unnecessarily
 uploaded at each probe.
Date: Mon, 09 Feb 2015 19:30:59 +0100
Message-ID: <20150209183059.26064.89422.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ip83.parkeon.com ([213.152.31.83]:47866 "EHLO mta2.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933111AbbBITMQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Feb 2015 14:12:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

mxt_update_cfg() first checks the info block CRC (data->info_crc) and
always does an upload irrespective of configuration CRC if it does not match.

However the info_crc is never initialised from the information provided
by the firmware which causes an upload to be done at each probe if
configuration data firmware is available.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index aaacf8b..0666759 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1413,21 +1413,26 @@ static int mxt_get_object_table(struct mxt_data *data)
 	int i;
 	u8 reportid;
 	u16 end_address;
+	u8 *crc_ptr;
 
 	table_size = data->info.object_num * sizeof(struct mxt_object);
-	object_table = kzalloc(table_size, GFP_KERNEL);
+	object_table = kzalloc(table_size + MXT_INFO_CHECKSUM_SIZE, GFP_KERNEL);
 	if (!object_table) {
 		dev_err(&data->client->dev, "Failed to allocate memory\n");
 		return -ENOMEM;
 	}
 
-	error = __mxt_read_reg(client, MXT_OBJECT_START, table_size,
+	error = __mxt_read_reg(client, MXT_OBJECT_START,
+			table_size + MXT_INFO_CHECKSUM_SIZE,
 			object_table);
 	if (error) {
 		kfree(object_table);
 		return error;
 	}
 
+	crc_ptr = (u8 *)object_table + table_size;
+	data->info_crc = crc_ptr[0] | (crc_ptr[1] << 8) | (crc_ptr[2] << 16);
+
 	/* Valid Report IDs start counting from 1 */
 	reportid = 1;
 	data->mem_size = 0;

