From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 02/05] input synaptics-rmi4: Add some additional F01 properties for the use of reflash.
Date: Fri, 7 Mar 2014 18:29:52 -0800
Message-ID: <1394245795-17347-2-git-send-email-cheiny@synaptics.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:2175 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaCHCaF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 21:30:05 -0500
In-Reply-To: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

The reflash code will need access to the firmware build ID and
some other info.  As long as we're taking the scenic route to
the firmware build ID, we remember a number of other interesting
settings for use by diagnostic modules.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_f01.c | 170 ++++++++++++++++++++++++++++++++++++++++---
 drivers/input/rmi4/rmi_f01.h | 101 +++++++++++++++++++++++++
 2 files changed, 262 insertions(+), 9 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 41cb795..8504865 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -48,11 +48,18 @@ struct f01_data {
 	unsigned int num_of_irq_regs;
 };
 
+#define PACKAGE_ID_BYTES 4
+#define BUILD_ID_BYTES 3
+
 int rmi_f01_read_properties(struct rmi_device *rmi_dev, u16 query_base_addr,
 				   struct f01_basic_properties *props)
 {
 	u8 basic_query[RMI_F01_BASIC_QUERY_LEN];
+	u8 info_buf[4];
 	int error;
+	int i;
+	u16 query_addr = query_base_addr;
+	u16 prod_info_addr;
 
 	error = rmi_read_block(rmi_dev, query_base_addr,
 			       basic_query, sizeof(basic_query));
@@ -70,19 +77,164 @@ int rmi_f01_read_properties(struct rmi_device *rmi_dev, u16 query_base_addr,
 			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE;
 	props->has_adjustable_doze_holdoff =
 			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF;
+	props->has_query42 = basic_query[1] & RMI_F01_QRY1_HAS_PROPS_2;
+
+	props->productinfo =
+			((basic_query[2] & RMI_F01_QRY2_PRODINFO_MASK) << 7) |
+			(basic_query[3] & RMI_F01_QRY2_PRODINFO_MASK);
 
 	snprintf(props->dom, sizeof(props->dom), "20%02d/%02d/%02d",
 		 basic_query[5] & RMI_F01_QRY5_YEAR_MASK,
 		 basic_query[6] & RMI_F01_QRY6_MONTH_MASK,
 		 basic_query[7] & RMI_F01_QRY7_DAY_MASK);
 
-	memcpy(props->product_id, &basic_query[11],
-		RMI_PRODUCT_ID_LENGTH);
+	memcpy(props->product_id, &basic_query[11], RMI_PRODUCT_ID_LENGTH);
 	props->product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
+	query_addr += 11;
 
-	props->productinfo =
-			((basic_query[2] & RMI_F01_QRY2_PRODINFO_MASK) << 7) |
-			(basic_query[3] & RMI_F01_QRY2_PRODINFO_MASK);
+
+	error = rmi_read_block(rmi_dev, query_addr, props->product_id,
+				RMI_PRODUCT_ID_LENGTH);
+	if (error < 0) {
+		dev_err(&rmi_dev->dev, "Failed to read product ID.\n");
+		return error;
+	}
+	props->product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
+
+	/* We'll come back and use this later, depending on some other query
+	 * bits.
+	 */
+	prod_info_addr = query_addr + 6;
+
+	query_addr += RMI_PRODUCT_ID_LENGTH;
+	if (props->has_lts) {
+		error = rmi_read(rmi_dev, query_addr, info_buf);
+		if (error < 0) {
+			dev_err(&rmi_dev->dev, "Failed to read LTS info.\n");
+			return error;
+		}
+		props->slave_asic_rows = info_buf[0] &
+				RMI_F01_QRY21_SLAVE_ROWS_MASK;
+		props->slave_asic_columns = (info_buf[1] &
+				RMI_F01_QRY21_SLAVE_COLUMNS_MASK) >> 3;
+		query_addr++;
+	}
+
+	if (props->has_sensor_id) {
+		error = rmi_read(rmi_dev, query_addr, &props->sensor_id);
+		if (error < 0) {
+			dev_err(&rmi_dev->dev, "Failed to read sensor ID.\n");
+			return error;
+		}
+		query_addr++;
+	}
+
+	/* Maybe skip a block of undefined LTS registers. */
+	if (props->has_lts)
+		query_addr += RMI_F01_LTS_RESERVED_SIZE;
+
+	if (props->has_query42) {
+		error = rmi_read(rmi_dev, query_addr, info_buf);
+		if (error < 0) {
+			dev_err(&rmi_dev->dev, "Failed to read additional properties.\n");
+			return error;
+		}
+		props->has_ds4_queries = info_buf[0] &
+				RMI_F01_QRY42_DS4_QUERIES;
+		props->has_multi_physical = info_buf[0] &
+				RMI_F01_QRY42_MULTI_PHYS;
+		props->has_guest = info_buf[0] & RMI_F01_QRY42_GUEST;
+		props->has_swr = info_buf[0] & RMI_F01_QRY42_SWR;
+		props->has_nominal_report_rate = info_buf[0] &
+				RMI_F01_QRY42_NOMINAL_REPORT;
+		props->has_recalibration_interval = info_buf[0] &
+				RMI_F01_QRY42_RECAL_INTERVAL;
+		query_addr++;
+	}
+
+	if (props->has_ds4_queries) {
+		error = rmi_read(rmi_dev, query_addr, &props->ds4_query_length);
+		if (error < 0) {
+			dev_err(&rmi_dev->dev, "Failed to read DS4 query length size.\n");
+			return error;
+		}
+		query_addr++;
+	}
+
+	for (i = 1; i <= props->ds4_query_length; i++) {
+		u8 val;
+		error = rmi_read(rmi_dev, query_addr, &val);
+		query_addr++;
+		if (error < 0) {
+			dev_err(&rmi_dev->dev, "Failed to read F01_RMI_QUERY43.%02d, code: %d.\n",
+				i, error);
+			continue;
+		}
+		switch (i) {
+		case 1:
+			props->has_package_id_query = val &
+					RMI_F01_QRY43_01_PACKAGE_ID;
+			props->has_build_id_query = val &
+					RMI_F01_QRY43_01_BUILD_ID;
+			props->has_reset_query = val & RMI_F01_QRY43_01_RESET;
+			props->has_maskrev_query = val &
+					RMI_F01_QRY43_01_PACKAGE_ID;
+			break;
+		case 2:
+			props->has_i2c_control = val & RMI_F01_QRY43_02_I2C_CTL;
+			props->has_spi_control = val & RMI_F01_QRY43_02_SPI_CTL;
+			props->has_attn_control = val &
+					RMI_F01_QRY43_02_ATTN_CTL;
+			props->has_win8_vendor_info = val &
+					RMI_F01_QRY43_02_WIN8;
+			props->has_timestamp = val & RMI_F01_QRY43_02_TIMESTAMP;
+			break;
+		case 3:
+			props->has_tool_id_query = val &
+					RMI_F01_QRY43_03_TOOL_ID;
+			props->has_fw_revision_query = val &
+					RMI_F01_QRY43_03_FW_REVISION;
+			break;
+		default:
+			dev_warn(&rmi_dev->dev, "No handling for F01_RMI_QUERY43.%02d.\n",
+				 i);
+		}
+	}
+
+	/* If present, the ASIC package ID registers are overlaid on the
+	 * product ID. Go back to the right address (saved previously) and
+	 * read them.
+	 */
+	if (props->has_package_id_query) {
+		error = rmi_read_block(rmi_dev, prod_info_addr, info_buf,
+				PACKAGE_ID_BYTES);
+		if (error < 0)
+			dev_warn(&rmi_dev->dev, "Failed to read package ID.\n");
+		else {
+			u16 *val = (u16 *)info_buf;
+			props->package_id = le16_to_cpu(*val);
+			val = (u16 *)(info_buf + 2);
+			props->package_rev = le16_to_cpu(*val);
+		}
+	}
+	prod_info_addr++;
+
+	/* The firmware build id (if present) is similarly overlaid on product
+	 * ID registers.  Go back again and read that data.
+	 */
+	if (props->has_build_id_query) {
+		error = rmi_read_block(rmi_dev, prod_info_addr, info_buf,
+				BUILD_ID_BYTES);
+		if (error < 0)
+			dev_warn(&rmi_dev->dev, "Failed to read FW build ID.\n");
+		else {
+			u16 *val = (u16 *)info_buf;
+			props->build_id = le16_to_cpu(*val);
+			props->build_id += info_buf[2] * 65536;
+			dev_info(&rmi_dev->dev, "FW build ID: %#08x (%u).\n",
+				props->build_id, props->build_id);
+		}
+	}
 
 	return 0;
 }
@@ -164,10 +316,10 @@ static int rmi_f01_probe(struct rmi_function *fn)
 		dev_err(&fn->dev, "Failed to read F01 properties.\n");
 		return error;
 	}
