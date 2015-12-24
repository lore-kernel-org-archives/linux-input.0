From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 6/9] Input: atmel_mxt_ts - add support for reference data
Date: Thu, 24 Dec 2015 13:49:25 +0000
Message-ID: <1450964968-9792-7-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

There are different datatypes available from a maXTouch chip. Add
support to retrieve reference data as well.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 75 +++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a2f11836..bccd7bc 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -132,6 +132,7 @@ struct t9_range {
 /* MXT_DEBUG_DIAGNOSTIC_T37 */
 #define MXT_DIAGNOSTIC_PAGEUP 0x01
 #define MXT_DIAGNOSTIC_DELTAS 0x10
+#define MXT_DIAGNOSTIC_REFS   0x11
 #define MXT_DIAGNOSTIC_SIZE    128
 
 #define MXT_FAMILY_1386			160
@@ -211,6 +212,8 @@ enum t100_type {
 
 #define MXT_PIXELS_PER_MM	20
 
+struct mxt_data;
+
 struct mxt_info {
 	u8 family_id;
 	u8 variant_id;
@@ -230,6 +233,27 @@ struct mxt_object {
 } __packed;
 
 #ifdef CONFIG_DEBUG_FS
+struct mxt_debug_datatype {
+	u8 mode;
+	char *name;
+};
+
+struct mxt_debug_entry {
+	struct mxt_data *data;
+	const struct mxt_debug_datatype *datatype;
+};
+
+static const struct mxt_debug_datatype mxt_dbg_datatypes[] = {
+	{
+		.mode = MXT_DIAGNOSTIC_REFS,
+		.name = "refs",
+	},
+	{
+		.mode = MXT_DIAGNOSTIC_DELTAS,
+		.name = "deltas",
+	},
+};
+
 struct mxt_dbg {
 	u16 t37_address;
 	u16 diag_cmd_address;
@@ -238,6 +262,8 @@ struct mxt_dbg {
 	unsigned int t37_nodes;
 
 	struct dentry *debugfs_dir;
+	struct mxt_debug_entry entries[ARRAY_SIZE(mxt_dbg_datatypes)];
+	struct mutex dbg_mutex;
 };
 #endif
 
@@ -2142,7 +2168,7 @@ static u16 mxt_get_debug_value(struct mxt_data *data, unsigned int x,
 	return get_unaligned_le16(&dbg->t37_buf[page].data[ofs]);
 }
 
-static void mxt_convert_debug_pages(struct seq_file *s, struct mxt_data *data)
+static int mxt_convert_debug_pages(struct seq_file *s, struct mxt_data *data)
 {
 	struct mxt_dbg *dbg = &data->dbg;
 	unsigned int x = 0;
@@ -2166,26 +2192,31 @@ static void mxt_convert_debug_pages(struct seq_file *s, struct mxt_data *data)
 			y++;
 		}
 	}
+
+	return 0;
 }
 
 static int mxt_read_diagnostic_debug(struct seq_file *s, void *d)
 {
-	struct mxt_data *data = dev_get_drvdata(s->private);
+	struct mxt_debug_entry *e = s->private;
+	struct mxt_data *data = e->data;
 	struct mxt_dbg *dbg = &data->dbg;
 	int retries = 0;
 	int page;
 	int ret;
-	u8 mode = MXT_DIAGNOSTIC_DELTAS;
+	u8 mode = e->datatype->mode;
 	u8 cmd = mode;
 	struct t37_debug *p;
 
+	mutex_lock(&dbg->dbg_mutex);
+
 	for (page = 0; page < dbg->t37_pages; page++) {
 		p = dbg->t37_buf + page;
 
 		ret = mxt_write_reg(data->client, dbg->diag_cmd_address,
 				    cmd);
 		if (ret)
-			return ret;
+			goto release;
 
 		retries = 0;
 
@@ -2196,7 +2227,7 @@ wait_cmd:
 		ret = __mxt_read_reg(data->client, dbg->t37_address,
 				     2, p);
 		if (ret)
-			return ret;
+			goto release;
 
 		if ((p->mode != mode) || (p->page != page)) {
 			if (retries++ > 100)
@@ -2210,7 +2241,7 @@ wait_cmd:
 		ret = __mxt_read_reg(data->client, dbg->t37_address,
 				sizeof(struct t37_debug), p);
 		if (ret)
-			return ret;
+			goto release;
 
 		dev_dbg(&data->client->dev, "%s page:%d retries:%d\n",
 			__func__, page, retries);
@@ -2219,17 +2250,19 @@ wait_cmd:
 		cmd = MXT_DIAGNOSTIC_PAGEUP;
 	}
 
-	mxt_convert_debug_pages(s, data);
+	ret = mxt_convert_debug_pages(s, data);
 
-	return 0;
+release:
+	mutex_unlock(&dbg->dbg_mutex);
+	return ret;
 }
 
 static int mxt_debugfs_data_open(struct inode *inode, struct file *f)
 {
-	struct mxt_data *data = inode->i_private;
-	size_t size = data->dbg.t37_nodes * sizeof(u16);
+	struct mxt_debug_entry *e = inode->i_private;
+	size_t size = e->data->dbg.t37_nodes * sizeof(u16);
 
-	return single_open_size(f, mxt_read_diagnostic_debug, data, size);
+	return single_open_size(f, mxt_read_diagnostic_debug, e, size);
 }
 
 static const struct file_operations mxt_debugfs_data_ops = {
@@ -2252,6 +2285,8 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	struct mxt_object *object;
 	char dirname[50];
 	struct dentry *dent;
+	struct mxt_debug_entry *e;
+	int i;
 
 	object = mxt_get_object(data, MXT_GEN_COMMAND_T6);
 	if (!object)
@@ -2297,11 +2332,19 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	if (!dbg->t37_buf)
 		goto error;
 
-	dent = debugfs_create_file("deltas", S_IRUGO,
-				   dbg->debugfs_dir, data,
-				   &mxt_debugfs_data_ops);
-	if (!dent)
-		goto error;
+	for (i = 0; i < ARRAY_SIZE(mxt_dbg_datatypes); i++) {
+		e = &dbg->entries[i];
+		e->data = data;
+		e->datatype = mxt_dbg_datatypes + i;
+
+		dent = debugfs_create_file(mxt_dbg_datatypes[i].name, S_IRUGO,
+					   dbg->debugfs_dir, e,
+					   &mxt_debugfs_data_ops);
+		if (!dent)
+			goto error;
+	}
+
+	mutex_init(&dbg->dbg_mutex);
 
 	return;
 
-- 
2.5.0
