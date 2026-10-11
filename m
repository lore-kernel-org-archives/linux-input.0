Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F33E00A9;
	Sun, 11 Oct 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742932; cv=none; b=BNUGah0mcUu/sjrsMAvFAz4rH7q0wMXM2sxxELubwQ1VwKYv9y+ui9DoP4MGyRtQlbELNmdVdcq74PfN16b/4tgfryGqx66lfn2JU1eKtRxgR4x3z6bJ3ozVcM6vAemDmCkgHDs8qpuB+kUDBoPfTLNFHXFai50XGYOGhW95Ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742932; c=relaxed/simple;
	bh=uESTUndUTYrVjNYDtKYHy42tmX89HJie+i234m/FtTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSUyHecF+zUiCrW02Z47HwifcaSvSPXcvXQeISgsJUDqf0LwX9LoR88j7qUB1BozVc4RoAbCSnIvUWuKGvy9xGOPmjHTIQ6JEe2owupIq4JhGT1grSQXIot/P7vxTboEwH/EcGrnGxUQn4Jz8z1RvIStuBCd40G2Dutatb2AG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=ZVDUD9St; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="ZVDUD9St"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791742599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7636kGrdCjTubPj/aOOxMYsCP5OEZ2mCSMNajnV9iA=;
	b=ZVDUD9StclVJ2ll4eINrcoWKWsdZP95C1B/eepZm0kUyv6QtQMKE/f8MAZm9xtymhDTV4x
	FIwu6PK6MeNdk1RnOPyykOnLpNm02O1UDrclEQ3pp3KC3qNMB9PuNVBX9EuHS1aDFC8cHz
	Xh/Z2vrBlF8ObJDqq4hDrf7dLXKgcrmsYzXgwcYYB13XQVc2f0pHIrT8MyO835hgSMSpvC
	G118qkoHD7WegX3UtsYBX8FuzSqSj1SGH/EimkU6cQGgSC4nx5U3wGGBXzOmBWkdIE7Pbu
	9CiVBKDP9MPRss/r4Az4JvrtB1OASQmT1etJyBdidIZfjPGQAHJau3aN3O4l1g==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	allencl_lin@hotmail.com,
	tylor_yang@himax.corp-partner.google.com,
	felix@kaechele.ca,
	dianders@chromium.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v6 2/3] HID: Add Himax HX83102J SPI touchscreen driver
Date: Sun, 11 Oct 2026 20:16:32 +0200
Message-ID: <20261011181633.1778969-3-michal@nozomi.space>
In-Reply-To: <20261011181633.1778969-1-michal@nozomi.space>
References: <20261011181633.1778969-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a driver for the touch function of the Himax HX83102J, a touch and
display driver integrated (TDDI) controller. The touch function is
connected over SPI and sends HID reports.

The flashless variant of the IC, used in the Lenovo Chromebook Duet,
loses its firmware when it is powered off. The driver loads it from the
file named by the firmware-name property, keeps it for the next power
up, and takes the HID descriptor and the report descriptor from it.

The touch function shares its power and reset with the display, so the
driver follows the panel: it powers the touch function up when the
panel has been prepared and down before the panel is unprepared. The
firmware is loaded from a work item so that it doesn't delay the panel,
and the HID device is kept across power cycles.

Every interrupt delivers a frame with the touch report, the stylus
report if the IC has a stylus function, and a heatmap. The IC packs the
heatmap as 12-bit values, while the report descriptor declares 16-bit
values, so the driver unpacks it before passing it on.

This is based on the driver that Allen Lin posted [1] and on Tylor
Yang's heatmap support in the ChromeOS kernel [2].

Link: https://lore.kernel.org/all/TY0PR06MB56110754EB9D827BE3304A259E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com/ [1]
Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5326106 [2]
Co-developed-by: Allen Lin <allencl_lin@hotmail.com>
Signed-off-by: Allen Lin <allencl_lin@hotmail.com>
Co-developed-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 MAINTAINERS                 |    1 +
 drivers/hid/Kconfig         |   13 +
 drivers/hid/Makefile        |    1 +
 drivers/hid/hid-himax-spi.c | 1300 +++++++++++++++++++++++++++++++++++
 4 files changed, 1315 insertions(+)
 create mode 100644 drivers/hid/hid-himax-spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e209f0d44fa73..3893cf3122ecf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11734,6 +11734,7 @@ M:	Michał Kopeć <michal@nozomi.space>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
+F:	drivers/hid/hid-himax-spi.c
 
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c43e824428f02..6675e060e993c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -412,6 +412,19 @@ config HID_GLORIOUS
 	  Support for Glorious PC Gaming Race mice such as
 	  the Glorious Model O, O- and D.
 
+config HID_HIMAX_SPI
+	tristate "Himax HX83102J SPI HID touchscreen"
+	depends on SPI
+	depends on DRM
+	select CRC32
+	help
+	  Say Y here if you have a Himax HX83102J touch and display driver
+	  integrated (TDDI) controller whose touch function is connected
+	  over SPI.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-himax-spi.
+
 config HID_HOLTEK
 	tristate "Holtek HID devices"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b245eed..fc978c61d5b78 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_HID_GOOGLE_STADIA_FF)	+= hid-google-stadiaff.o
 obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