-
-	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s\n",
-		 f01->properties.manufacturer_id == 1 ? "Synaptics" : "unknown",
-		 f01->properties.product_id);
+	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s, fw build: %d.\n",
+		 f01->properties.manufacturer_id == 1 ?
+							"Synaptics" : "unknown",
+		 f01->properties.product_id, f01->properties.build_id);
 
 	/* Advance to interrupt control registers, then skip over them. */
 	ctrl_base_addr++;
diff --git a/drivers/input/rmi4/rmi_f01.h b/drivers/input/rmi4/rmi_f01.h
index 9e5cc2b..af82fb7 100644
--- a/drivers/input/rmi4/rmi_f01.h
+++ b/drivers/input/rmi4/rmi_f01.h
@@ -21,6 +21,9 @@
 
 /* Force a firmware reset of the sensor */
 #define RMI_F01_CMD_DEVICE_RESET	1
+#define RMI_F01_DEFAULT_RESET_DELAY_MS	100
+
+#define F01_SERIALIZATION_SIZE 7
 
 /* Various F01_RMI_QueryX bits */
 
@@ -41,20 +44,118 @@
 
 #define RMI_F01_BASIC_QUERY_LEN		21 /* From Query 00 through 20 */
 
+#define RMI_F01_QRY21_SLAVE_ROWS_MASK   0x07
+#define RMI_F01_QRY21_SLAVE_COLUMNS_MASK 0x38
+
+#define RMI_F01_LTS_RESERVED_SIZE 19
+
+#define RMI_F01_QRY42_DS4_QUERIES	(1 << 0)
+#define RMI_F01_QRY42_MULTI_PHYS	(1 << 1)
+#define RMI_F01_QRY42_GUEST		(1 << 2)
+#define RMI_F01_QRY42_SWR		(1 << 3)
+#define RMI_F01_QRY42_NOMINAL_REPORT	(1 << 4)
+#define RMI_F01_QRY42_RECAL_INTERVAL	(1 << 5)
+
+#define RMI_F01_QRY43_01_PACKAGE_ID     (1 << 0)
+#define RMI_F01_QRY43_01_BUILD_ID       (1 << 1)
+#define RMI_F01_QRY43_01_RESET          (1 << 2)
+#define RMI_F01_QRY43_01_MASK_REV       (1 << 3)
+
+#define RMI_F01_QRY43_02_I2C_CTL	(1 << 0)
+#define RMI_F01_QRY43_02_SPI_CTL	(1 << 1)
+#define RMI_F01_QRY43_02_ATTN_CTL	(1 << 2)
+#define RMI_F01_QRY43_02_WIN8		(1 << 3)
+#define RMI_F01_QRY43_02_TIMESTAMP	(1 << 4)
+
+#define RMI_F01_QRY43_03_TOOL_ID	(1 << 0)
+#define RMI_F01_QRY43_03_FW_REVISION	(1 << 1)
+
+#define RMI_F01_QRY44_RST_ENABLED	(1 << 0)
+#define RMI_F01_QRY44_RST_POLARITY	(1 << 1)
+#define RMI_F01_QRY44_PULLUP_ENABLED	(1 << 2)
+#define RMI_F01_QRY44_RST_PIN_MASK	0xF0
+
+#define RMI_TOOL_ID_LENGTH		16
+#define RMI_FW_REVISION_LENGTH		16
+
 struct f01_basic_properties {
 	u8 manufacturer_id;
 	bool has_lts;
+	bool has_sensor_id;
 	bool has_adjustable_doze;
 	bool has_adjustable_doze_holdoff;
+	bool has_query42;
 	char dom[11]; /* YYYY/MM/DD + '\0' */
 	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
 	u16 productinfo;
+	u16 package_id;
+	u16 package_rev;
+	u32 build_id;
+
+	/* These are meaningful only if has_lts is true. */
+	u8 slave_asic_rows;
+	u8 slave_asic_columns;
+
+	/* This is meaningful only if has_sensor_id is true. */
+	u8 sensor_id;
+
+	/* These are meaningful only if has_query42 is true. */
+	bool has_ds4_queries;
+	bool has_multi_physical;
+	bool has_guest;
+	bool has_swr;
+	bool has_nominal_report_rate;
+	bool has_recalibration_interval;
+
+	/* Tells how many of the Query43.xx registers are present.
+	 */
+	u8 ds4_query_length;
+
+	/* Query 43.1 */
+	bool has_package_id_query;
+	bool has_build_id_query;
+	bool has_reset_query;
+	bool has_maskrev_query;
+
+	/* Query 43.2 */
+	bool has_i2c_control;
+	bool has_spi_control;
+	bool has_attn_control;
+	bool has_win8_vendor_info;
+	bool has_timestamp;
+
+	/* Query 43.3 */
+	bool has_tool_id_query;
+	bool has_fw_revision_query;
+
+	/* Query 44 */
+	bool reset_enabled;
+	bool reset_polarity;
+	bool pullup_enabled;
+	u8 reset_pin;
+
+	/* Query 45 */
+	char tool_id[RMI_TOOL_ID_LENGTH + 1];
+
+	/* Query 46 */
+	char fw_revision[RMI_FW_REVISION_LENGTH + 1];
 };
 
+
+/** Read the F01 query registers and populate the basic_properties structure.
+ * @rmi_dev - the device to be queries.
+ * @query_base_addr - address of the start of the query registers.
+ * @props - pointer to the structure to be filled in.
+ */
+int rmi_f01_read_properties(struct rmi_device *rmi_dev, u16 query_base_addr,
+			    struct f01_basic_properties *props);
+
 /* F01 device status bits */
 
 /* Most recent device status event */
 #define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
+/* Indicates that flash programming is enabled (bootloader mode). */
+#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
 /* The device has lost its configuration for some reason. */
 #define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
 
