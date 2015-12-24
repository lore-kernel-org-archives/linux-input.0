From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 5/9] Input: atmel_mxt_ts - add diagnostic data support for mXT1386
Date: Thu, 24 Dec 2015 13:49:24 +0000
Message-ID: <1450964968-9792-6-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

The mXT1386 family of chips have a different architecture which splits
the diagnostic data into 3 columns.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 48bf9ec..a2f11836 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -134,6 +134,10 @@ struct t9_range {
 #define MXT_DIAGNOSTIC_DELTAS 0x10
 #define MXT_DIAGNOSTIC_SIZE    128
 
+#define MXT_FAMILY_1386			160
+#define MXT1386_COLUMNS			3
+#define MXT1386_PAGES_PER_COLUMN	8
+
 struct t37_debug {
 	u8 mode;
 	u8 page;
@@ -2114,13 +2118,27 @@ recheck:
 static u16 mxt_get_debug_value(struct mxt_data *data, unsigned int x,
 			       unsigned int y)
 {
+	struct mxt_info *info = &data->info;
 	struct mxt_dbg *dbg = &data->dbg;
 	unsigned int ofs, page;
+	unsigned int col = 0;
+	unsigned int col_width;
+
+	if (info->family_id == MXT_FAMILY_1386) {
+		col_width = info->matrix_ysize / MXT1386_COLUMNS;
+		col = y / col_width;
+		y = y % col_width;
+	} else {
+		col_width = info->matrix_ysize;
+	}
 
-	ofs = (y + (x * data->info.matrix_ysize)) * sizeof(u16);
+	ofs = (y + (x * col_width)) * sizeof(u16);
 	page = ofs / MXT_DIAGNOSTIC_SIZE;
 	ofs %= MXT_DIAGNOSTIC_SIZE;
 
+	if (info->family_id == MXT_FAMILY_1386)
+		page += col * MXT1386_PAGES_PER_COLUMN;
+
 	return get_unaligned_le16(&dbg->t37_buf[page].data[ofs]);
 }
 
@@ -2229,6 +2247,7 @@ static void mxt_debugfs_remove(struct mxt_data *data)
 
 static void mxt_debugfs_init(struct mxt_data *data)
 {
+	struct mxt_info *info = &data->info;
 	struct mxt_dbg *dbg = &data->dbg;
 	struct mxt_object *object;
 	char dirname[50];
@@ -2263,8 +2282,13 @@ static void mxt_debugfs_init(struct mxt_data *data)
 
 	/* Calculate size of data and allocate buffer */
 	dbg->t37_nodes = data->xsize * data->ysize;
-	dbg->t37_pages = ((data->xsize * data->info.matrix_ysize)
-			  * sizeof(u16) / sizeof(dbg->t37_buf->data)) + 1;
+
+	if (info->family_id == MXT_FAMILY_1386)
+		dbg->t37_pages = MXT1386_COLUMNS * MXT1386_PAGES_PER_COLUMN;
+	else
+		dbg->t37_pages = ((data->xsize * info->matrix_ysize)
+				   * sizeof(u16) / sizeof(dbg->t37_buf->data))
+				   + 1;
 
 
 	dbg->t37_buf = devm_kzalloc(&data->client->dev,
-- 
2.5.0
