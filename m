From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC 8/8] Input: atmel_mxt_ts - create debugfs info file
Date: Wed,  2 Dec 2015 20:42:31 +0000
Message-ID: <1449088951-7069-9-git-send-email-nick.dyer@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Add a file in debugfs directory with info about the chip.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 Documentation/ABI/testing/debugfs-heatmap | 14 ++++++++++++++
 drivers/input/touchscreen/atmel_mxt_ts.c  | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-heatmap b/Documentation/ABI/testing/debugfs-heatmap
index 9246340..95668a5 100644
--- a/Documentation/ABI/testing/debugfs-heatmap
+++ b/Documentation/ABI/testing/debugfs-heatmap
@@ -6,6 +6,13 @@ Description:
 	A directory will be created under heatmap for each device which
 	provides heatmap data.
 
+What:           /sys/kernel/debug/heatmap-dev_driver_string-dev_name/info
+Date:
+KernelVersion:
+Contact:
+Description:
+        Info relating to the device, eg hardware/firmware version
+
 What:		/sys/kernel/debug/heatmap-dev_driver_string-dev_name/datatype/
 Date:
 KernelVersion:
@@ -48,6 +55,13 @@ Contact:
 Description:
 	Display name for the data.
 
+What:		/sys/kernel/debug/heatmap-xxx/datatype/input_name
+Date:
+KernelVersion:
+Contact:
+Description:
+	The name of the corresponding input device, if relevant.
+
 What:		/sys/kernel/debug/heatmap-xxx/datatype/data
 Date:
 KernelVersion:
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dbe9ebb..34f3d86 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -277,7 +277,10 @@ struct mxt_dbg {
 	struct dentry *debugfs_dir;
 	struct dentry *deltas_file;
 	struct dentry *refs_file;
+	struct debugfs_blob_wrapper input_name_wrapper;
 	struct mxt_debug_datatype_meta dt_meta[ARRAY_SIZE(datatypes)];
+	char info[50];
+	struct debugfs_blob_wrapper info_wrapper;
 };
 #endif
 
@@ -2319,6 +2322,18 @@ static void mxt_debugfs_init(struct mxt_data *data)
 		return;
 	}
 
+	dbg->info_wrapper.data = dbg->info;
+	dbg->info_wrapper.size = sizeof(dbg->info);
+	scnprintf(dbg->info, sizeof(dbg->info),
+		 "Family: %u Variant: %u Firmware V%u.%u.%02X",
+		 info->family_id, info->variant_id, info->version >> 4,
+		 info->version & 0xf, info->build);
+
+	dent = debugfs_create_blob("info", S_IRUGO, dbg->debugfs_dir,
+			&dbg->info_wrapper);
+	if (!dent)
+		goto error;
+
 	/* Calculate size of data and allocate buffer */
 	dbg->t37_nodes = data->xsize * data->ysize;
 
@@ -2383,6 +2398,13 @@ static void mxt_debugfs_init(struct mxt_data *data)
 		if (!dent)
 			goto error;
 
+		dbg->input_name_wrapper.data = (void *)data->input_dev->name;
+		dbg->input_name_wrapper.size = strlen(data->input_dev->name);
+		dent = debugfs_create_blob("input_name", S_IRUGO,
+					   dir, &dbg->input_name_wrapper);
+		if (!dent)
+			goto error;
+
 		dtm->dent = dent;
 		dent->d_inode->i_size = dbg->t37_nodes * sizeof(u16);
 	}
-- 
2.5.0
