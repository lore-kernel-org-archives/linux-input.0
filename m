From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 7/9] Input: atmel_mxt_ts - add metadata to debugfs
Date: Thu, 24 Dec 2015 13:49:26 +0000
Message-ID: <1450964968-9792-8-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Add information to debugfs to allow a generic utility to retrieve
screen parameters and info.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 Documentation/ABI/testing/debugfs-heatmap | 60 +++++++++++++++++++++++++++++++
 drivers/input/touchscreen/atmel_mxt_ts.c  | 48 +++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 3 deletions(-)
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
index bccd7bc..3f12915 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -236,21 +236,31 @@ struct mxt_object {
 struct mxt_debug_datatype {
 	u8 mode;
 	char *name;
+	char *desc;
+	char *format;
 };
 
 struct mxt_debug_entry {
 	struct mxt_data *data;
 	const struct mxt_debug_datatype *datatype;
+	u16 width;
+	u16 height;
+	struct debugfs_blob_wrapper format_wrapper;
+	struct debugfs_blob_wrapper desc_wrapper;
 };
 
 static const struct mxt_debug_datatype mxt_dbg_datatypes[] = {
 	{
 		.mode = MXT_DIAGNOSTIC_REFS,
 		.name = "refs",
+		.desc = "Mutual Capacitance References",
+		.format = "uint16",
 	},
 	{
 		.mode = MXT_DIAGNOSTIC_DELTAS,
 		.name = "deltas",
+		.desc = "Mutual Capacitance Deltas",
+		.format = "int16",
 	},
 };
 
@@ -2286,6 +2296,7 @@ static void mxt_debugfs_init(struct mxt_data *data)
 	char dirname[50];
 	struct dentry *dent;
 	struct mxt_debug_entry *e;
+	struct dentry *dir;
 	int i;
 
 	object = mxt_get_object(data, MXT_GEN_COMMAND_T6);
@@ -2337,9 +2348,40 @@ static void mxt_debugfs_init(struct mxt_data *data)
 		e->data = data;
 		e->datatype = mxt_dbg_datatypes + i;
 
-		dent = debugfs_create_file(mxt_dbg_datatypes[i].name, S_IRUGO,
-					   dbg->debugfs_dir, e,
-					   &mxt_debugfs_data_ops);
+		dir = debugfs_create_dir(mxt_dbg_datatypes[i].name,
+					 dbg->debugfs_dir);
+		if (!dir)
+			goto error;
+
+		e->width = data->xyswitch ? data->ysize : data->xsize;
+		e->height = data->xyswitch ? data->xsize : data->ysize;
+
+		e->format_wrapper.data = (void *)e->datatype->format;
+		e->format_wrapper.size = strlen(e->datatype->format);
+		dent = debugfs_create_blob("format", S_IRUGO,
+					   dir, &e->format_wrapper);
+		if (!dent)
+			goto error;
+
+		e->desc_wrapper.data = (void *)e->datatype->desc;
+		e->desc_wrapper.size = strlen(e->datatype->desc);
+		dent = debugfs_create_blob("name", S_IRUGO,
+					   dir, &e->desc_wrapper);
+		if (!dent)
+			goto error;
+
+		dent = debugfs_create_u16("width", S_IRUGO,
+					  dir, &e->width);
+		if (!dent)
+			goto error;
+
+		dent = debugfs_create_u16("height", S_IRUGO,
+					  dir, &e->height);
+		if (!dent)
+			goto error;
+
+		dent = debugfs_create_file("data", S_IRUGO,
+					   dir, e, &mxt_debugfs_data_ops);
 		if (!dent)
 			goto error;
 	}
-- 
2.5.0
