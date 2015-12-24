From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 3/9] Input: atmel_mxt_ts - read touchscreen position in matrix
Date: Thu, 24 Dec 2015 13:49:22 +0000
Message-ID: <1450964968-9792-4-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:10179 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752117AbbLXNth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 08:49:37 -0500
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>

The touchscreen may have a margin where not all the matrix is used. Read
the parameters from T9 and T100 and take account of the difference.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 41 ++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 96000f4..a177019 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -100,6 +100,8 @@ struct t7_config {
 
 /* MXT_TOUCH_MULTI_T9 field */
 #define MXT_T9_CTRL		0
+#define MXT_T9_XSIZE		3
+#define MXT_T9_YSIZE		4
 #define MXT_T9_ORIENT		9
 #define MXT_T9_RANGE		18
 
@@ -145,7 +147,9 @@ struct t37_debug {
 #define MXT_T100_CTRL		0
 #define MXT_T100_CFG1		1
 #define MXT_T100_TCHAUX		3
+#define MXT_T100_XSIZE		9
 #define MXT_T100_XRANGE		13
+#define MXT_T100_YSIZE		20
 #define MXT_T100_YRANGE		24
 
 #define MXT_T100_CFG_SWITCHXY	BIT(5)
@@ -241,6 +245,8 @@ struct mxt_data {
 	unsigned int max_x;
 	unsigned int max_y;
 	bool xy_switch;
+	u8 xsize;
+	u8 ysize;
 	bool in_bootloader;
 	u16 mem_size;
 	u8 t100_aux_ampl;
@@ -1688,6 +1694,18 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
 		return -EINVAL;
 
 	error = __mxt_read_reg(client,
+			       object->start_address + MXT_T9_XSIZE,
+			       sizeof(data->xsize), &data->xsize);
+	if (error)
+		return error;
+
+	error = __mxt_read_reg(client,
+			       object->start_address + MXT_T9_YSIZE,
+			       sizeof(data->ysize), &data->ysize);
+	if (error)
+		return error;
+
+	error = __mxt_read_reg(client,
 			       object->start_address + MXT_T9_RANGE,
 			       sizeof(range), &range);
 	if (error)
@@ -1737,6 +1755,18 @@ static int mxt_read_t100_config(struct mxt_data *data)
 
 	data->max_y = get_unaligned_le16(&range_y);
 
+	error = __mxt_read_reg(client,
+			       object->start_address + MXT_T100_XSIZE,
+			       sizeof(data->xsize), &data->xsize);
+	if (error)
+		return error;
+
+	error = __mxt_read_reg(client,
+			       object->start_address + MXT_T100_YSIZE,
+			       sizeof(data->ysize), &data->ysize);
+	if (error)
+		return error;
+
 	/* read orientation config */
 	error =  __mxt_read_reg(client,
 				object->start_address + MXT_T100_CFG1,
@@ -2077,7 +2107,7 @@ static u16 mxt_get_debug_value(struct mxt_data *data, unsigned int x,
 	struct mxt_dbg *dbg = &data->dbg;
 	unsigned int ofs, page;
 
-	ofs = (y + (x * (data->info.matrix_ysize))) * sizeof(u16);
+	ofs = (y + (x * data->info.matrix_ysize)) * sizeof(u16);
 	page = ofs / MXT_DIAGNOSTIC_SIZE;
 	ofs %= MXT_DIAGNOSTIC_SIZE;
 
@@ -2097,7 +2127,7 @@ static void mxt_convert_debug_pages(struct seq_file *s, struct mxt_data *data)
 		seq_write(s, &val, sizeof(u16));
 
 		/* Next value */
-		if (++x >= data->info.matrix_xsize) {
+		if (++x >= data->xsize) {
 			x = 0;
 			y++;
 		}
@@ -2216,9 +2246,10 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	}
 
 	/* Calculate size of data and allocate buffer */
-	dbg->t37_nodes = data->info.matrix_xsize * data->info.matrix_ysize;
-	dbg->t37_pages = dbg->t37_nodes * sizeof(u16)
-					/ sizeof(dbg->t37_buf->data) + 1;
+	dbg->t37_nodes = data->xsize * data->ysize;
+	dbg->t37_pages = ((data->xsize * data->info.matrix_ysize)
+			  * sizeof(u16) / sizeof(dbg->t37_buf->data)) + 1;
+
 
 	dbg->t37_buf = devm_kzalloc(&data->client->dev,
 				     sizeof(struct t37_debug) * dbg->t37_pages,
-- 
2.5.0

