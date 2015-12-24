From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 8/9] Input: atmel_mxt_ts - create debugfs info file
Date: Thu, 24 Dec 2015 13:49:27 +0000
Message-ID: <1450964968-9792-9-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:30461 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752813AbbLXNtj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 08:49:39 -0500
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Add files in debugfs directory with info about the chip and input device.

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
index 3f12915..05bacc6 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -274,6 +274,9 @@ struct mxt_dbg {
 	struct dentry *debugfs_dir;
 	struct mxt_debug_entry entries[ARRAY_SIZE(mxt_dbg_datatypes)];
 	struct mutex dbg_mutex;
+	struct debugfs_blob_wrapper input_name_wrapper;
+	char info[50];
+	struct debugfs_blob_wrapper info_wrapper;
 };
 #endif
 
@@ -2326,6 +2329,18 @@ static void mxt_debugfs_init(struct mxt_data *data)
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
 
@@ -2370,6 +2385,13 @@ static void mxt_debugfs_init(struct mxt_data *data)
 		if (!dent)
 			goto error;
 
+		dbg->input_name_wrapper.data = (void *)data->input_dev->name;
+		dbg->input_name_wrapper.size = strlen(data->input_dev->name);
+		dent = debugfs_create_blob("input_name", S_IRUGO,
+					   dir, &dbg->input_name_wrapper);
+		if (!dent)
+			goto error;
+
 		dent = debugfs_create_u16("width", S_IRUGO,
 					  dir, &e->width);
 		if (!dent)
-- 
2.5.0

