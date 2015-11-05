From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 19/26] Input: synaptics-rmi4: Add support for packet register descriptors
Date: Thu, 5 Nov 2015 15:41:52 -0800
Message-ID: <1446766912-31077-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:2106 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965935AbbKEXl6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 18:41:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

Newer RMI functions make use of packet registers. Packet registers contain
several bytes of data at a RMI address instead of just a single byte.
Packet registers may also contain subpackets which may or may not be
present for a given firmware configuration. Functions which use packet
registers contain Packet Register Descriptors in their query registers.
This patch implements the reading and processing of packet register
descriptors.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_driver.c | 188 ++++++++++++++++++++++++++++++++++++++++
 drivers/input/rmi4/rmi_driver.h |  38 ++++++++
 2 files changed, 226 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 54852a0..328a0e5 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -548,6 +548,194 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 	return retval < 0 ? retval : 0;
 }
 
+
+int rmi_read_register_desc(struct rmi_device *d, u16 addr,
+				struct rmi_register_descriptor *rdesc)
+{
+	int ret;
+	u8 size_presence_reg;
+	u8 buf[35];
+	int presense_offset = 1;
+	u8 *struct_buf;
+	int reg;
+	int offset = 0;
+	int map_offset = 0;
+	int i;
+	int b;
+
+	/*
+	 * The first register of the register descriptor is the size of
+	 * the register descriptor's presense register.
+	 */
+	ret = rmi_read(d, addr, &size_presence_reg);
+	if (ret)
+		return ret;
+	++addr;
+
+	if (size_presence_reg < 0 || size_presence_reg > 35)
+		/* sanity check the value */
+		return -EIO;
+
+	memset(buf, 0, sizeof(buf));
+
+	/*
+	 * The presence register contains the size of the register structure
+	 * and a bitmap which identified which packet registers are present
+	 * for this particular register type (ie query, control, or data).
+	 */
+	ret = rmi_read_block(d, addr, buf, size_presence_reg);
+	if (ret)
+		return ret;
+	++addr;
+
+	if (buf[0] == 0) {
+		presense_offset = 3;
+		rdesc->struct_size = buf[1] | (buf[2] << 8);
+	} else {
+		rdesc->struct_size = buf[0];
+	}
+
+	for (i = presense_offset; i < size_presence_reg; i++) {
+		for (b = 0; b < 8; b++) {
+			if (buf[i] & (0x1 << b))
+				bitmap_set(rdesc->presense_map, map_offset, 1);
+			++map_offset;
+		}
+	}
+
+	rdesc->num_registers = bitmap_weight(rdesc->presense_map,
+						RMI_REG_DESC_PRESENSE_BITS);
+
+	rdesc->registers = devm_kzalloc(&d->dev, rdesc->num_registers *
+				sizeof(struct rmi_register_desc_item),
+				GFP_KERNEL);
+	if (!rdesc->registers)
+		return -ENOMEM;
+
+	/*
+	 * Allocate a temporary buffer to hold the register structure.
+	 * I'm not using devm_kzalloc here since it will not be retained
+	 * after exiting this function
+	 */
+	struct_buf = kzalloc(rdesc->struct_size, GFP_KERNEL);
+	if (!struct_buf)
+		return -ENOMEM;
+
+	/*
+	 * The register structure contains information about every packet
+	 * register of this type. This includes the size of the packet
+	 * register and a bitmap of all subpackets contained in the packet
+	 * register.
+	 */
+	ret = rmi_read_block(d, addr, struct_buf, rdesc->struct_size);
+	if (ret)
+		goto free_struct_buff;
+
+	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
+	map_offset = 0;
+	for (i = 0; i < rdesc->num_registers; i++) {
+		struct rmi_register_desc_item *item = &rdesc->registers[i];
+		int reg_size = struct_buf[offset];
+
+		++offset;
+		if (reg_size == 0) {
+			reg_size = struct_buf[offset] |
+					(struct_buf[offset + 1] << 8);
+			offset += 2;
+		}
+
+		if (reg_size == 0) {
+			reg_size = struct_buf[offset] |
+					(struct_buf[offset + 1] << 8) |
+					(struct_buf[offset + 2] << 16) |
+					(struct_buf[offset + 3] << 24);
+			offset += 4;
+		}
+
+		item->reg = reg;
+		item->reg_size = reg_size;
+
+		do {
+			for (b = 0; b < 7; b++) {
+				if (struct_buf[offset] & (0x1 << b))
+					bitmap_set(item->subpacket_map,
+						map_offset, 1);
+				++map_offset;
+			}
+		} while (struct_buf[offset++] & 0x80);
+
+		item->num_subpackets = bitmap_weight(item->subpacket_map,
+						RMI_REG_DESC_SUBPACKET_BITS);
+
+		dev_dbg(&d->dev, "%s: reg: %d reg size: %ld subpackets: %d\n",
+			__func__, item->reg, item->reg_size,
+			item->num_subpackets);
+
+		reg = find_next_bit(rdesc->presense_map,
+				RMI_REG_DESC_PRESENSE_BITS, reg + 1);
+	}
+
+free_struct_buff:
+	kfree(struct_buf);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rmi_read_register_desc);
+
+const struct rmi_register_desc_item *rmi_get_register_desc_item(
+				struct rmi_register_descriptor *rdesc, u16 reg)
+{
+	const struct rmi_register_desc_item *item;
+	int i;
+
+	for (i = 0; i < rdesc->num_registers; i++) {
+		item = &rdesc->registers[i];
+		if (item->reg == reg)
+			return item;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(rmi_get_register_desc_item);
+
+size_t rmi_register_desc_calc_size(struct rmi_register_descriptor *rdesc)
+{
+	const struct rmi_register_desc_item *item;
+	int i;
+	size_t size = 0;
+
+	for (i = 0; i < rdesc->num_registers; i++) {
+		item = &rdesc->registers[i];
+		size += item->reg_size;
+	}
+	return size;
+}
+EXPORT_SYMBOL_GPL(rmi_register_desc_calc_size);
+
+/* Compute the register offset relative to the base address */
+int rmi_register_desc_calc_reg_offset(
+		struct rmi_register_descriptor *rdesc, u16 reg)
+{
+	const struct rmi_register_desc_item *item;
+	int offset = 0;
+	int i;
+
+	for (i = 0; i < rdesc->num_registers; i++) {
+		item = &rdesc->registers[i];
+		if (item->reg == reg)
+			return offset;
+		++offset;
+	}
+	return -1;
+}
+EXPORT_SYMBOL_GPL(rmi_register_desc_calc_reg_offset);
+
+bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
+	u8 subpacket)
+{
+	return find_next_bit(item->subpacket_map, RMI_REG_DESC_PRESENSE_BITS,
+				subpacket) == subpacket;
+}
+
 /* Indicates that flash programming is enabled (bootloader mode). */
 #define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
 
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 833e954..7823d41 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -99,6 +99,44 @@ struct pdt_entry {
 int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
 			u16 pdt_address);
 
+#define RMI_REG_DESC_PRESENSE_BITS	(32 * BITS_PER_BYTE)
+#define RMI_REG_DESC_SUBPACKET_BITS	(37 * BITS_PER_BYTE)
+
+/* describes a single packet register */
+struct rmi_register_desc_item {
+	u16 reg;
+	unsigned long reg_size;
+	u8 num_subpackets;
+	unsigned long subpacket_map[BITS_TO_LONGS(
+				RMI_REG_DESC_SUBPACKET_BITS)];
+};
+
+/*
+ * describes the packet registers for a particular type
+ * (ie query, control, data)
+ */
+struct rmi_register_descriptor {
+	unsigned long struct_size;
+	unsigned long presense_map[BITS_TO_LONGS(RMI_REG_DESC_PRESENSE_BITS)];
+	u8 num_registers;
+	struct rmi_register_desc_item *registers;
+};
+
+int rmi_read_register_desc(struct rmi_device *d, u16 addr,
+				struct rmi_register_descriptor *rdesc);
+const struct rmi_register_desc_item *rmi_get_register_desc_item(
+				struct rmi_register_descriptor *rdesc, u16 reg);
+
+/*
+ * Calculate the total size of all of the registers described in the
+ * descriptor.
+ */
+size_t rmi_register_desc_calc_size(struct rmi_register_descriptor *rdesc);
+int rmi_register_desc_calc_reg_offset(
+			struct rmi_register_descriptor *rdesc, u16 reg);
+bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
+			u8 subpacket);
+
 bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
 void rmi_unregister_physical_driver(void);
-- 
2.1.4

