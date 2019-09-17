From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v3 31/49] Input: atmel_mxt_ts - eliminate data->raw_info_block
Date: Tue, 17 Sep 2019 18:40:32 +0900
Message-ID: <20190917094050.18771-3-jiada_wang@mentor.com>
References: <20190917094050.18771-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917094050.18771-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: linux-input@vger.kernel.org

Dynamically allocated in mxt_read_info_block() buffer buf is assigned
both to data->info and data->raw_info_block, having both data->info
and data->raw_info_block is redundant and confusing.

This patch eliminates data->raw_info_block.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b3152aaaed63..560fe8a3bf62 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -323,7 +323,6 @@ struct mxt_data {
 	char phys[64];		/* device physical location */
 	struct mxt_object *object_table;
 	struct mxt_info *info;
-	void *raw_info_block;
 	unsigned int irq;
 	unsigned int max_x;
 	unsigned int max_y;
@@ -2070,9 +2069,8 @@ static void mxt_free_object_table(struct mxt_data *data)
 	v4l2_device_unregister(&data->dbg.v4l2);
 #endif
 	data->object_table = NULL;
+	kfree(data->info);
 	data->info = NULL;
-	kfree(data->raw_info_block);
-	data->raw_info_block = NULL;
 	kfree(data->msg_buf);
 	data->msg_buf = NULL;
 	data->T5_address = 0;
@@ -2241,7 +2239,7 @@ static int mxt_read_info_block(struct mxt_data *data)
 	u8 *crc_ptr;
 
 	/* If info block already allocated, free it */
-	if (data->raw_info_block)
+	if (data->info)
 		mxt_free_object_table(data);
 
 	/* Read 7-byte ID information block starting at address 0 */
@@ -2292,7 +2290,6 @@ static int mxt_read_info_block(struct mxt_data *data)
 		goto err_free_mem;
 	}
 
-	data->raw_info_block = id_buf;
 	data->info = (struct mxt_info *)id_buf;
 
 	dev_info(&client->dev,
-- 
2.19.2
