From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 18/26] Input: synaptics-rmi4: Add SPI transport driver
Date: Thu, 5 Nov 2015 15:41:40 -0800
Message-ID: <1446766900-31032-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

Add a transport driver for devices using RMI4 over SPI.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |  57 +++
 drivers/input/rmi4/Kconfig                         |   9 +
 drivers/input/rmi4/Makefile                        |   1 +
 drivers/input/rmi4/rmi_spi.c                       | 464 +++++++++++++++++++++
 include/linux/rmi.h                                |   2 +
 5 files changed, 533 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
 create mode 100644 drivers/input/rmi4/rmi_spi.c

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
new file mode 100644
index 0000000..f20366b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
@@ -0,0 +1,57 @@
+Synaptics RMI4 SPI Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using differnet
+transports and differnet functions. This file describes the device tree
+bindings for devices using the SPI tranport driver. Complete documentation
+for other transports and functions cen be found ini
+Documentation/devicetree/bindings/input/rmi4.
+
+Required Properties:
+- compatible: syna,rmi-spi
+- reg: Chip select address for the device
+- #address-cells: Set to 1 to indicate that the function child nodes
+		    consist of only on uint32 value.
+- #size-cells: Set to 0 to indicate that the function child nodes do not
+		have a size property.
+
+Optional Properties:
+- interrupts: interrupt which the rmi device is connected to.
+- interrupt-parent: The interrupt controller.
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+- syna,spi-read-delay: millisecond delay between read byte transfers.
+- syna,spi-write-delay: millisecond delay between write byte transfers.
+
+Function Parameters:
+Parameters specific to RMI functions are contained in child nodes of the rmi device
+ node. Documentation for the parameters of each function can be found in:
+Documentation/devicetree/bindings/input/rmi4/rmi_f*.txt.
+
+
+
+Example:
+	spi@7000d800 {
+		rmi-spi-dev@0 {
+			compatible = "syna,rmi-spi";
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			spi-max-frequency = <4000000>;
+			spi-cpha;
+			spi-cpol;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(K, 2) 0x2>;
+			syna,spi-read-delay = <30>;
+
+			rmi-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+
+			rmi-f11@11 {
+				reg = <0x11>;
+				syna,flip-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 5e3890e..88a3919 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -36,6 +36,15 @@ config RMI4_I2C
 
 	  This feature is not currently available as a loadable module.
 
+config RMI4_SPI
+	tristate "RMI4 SPI Support"
+	depends on RMI4_CORE && SPI
+	help
+	  Say Y here if you want to support RMI4 devices connected to a SPI
+	  bus.
+
+	  If unsure, say N.
+
 config RMI4_F11
 	bool "RMI4 Function 11 (2D pointing)"
 	depends on RMI4_CORE
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 37b6789..1745757 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -6,5 +6,6 @@ rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 
 # Transports
 obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
+obj-$(CONFIG_RMI4_SPI) += rmi_spi.o
 
 ccflags-$(CONFIG_RMI4_DEBUG) += -DDEBUG
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
new file mode 100644
index 0000000..1b6c258
--- /dev/null
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -0,0 +1,464 @@
+/*
+ * Copyright (c) 2011, 2012 Synaptics Incorporated
+ * Copyright (c) 2011 Unixphere
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rmi.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/of.h>
+#include "rmi_driver.h"
+
+#define RMI_SPI_DEFAULT_XFER_BUF_SIZE	64
+
+#define RMI_PAGE_SELECT_REGISTER	0x00FF
+#define RMI_SPI_PAGE(addr)		(((addr) >> 8) & 0x80)
+#define RMI_SPI_XFER_SIZE_LIMIT		255
+
+#define BUFFER_SIZE_INCREMENT 32
+
+enum rmi_spi_op {
+	RMI_SPI_WRITE = 0,
+	RMI_SPI_READ,
+	RMI_SPI_V2_READ_UNIFIED,
+	RMI_SPI_V2_READ_SPLIT,
+	RMI_SPI_V2_WRITE,
+};
+
+struct rmi_spi_cmd {
+	enum rmi_spi_op op;
+	u16 addr;
+};
+
+struct rmi_spi_xport {
+	struct rmi_transport_dev xport;
+	struct spi_device *spi;
+
+	struct mutex page_mutex;
+	int page;
+
+	u8 *rx_buf;
+	u8 *tx_buf;
+	int xfer_buf_size;
+
+	struct spi_transfer *rx_xfers;
+	struct spi_transfer *tx_xfers;
+	int rx_xfer_count;
+	int tx_xfer_count;
+};
+
+static int rmi_spi_manage_pools(struct rmi_spi_xport *rmi_spi, int len)
+{
+	struct spi_device *spi = rmi_spi->spi;
+	int buf_size = rmi_spi->xfer_buf_size
+		? rmi_spi->xfer_buf_size : RMI_SPI_DEFAULT_XFER_BUF_SIZE;
+	struct spi_transfer *xfer_buf;
+	void *buf;
+	void *tmp;
+
+	while (buf_size < len)
+		buf_size *= 2;
+
+	if (buf_size > RMI_SPI_XFER_SIZE_LIMIT)
+		buf_size = RMI_SPI_XFER_SIZE_LIMIT;
+
+	tmp = rmi_spi->rx_buf;
+	buf = devm_kzalloc(&spi->dev, buf_size * 2,
+				GFP_KERNEL | GFP_DMA);
+	if (!buf)
+		return -ENOMEM;
+
+	rmi_spi->rx_buf = buf;
+	rmi_spi->tx_buf = &rmi_spi->rx_buf[buf_size];
+	rmi_spi->xfer_buf_size = buf_size;
+
+	if (tmp)
+		devm_kfree(&spi->dev, tmp);
+
+	if (rmi_spi->xport.pdata.spi_data.read_delay_us)
+		rmi_spi->rx_xfer_count = buf_size;
+	else
+		rmi_spi->rx_xfer_count = 1;
+
+	if (rmi_spi->xport.pdata.spi_data.write_delay_us)
+		rmi_spi->tx_xfer_count = buf_size;
+	else
+		rmi_spi->tx_xfer_count = 1;
+
+	/*
+	 * Allocate a pool of spi_transfer buffers for devices which need
+	 * per byte delays.
+	 */
+	tmp = rmi_spi->rx_xfers;
+	xfer_buf = devm_kzalloc(&spi->dev,
+		(rmi_spi->rx_xfer_count + rmi_spi->tx_xfer_count)
+		* sizeof(struct spi_transfer), GFP_KERNEL);
+	if (!xfer_buf)
+		return -ENOMEM;
+
+	rmi_spi->rx_xfers = xfer_buf;
+	rmi_spi->tx_xfers = &xfer_buf[rmi_spi->rx_xfer_count];
+
+	if (tmp)
+		devm_kfree(&spi->dev, tmp);
+
+	return 0;
+}
+
+static int rmi_spi_xfer(struct rmi_spi_xport *rmi_spi,
+			const struct rmi_spi_cmd *cmd, const u8 *tx_buf,
+			int tx_len, u8 *rx_buf, int rx_len)
+{
+	struct spi_device *spi = rmi_spi->spi;
+	struct rmi_device_platform_data_spi *spi_data =
+					&rmi_spi->xport.pdata.spi_data;
+	struct spi_message msg;
+	struct spi_transfer *xfer;
+	int ret = 0;
+	int len;
+	int cmd_len = 0;
+	int total_tx_len;
+	int i;
+	u16 addr = cmd->addr;
+
+	spi_message_init(&msg);
+
+	switch (cmd->op) {
+	case RMI_SPI_WRITE:
+	case RMI_SPI_READ:
+		cmd_len += 2;
+		break;
+	case RMI_SPI_V2_READ_UNIFIED:
+	case RMI_SPI_V2_READ_SPLIT:
+	case RMI_SPI_V2_WRITE:
+		cmd_len += 4;
+		break;
+	}
+
+	total_tx_len = cmd_len + tx_len;
+	len = max(total_tx_len, rx_len);
+
+	if (len > RMI_SPI_XFER_SIZE_LIMIT)
+		return -EINVAL;
+
+	if (rmi_spi->xfer_buf_size < len)
+		rmi_spi_manage_pools(rmi_spi, len);
+
+	if (addr == 0)
+		/*
+		 * SPI needs an address. Use 0x7FF if we want to keep
+		 * reading from the last position of the register pointer.
+		 */
+		addr = 0x7FF;
+
+	switch (cmd->op) {
+	case RMI_SPI_WRITE:
+		rmi_spi->tx_buf[0] = (addr >> 8);
+		rmi_spi->tx_buf[1] = addr & 0xFF;
+		break;
+	case RMI_SPI_READ:
+		rmi_spi->tx_buf[0] = (addr >> 8) | 0x80;
+		rmi_spi->tx_buf[1] = addr & 0xFF;
+		break;
+	case RMI_SPI_V2_READ_UNIFIED:
+		break;
+	case RMI_SPI_V2_READ_SPLIT:
+		break;
+	case RMI_SPI_V2_WRITE:
+		rmi_spi->tx_buf[0] = 0x40;
+		rmi_spi->tx_buf[1] = (addr >> 8) & 0xFF;
+		rmi_spi->tx_buf[2] = addr & 0xFF;
+		rmi_spi->tx_buf[3] = tx_len;
+		break;
+	}
+
+	if (tx_buf)
+		memcpy(&rmi_spi->tx_buf[cmd_len], tx_buf, tx_len);
+
+	if (rmi_spi->tx_xfer_count > 1) {
+		for (i = 0; i < total_tx_len; i++) {
+			xfer = &rmi_spi->tx_xfers[i];
+			memset(xfer, 0,	sizeof(struct spi_transfer));
+			xfer->tx_buf = &rmi_spi->tx_buf[i];
+			xfer->len = 1;
+			xfer->delay_usecs = spi_data->write_delay_us;
+			spi_message_add_tail(xfer, &msg);
+		}
+	} else {
+		xfer = rmi_spi->tx_xfers;
+		memset(xfer, 0, sizeof(struct spi_transfer));
+		xfer->tx_buf = rmi_spi->tx_buf;
+		xfer->len = total_tx_len;
+		spi_message_add_tail(xfer, &msg);
+	}
+
+	dev_dbg(&spi->dev, "%s: cmd: %s tx_buf len: %d tx_buf: %*ph\n",
+		__func__, cmd->op == RMI_SPI_WRITE ? "WRITE" : "READ",
+		total_tx_len, total_tx_len, rmi_spi->tx_buf);
+
+	if (rx_buf) {
+		if (rmi_spi->rx_xfer_count > 1) {
+			for (i = 0; i < rx_len; i++) {
+				xfer = &rmi_spi->rx_xfers[i];
+				memset(xfer, 0, sizeof(struct spi_transfer));
+				xfer->rx_buf = &rmi_spi->rx_buf[i];
+				xfer->len = 1;
+				xfer->delay_usecs = spi_data->read_delay_us;
+				spi_message_add_tail(xfer, &msg);
+			}
+		} else {
+			xfer = rmi_spi->rx_xfers;
+			memset(xfer, 0, sizeof(struct spi_transfer));
+			xfer->rx_buf = rmi_spi->rx_buf;
+			xfer->len = rx_len;
+			spi_message_add_tail(xfer, &msg);
+		}
+	}
+
+	ret = spi_sync(spi, &msg);
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi xfer failed: %d\n", ret);
+		return ret;
+	}
+
+	if (rx_buf) {
+		memcpy(rx_buf, rmi_spi->rx_buf, rx_len);
+		dev_dbg(&spi->dev, "%s: (%d) %*ph\n", __func__, rx_len,
+			rx_len, rx_buf);
+	}
+
+	return 0;
+}
+
+/*
+ * rmi_set_page - Set RMI page
+ * @xport: The pointer to the rmi_transport_dev struct
+ * @page: The new page address.
+ *
+ * RMI devices have 16-bit addressing, but some of the transport
+ * implementations (like SMBus) only have 8-bit addressing. So RMI implements
+ * a page address at 0xff of every page so we can reliable page addresses
+ * every 256 registers.
+ *
+ * The page_mutex lock must be held when this function is entered.
+ *
+ * Returns zero on success, non-zero on failure.
+ */
+static int rmi_set_page(struct rmi_spi_xport *rmi_spi, u8 page)
+{
+	struct rmi_spi_cmd cmd;
+	int ret;
+
+	cmd.op = RMI_SPI_WRITE;
+	cmd.addr = RMI_PAGE_SELECT_REGISTER;
+
+	ret = rmi_spi_xfer(rmi_spi, &cmd, &page, 1, NULL, 0);
+
+	if (ret)
+		rmi_spi->page = page;
+
+	return ret;
+}
+
+static int rmi_spi_write_block(struct rmi_transport_dev *xport, u16 addr,
+			       const void *buf, size_t len)
+{
+	struct rmi_spi_xport *rmi_spi =
+		container_of(xport, struct rmi_spi_xport, xport);
+	struct rmi_spi_cmd cmd;
+	int ret;
+
+	mutex_lock(&rmi_spi->page_mutex);
+
+	if (RMI_SPI_PAGE(addr) != rmi_spi->page) {
+		ret = rmi_set_page(rmi_spi, RMI_SPI_PAGE(addr));
+		if (ret)
+			goto exit;
+	}
+
+	cmd.op = RMI_SPI_WRITE;
+	cmd.addr = addr;
+
+	ret = rmi_spi_xfer(rmi_spi, &cmd, buf, len, NULL, 0);
+
+exit:
+	mutex_unlock(&rmi_spi->page_mutex);
+	return ret;
+}
+
+static int rmi_spi_read_block(struct rmi_transport_dev *xport, u16 addr,
+			      void *buf, size_t len)
+{
+	struct rmi_spi_xport *rmi_spi =
+		container_of(xport, struct rmi_spi_xport, xport);
+	struct rmi_spi_cmd cmd;
+	int ret;
+
+	mutex_lock(&rmi_spi->page_mutex);
+
+	if (RMI_SPI_PAGE(addr) != rmi_spi->page) {
+		ret = rmi_set_page(rmi_spi, RMI_SPI_PAGE(addr));
+		if (ret)
+			goto exit;
+	}
+
+	cmd.op = RMI_SPI_READ;
+	cmd.addr = addr;
+
+	ret = rmi_spi_xfer(rmi_spi, &cmd, NULL, 0, buf, len);
+
+exit:
+	mutex_unlock(&rmi_spi->page_mutex);
+	return ret;
+}
+
+static const struct rmi_transport_ops rmi_spi_ops = {
+	.write_block	= rmi_spi_write_block,
+	.read_block	= rmi_spi_read_block,
+};
+
+#ifdef CONFIG_OF
+static int rmi_spi_of_probe(struct spi_device *spi,
+				struct rmi_device_platform_data *pdata)
+{
+	struct device *dev = &spi->dev;
+	int retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->spi_data.read_delay_us,
+			"syna,spi-read-delay", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			&pdata->spi_data.write_delay_us,
+			"syna,spi-write-delay", 1);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
+static const struct of_device_id rmi_spi_of_match[] = {
+	{ .compatible = "syna,rmi-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rmi_spi_of_match);
+#else
+static inline int rmi_spi_of_probe(struct spi_device *spi,
+					struct rmi_device_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+
+static int rmi_spi_probe(struct spi_device *spi)
+{
+	struct rmi_spi_xport *rmi_spi;
+	struct rmi_device_platform_data *pdata;
+	struct rmi_device_platform_data *spi_pdata = spi->dev.platform_data;
+	int retval;
+
+	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX)
+		return -EINVAL;
+
+	rmi_spi = devm_kzalloc(&spi->dev, sizeof(struct rmi_spi_xport),
+			GFP_KERNEL);
+	if (!rmi_spi)
+		return -ENOMEM;
+
+	pdata = &rmi_spi->xport.pdata;
+
+	if (spi->dev.of_node) {
+		retval = rmi_spi_of_probe(spi, pdata);
+		if (retval)
+			return retval;
+	} else if (spi_pdata) {
+		*pdata = *spi_pdata;
+	}
+
+	if (pdata->spi_data.bits_per_word)
+		spi->bits_per_word = pdata->spi_data.bits_per_word;
+
+	if (pdata->spi_data.mode)
+		spi->mode = pdata->spi_data.mode;
+
+	retval = spi_setup(spi);
+	if (retval < 0) {
+		dev_err(&spi->dev, "spi_setup failed!\n");
+		return retval;
+	}
+
+	rmi_spi->spi = spi;
+	mutex_init(&rmi_spi->page_mutex);
+
+	rmi_spi->xport.dev = &spi->dev;
+	rmi_spi->xport.proto_name = "spi";
+	rmi_spi->xport.ops = &rmi_spi_ops;
+	rmi_spi->xport.irq = spi->irq;
+
+	retval = rmi_spi_manage_pools(rmi_spi, RMI_SPI_DEFAULT_XFER_BUF_SIZE);
+	if (retval)
+		return retval;
+
+	/*
+	 * Setting the page to zero will (a) make sure the PSR is in a
+	 * known state, and (b) make sure we can talk to the device.
+	 */
+	retval = rmi_set_page(rmi_spi, 0);
+	if (retval) {
+		dev_err(&spi->dev, "Failed to set page select to 0.\n");
+		return retval;
+	}
+
+	retval = rmi_register_transport_device(&rmi_spi->xport);
+	if (retval) {
+		dev_err(&spi->dev, "failed to register transport.\n");
+		return retval;
+	}
+
+	spi_set_drvdata(spi, rmi_spi);
+
+	dev_info(&spi->dev, "registered RMI SPI driver\n");
+	return 0;
+}
+
+static int rmi_spi_remove(struct spi_device *spi)
+{
+	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
+
+	rmi_unregister_transport_device(&rmi_spi->xport);
+
+	return 0;
+}
+
+static const struct spi_device_id rmi_id[] = {
+	{ "rmi_spi", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, rmi_id);
+
+static struct spi_driver rmi_spi_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "rmi_spi",
+		.of_match_table = of_match_ptr(rmi_spi_of_match),
+	},
+	.id_table	= rmi_id,
+	.probe		= rmi_spi_probe,
+	.remove		= rmi_spi_remove,
+};
+
+module_spi_driver(rmi_spi_driver);
+
+MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com>");
+MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com>");
+MODULE_DESCRIPTION("RMI SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(RMI_DRIVER_VERSION);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index fef482a..c781d09 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -205,6 +205,8 @@ struct rmi_device_platform_data_spi {
 	u32 split_read_byte_delay_us;
 	u32 pre_delay_us;
 	u32 post_delay_us;
+	u8 bits_per_word;
+	u16 mode;
 
 	void *cs_assert_data;
 	int (*cs_assert) (const void *cs_assert_data, const bool assert);
-- 
2.1.4
