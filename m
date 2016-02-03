From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v3 08/10] Input: synaptics-rmi4: Add SPI transport driver
Date: Tue, 2 Feb 2016 17:45:52 -0800
Message-ID: <1454463952-4323-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:46726 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755383AbcBCBp6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Feb 2016 20:45:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Mark Brown <broonie@kernel.org>

Add the transport driver for devices using RMI4 over SPI.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/Kconfig   |   9 +
 drivers/input/rmi4/Makefile  |   1 +
 drivers/input/rmi4/rmi_spi.c | 547 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/rmi.h          |  51 ++++
 4 files changed, 608 insertions(+)
 create mode 100644 drivers/input/rmi4/rmi_spi.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 284faec..f73df24 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -18,6 +18,15 @@ config RMI4_I2C
 
 	  If unsure, say Y.
 
+config RMI4_SPI
+	tristate "RMI4 SPI Support"
+	depends on RMI4_CORE && SPI
+	help
+	  Say Y here if you want to support RMI4 devices connected to a SPI
+	  bus.
+
+	  If unsure, say N.
+
 config RMI4_2D_SENSOR
 	bool
 	depends on RMI4_CORE
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index ad7156d..95c00a7 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -10,3 +10,4 @@ rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
 
 # Transports
 obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
+obj-$(CONFIG_RMI4_SPI) += rmi_spi.o
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
new file mode 100644
index 0000000..8b4d169
--- /dev/null
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -0,0 +1,547 @@
+/*
+ * Copyright (c) 2011-2016 Synaptics Incorporated
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
+	int irq;
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
+	rmi_dbg(RMI_DEBUG_XPORT, &spi->dev, "%s: cmd: %s tx_buf len: %d tx_buf: %*ph\n",
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
+		rmi_dbg(RMI_DEBUG_XPORT, &spi->dev, "%s: (%d) %*ph\n",
+			__func__, rx_len, rx_len, rx_buf);
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
+static irqreturn_t rmi_spi_irq(int irq, void *dev_id)
+{
+	struct rmi_spi_xport *rmi_spi = dev_id;
+	struct rmi_device *rmi_dev = rmi_spi->xport.rmi_dev;
+	int ret;
+
+	ret = rmi_process_interrupt_requests(rmi_dev);
+	if (ret)
+		rmi_dbg(RMI_DEBUG_XPORT, &rmi_dev->dev,
+			"Failed to process interrupt request: %d\n", ret);
+
+	return IRQ_HANDLED;
+}
+
+static int rmi_spi_init_irq(struct spi_device *spi)
+{
+	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
+	int irq_flags = rmi_spi->xport.pdata.irq_flags;
+	int ret;
+
+	if (!irq_flags)
+		irq_flags = IRQF_TRIGGER_LOW;
+
+	ret = request_threaded_irq(rmi_spi->irq, NULL, rmi_spi_irq,
+			irq_flags | IRQF_ONESHOT, dev_name(&spi->dev),
+			rmi_spi);
+	if (ret < 0) {
+		dev_warn(&spi->dev, "Failed to register interrupt %d\n",
+			rmi_spi->irq);
+		return ret;
+	}
+
+	return 0;
+}
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
+	if (spi_pdata)
+		*pdata = *spi_pdata;
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
+	if (spi->irq > 0)
+		rmi_spi->irq = spi->irq;
+
+	rmi_spi->spi = spi;
+	mutex_init(&rmi_spi->page_mutex);
+
+	rmi_spi->xport.dev = &spi->dev;
+	rmi_spi->xport.proto_name = "spi";
+	rmi_spi->xport.ops = &rmi_spi_ops;
+
+	spi_set_drvdata(spi, rmi_spi);
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
+	retval = rmi_spi_init_irq(spi);
+	if (retval < 0)
+		return retval;
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
+#ifdef CONFIG_PM_SLEEP
+static int rmi_spi_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
+	int ret;
+
+	ret = rmi_driver_suspend(rmi_spi->xport.rmi_dev);
+	if (ret)
+		dev_warn(dev, "Failed to resume device: %d\n", ret);
+
+	disable_irq(rmi_spi->irq);
+	if (device_may_wakeup(&spi->dev)) {
+		ret = enable_irq_wake(rmi_spi->irq);
+		if (!ret)
+			dev_warn(dev, "Failed to enable irq for wake: %d\n",
+				ret);
+	}
+	return ret;
+}
+
+static int rmi_spi_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
+	int ret;
+
+	enable_irq(rmi_spi->irq);
+	if (device_may_wakeup(&spi->dev)) {
+		ret = disable_irq_wake(rmi_spi->irq);
+		if (!ret)
+			dev_warn(dev, "Failed to disable irq for wake: %d\n",
+				ret);
+	}
+
+	ret = rmi_driver_resume(rmi_spi->xport.rmi_dev);
+	if (ret)
+		dev_warn(dev, "Failed to resume device: %d\n", ret);
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int rmi_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
+	int ret;
+
+	ret = rmi_driver_suspend(rmi_spi->xport.rmi_dev);
+	if (ret)
+		dev_warn(dev, "Failed to resume device: %d\n", ret);
+
+	disable_irq(rmi_spi->irq);
+
+	return 0;
+}
+
+static int rmi_spi_runtime_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
+	int ret;
+
+	enable_irq(rmi_spi->irq);
+
+	ret = rmi_driver_resume(rmi_spi->xport.rmi_dev);
+	if (ret)
+		dev_warn(dev, "Failed to resume device: %d\n", ret);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops rmi_spi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(rmi_spi_suspend, rmi_spi_resume)
+	SET_RUNTIME_PM_OPS(rmi_spi_runtime_suspend, rmi_spi_runtime_resume,
+			   NULL)
+};
+
+static const struct spi_device_id rmi_id[] = {
+	{ "rmi4_spi", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, rmi_id);
+
+static struct spi_driver rmi_spi_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "rmi4_spi",
+		.pm	= &rmi_spi_pm,
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
index dca1b25..7b9d15f 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -150,6 +150,55 @@ struct rmi_f01_power_management {
 };
 
 /**
+ * struct rmi_device_platform_data_spi - provides parameters used in SPI
+ * communications.  All Synaptics SPI products support a standard SPI
+ * interface; some also support what is called SPI V2 mode, depending on
+ * firmware and/or ASIC limitations.  In V2 mode, the touch sensor can
+ * support shorter delays during certain operations, and these are specified
+ * separately from the standard mode delays.
+ *
+ * @block_delay - for standard SPI transactions consisting of both a read and
+ * write operation, the delay (in microseconds) between the read and write
+ * operations.
+ * @split_read_block_delay_us - for V2 SPI transactions consisting of both a
+ * read and write operation, the delay (in microseconds) between the read and
+ * write operations.
+ * @read_delay_us - the delay between each byte of a read operation in normal
+ * SPI mode.
+ * @write_delay_us - the delay between each byte of a write operation in normal
+ * SPI mode.
+ * @split_read_byte_delay_us - the delay between each byte of a read operation
+ * in V2 mode.
+ * @pre_delay_us - the delay before the start of a SPI transaction.  This is
+ * typically useful in conjunction with custom chip select assertions (see
+ * below).
+ * @post_delay_us - the delay after the completion of an SPI transaction.  This
+ * is typically useful in conjunction with custom chip select assertions (see
+ * below).
+ * @cs_assert - For systems where the SPI subsystem does not control the CS/SSB
+ * line, or where such control is broken, you can provide a custom routine to
+ * handle a GPIO as CS/SSB.  This routine will be called at the beginning and
+ * end of each SPI transaction.  The RMI SPI implementation will wait
+ * pre_delay_us after this routine returns before starting the SPI transfer;
+ * and post_delay_us after completion of the SPI transfer(s) before calling it
+ * with assert==FALSE.
+ */
+struct rmi_device_platform_data_spi {
+	u32 block_delay_us;
+	u32 split_read_block_delay_us;
+	u32 read_delay_us;
+	u32 write_delay_us;
+	u32 split_read_byte_delay_us;
+	u32 pre_delay_us;
+	u32 post_delay_us;
+	u8 bits_per_word;
+	u16 mode;
+
+	void *cs_assert_data;
+	int (*cs_assert)(const void *cs_assert_data, const bool assert);
+};
+
+/**
  * struct rmi_device_platform_data - system specific configuration info.
  *
  * @irq_flags - this is used to specify intrerrupt type flags.
@@ -163,6 +212,8 @@ struct rmi_device_platform_data {
 
 	int reset_delay_ms;
 
+	struct rmi_device_platform_data_spi spi_data;
+
 	/* function handler pdata */
 	struct rmi_2d_sensor_platform_data *sensor_pdata;
 	struct rmi_f01_power_management power_management;
-- 
2.5.0