+obj-$(CONFIG_HID_HIMAX_SPI)	+= hid-himax-spi.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
diff --git a/drivers/hid/hid-himax-spi.c b/drivers/hid/hid-himax-spi.c
new file mode 100644
index 0000000000000..98ee51658b362
--- /dev/null
+++ b/drivers/hid/hid-himax-spi.c
@@ -0,0 +1,1300 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI driver for the touch function of the Himax HX83102J
+ *
+ * Copyright (C) 2024 Himax Corporation.
+ * Copyright (C) 2026 Michał Kopeć <michal@nozomi.space>
+ */
+
+#include <drm/drm_panel.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/hid.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sizes.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+
+#define HIMAX_SPI_READ			0xf3
+#define HIMAX_SPI_WRITE			0xf2
+/* Reads have a dummy byte after the register */
+#define HIMAX_SPI_READ_HDR_LEN		3
+#define HIMAX_SPI_WRITE_HDR_LEN		2
+
+/* Bus interface registers */
+#define HIMAX_BUS_AHB_ADDR		0x00
+#define HIMAX_BUS_AHB_RDATA		0x08
+#define HIMAX_BUS_AHB_DIRECTION		0x0c
+#define HIMAX_BUS_AHB_INCR4		0x0d
+#define HIMAX_BUS_AHB_CONTI		0x13
+#define HIMAX_BUS_EVENT_STACK		0x30
+#define HIMAX_BUS_SAFE_MODE		0x31
+
+#define HIMAX_AHB_DIRECTION_READ	0x00
+#define HIMAX_AHB_CONTI			0x31
+#define HIMAX_AHB_INCR4			0x10
+#define HIMAX_AHB_INCR4_AUTO		BIT(0)
+#define HIMAX_AHB_MAX_XFER		SZ_4K
+
+#define HIMAX_SAFE_MODE_PASSWORD	0x9527
+
+/* MCU registers */
+#define HX83102J_REG_HW_CRC		0x80010000
+#define HX83102J_REG_TCON_RST		0x80020004
+#define HIMAX_REG_RELOAD_STATUS		0x80050000
+#define HIMAX_REG_RELOAD_CRC32		0x80050018
+#define HIMAX_REG_RELOAD_ADDR		0x80050020
+#define HIMAX_REG_RELOAD_CMD		0x80050028
+#define HIMAX_REG_SYSTEM_RESET		0x90000018
+#define HIMAX_REG_RELOAD_TO_ACTIVE	0x90000048
+#define HIMAX_REG_CTRL_FW		0x9000005c
+#define HIMAX_REG_FW_STATUS		0x900000a8
+#define HIMAX_REG_ICID			0x900000d0
+
+#define HX83102J_HW_CRC_ENABLE		0xecce
+#define HIMAX_RELOAD_BUSY		BIT(0)
+#define HIMAX_RELOAD_CMD_PASSWORD	GENMASK(31, 16)
+#define HIMAX_RELOAD_CMD_WORDS		GENMASK(15, 0)
+#define HIMAX_RELOAD_PASSWORD		0x99
+#define HIMAX_SYSTEM_RESET		0x55
+#define HIMAX_RELOAD_TO_ACTIVE		0xec
+#define HIMAX_RELOAD_TO_ACTIVE_DONE	0x01ec
+#define HIMAX_FW_RE_INIT		0x00
+#define HIMAX_FW_STATE			GENMASK(7, 0)
+#define HIMAX_FW_STATE_SAFE_MODE	0x0c
+#define HIMAX_ICID_MASK			GENMASK(31, 8)
+#define HX83102J_ICID			0x83102900
+
+/* Data RAM, set up by the driver or filled in by the firmware */
+#define HIMAX_DSRAM_FW_VER		0x10007004
+#define HIMAX_DSRAM_RX_TX_NUM		0x100070f4
+#define HIMAX_DSRAM_MAX_POINTS		0x100070f8
+#define HIMAX_DSRAM_STYLUS		0x1000719c
+#define HIMAX_DSRAM_SET_NFRAME		0x10007294
+#define HIMAX_DSRAM_FW_RELOAD		0x100072c0
+#define HX83102J_DSRAM_RAW_OUT_SEL	0x100072ec
+#define HIMAX_DSRAM_FLASH_RELOAD	0x10007f00
+#define HIMAX_DSRAM_SORTING_MODE	0x10007f04
+#define HIMAX_DSRAM_AP_SUSPEND		0x10007fd0
+
+#define HIMAX_RX_NUM			GENMASK(23, 16)
+#define HIMAX_TX_NUM			GENMASK(31, 24)
+#define HIMAX_MAX_POINTS		GENMASK(7, 0)
+#define HIMAX_STYLUS			GENMASK(31, 24)
+#define HIMAX_FW_RELOAD_DONE		0x72c0
+#define HIMAX_NO_FLASH			0x9aa9
+#define HIMAX_AP_RESUMED		0x00000000
+
+#define HX83102J_DSRAM_SIZE		(SZ_64K + SZ_8K)
+#define HX83102J_MAIN_CODE_MAX		SZ_128K
+#define HX83102J_MAX_RX			50
+#define HX83102J_MAX_TX			32
+
+/* Firmware image: a 1 KiB header with a map of the tables in the image */
+#define HIMAX_FW_HEADER_SIZE		SZ_1K
+#define HIMAX_FW_HEADER_ID_OFFSET	0x0e
+#define HIMAX_FW_HEADER_ID		0x87
+#define HIMAX_FW_MAP_ENTRY_SIZE		16
+#define HIMAX_FW_MAP_CFG_TABLE		0x00000a00
+#define HIMAX_FW_MAP_HID_TABLE		0x30000100
+#define HIMAX_FW_PART_DESC_SIZE		16
+#define HIMAX_FW_PART_COUNT_OFFSET	12
+
+/* Every report in the event stack has a 2 byte header */
+#define HIMAX_REPORT_HDR_SIZE		2
+#define HIMAX_REPORT_MAX_INPUT		128
+/* The heatmap report starts with its ID and 20 bytes of frame information */
+#define HIMAX_HEATMAP_HDR_SIZE		(1 + 20)
+#define HIMAX_REPORT_ID_CONTACT_MAX	0x03
+
+#define HIMAX_XFER_BUF_SIZE		(HIMAX_AHB_MAX_XFER + 8)
+
+struct himax_hid_desc {
+	__le16 desc_length;
+	__le16 bcd_version;
+	__le16 report_desc_length;
+	__le16 max_input_length;
+	__le16 max_output_length;
+	__le16 max_fragment_length;
+	__le16 vendor_id;
+	__le16 product_id;
+	__le16 version_id;
+	__le16 flags;
+	__le32 reserved;
+} __packed;
+
+struct himax_fw_part {
+	u32 sram_addr;
+	u32 offset;
+	u32 size;
+};
+
+struct himax_ts_data {
+	struct device *dev;
+	struct spi_device *spi;
+	struct hid_device *hid;
+	struct gpio_desc *reset_gpio;
+	struct regulator *vccd;
+	struct drm_panel_follower panel_follower;
+	struct work_struct power_on_work;
+
+	/* Serializes power changes, firmware loading and HID registration */
+	struct mutex lock;
+	bool powered;
+	bool irq_enabled;
+
+	const char *fw_name;
+	const struct firmware *fw;
+	const struct himax_hid_desc *hid_desc;
+	const u8 *report_desc;
+	u16 report_desc_len;
+	u16 max_input_len;
+	struct himax_fw_part main_code;
+	u32 cfg_addr;
+	u32 cfg_size;
+	u32 cfg_crc;
+	u8 *cfg_image;
+
+	u32 rx_num;
+	u32 tx_num;
+	u8 max_points;
+	bool has_stylus;
+
+	u8 *event_buf;
+	size_t event_size;
+	u8 *heatmap_buf;
+	size_t heatmap_size;
+
+	/* Serializes bus access, which also uses the transfer buffers */
+	struct mutex xfer_lock;
+	size_t xfer_max;
+	u8 tx_buf[HIMAX_XFER_BUF_SIZE] ____cacheline_aligned;
+	u8 rx_buf[HIMAX_XFER_BUF_SIZE] ____cacheline_aligned;
+};
+
+static int himax_bus_read(struct himax_ts_data *ts, u8 reg, u8 *buf, size_t len)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = ts->tx_buf,
+		.rx_buf = ts->rx_buf,
+		.len = HIMAX_SPI_READ_HDR_LEN + len,
+	};
+	int ret;
+
+	lockdep_assert_held(&ts->xfer_lock);
+
+	ts->tx_buf[0] = HIMAX_SPI_READ;
+	ts->tx_buf[1] = reg;
+	memset(ts->tx_buf + 2, 0, len + 1);
+
+	ret = spi_sync_transfer(ts->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	memcpy(buf, ts->rx_buf + HIMAX_SPI_READ_HDR_LEN, len);
+
+	return 0;
+}
+
+/* Sends @len bytes of data, which the caller has put after the header */
+static int himax_bus_send(struct himax_ts_data *ts, u8 reg, size_t len)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = ts->tx_buf,
+		.len = HIMAX_SPI_WRITE_HDR_LEN + len,
+	};
+
+	lockdep_assert_held(&ts->xfer_lock);
+
+	ts->tx_buf[0] = HIMAX_SPI_WRITE;
+	ts->tx_buf[1] = reg;
+
+	return spi_sync_transfer(ts->spi, &xfer, 1);
+}
+
+static int himax_bus_write8(struct himax_ts_data *ts, u8 reg, u8 val)
+{
+	ts->tx_buf[HIMAX_SPI_WRITE_HDR_LEN] = val;
+
+	return himax_bus_send(ts, reg, 1);
+}
+
+static int himax_ahb_set_burst(struct himax_ts_data *ts, bool auto_incr)
+{
+	int ret;
+
+	ret = himax_bus_write8(ts, HIMAX_BUS_AHB_CONTI, HIMAX_AHB_CONTI);
+	if (ret)
+		return ret;
+
+	return himax_bus_write8(ts, HIMAX_BUS_AHB_INCR4,
+				HIMAX_AHB_INCR4 | (auto_incr ? HIMAX_AHB_INCR4_AUTO : 0));
+}
+
+static int himax_ahb_read(struct himax_ts_data *ts, u32 addr, u8 *buf, size_t len)
+{
+	size_t chunk = min(HIMAX_AHB_MAX_XFER, ts->xfer_max - HIMAX_SPI_READ_HDR_LEN);
+	size_t pos, n;
+	int ret;
+
+	guard(mutex)(&ts->xfer_lock);
+
+	ret = himax_ahb_set_burst(ts, len > sizeof(u32));
+	if (ret)
+		return ret;
+
+	for (pos = 0; pos < len; pos += n) {
+		n = min(len - pos, chunk);
+
+		put_unaligned_le32(addr + pos, ts->tx_buf + HIMAX_SPI_WRITE_HDR_LEN);
+		ret = himax_bus_send(ts, HIMAX_BUS_AHB_ADDR, sizeof(u32));
+		if (ret)
+			return ret;
+
+		ret = himax_bus_write8(ts, HIMAX_BUS_AHB_DIRECTION, HIMAX_AHB_DIRECTION_READ);
+		if (ret)
+			return ret;
+
+		ret = himax_bus_read(ts, HIMAX_BUS_AHB_RDATA, buf + pos, n);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int himax_ahb_write(struct himax_ts_data *ts, u32 addr, const u8 *buf, size_t len)
+{
+	size_t chunk = min(HIMAX_AHB_MAX_XFER,
+			   ts->xfer_max - HIMAX_SPI_WRITE_HDR_LEN - sizeof(u32));
+	u8 *data = ts->tx_buf + HIMAX_SPI_WRITE_HDR_LEN;
+	size_t pos, n;
+	int ret;
+
+	guard(mutex)(&ts->xfer_lock);
+
+	ret = himax_ahb_set_burst(ts, len > sizeof(u32));
+	if (ret)
+		return ret;
+
+	for (pos = 0; pos < len; pos += n) {
+		n = min(len - pos, chunk);
+
+		put_unaligned_le32(addr + pos, data);
+		memcpy(data + sizeof(u32), buf + pos, n);
+		ret = himax_bus_send(ts, HIMAX_BUS_AHB_ADDR, sizeof(u32) + n);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int himax_read32(struct himax_ts_data *ts, u32 addr, u32 *val)
+{
+	__le32 data;
+	int ret;
+
+	ret = himax_ahb_read(ts, addr, (u8 *)&data, sizeof(data));
+	if (ret)
+		return ret;
+
+	*val = le32_to_cpu(data);
+
+	return 0;
+}
+
+static int himax_write32(struct himax_ts_data *ts, u32 addr, u32 val)
+{
+	__le32 data = cpu_to_le32(val);
+
+	return himax_ahb_write(ts, addr, (u8 *)&data, sizeof(data));
+}
+
+static int himax_write32_verify(struct himax_ts_data *ts, u32 addr, u32 val,
+				u32 mask, unsigned int tries)
+{
+	u32 rval;
+	int ret;
+
+	while (tries--) {
+		ret = himax_write32(ts, addr, val);
+		if (ret)
+			return ret;
+
+		fsleep(1000);
+
+		ret = himax_read32(ts, addr, &rval);
+		if (ret)
+			return ret;
+
+		if ((rval & mask) == (val & mask))
+			return 0;
+	}
+
+	return -EIO;
+}
+
+static int himax_enter_safe_mode(struct himax_ts_data *ts)
+{
+	guard(mutex)(&ts->xfer_lock);
+
+	put_unaligned_le16(HIMAX_SAFE_MODE_PASSWORD, ts->tx_buf + HIMAX_SPI_WRITE_HDR_LEN);
+
+	return himax_bus_send(ts, HIMAX_BUS_SAFE_MODE, sizeof(u16));
+}
+
+static void himax_pin_reset(struct himax_ts_data *ts)
+{
+	gpiod_set_value_cansleep(ts->reset_gpio, 1);
+	fsleep(10000);
+	gpiod_set_value_cansleep(ts->reset_gpio, 0);
+	fsleep(20000);
+}
+
+static int himax_interface_on(struct himax_ts_data *ts)
+{
+	unsigned int tries = 10;
+	u8 buf[4], conti, incr4;
+	int ret;
+
+	guard(mutex)(&ts->xfer_lock);
+
+	/* The first access after a reset only wakes up the bus interface */
+	ret = himax_bus_read(ts, HIMAX_BUS_AHB_RDATA, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	while (tries--) {
+		ret = himax_ahb_set_burst(ts, false);
+		if (ret)
+			return ret;
+
+		ret = himax_bus_read(ts, HIMAX_BUS_AHB_CONTI, &conti, 1);
+		if (ret)
+			return ret;
+
+		ret = himax_bus_read(ts, HIMAX_BUS_AHB_INCR4, &incr4, 1);
+		if (ret)
+			return ret;
+
+		if (conti == HIMAX_AHB_CONTI && incr4 == HIMAX_AHB_INCR4)
+			return 0;
+
+		fsleep(1000);
+	}
+
+	return -EIO;
+}
+
+static int himax_enable_hw_crc(struct himax_ts_data *ts)
+{
+	return himax_write32_verify(ts, HX83102J_REG_HW_CRC, HX83102J_HW_CRC_ENABLE,
+				    GENMASK(15, 0), 5);
+}
+
+static int himax_reload_to_active(struct himax_ts_data *ts)
+{
+	unsigned int tries = 5;
+	u32 val;
+	int ret;
+
+	while (tries--) {
+		ret = himax_write32(ts, HIMAX_REG_RELOAD_TO_ACTIVE, HIMAX_RELOAD_TO_ACTIVE);
+		if (ret)
+			return ret;
+
+		fsleep(1000);
+
+		ret = himax_read32(ts, HIMAX_REG_RELOAD_TO_ACTIVE, &val);
+		if (ret)
+			return ret;
+
+		if ((val & GENMASK(15, 0)) == HIMAX_RELOAD_TO_ACTIVE_DONE)
+			return 0;
+	}
+
+	return -EIO;
+}
+
+static int himax_sense_off(struct himax_ts_data *ts)
+{
+	unsigned int tries = 5;
+	u32 val;
+	int ret;
+
+	while (tries--) {
+		ret = himax_enter_safe_mode(ts);
+		if (ret)
+			return ret;
+
+		ret = himax_read32(ts, HIMAX_REG_FW_STATUS, &val);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(HIMAX_FW_STATE, val) == HIMAX_FW_STATE_SAFE_MODE) {
+			/* The touch MCU can't be used before the TCON is reset */
+			ret = himax_write32(ts, HX83102J_REG_TCON_RST, 0);
+			if (ret)
+				return ret;
+
+			fsleep(1000);
+			return 0;
+		}
+
+		fsleep(5000);
+		himax_pin_reset(ts);
+	}
+
+	return -EIO;
+}
+
+static int himax_sense_on(struct himax_ts_data *ts)
+{
+	int ret;
+
+	ret = himax_interface_on(ts);
+	if (ret)
+		return ret;
+
+	ret = himax_write32(ts, HIMAX_REG_CTRL_FW, HIMAX_FW_RE_INIT);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+	himax_pin_reset(ts);
+
+	ret = himax_enable_hw_crc(ts);
+	if (ret)
+		return ret;
+
+	return himax_reload_to_active(ts);
+}
+
+static int himax_detect(struct himax_ts_data *ts)
+{
+	unsigned int tries = 5;
+	u32 id;
+	int ret;
+
+	himax_pin_reset(ts);
+
+	ret = himax_interface_on(ts);
+	if (ret)
+		return ret;
+
+	ret = himax_sense_off(ts);
+	if (ret)
+		return ret;
+
+	/* The ID may not be readable yet while the display function starts up */
+	while (tries--) {
+		ret = himax_read32(ts, HIMAX_REG_ICID, &id);
+		if (ret)
+			return ret;
+
+		if ((id & HIMAX_ICID_MASK) == HX83102J_ICID)
+			return 0;
+	}
+
+	dev_err(ts->dev, "unexpected IC ID %#010x\n", id);
+
+	return -ENODEV;
+}
+
+static int himax_hw_crc(struct himax_ts_data *ts, u32 addr, u32 len, u32 *crc)
+{
+	u32 words = len / sizeof(u32);
+	unsigned int tries = 100;
+	u32 val;
+	int ret;
+
+	ret = himax_write32(ts, HIMAX_REG_RELOAD_ADDR, addr);
+	if (ret)
+		return ret;
+
+	ret = himax_write32(ts, HIMAX_REG_RELOAD_CMD,
+			    FIELD_PREP(HIMAX_RELOAD_CMD_PASSWORD, HIMAX_RELOAD_PASSWORD) |
+			    FIELD_PREP(HIMAX_RELOAD_CMD_WORDS, words));
+	if (ret)
+		return ret;
+
+	ret = himax_read32(ts, HIMAX_REG_RELOAD_CMD, &val);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(HIMAX_RELOAD_CMD_WORDS, val) != words)
+		return -EIO;
+
+	while (tries--) {
+		ret = himax_read32(ts, HIMAX_REG_RELOAD_STATUS, &val);
+		if (ret)
+			return ret;
+
+		if (!(val & HIMAX_RELOAD_BUSY))
+			return himax_read32(ts, HIMAX_REG_RELOAD_CRC32, crc);
+
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int himax_write_sram(struct himax_ts_data *ts, u32 addr, const u8 *data,
+			    u32 len, u32 expected_crc)
+{
+	unsigned int tries = 3;
+	u32 crc;
+	int ret;
+
+	while (tries--) {
+		ret = himax_ahb_write(ts, addr, data, len);
+		if (ret)
+			return ret;
+
+		ret = himax_hw_crc(ts, addr, len, &crc);
+		if (ret)
+			return ret;
+
+		if (crc == expected_crc)
+			return 0;
+	}
+
+	dev_err(ts->dev, "CRC mismatch at %#010x: %#010x != %#010x\n",
+		addr, crc, expected_crc);
+
+	return -EIO;
+}
+
+static int himax_start_fw(struct himax_ts_data *ts)
+{
+	unsigned int tries = 30;
+	u32 val;
+	int ret;
+
+	ret = himax_write32(ts, HX83102J_DSRAM_RAW_OUT_SEL, 0);
+	if (ret)
+		return ret;
+
+	ret = himax_write32_verify(ts, HIMAX_DSRAM_SORTING_MODE, 0, U32_MAX, 3);
+	if (ret)
+		return ret;
+
+	ret = himax_write32(ts, HIMAX_DSRAM_SET_NFRAME, 1);
+	if (ret)
+		return ret;
+
+	ret = himax_write32(ts, HIMAX_DSRAM_FW_RELOAD, 0);
+	if (ret)
+		return ret;
+
+	ret = himax_sense_on(ts);
+	if (ret)
+		return ret;
+
+	while (tries--) {
+		ret = himax_read32(ts, HIMAX_DSRAM_FW_RELOAD, &val);
+		if (ret)
+			return ret;
+
+		if (val == HIMAX_FW_RELOAD_DONE)
+			return 0;
+
+		fsleep(10000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+/* Only the flashless variant is supported, which loses the firmware at power off */
+static int himax_load_fw(struct himax_ts_data *ts)
+{
+	const struct himax_fw_part *main_code = &ts->main_code;
+	unsigned int tries = 3;
+	int ret;
+
+	while (tries--) {
+		ret = himax_write32(ts, HIMAX_REG_SYSTEM_RESET, HIMAX_SYSTEM_RESET);
+		if (ret)
+			continue;
+
+		ret = himax_sense_off(ts);
+		if (ret)
+			continue;
+
+		ret = himax_enable_hw_crc(ts);
+		if (ret)
+			continue;
+
+		/* The main code includes its own CRC, so the CRC over it is 0 */
+		ret = himax_write_sram(ts, main_code->sram_addr,
+				       ts->fw->data + main_code->offset,
+				       main_code->size, 0);
+		if (ret)
+			continue;
+
+		ret = himax_write_sram(ts, ts->cfg_addr, ts->cfg_image,
+				       ts->cfg_size, ts->cfg_crc);
+		if (!ret)
+			break;
+	}
+	if (ret)
+		return ret;
+
+	ret = himax_write32(ts, HIMAX_DSRAM_FLASH_RELOAD, HIMAX_NO_FLASH);
+	if (ret)
+		return ret;
+
+	ret = himax_start_fw(ts);
+	if (ret)
+		return ret;
+
+	if (himax_write32_verify(ts, HIMAX_DSRAM_AP_SUSPEND, HIMAX_AP_RESUMED, U32_MAX, 10))
+		dev_dbg(ts->dev, "failed to notify the firmware of the resume\n");
+
+	return 0;
+}
+
+static int himax_parse_fw_map(struct himax_ts_data *ts, u32 *cfg_table, u32 *hid_table)
+{
+	const struct firmware *fw = ts->fw;
+	const u8 *entry;
+	size_t pos, i;
+	u8 sum;
+
+	if (fw->size < HIMAX_FW_HEADER_SIZE || memchr_inv(fw->data, 0, 8) ||
+	    fw->data[HIMAX_FW_HEADER_ID_OFFSET] != HIMAX_FW_HEADER_ID)
+		return -EINVAL;
+
+	*cfg_table = 0;
+	*hid_table = 0;
+
+	for (pos = 0; pos < HIMAX_FW_HEADER_SIZE; pos += HIMAX_FW_MAP_ENTRY_SIZE) {
+		entry = fw->data + pos;
+		if (!memchr_inv(entry, 0, HIMAX_FW_MAP_ENTRY_SIZE))
+			break;
+
+		for (sum = 0, i = 0; i < HIMAX_FW_MAP_ENTRY_SIZE; i++)
+			sum += entry[i];
+		if (sum) {
+			dev_warn(ts->dev, "bad checksum of map entry at %#zx\n", pos);
+			continue;
+		}
+
+		switch (get_unaligned_le32(entry)) {
+		case HIMAX_FW_MAP_CFG_TABLE:
+			*cfg_table = get_unaligned_le32(entry + 4);
+			break;
+		case HIMAX_FW_MAP_HID_TABLE:
+			*hid_table = get_unaligned_le32(entry + 4);
+			break;
+		}
+	}
+
+	if (!*cfg_table || !*hid_table)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int himax_parse_hid_desc(struct himax_ts_data *ts, u32 hid_table)
+{
+	const struct firmware *fw = ts->fw;
+	const struct himax_hid_desc *desc;
+	size_t rd_offset;
+
+	if (hid_table > fw->size || fw->size - hid_table < sizeof(*desc))
+		return -EINVAL;
+
+	desc = (const struct himax_hid_desc *)(fw->data + hid_table);
+	ts->max_input_len = le16_to_cpu(desc->max_input_length);
+	if (ts->max_input_len <= HIMAX_REPORT_HDR_SIZE ||
+	    ts->max_input_len > HIMAX_REPORT_MAX_INPUT)
+		return -EINVAL;
+
+	/* The report descriptor follows the HID descriptor */
+	rd_offset = hid_table + sizeof(*desc);
+	ts->report_desc_len = le16_to_cpu(desc->report_desc_length);
+	if (!ts->report_desc_len || ts->report_desc_len > HID_MAX_DESCRIPTOR_SIZE ||
+	    rd_offset > fw->size || fw->size - rd_offset < ts->report_desc_len)
+		return -EINVAL;
+
+	ts->hid_desc = desc;
+	ts->report_desc = fw->data + rd_offset;
+
+	return 0;
+}
+
+static int himax_get_fw_part(struct himax_ts_data *ts, u32 table, unsigned int index,
+			     struct himax_fw_part *part)
+{
+	const u8 *desc = ts->fw->data + table + index * HIMAX_FW_PART_DESC_SIZE;
+	size_t fw_size = ts->fw->size;
+	u32 misalign;
+
+	part->sram_addr = get_unaligned_le32(desc);
+	part->size = get_unaligned_le32(desc + 4);
+	part->offset = get_unaligned_le32(desc + 8);
+
+	/* The config partitions are written in whole words */
+	misalign = index ? part->sram_addr % sizeof(u32) : 0;
+	if (part->offset < misalign)
+		return -EINVAL;
+	part->sram_addr -= misalign;
+	part->offset -= misalign;
+	part->size += misalign;
+
+	if (!part->size || part->offset > fw_size || fw_size - part->offset < part->size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Partition 0 is the main code. The others are pieces of the configuration in
+ * the data RAM, which are merged into one image that is written at once.
+ */
+static int himax_parse_fw_parts(struct himax_ts_data *ts, u32 table)
+{
+	const struct firmware *fw = ts->fw;
+	struct himax_fw_part part;
+	u32 start = U32_MAX;
+	unsigned int count, i;
+	u64 end = 0;
+	int ret;
+
+	if (table >= fw->size || fw->size - table <= HIMAX_FW_PART_COUNT_OFFSET)
+		return -EINVAL;
+
+	count = fw->data[table + HIMAX_FW_PART_COUNT_OFFSET];
+	if (count < 2 || fw->size - table < count * HIMAX_FW_PART_DESC_SIZE)
+		return -EINVAL;
+
+	ret = himax_get_fw_part(ts, table, 0, &ts->main_code);
+	if (ret)
+		return ret;
+
+	if (ts->main_code.size > HX83102J_MAIN_CODE_MAX)
+		return -EINVAL;
+
+	for (i = 1; i < count; i++) {
+		ret = himax_get_fw_part(ts, table, i, &part);
+		if (ret)
+			return ret;
+
+		start = min(start, part.sram_addr);
+		end = max(end, (u64)part.sram_addr + part.size);
+	}
+
+	if (end - start > HX83102J_DSRAM_SIZE)
+		return -EINVAL;
+
+	ts->cfg_addr = start;
+	ts->cfg_size = round_up(end - start, sizeof(u32));
+	ts->cfg_image = devm_kzalloc(ts->dev, ts->cfg_size, GFP_KERNEL);
+	if (!ts->cfg_image)
+		return -ENOMEM;
+
+	for (i = 1; i < count; i++) {
+		himax_get_fw_part(ts, table, i, &part);
+		memcpy(ts->cfg_image + part.sram_addr - start, fw->data + part.offset,
+		       part.size);
+	}
+
+	ts->cfg_crc = crc32c(~0, ts->cfg_image, ts->cfg_size);
+
+	return 0;
+}
+
+static int himax_request_fw(struct himax_ts_data *ts)
+{
+	u32 cfg_table, hid_table;
+	int ret;
+
+	ret = request_firmware(&ts->fw, ts->fw_name, ts->dev);
+	if (ret)
+		return ret;
+
+	ret = himax_parse_fw_map(ts, &cfg_table, &hid_table);
+	if (!ret)
+		ret = himax_parse_hid_desc(ts, hid_table);
+	if (!ret)
+		ret = himax_parse_fw_parts(ts, cfg_table);
+	if (ret) {
+		dev_err(ts->dev, "invalid firmware %s\n", ts->fw_name);
+		release_firmware(ts->fw);
+		ts->fw = NULL;
+	}
+
+	return ret;
+}
+
+static int himax_hid_parse(struct hid_device *hid)
+{
+	struct himax_ts_data *ts = hid->driver_data;
+
+	return hid_parse_report(hid, ts->report_desc, ts->report_desc_len);
+}
+
+static int himax_hid_start(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void himax_hid_stop(struct hid_device *hid)
+{
+}
+
+static int himax_hid_open(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void himax_hid_close(struct hid_device *hid)
+{
+}
+
+static int himax_hid_raw_request(struct hid_device *hid, unsigned char reportnum,
+				 u8 *buf, size_t len, unsigned char rtype, int reqtype)
+{
+	struct himax_ts_data *ts = hid->driver_data;
+
+	/* The only feature report the driver serves is the maximum contact count */
+	if (reqtype != HID_REQ_GET_REPORT || reportnum != HIMAX_REPORT_ID_CONTACT_MAX ||
+	    len < 2)
+		return -EINVAL;
+
+	buf[0] = reportnum;
+	buf[1] = ts->max_points;
+
+	return len;
+}
+
+static const struct hid_ll_driver himax_hid_ll_driver = {
+	.parse = himax_hid_parse,
+	.start = himax_hid_start,
+	.stop = himax_hid_stop,
+	.open = himax_hid_open,
+	.close = himax_hid_close,
+	.raw_request = himax_hid_raw_request,
+};
+
+static int himax_read_ic_info(struct himax_ts_data *ts)
+{
+	u8 ver[4];
+	u32 val;
+	int ret;
+
+	ret = himax_read32(ts, HIMAX_DSRAM_RX_TX_NUM, &val);
+	if (ret)
+		return ret;
+
+	ts->rx_num = FIELD_GET(HIMAX_RX_NUM, val);
+	ts->tx_num = FIELD_GET(HIMAX_TX_NUM, val);
+	if (!ts->rx_num || ts->rx_num > HX83102J_MAX_RX ||
+	    !ts->tx_num || ts->tx_num > HX83102J_MAX_TX) {
+		dev_err(ts->dev, "invalid sensor size %ux%u\n", ts->rx_num, ts->tx_num);
+		return -EINVAL;
+	}
+
+	ret = himax_read32(ts, HIMAX_DSRAM_MAX_POINTS, &val);
+	if (ret)
+		return ret;
+
+	ts->max_points = FIELD_GET(HIMAX_MAX_POINTS, val);
+
+	ret = himax_read32(ts, HIMAX_DSRAM_STYLUS, &val);
+	if (ret)
+		return ret;
+
+	ts->has_stylus = FIELD_GET(HIMAX_STYLUS, val);
+
+	ret = himax_ahb_read(ts, HIMAX_DSRAM_FW_VER, ver, sizeof(ver));
+	if (ret)
+		return ret;
+
+	dev_dbg(ts->dev, "firmware %02x%02x, %ux%u nodes, %u contacts%s\n",
+		ver[1], ver[2], ts->rx_num, ts->tx_num, ts->max_points,
+		ts->has_stylus ? ", stylus" : "");
+
+	return 0;
+}
+
+/*
+ * Every frame in the event stack holds the touch report, the stylus report if
+ * the IC has a stylus function, and a heatmap. The IC packs the heatmap as
+ * 12-bit values, while the report descriptor declares 16-bit values.
+ */
+static int himax_alloc_report_bufs(struct himax_ts_data *ts)
+{
+	u32 nodes = ts->rx_num * ts->tx_num;
+	unsigned int reports = ts->has_stylus ? 2 : 1;
+	size_t event_size, heatmap_size;
+	u8 *buf;
+
+	event_size = reports * ts->max_input_len + HIMAX_REPORT_HDR_SIZE +
+		     HIMAX_HEATMAP_HDR_SIZE + DIV_ROUND_UP(nodes * 3, 2);
+	if (event_size > HIMAX_AHB_MAX_XFER)
+		return -EINVAL;
+
+	heatmap_size = HIMAX_HEATMAP_HDR_SIZE + round_up(nodes, 2) * sizeof(u16);
+
+	/* The heatmap is unpacked in pairs, which may read past an odd count */
+	buf = devm_kzalloc(ts->dev, event_size + 1 + heatmap_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ts->event_buf = buf;
+	ts->event_size = event_size;
+	ts->heatmap_buf = buf + event_size + 1;
+	ts->heatmap_size = heatmap_size;
+
+	return 0;
+}
+
+static int himax_hid_add(struct himax_ts_data *ts)
+{
+	const struct himax_hid_desc *desc = ts->hid_desc;
+	struct hid_device *hid;
+	int ret;
+
+	if (!ts->event_buf) {
+		ret = himax_read_ic_info(ts);
+		if (ret)
+			return ret;
+
+		ret = himax_alloc_report_bufs(ts);
+		if (ret)
+			return ret;
+	}
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid))
+		return PTR_ERR(hid);
+
+	hid->driver_data = ts;
+	hid->ll_driver = &himax_hid_ll_driver;
+	hid->bus = BUS_SPI;
+	hid->dev.parent = ts->dev;
+	hid->version = le16_to_cpu(desc->bcd_version);
+	hid->vendor = le16_to_cpu(desc->vendor_id);
+	hid->product = le16_to_cpu(desc->product_id);
+	snprintf(hid->name, sizeof(hid->name), "hid-hxtp %04X:%04X",
+		 hid->vendor, hid->product);
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		hid_destroy_device(hid);
+		return ret;
+	}
+
+	ts->hid = hid;
+
+	return 0;
+}
+
+static int himax_read_events(struct himax_ts_data *ts)
+{
+	size_t chunk = ts->xfer_max - HIMAX_SPI_READ_HDR_LEN;
+	size_t pos, n;
+	int ret;
+
+	guard(mutex)(&ts->xfer_lock);
+
+	for (pos = 0; pos < ts->event_size; pos += n) {
+		n = min(ts->event_size - pos, chunk);
+		ret = himax_bus_read(ts, HIMAX_BUS_EVENT_STACK, ts->event_buf + pos, n);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void himax_unpack_heatmap(struct himax_ts_data *ts, const u8 *src)
+{
+	u32 count = round_up(ts->rx_num * ts->tx_num, 2);
+	u8 *dst = ts->heatmap_buf;
+	u32 i;
+
+	memcpy(dst, src, HIMAX_HEATMAP_HDR_SIZE);
+	src += HIMAX_HEATMAP_HDR_SIZE;
+	dst += HIMAX_HEATMAP_HDR_SIZE;
+
+	for (i = 0; i < count; i += 2, src += 3, dst += 4) {
+		dst[0] = src[0];
+		dst[1] = src[2] >> 4;
+		dst[2] = src[1];
+		dst[3] = src[2] & 0x0f;
+	}
+}
+
+static irqreturn_t himax_irq(int irq, void *data)
+{
+	struct himax_ts_data *ts = data;
+	size_t len = ts->max_input_len - HIMAX_REPORT_HDR_SIZE;
+	size_t pos = HIMAX_REPORT_HDR_SIZE;
+	int ret;
+
+	ret = himax_read_events(ts);
+	if (ret) {
+		dev_warn_ratelimited(ts->dev, "failed to read events: %d\n", ret);
+		himax_pin_reset(ts);
+		himax_reload_to_active(ts);
+		return IRQ_HANDLED;
+	}
+
+	hid_safe_input_report(ts->hid, HID_INPUT_REPORT, ts->event_buf + pos,
+			      ts->event_size - pos, len, 1);
+	pos += ts->max_input_len;
+
+	if (ts->has_stylus) {
+		hid_safe_input_report(ts->hid, HID_INPUT_REPORT, ts->event_buf + pos,
+				      ts->event_size - pos, len, 1);
+		pos += ts->max_input_len;
+	}
+
+	himax_unpack_heatmap(ts, ts->event_buf + pos);
+	hid_safe_input_report(ts->hid, HID_INPUT_REPORT, ts->heatmap_buf, ts->heatmap_size,
+			      HIMAX_HEATMAP_HDR_SIZE +
+			      ts->rx_num * ts->tx_num * sizeof(u16), 1);
+
+	return IRQ_HANDLED;
+}
+
+static int himax_power_on(struct himax_ts_data *ts)
+{
+	int ret;
+
+	if (!ts->powered) {
+		gpiod_set_value_cansleep(ts->reset_gpio, 1);
+
+		ret = regulator_enable(ts->vccd);
+		if (ret)
+			return ret;
+
+		ts->powered = true;
+		fsleep(2000);
+	}
+
+	gpiod_set_value_cansleep(ts->reset_gpio, 0);
+	fsleep(20000);
+
+	return 0;
+}
+
+static void himax_power_off(struct himax_ts_data *ts)
+{
+	if (ts->irq_enabled) {
+		disable_irq(ts->spi->irq);
+		ts->irq_enabled = false;
+	}
+
+	gpiod_set_value_cansleep(ts->reset_gpio, 1);
+
+	if (ts->powered) {
+		regulator_disable(ts->vccd);
+		ts->powered = false;
+	}
+}
+
+static int himax_boot(struct himax_ts_data *ts)
+{
+	int ret;
+
+	ret = himax_power_on(ts);
+	if (ret)
+		return ret;
+
+	if (!ts->fw) {
+		ret = himax_detect(ts);
+		if (ret)
+			return ret;
+
+		ret = himax_request_fw(ts);
+		if (ret)
+			return ret;
+	}
+
+	ret = himax_load_fw(ts);
+	if (ret)
+		return ret;
+
+	if (!ts->hid)
+		return himax_hid_add(ts);
+
+	return 0;
+}
+
+static void himax_power_on_work(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data, power_on_work);
+	int ret;
+
+	guard(mutex)(&ts->lock);
+
+	if (ts->irq_enabled)
+		return;
+
+	/* A failed power up is retried when the panel is prepared again */
+	ret = himax_boot(ts);
+	if (ret) {
+		dev_err(ts->dev, "failed to power up: %d\n", ret);
+		himax_power_off(ts);
+		return;
+	}
+
+	enable_irq(ts->spi->irq);
+	ts->irq_enabled = true;
+}
+
+static int himax_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct himax_ts_data *ts = container_of(follower, struct himax_ts_data,
+						panel_follower);
+
+	/* Loading the firmware takes a while, don't hold up the panel */
+	schedule_work(&ts->power_on_work);
+
+	return 0;
+}
+
+static int himax_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct himax_ts_data *ts = container_of(follower, struct himax_ts_data,
+						panel_follower);
+
+	cancel_work_sync(&ts->power_on_work);
+
+	guard(mutex)(&ts->lock);
+	himax_power_off(ts);
+
+	return 0;
+}
+
+static const struct drm_panel_follower_funcs himax_panel_follower_funcs = {
+	.panel_prepared = himax_panel_prepared,
+	.panel_unpreparing = himax_panel_unpreparing,
+};
+
+static void himax_cleanup(void *data)
+{
+	struct himax_ts_data *ts = data;
+
+	cancel_work_sync(&ts->power_on_work);
+
+	guard(mutex)(&ts->lock);
+	himax_power_off(ts);
+	if (ts->hid)
+		hid_destroy_device(ts->hid);
+	release_firmware(ts->fw);
+}
+
+static int himax_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct himax_ts_data *ts;
+	int ret;
+
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
+		return dev_err_probe(dev, -EINVAL, "full duplex SPI controller required\n");
+
+	spi->mode = SPI_MODE_3;
+	spi->bits_per_word = 8;
+	spi->cs_setup.value = 300;
+	spi->cs_setup.unit = SPI_DELAY_UNIT_USECS;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->dev = dev;
+	ts->spi = spi;
+	ts->xfer_max = min(spi_max_transfer_size(spi), sizeof(ts->tx_buf));
+	if (ts->xfer_max < SZ_64)
+		return dev_err_probe(dev, -EINVAL, "SPI transfer size limit too low\n");
+
+	ts->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio),
+				     "failed to get reset GPIO\n");
+
+	ts->vccd = devm_regulator_get(dev, "vccd");
+	if (IS_ERR(ts->vccd))
+		return dev_err_probe(dev, PTR_ERR(ts->vccd),
+				     "failed to get vccd supply\n");
+
+	ts->fw_name = "himax_i2chid.bin";
+	device_property_read_string(dev, "firmware-name", &ts->fw_name);
+
+	ret = devm_mutex_init(dev, &ts->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &ts->xfer_lock);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&ts->power_on_work, himax_power_on_work);
+
+	ret = devm_request_threaded_irq(dev, spi->irq, NULL, himax_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					dev_name(dev), ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request interrupt\n");
+
+	ret = devm_add_action_or_reset(dev, himax_cleanup, ts);
+	if (ret)
+		return ret;
+
+	/* The touch function is powered and reset together with the panel */
+	ts->panel_follower.funcs = &himax_panel_follower_funcs;
+	ret = devm_drm_panel_add_follower(dev, &ts->panel_follower);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to follow the panel\n");
+
+	return 0;
+}
+
+static const struct of_device_id himax_of_match[] = {
+	{ .compatible = "himax,hx83102j" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, himax_of_match);
+
+static const struct spi_device_id himax_spi_ids[] = {
+	{ "hx83102j" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, himax_spi_ids);
+
+static struct spi_driver himax_spi_driver = {
+	.driver = {
+		.name = "himax-spi-hid",
+		.of_match_table = himax_of_match,
+	},
+	.probe = himax_probe,
+	.id_table = himax_spi_ids,
+};
+module_spi_driver(himax_spi_driver);
+
+MODULE_DESCRIPTION("Himax HX83102J HID over SPI touchscreen driver");
+MODULE_AUTHOR("Michał Kopeć <michal@nozomi.space>");
+MODULE_LICENSE("GPL");
-- 
2.56.0

