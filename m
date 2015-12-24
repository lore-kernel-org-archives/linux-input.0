From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 2/9] Input: atmel_mxt_ts - add diagnostic data retrieval via debugfs
Date: Thu, 24 Dec 2015 13:49:21 +0000
Message-ID: <1450964968-9792-3-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:6855 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752128AbbLXNth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 08:49:37 -0500
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Retrieve refs data from the T37 diagnostic data object and expose it via
a binary attribute in debugfs.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 208 +++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4a1d218..96000f4 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
+#include <linux/debugfs.h>
 
 /* Firmware files */
 #define MXT_FW_NAME		"maxtouch.fw"
@@ -124,6 +125,17 @@ struct t9_range {
 #define MXT_COMMS_CTRL		0
 #define MXT_COMMS_CMD		1
 
+/* MXT_DEBUG_DIAGNOSTIC_T37 */
+#define MXT_DIAGNOSTIC_PAGEUP 0x01
+#define MXT_DIAGNOSTIC_DELTAS 0x10
+#define MXT_DIAGNOSTIC_SIZE    128
+
+struct t37_debug {
+	u8 mode;
+	u8 page;
+	u8 data[MXT_DIAGNOSTIC_SIZE];
+};
+
 /* Define for MXT_GEN_COMMAND_T6 */
 #define MXT_BOOT_VALUE		0xa5
 #define MXT_RESET_VALUE		0x01
@@ -205,6 +217,18 @@ struct mxt_object {
 	u8 num_report_ids;
 } __packed;
 
+#ifdef CONFIG_DEBUG_FS
+struct mxt_dbg {
+	u16 t37_address;
+	u16 diag_cmd_address;
+	struct t37_debug *t37_buf;
+	unsigned int t37_pages;
+	unsigned int t37_nodes;
+
+	struct dentry *debugfs_dir;
+};
+#endif
+
 /* Each client has this additional data */
 struct mxt_data {
 	struct i2c_client *client;
@@ -233,6 +257,9 @@ struct mxt_data {
 	u8 num_touchids;
 	u8 multitouch;
 	struct t7_config t7_cfg;
+#ifdef CONFIG_DEBUG_FS
+	struct mxt_dbg dbg;
+#endif
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -2043,6 +2070,184 @@ recheck:
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static u16 mxt_get_debug_value(struct mxt_data *data, unsigned int x,
+			       unsigned int y)
+{
+	struct mxt_dbg *dbg = &data->dbg;
+	unsigned int ofs, page;
+
+	ofs = (y + (x * (data->info.matrix_ysize))) * sizeof(u16);
+	page = ofs / MXT_DIAGNOSTIC_SIZE;
+	ofs %= MXT_DIAGNOSTIC_SIZE;
+
+	return get_unaligned_le16(&dbg->t37_buf[page].data[ofs]);
+}
+
+static void mxt_convert_debug_pages(struct seq_file *s, struct mxt_data *data)
+{
+	struct mxt_dbg *dbg = &data->dbg;
+	unsigned int x = 0;
+	unsigned int y = 0;
+	unsigned int i;
+	u16 val;
+
+	for (i = 0; i < dbg->t37_nodes; i++) {
+		val = mxt_get_debug_value(data, x, y);
+		seq_write(s, &val, sizeof(u16));
+
+		/* Next value */
+		if (++x >= data->info.matrix_xsize) {
+			x = 0;
+			y++;
+		}
+	}
+}
+
+static int mxt_read_diagnostic_debug(struct seq_file *s, void *d)
+{
+	struct mxt_data *data = dev_get_drvdata(s->private);
+	struct mxt_dbg *dbg = &data->dbg;
+	int retries = 0;
+	int page;
+	int ret;
+	u8 mode = MXT_DIAGNOSTIC_DELTAS;
+	u8 cmd = mode;
+	struct t37_debug *p;
+
+	for (page = 0; page < dbg->t37_pages; page++) {
+		p = dbg->t37_buf + page;
+
+		ret = mxt_write_reg(data->client, dbg->diag_cmd_address,
+				    cmd);
+		if (ret)
+			return ret;
+
+		retries = 0;
+
+		/* Poll until command is actioned */
+		msleep(20);
+wait_cmd:
+		/* Read first two bytes only */
+		ret = __mxt_read_reg(data->client, dbg->t37_address,
+				     2, p);
+		if (ret)
+			return ret;
+
+		if ((p->mode != mode) || (p->page != page)) {
+			if (retries++ > 100)
+				return -EINVAL;
+
+			msleep(20);
+			goto wait_cmd;
+		}
+
+		/* Read entire T37 page */
+		ret = __mxt_read_reg(data->client, dbg->t37_address,
+				sizeof(struct t37_debug), p);
+		if (ret)
+			return ret;
+
+		dev_dbg(&data->client->dev, "%s page:%d retries:%d\n",
+			__func__, page, retries);
+
+		/* For remaining pages, write PAGEUP rather than mode */
+		cmd = MXT_DIAGNOSTIC_PAGEUP;
+	}
+
+	mxt_convert_debug_pages(s, data);
+
+	return 0;
+}
+
+static int mxt_debugfs_data_open(struct inode *inode, struct file *f)
+{
+	struct mxt_data *data = inode->i_private;
+	size_t size = data->dbg.t37_nodes * sizeof(u16);
+
+	return single_open_size(f, mxt_read_diagnostic_debug, data, size);
+}
+
+static const struct file_operations mxt_debugfs_data_ops = {
+	.owner = THIS_MODULE,
+	.open = mxt_debugfs_data_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek
+};
+
+static void mxt_debugfs_remove(struct mxt_data *data)
+{
+	debugfs_remove_recursive(data->dbg.debugfs_dir);
+}
+
+static void mxt_debugfs_init(struct mxt_data *data)
+{
+	struct mxt_dbg *dbg = &data->dbg;
+	struct mxt_object *object;
+	char dirname[50];
+	struct dentry *dent;
+
+	object = mxt_get_object(data, MXT_GEN_COMMAND_T6);
+	if (!object)
+		return;
+
+	dbg->diag_cmd_address = object->start_address + MXT_COMMAND_DIAGNOSTIC;
+
+	object = mxt_get_object(data, MXT_DEBUG_DIAGNOSTIC_T37);
+	if (!object)
+		return;
+
+	if (mxt_obj_size(object) != sizeof(struct t37_debug)) {
+		dev_warn(&data->client->dev, "Bad T37 size");
+		return;
+	}
+
+	dbg->t37_address = object->start_address;
+
+	snprintf(dirname, sizeof(dirname), "heatmap-%s-%s",
+		 dev_driver_string(&data->client->dev),
+		 dev_name(&data->client->dev));
+
+	dbg->debugfs_dir = debugfs_create_dir(dirname, NULL);
+	if (!dbg->debugfs_dir) {
+		dev_err(&data->client->dev, "Error creating debugfs dir\n");
+		return;
+	}
+
+	/* Calculate size of data and allocate buffer */
+	dbg->t37_nodes = data->info.matrix_xsize * data->info.matrix_ysize;
+	dbg->t37_pages = dbg->t37_nodes * sizeof(u16)
+					/ sizeof(dbg->t37_buf->data) + 1;
+
+	dbg->t37_buf = devm_kzalloc(&data->client->dev,
+				     sizeof(struct t37_debug) * dbg->t37_pages,
+				     GFP_KERNEL);
+	if (!dbg->t37_buf)
+		goto error;
+
+	dent = debugfs_create_file("deltas", S_IRUGO,
+				   dbg->debugfs_dir, data,
+				   &mxt_debugfs_data_ops);
+	if (!dent)
+		goto error;
+
+	return;
+
+error:
+	dev_err(&data->client->dev, "Error creating debugfs entry\n");
+	mxt_debugfs_remove(data);
+}
+#else
+static inline void mxt_debugfs_remove(struct mxt_data *data)
+{
+}
+
+static inline void mxt_debugfs_init(struct mxt_data *data)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static int mxt_configure_objects(struct mxt_data *data,
 				 const struct firmware *cfg)
 {
@@ -2070,6 +2275,8 @@ static int mxt_configure_objects(struct mxt_data *data,
 		dev_warn(dev, "No touch object detected\n");
 	}
 
+	mxt_debugfs_init(data);
+
 	dev_info(dev,
 		 "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
 		 info->family_id, info->variant_id, info->version >> 4,
@@ -2617,6 +2824,7 @@ static int mxt_remove(struct i2c_client *client)
 {
 	struct mxt_data *data = i2c_get_clientdata(client);
 
+	mxt_debugfs_remove(data);
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	free_irq(data->irq, data);
 	mxt_free_input_device(data);
-- 
2.5.0

