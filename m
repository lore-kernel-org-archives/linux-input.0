From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 9/9] Input: atmel_mxt_ts - single node diagnostic data support
Date: Thu, 24 Dec 2015 13:49:28 +0000
Message-ID: <1450964968-9792-10-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:4607 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812AbbLXNtk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 08:49:40 -0500
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Add support for retrieving a single node of data at high rate.
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 60 +++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 05bacc6..fd3aaae 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -238,6 +238,7 @@ struct mxt_debug_datatype {
 	char *name;
 	char *desc;
 	char *format;
+	bool single_node;
 };
 
 struct mxt_debug_entry {
@@ -262,6 +263,20 @@ static const struct mxt_debug_datatype mxt_dbg_datatypes[] = {
 		.desc = "Mutual Capacitance Deltas",
 		.format = "int16",
 	},
+	{
+		.mode = MXT_DIAGNOSTIC_REFS,
+		.name = "single_node_refs",
+		.desc = "Single Node References",
+		.format = "uint16",
+		.single_node = true,
+	},
+	{
+		.mode = MXT_DIAGNOSTIC_DELTAS,
+		.name = "single_node_deltas",
+		.format = "int16",
+		.desc = "Single Node Deltas",
+		.single_node = true,
+	},
 };
 
 struct mxt_dbg {
@@ -270,6 +285,7 @@ struct mxt_dbg {
 	struct t37_debug *t37_buf;
 	unsigned int t37_pages;
 	unsigned int t37_nodes;
+	unsigned int single_node_ofs;
 
 	struct dentry *debugfs_dir;
 	struct mxt_debug_entry entries[ARRAY_SIZE(mxt_dbg_datatypes)];
@@ -2216,14 +2232,16 @@ static int mxt_read_diagnostic_debug(struct seq_file *s, void *d)
 	struct mxt_dbg *dbg = &data->dbg;
 	int retries = 0;
 	int page;
+	int pages = e->datatype->single_node ? 1 : dbg->t37_pages;
 	int ret;
 	u8 mode = e->datatype->mode;
 	u8 cmd = mode;
 	struct t37_debug *p;
+	u16 val;
 
 	mutex_lock(&dbg->dbg_mutex);
 
-	for (page = 0; page < dbg->t37_pages; page++) {
+	for (page = 0; page < pages; page++) {
 		p = dbg->t37_buf + page;
 
 		ret = mxt_write_reg(data->client, dbg->diag_cmd_address,
@@ -2263,7 +2281,14 @@ wait_cmd:
 		cmd = MXT_DIAGNOSTIC_PAGEUP;
 	}
 
-	ret = mxt_convert_debug_pages(s, data);
+	if (e->datatype->single_node) {
+		val = get_unaligned_le16(&dbg->t37_buf[0]
+					 .data[dbg->single_node_ofs]);
+		seq_write(s, &val, sizeof(u16));
+		ret = 0;
+	} else {
+		ret = mxt_convert_debug_pages(s, data);
+	}
 
 release:
 	mutex_unlock(&dbg->dbg_mutex);
@@ -2273,7 +2298,12 @@ release:
 static int mxt_debugfs_data_open(struct inode *inode, struct file *f)
 {
 	struct mxt_debug_entry *e = inode->i_private;
-	size_t size = e->data->dbg.t37_nodes * sizeof(u16);
+	size_t size;
+
+	if (e->datatype->single_node)
+		size = sizeof(u16);
+	else
+		size = e->data->dbg.t37_nodes * sizeof(u16);
 
 	return single_open_size(f, mxt_read_diagnostic_debug, e, size);
 }
@@ -2291,6 +2321,19 @@ static void mxt_debugfs_remove(struct mxt_data *data)
 	debugfs_remove_recursive(data->dbg.debugfs_dir);
 }
 
+static void mxt_debugfs_calc_single_node_ofs(struct mxt_data *data)
+{
+	struct mxt_info *info = &data->info;
+	int ofs = data->ysize / 2;
+
+	while ((ofs + info->matrix_ysize) <= (MXT_DIAGNOSTIC_SIZE/sizeof(u16)))
+		ofs += info->matrix_ysize;
+
+	dev_dbg(&data->client->dev, "Single node ofs: %d\n", ofs);
+
+	data->dbg.single_node_ofs = ofs;
+}
+
 static void mxt_debugfs_init(struct mxt_data *data)
 {
 	struct mxt_info *info = &data->info;
@@ -2358,6 +2401,8 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	if (!dbg->t37_buf)
 		goto error;
 
+	mxt_debugfs_calc_single_node_ofs(data);
+
 	for (i = 0; i < ARRAY_SIZE(mxt_dbg_datatypes); i++) {
 		e = &dbg->entries[i];
 		e->data = data;
@@ -2368,8 +2413,13 @@ static void mxt_debugfs_init(struct mxt_data *data)
 		if (!dir)
 			goto error;
 
-		e->width = data->xyswitch ? data->ysize : data->xsize;
-		e->height = data->xyswitch ? data->xsize : data->ysize;
+		if (e->datatype->single_node) {
+			e->width = 1;
+			e->height = 1;
+		} else {
+			e->width = data->xyswitch ? data->ysize : data->xsize;
+			e->height = data->xyswitch ? data->xsize : data->ysize;
+		}
 
 		e->format_wrapper.data = (void *)e->datatype->format;
 		e->format_wrapper.size = strlen(e->datatype->format);
-- 
2.5.0

