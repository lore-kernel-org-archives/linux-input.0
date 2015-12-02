From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC 7/8] Input: atmel_mxt_ts - add metadata to debugfs
Date: Wed,  2 Dec 2015 20:42:30 +0000
Message-ID: <1449088951-7069-8-git-send-email-nick.dyer@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Add information to debugfs to allow a generic utility to retrieve
screen parameters and info.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 Documentation/ABI/testing/debugfs-heatmap | 60 +++++++++++++++++++++++++++++++
 drivers/input/touchscreen/atmel_mxt_ts.c  | 46 ++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-heatmap

diff --git a/Documentation/ABI/testing/debugfs-heatmap b/Documentation/ABI/testing/debugfs-heatmap
new file mode 100644
index 0000000..9246340
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-heatmap
@@ -0,0 +1,60 @@
+What:		/sys/kernel/debug/heatmap-dev_driver_string-dev_name/
+Date:
+KernelVersion:
+Contact:
+Description:
+	A directory will be created under heatmap for each device which
+	provides heatmap data.
+
+What:		/sys/kernel/debug/heatmap-dev_driver_string-dev_name/datatype/
+Date:
+KernelVersion:
+Contact:
+Description:
+	The device can have multiple heatmap data types. A directory is created
+	for each one.
+
+What:		/sys/kernel/debug/heatmap-xxx/datatype/format
+Date:
+KernelVersion:
+Contact:
+Description:
+	Specifies the type of each data value, one of:
+		uint8
+		uint16
+		uint32
+		int8
+		int16
+		int32
+
+What:		/sys/kernel/debug/heatmap-xxx/datatype/width
+Date:
+KernelVersion:
+Contact:
+Description:
+	The width of the data.
+
+What:		/sys/kernel/debug/heatmap-xxx/datatype/height
+Date:
+KernelVersion:
+Contact:
+Description:
+	The height of the data.
+
+What:		/sys/kernel/debug/heatmap-xxx/datatype/name
+Date:
+KernelVersion:
+Contact:
+Description:
+	Display name for the data.
+
+What:		/sys/kernel/debug/heatmap-xxx/datatype/data
+Date:
+KernelVersion:
+Contact:
+Description:
+	Binary attribute for the data.
+
+	The orientation of the data should correspond to the co-ordinates
+	reported to the input layer. Starting at the top left hand corner, rows
+	then columns.  The endianness of data values will be as per host cpu.
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 49fbe2a..dbe9ebb 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -236,23 +236,33 @@ struct mxt_object {
 struct mxt_debug_datatype {
 	u8 mode;
 	char *name;
+	char *desc;
+	char *format;
 };
 
 struct mxt_debug_datatype_meta {
 	struct mxt_data *data;
 	const struct mxt_debug_datatype *datatype;
 	struct dentry *dent;
+	u16 width;
+	u16 height;
 	void *buf;
+	struct debugfs_blob_wrapper format_wrapper;
+	struct debugfs_blob_wrapper desc_wrapper;
 };
 
 static const struct mxt_debug_datatype datatypes[] = {
 	{
 		.mode = MXT_DIAGNOSTIC_REFS,
 		.name = "refs",
+		.desc = "Mutual Capacitance References",
+		.format = "uint16",
 	},
 	{
 		.mode = MXT_DIAGNOSTIC_DELTAS,
 		.name = "deltas",
+		.format = "int16",
+		.desc = "Mutual Capacitance Deltas",
 	}
 };
 
@@ -2277,6 +2287,7 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	struct mxt_dbg *dbg = &data->dbg;
 	struct mxt_object *object;
 	struct dentry *dent;
+	struct dentry *dir;
 	struct mxt_debug_datatype_meta *dtm;
 	char dirname[50];
 	int i;
@@ -2333,13 +2344,42 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	for (i = 0; i < ARRAY_SIZE(datatypes); i++) {
 		dtm = &data->dbg.dt_meta[i];
 
+		dir = debugfs_create_dir(datatypes[i].name, dbg->debugfs_dir);
+		if (!dir)
+			goto error;
+
 		dtm->data = data;
 		dtm->datatype = datatypes + i;
+		dtm->width = data->xy_switch ? data->ysize : data->xsize;
+		dtm->height = data->xy_switch ? data->xsize: data->ysize;
 		dtm->buf = dbg->debug_buf;
 
-		dent = debugfs_create_file(datatypes[i].name,
-				S_IRUGO, dbg->debugfs_dir,
-				dtm, &atmel_mxt_dbg_fops);
+		dtm->format_wrapper.data = (void *)dtm->datatype->format;
+		dtm->format_wrapper.size = strlen(dtm->datatype->format);
+		dent = debugfs_create_blob("format", S_IRUGO,
+					   dir, &dtm->format_wrapper);
+		if (!dent)
+			goto error;
+
+		dtm->desc_wrapper.data = (void *)dtm->datatype->desc;
+		dtm->desc_wrapper.size = strlen(dtm->datatype->desc);
+		dent = debugfs_create_blob("name", S_IRUGO,
+					   dir, &dtm->desc_wrapper);
+		if (!dent)
+			goto error;
+
+		dent = debugfs_create_u16("width", S_IRUGO,
+					  dir, &dtm->width);
+		if (!dent)
+			goto error;
+
+		dent = debugfs_create_u16("height", S_IRUGO,
+					  dir, &dtm->height);
+		if (!dent)
+			goto error;
+
+		dent = debugfs_create_file("data", S_IRUGO, dir, dtm,
+					   &atmel_mxt_dbg_fops);
 		if (!dent)
 			goto error;
 
-- 
2.5.0
