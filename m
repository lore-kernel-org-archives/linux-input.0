From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v3 09/17] spi: add locomo SPI driver
Date: Sun, 17 May 2015 19:27:49 +0300
Message-ID: <1431880077-26321-10-git-send-email-dbaryshkov@gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

LoCoMo chip has a built-in simple SPI controller. On Sharp SL-5500 PDDAs
it is connected to external MMC slot.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/spi/Kconfig      |  10 ++
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-locomo.c | 332 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/spi/spi-locomo.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 198f96b..c9e3176 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -258,6 +258,16 @@ config SPI_LM70_LLP
 	  which interfaces to an LM70 temperature sensor using
 	  a parallel port.
 
+config SPI_LOCOMO
+	tristate "Locomo SPI master"
+	depends on MFD_LOCOMO
+	help
+	  This enables using the SPI controller as present in the LoCoMo
+	  chips. It is probably only useful on the Sharp SL-5x00 PDA family.
+
+	  On SL-5500 and SL-5000 devices this controller is used for
+	  MMC/SD cards.
+
 config SPI_MPC52xx
 	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
 	depends on PPC_MPC52xx
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d8cbf65..623c463 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
+obj-$(CONFIG_SPI_LOCOMO)		+= spi-locomo.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
diff --git a/drivers/spi/spi-locomo.c b/drivers/spi/spi-locomo.c
new file mode 100644
index 0000000..bef0354
--- /dev/null
+++ b/drivers/spi/spi-locomo.c
@@ -0,0 +1,332 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/locomo.h>
+
+struct locomospi_dev {
+	struct regmap *regmap;
+
+	int clock_base;
+	int clock_div;
+	unsigned nsecs;
+
+	unsigned int save_ct;
+	unsigned int save_md;
+};
+
+static void locomospi_chipselect(struct spi_device *spi, bool enable)
+{
+	struct locomospi_dev *spidev;
+
+	dev_dbg(&spi->dev, "SPI cs: %s\n", enable ? "enable" : "disable");
+
+	spidev = spi_master_get_devdata(spi->master);
+
+	regmap_update_bits(spidev->regmap, LOCOMO_SPICT, LOCOMO_SPICT_CS,
+			enable ? LOCOMO_SPICT_CS : 0);
+}
+
+static u32 locomospi_txrx_word(struct spi_device *spi,
+		unsigned nsecs,
+		u32 word)
+{
+	struct locomospi_dev *spidev;
+	int wait;
+	int j;
+	unsigned int rx;
+	unsigned int r;
+
+	spidev = spi_master_get_devdata(spi->master);
+
+	if (spidev->clock_div == DIV_64)
+		wait = 0x10000;
+	else
+		wait = 8;
+
+	for (j = 0; j < wait; j++) {
+		regmap_read(spidev->regmap, LOCOMO_SPIST, &r);
+		if (r & LOCOMO_SPI_RFW)
+			break;
+	}
+	if (j == wait)
+		dev_err_ratelimited(&spi->dev, "rfw timeout\n");
+
+	regmap_write(spidev->regmap, LOCOMO_SPITD, word);
+	ndelay(nsecs);
+
+	for (j = 0; j < wait; j++) {
+		regmap_read(spidev->regmap, LOCOMO_SPIST, &r);
+		if (r & LOCOMO_SPI_RFR)
+			break;
+	}
+	if (j == wait)
+		dev_err_ratelimited(&spi->dev, "rfr timeout\n");
+
+	regmap_read(spidev->regmap, LOCOMO_SPIRD, &rx);
+	ndelay(nsecs);
+
+	dev_dbg(&spi->dev, "SPI txrx: %02x/%02x\n", word, rx);
+
+	return rx;
+}
+
+static void locomo_spi_set_speed(struct locomospi_dev *spidev, u32 hz)
+{
+	spidev->nsecs = (1000000000/2) / hz;
+
+	if (hz >= 24576000) {
+		spidev->clock_base = CLOCK_25MHZ;
+		spidev->clock_div = DIV_1;
+	} else if (hz >= 22579200) {
+		spidev->clock_base = CLOCK_22MHZ;
+		spidev->clock_div = DIV_1;
+	} else if (hz >= 18432000) {
+		spidev->clock_base = CLOCK_18MHZ;
+		spidev->clock_div = DIV_1;
+	} else if (hz >= 12288000) {
+		spidev->clock_base = CLOCK_25MHZ;
+		spidev->clock_div = DIV_2;
+	} else if (hz >= 11289600) {
+		spidev->clock_base = CLOCK_22MHZ;
+		spidev->clock_div = DIV_2;
+	} else if (hz >= 9216000) {
+		spidev->clock_base = CLOCK_18MHZ;
+		spidev->clock_div = DIV_2;
+	} else if (hz >= 6144000) {
+		spidev->clock_base = CLOCK_25MHZ;
+		spidev->clock_div = DIV_4;
+	} else if (hz >= 5644800) {
+		spidev->clock_base = CLOCK_22MHZ;
+		spidev->clock_div = DIV_4;
+	} else if (hz >= 4608000) {
+		spidev->clock_base = CLOCK_18MHZ;
+		spidev->clock_div = DIV_4;
+	} else if (hz >= 3072000) {
+		spidev->clock_base = CLOCK_25MHZ;
+		spidev->clock_div = DIV_8;
+	} else if (hz >= 2822400) {
+		spidev->clock_base = CLOCK_22MHZ;
+		spidev->clock_div = DIV_8;
+	} else if (hz >= 2304000) {
+		spidev->clock_base = CLOCK_18MHZ;
+		spidev->clock_div = DIV_8;
+	} else if (hz >= 384000) {
+		spidev->clock_base = CLOCK_25MHZ;
+		spidev->clock_div = DIV_64;
+	} else if (hz >= 352800) {
+		spidev->clock_base = CLOCK_22MHZ;
+		spidev->clock_div = DIV_64;
+	} else {		/* set to 288 Khz */
+		spidev->clock_base = CLOCK_18MHZ;
+		spidev->clock_div = DIV_64;
+	}
+
+	regmap_update_bits(spidev->regmap, LOCOMO_SPIMD,
+			LOCOMO_SPIMD_XSEL | LOCOMO_SPIMD_CLKSEL |
+				LOCOMO_SPIMD_XEN,
+			0);
+	regmap_update_bits(spidev->regmap, LOCOMO_SPIMD,
+			LOCOMO_SPIMD_XSEL | LOCOMO_SPIMD_CLKSEL |
+				LOCOMO_SPIMD_XEN,
+			spidev->clock_div | (spidev->clock_base << 3) |
+				LOCOMO_SPIMD_XEN);
+
+	usleep_range(300, 400);
+}
+
+static int locomo_spi_setup_transfer(struct spi_device *spi,
+		struct spi_transfer *t)
+{
+	struct locomospi_dev *spidev;
+
+	spidev = spi_master_get_devdata(spi->master);
+
+	regmap_update_bits(spidev->regmap, LOCOMO_SPIMD,
+			LOCOMO_SPIMD_XON,
+			LOCOMO_SPIMD_XON);
+
+	locomo_spi_set_speed(spidev, t->speed_hz);
+
+	return 0;
+}
+
+static int locomospi_transfer_one(struct spi_master *master,
+		struct spi_device *spi,
+		struct spi_transfer *t)
+{
+	struct locomospi_dev *spidev = spi_master_get_devdata(spi->master);
+	int rc;
+	unsigned count;
+	const u8 *tx = t->tx_buf;
+	u8 *rx = t->rx_buf;
+
+	rc = locomo_spi_setup_transfer(spi, t);
+	if (rc < 0)
+		return rc;
+
+	if (!t->len)
+		return 0;
+
+	for (count = t->len; likely(count > 0); count--) {
+		u8 word = 0;
+
+		if (tx)
+			word = *tx++;
+		word = locomospi_txrx_word(spi, spidev->nsecs, word);
+
+		if (rx)
+			*rx++ = word;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int locomo_spi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct locomospi_dev *spidev = spi_master_get_devdata(master);
+	int ret;
+
+	/* Stop the queue running */
+	ret = spi_master_suspend(master);
+	if (ret) {
+		dev_warn(dev, "cannot suspend master\n");
+		return ret;
+	}
+
+	regmap_read(spidev->regmap, LOCOMO_SPICT, &spidev->save_ct);
+	regmap_write(spidev->regmap, LOCOMO_SPICT, LOCOMO_SPICT_CS);
+	regmap_read(spidev->regmap, LOCOMO_SPIMD, &spidev->save_md);
+	regmap_write(spidev->regmap, LOCOMO_SPIMD,
+			LOCOMO_SPIMD_MSB1ST | LOCOMO_SPIMD_DOSTAT |
+			LOCOMO_SPIMD_RCPOL | LOCOMO_SPIMD_TCPOL |
+			(CLOCK_25MHZ << 3) | DIV_64);
+
+	return 0;
+}
+
+static int locomo_spi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct locomospi_dev *spidev = spi_master_get_devdata(master);
+	int ret;
+
+	regmap_write(spidev->regmap, LOCOMO_SPIMD, spidev->save_md);
+	regmap_write(spidev->regmap, LOCOMO_SPICT, spidev->save_ct);
+
+	/* Start the queue running */
+	ret = spi_master_resume(master);
+	if (ret)
+		dev_err(dev, "problem starting queue (%d)\n", ret);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(locomo_spi_pm_ops,
+		locomo_spi_suspend, locomo_spi_resume);
+
+#define LOCOMO_SPI_PM_OPS	(&locomo_spi_pm_ops)
+#else
+#define LOCOMO_SPI_PM_OPS	NULL
+#endif
+
+static int locomo_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct locomospi_dev *spidev;
+	int ret = -ENODEV;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct locomospi_dev));
+	if (!master)
+		return -ENOMEM;
+
+	master->bus_num = 0;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 8);
+	master->max_speed_hz = 24576000;
+	master->num_chipselect = 1;
+	master->set_cs = locomospi_chipselect;
+	master->transfer_one = locomospi_transfer_one;
+
+	spidev = spi_master_get_devdata(master);
+
+	spidev->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!spidev->regmap)
+		goto out_put;
+
+	spidev->clock_div = DIV_1;
+	spidev->clock_base = CLOCK_25MHZ;
+
+	platform_set_drvdata(pdev, master);
+
+	regmap_write(spidev->regmap, LOCOMO_SPIMD,
+			LOCOMO_SPIMD_MSB1ST | LOCOMO_SPIMD_DOSTAT |
+			LOCOMO_SPIMD_RCPOL | LOCOMO_SPIMD_TCPOL |
+			LOCOMO_SPIMD_XON);
+
+	regmap_write(spidev->regmap, LOCOMO_SPIMD,
+			LOCOMO_SPIMD_MSB1ST | LOCOMO_SPIMD_DOSTAT |
+			LOCOMO_SPIMD_RCPOL | LOCOMO_SPIMD_TCPOL |
+			LOCOMO_SPIMD_XON | LOCOMO_SPIMD_XEN |
+			(spidev->clock_base << 3) | spidev->clock_div);
+
+	regmap_write(spidev->regmap, LOCOMO_SPICT, LOCOMO_SPICT_CS |
+			LOCOMO_SPICT_CEN | LOCOMO_SPICT_RXUEN |
+			LOCOMO_SPICT_ALIGNEN);
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret) {
+		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		goto out_put;
+	}
+
+	return 0;
+
+out_put:
+	spi_master_put(master);
+	return ret;
+}
+
+static int locomo_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct locomospi_dev *spidev = spi_master_get_devdata(master);
+
+	regmap_update_bits(spidev->regmap, LOCOMO_SPICT, LOCOMO_SPICT_CEN, 0);
+	regmap_update_bits(spidev->regmap, LOCOMO_SPIMD, LOCOMO_SPIMD_XEN, 0);
+	regmap_update_bits(spidev->regmap, LOCOMO_SPIMD, LOCOMO_SPIMD_XON, 0);
+	regmap_update_bits(spidev->regmap, LOCOMO_SPICT,
+			LOCOMO_SPICT_CS,
+			LOCOMO_SPICT_CS);
+
+	return 0;
+}
+
+static struct platform_driver locomo_spi_driver = {
+	.probe = locomo_spi_probe,
+	.remove = locomo_spi_remove,
+	.driver = {
+		.name = "locomo-spi",
+		.pm = LOCOMO_SPI_PM_OPS,
+	},
+};
+module_platform_driver(locomo_spi_driver);
+
+MODULE_AUTHOR("Thomas Kunze thommy@tabao.de");
+MODULE_DESCRIPTION("LoCoMo SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:locomo-spi");
-- 
2.1.4

