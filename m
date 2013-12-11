From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: Eliminate packed structs in PDT handling
Date: Tue, 10 Dec 2013 19:10:42 -0800
Message-ID: <1386731442-31146-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:9563 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab3LKDKo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 22:10:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This converts the PDT handling routines from using bitfields in packed structs,
converting to bitmasks and shifts to parse out bitfields, nibbles, and so on.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joerie de Gram <j.de.gram@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

This patch implements changes to the synaptics-rmi4 branch of
Dmitry's input tree.  The base for the patch is commit
f154022b208a59b048f52b7b5d58a5ec1949b96e.

 drivers/input/rmi4/rmi_driver.c | 45 +++++++++++++++++++++++++++-------------
 drivers/input/rmi4/rmi_driver.h | 46 +++++++++++++++--------------------------
 2 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index dffbfa0..a30c7d3 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -483,6 +483,31 @@ int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
 		return -ENOMEM;
 }
 
+int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
+			u16 pdt_address)
+{
+	u8 buf[RMI_PDT_ENTRY_SIZE];
+	int error;
+
+	error = rmi_read_block(rmi_dev, pdt_address, buf, RMI_PDT_ENTRY_SIZE);
+	if (error < 0) {
+		dev_err(&rmi_dev->dev, "Read PDT entry at %#06x failed, code: %d.\n",
+				pdt_address, error);
+		return error;
+	}
+
+	entry->query_base_addr = buf[0];
+	entry->command_base_addr = buf[1];
+	entry->control_base_addr = buf[2];
+	entry->data_base_addr = buf[3];
+	entry->interrupt_source_count = buf[4] & RMI_PDT_INT_SOURCE_COUNT_MASK;
+	entry->function_version = (buf[4] & RMI_PDT_FUNCTION_VERSION_MASK) >> 5;
+	entry->function_number = buf[5];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rmi_read_pdt_entry);
+
 static void rmi_driver_copy_pdt_to_fd(struct pdt_entry *pdt,
 				      struct rmi_function_descriptor *fd,
 				      u16 page_start)
@@ -572,14 +597,10 @@ static int reset_and_reflash(struct rmi_device *rmi_dev)
 		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
 
 		done = true;
-		for (i = pdt_start; i >= pdt_end; i -= sizeof(pdt_entry)) {
-			retval = rmi_read_block(rmi_dev, i, &pdt_entry,
-					       sizeof(pdt_entry));
-			if (retval != sizeof(pdt_entry)) {
-				dev_err(dev, "Read PDT entry at %#06x failed, code = %d.\n",
-						i, retval);
+		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
+			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
+			if (retval < 0)
 				return retval;
-			}
 
 			if (RMI4_END_OF_PDT(pdt_entry.function_number))
 				break;
@@ -634,14 +655,10 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev)
 		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
 
 		done = true;
-		for (i = pdt_start; i >= pdt_end; i -= sizeof(pdt_entry)) {
-			retval = rmi_read_block(rmi_dev, i, &pdt_entry,
-					       sizeof(pdt_entry));
-			if (retval != sizeof(pdt_entry)) {
-				dev_err(dev, "Read of PDT entry at %#06x failed.\n",
-					i);
+		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
+			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
+			if (retval < 0)
 				goto error_exit;
-			}
 
 			if (RMI4_END_OF_PDT(pdt_entry.function_number))
 				break;
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index f8d87e9..5e3c4d4 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -29,11 +29,7 @@
 #define PDT_PROPERTIES_LOCATION 0x00EF
 #define BSR_LOCATION 0x00FE
 
-struct pdt_properties {
-	u8 reserved_1:6;
-	u8 has_bsr:1;
-	u8 reserved_2:1;
-} __attribute__((__packed__));
+#define RMI_PDT_PROPS_HAS_BSR 0x02
 
 struct rmi_driver_data {
 	struct list_head function_list;
@@ -61,7 +57,7 @@ struct rmi_driver_data {
 	ktime_t poll_interval;
 
 	struct mutex pdt_mutex;
-	struct pdt_properties pdt_props;
+	u8 pdt_props;
 	u8 bsr;
 
 	bool enabled;
@@ -90,34 +86,26 @@ struct rmi_driver_data {
 	void *data;
 };
 
+#define RMI_PDT_ENTRY_SIZE 6
+#define RMI_PDT_FUNCTION_VERSION_MASK   0x60
+#define RMI_PDT_INT_SOURCE_COUNT_MASK   0x07
+
 #define PDT_START_SCAN_LOCATION 0x00e9
 #define PDT_END_SCAN_LOCATION	0x0005
 #define RMI4_END_OF_PDT(id) ((id) == 0x00 || (id) == 0xff)
 
 struct pdt_entry {
-	u8 query_base_addr:8;
-	u8 command_base_addr:8;
-	u8 control_base_addr:8;
-	u8 data_base_addr:8;
-	u8 interrupt_source_count:3;
-	u8 bits3and4:2;
-	u8 function_version:2;
-	u8 bit7:1;
-	u8 function_number:8;
-} __attribute__((__packed__));
-
-static inline void copy_pdt_entry_to_fd(struct pdt_entry *pdt,
-				 struct rmi_function_descriptor *fd,
-				 u16 page_start)
-{
-	fd->query_base_addr = pdt->query_base_addr + page_start;
-	fd->command_base_addr = pdt->command_base_addr + page_start;
-	fd->control_base_addr = pdt->control_base_addr + page_start;
-	fd->data_base_addr = pdt->data_base_addr + page_start;
-	fd->function_number = pdt->function_number;
-	fd->interrupt_source_count = pdt->interrupt_source_count;
-	fd->function_version = pdt->function_version;
-}
+	u8 query_base_addr;
+	u8 command_base_addr;
+	u8 control_base_addr;
+	u8 data_base_addr;
+	u8 interrupt_source_count;
+	u8 function_version;
+	u8 function_number;
+};
+
+int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
+			u16 pdt_address);
 
 bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
