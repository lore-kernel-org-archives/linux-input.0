From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9] Input: synaptics-rmi4 - add support for F34 V7
 bootloader
Date: Sun, 11 Dec 2016 00:03:49 -0800
Message-ID: <20161211080349.GB39300@dtor-ws>
References: <1481415506-5152-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35432 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcLKIDw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Dec 2016 03:03:52 -0500
Content-Disposition: inline
In-Reply-To: <1481415506-5152-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi NIck,

On Sun, Dec 11, 2016 at 12:18:26AM +0000, Nick Dyer wrote:
> +static void rmi_f34v7_parse_img_header_10_bl_container(struct f34_data *f34,
> +						       const u8 *image)
> +{
> +	int i;
> +	int num_of_containers;
> +	unsigned int addr;
> +	unsigned int container_id;
> +	unsigned int length;
> +	const u8 *content;
> +	struct container_descriptor *descriptor;
> +
> +	BUG_ON(f34->v7.img.bootloader.size < 4);

Killing the box because you got bad firmware is not very nice...

> +
> +	num_of_containers = (f34->v7.img.bootloader.size - 4) / 4;

Wouldn't

	num_of_containes = f34->v7.img.bootloader.size / 4 - 1;

give the same result but be less "suspicious". The variable is 'int' so
for size < 4 we'll get a negative and the loop won't execute.

> +
> +	for (i = 1; i <= num_of_containers; i++) {
> +		addr = get_unaligned_le32(f34->v7.img.bootloader.data + i*4);
> +		descriptor = (struct container_descriptor *)(image + addr);

This casts away constness, which is not nice. DOes it still work if you
apply the below on top?

Thanks!

-- 
Dmitry


Input: synaptics-rmi4 - misc f34v7 changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f34.h   |    6 ++--
 drivers/input/rmi4/rmi_f34v7.c |   64 ++++++++++++++++------------------------
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
index 12827f4..2c21056 100644
--- a/drivers/input/rmi4/rmi_f34.h
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -145,7 +145,7 @@ struct f34v7_data_1_5 {
 } __packed;
 
 struct block_data {
-	const u8 *data;
+	const void *data;
 	int size;
 };
 
@@ -290,8 +290,8 @@ struct f34v7_data {
 	struct physical_address phyaddr;
 	struct image_metadata img;
 
-	const u8 *config_data;
-	const u8 *image;
+	const void *config_data;
+	const void *image;
 };
 
 struct f34_data {
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index f7b6c0a..ca31f95 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -348,7 +348,7 @@ static int rmi_f34v7_read_f34v7_partition_table(struct f34_data *f34)
 }
 
 static void rmi_f34v7_parse_partition_table(struct f34_data *f34,
-					    const u8 *partition_table,
+					    const void *partition_table,
 					    struct block_count *blkcount,
 					    struct physical_address *phyaddr)
 {
@@ -356,11 +356,11 @@ static void rmi_f34v7_parse_partition_table(struct f34_data *f34,
 	int index;
 	u16 partition_length;
 	u16 physical_address;
-	struct partition_table *ptable;
+	const struct partition_table *ptable;
 
 	for (i = 0; i < f34->v7.partitions; i++) {
 		index = i * 8 + 2;
-		ptable = (struct partition_table *)&partition_table[index];
+		ptable = partition_table + index;
 		partition_length = le16_to_cpu(ptable->partition_length);
 		physical_address = le16_to_cpu(ptable->start_physical_address);
 		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
@@ -503,7 +503,7 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
 
 	f34->v7.block_size = le16_to_cpu(query_1_7.block_size);
 	f34->v7.flash_config_length =
-				le16_to_cpu(query_1_7.flash_config_length);
+			le16_to_cpu(query_1_7.flash_config_length);
 	f34->v7.payload_length = le16_to_cpu(query_1_7.payload_length);
 
 	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: f34->v7.block_size = %d\n",
@@ -812,7 +812,7 @@ static int rmi_f34v7_read_f34v7_blocks(struct f34_data *f34, u16 block_cnt,
 }
 
 static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
-					const u8 *block_ptr, u16 block_cnt,
+					const void *block_ptr, u16 block_cnt,
 					u8 command)
 {
 	int ret;
@@ -915,17 +915,10 @@ static int rmi_f34v7_write_dp_config(struct f34_data *f34)
 
 static int rmi_f34v7_write_guest_code(struct f34_data *f34)
 {
-	u16 blk_count;
-	int ret;
-
-	blk_count = f34->v7.img.guest_code.size / f34->v7.block_size;
-
-	ret = rmi_f34v7_write_f34v7_blocks(f34, f34->v7.img.guest_code.data,
-					   blk_count, v7_CMD_WRITE_GUEST_CODE);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return rmi_f34v7_write_f34v7_blocks(f34, f34->v7.img.guest_code.data,
+					    f34->v7.img.guest_code.size /
+							f34->v7.block_size,
+					    v7_CMD_WRITE_GUEST_CODE);
 }
 
 static int rmi_f34v7_write_flash_config(struct f34_data *f34)
@@ -1025,14 +1018,14 @@ static void rmi_f34v7_compare_partition_tables(struct f34_data *f34)
 		return;
 	}
 
-	if (f34->v7.has_display_cfg
-	    && f34->v7.phyaddr.dp_config != f34->v7.img.phyaddr.dp_config) {
+	if (f34->v7.has_display_cfg &&
+	    f34->v7.phyaddr.dp_config != f34->v7.img.phyaddr.dp_config) {
 		f34->v7.new_partition_table = true;
 		return;
 	}
 
-	if (f34->v7.has_guest_code
-	    && f34->v7.phyaddr.guest_code != f34->v7.img.phyaddr.guest_code) {
+	if (f34->v7.has_guest_code &&
+	    f34->v7.phyaddr.guest_code != f34->v7.img.phyaddr.guest_code) {
 		f34->v7.new_partition_table = true;
 		return;
 	}
@@ -1041,23 +1034,21 @@ static void rmi_f34v7_compare_partition_tables(struct f34_data *f34)
 }
 
 static void rmi_f34v7_parse_img_header_10_bl_container(struct f34_data *f34,
-						       const u8 *image)
+						       const void *image)
 {
 	int i;
 	int num_of_containers;
 	unsigned int addr;
 	unsigned int container_id;
 	unsigned int length;
-	const u8 *content;
-	struct container_descriptor *descriptor;
+	const void *content;
+	const struct container_descriptor *descriptor;
 
-	BUG_ON(f34->v7.img.bootloader.size < 4);
-
-	num_of_containers = (f34->v7.img.bootloader.size - 4) / 4;
+	num_of_containers = f34->v7.img.bootloader.size / 4 - 1;
 
 	for (i = 1; i <= num_of_containers; i++) {
-		addr = get_unaligned_le32(f34->v7.img.bootloader.data + i*4);
-		descriptor = (struct container_descriptor *)(image + addr);
+		addr = get_unaligned_le32(f34->v7.img.bootloader.data + i * 4);
+		descriptor = image + addr;
 		container_id = le16_to_cpu(descriptor->container_id);
 		content = image + le32_to_cpu(descriptor->content_address);
 		length = le32_to_cpu(descriptor->content_length);
@@ -1086,13 +1077,10 @@ static void rmi_f34v7_parse_image_header_10(struct f34_data *f34)
 	unsigned int offset;
 	unsigned int container_id;
 	unsigned int length;
-	const u8 *image;
+	const void *image = f34->v7.image;
 	const u8 *content;
-	struct container_descriptor *descriptor;
-	struct image_header_10 *header;
-
-	image = f34->v7.image;
-	header = (struct image_header_10 *)image;
+	const struct container_descriptor *descriptor;
+	const struct image_header_10 *header = image;
 
 	f34->v7.img.checksum = le32_to_cpu(header->checksum);
 
@@ -1101,7 +1089,7 @@ static void rmi_f34v7_parse_image_header_10(struct f34_data *f34)
 
 	/* address of top level container */
 	offset = le32_to_cpu(header->top_level_container_start_addr);
-	descriptor = (struct container_descriptor *)(image + offset);
+	descriptor = image + offset;
 
 	/* address of top level container content */
 	offset = le32_to_cpu(descriptor->content_address);
@@ -1110,7 +1098,7 @@ static void rmi_f34v7_parse_image_header_10(struct f34_data *f34)
 	for (i = 0; i < num_of_containers; i++) {
 		addr = get_unaligned_le32(image + offset);
 		offset += 4;
-		descriptor = (struct container_descriptor *)(image + addr);
+		descriptor = image + addr;
 		container_id = le16_to_cpu(descriptor->container_id);
 		content = image + le32_to_cpu(descriptor->content_address);
 		length = le32_to_cpu(descriptor->content_length);
@@ -1164,9 +1152,7 @@ static void rmi_f34v7_parse_image_header_10(struct f34_data *f34)
 
 static int rmi_f34v7_parse_image_info(struct f34_data *f34)
 {
-	struct image_header_10 *header;
-
-	header = (struct image_header_10 *)f34->v7.image;
+	const struct image_header_10 *header = f34->v7.image;
 
 	memset(&f34->v7.img, 0x00, sizeof(f34->v7.img));
 
