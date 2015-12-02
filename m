From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC 6/8] Input: atmel_mxt_ts - Add support for reference data
Date: Wed,  2 Dec 2015 20:42:29 +0000
Message-ID: <1449088951-7069-7-git-send-email-nick.dyer@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

There are different datatypes available from a maXTouch chip. Add
support to retrieve reference data as well.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 78 ++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 6c9fbc0..49fbe2a 100644
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
@@ -230,6 +233,29 @@ struct mxt_object {
 } __packed;
 
 #ifdef CONFIG_DEBUG_FS
+struct mxt_debug_datatype {
+	u8 mode;
+	char *name;
+};
+
+struct mxt_debug_datatype_meta {
+	struct mxt_data *data;
+	const struct mxt_debug_datatype *datatype;
+	struct dentry *dent;
+	void *buf;
+};
+
+static const struct mxt_debug_datatype datatypes[] = {
+	{
+		.mode = MXT_DIAGNOSTIC_REFS,
+		.name = "refs",
+	},
+	{
+		.mode = MXT_DIAGNOSTIC_DELTAS,
+		.name = "deltas",
+	}
+};
+
 struct mxt_dbg {
 	u16 t37_address;
 	u16 diag_cmd_address;
@@ -240,6 +266,8 @@ struct mxt_dbg {
 
 	struct dentry *debugfs_dir;
 	struct dentry *deltas_file;
+	struct dentry *refs_file;
+	struct mxt_debug_datatype_meta dt_meta[ARRAY_SIZE(datatypes)];
 };
 #endif
 
@@ -2166,14 +2194,15 @@ static void mxt_convert_debug_pages(struct mxt_data *data)
 	}
 }
 
-static int mxt_open_deltas(struct inode *inode, struct file *file)
+static int mxt_dbg_open(struct inode *inode, struct file *file)
 {
-	struct mxt_data *data = inode->i_private;
+	struct mxt_debug_datatype_meta *dtm = inode->i_private;
+	struct mxt_data *data = dtm->data;
 	struct mxt_dbg *dbg = &data->dbg;
 	int retries = 0;
 	int page;
 	int ret;
-	u8 mode = MXT_DIAGNOSTIC_DELTAS;
+	u8 mode = dtm->datatype->mode;
 	u8 cmd = mode;
 	struct t37_debug *p;
 
@@ -2218,24 +2247,23 @@ wait_cmd:
 	}
 
 	mxt_convert_debug_pages(data);
-	file->private_data = data;
+	file->private_data = dtm;
 
 	return 0;
 }
 
-static ssize_t mxt_read_deltas(struct file *file, char __user *ubuf,
-			       size_t count, loff_t *offp)
+static ssize_t mxt_dbg_read(struct file *file, char __user *ubuf,
+			     size_t count, loff_t *offp)
 {
-	struct mxt_data *data = file->private_data;
+	struct mxt_debug_datatype_meta *dtm = file->private_data;
 
-	return simple_read_from_buffer(ubuf, count, offp,
-			data->dbg.debug_buf,
-			data->dbg.t37_nodes * sizeof(u16));
+	return simple_read_from_buffer(ubuf, count, offp, dtm->buf,
+				       dtm->dent->d_inode->i_size);
 }
 
-static const struct file_operations atmel_mxt_deltas_fops = {
-	.open = mxt_open_deltas,
-	.read = mxt_read_deltas,
+static const struct file_operations atmel_mxt_dbg_fops = {
+	.open = mxt_dbg_open,
+	.read = mxt_dbg_read,
 };
 
 static void mxt_debugfs_remove(struct mxt_data *data)
@@ -2248,7 +2276,10 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	struct mxt_info *info = &data->info;
 	struct mxt_dbg *dbg = &data->dbg;
 	struct mxt_object *object;
+	struct dentry *dent;
+	struct mxt_debug_datatype_meta *dtm;
 	char dirname[50];
+	int i;
 
 	object = mxt_get_object(data, MXT_GEN_COMMAND_T6);
 	if (!object)
@@ -2299,11 +2330,22 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	if (!dbg->t37_buf)
 		goto error;
 
-	dbg->deltas_file = debugfs_create_file("deltas", S_IRUGO,
-						dbg->debugfs_dir, data,
-						&atmel_mxt_deltas_fops);
-	if (!dbg->deltas_file)
-		goto error;
+	for (i = 0; i < ARRAY_SIZE(datatypes); i++) {
+		dtm = &data->dbg.dt_meta[i];
+
+		dtm->data = data;
+		dtm->datatype = datatypes + i;
+		dtm->buf = dbg->debug_buf;
+
+		dent = debugfs_create_file(datatypes[i].name,
+				S_IRUGO, dbg->debugfs_dir,
+				dtm, &atmel_mxt_dbg_fops);
+		if (!dent)
+			goto error;
+
+		dtm->dent = dent;
+		dent->d_inode->i_size = dbg->t37_nodes * sizeof(u16);
+	}
 
 	dbg->deltas_file->d_inode->i_size = dbg->t37_nodes * sizeof(u16);
 
-- 
2.5.0
