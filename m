From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 15/15] spi: add locomo SPI driver
Date: Tue, 28 Oct 2014 03:02:08 +0300
Message-ID: <1414454528-24240-16-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

LoCoMo chip has a built-in simple SPI controller. On Sharp SL-5500 PDDAs
it is connected to external MMC slot.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig        |   8 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-locomo.c   | 370 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/locomo.h |  30 ++++
 4 files changed, 409 insertions(+)
 create mode 100644 drivers/spi/spi-locomo.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 84e7c9e..1395780 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -242,6 +242,14 @@ config SPI_LM70_LLP
 	  which interfaces to an LM70 temperature sensor using
 	  a parallel port.
 
+config SPI_LOCOMO
+	tristate "Locomo SPI master"
+	depends on MFD_LOCOMO
+	select SPI_BITBANG
+	help
+	  This enables using the SPI controller as present in the LoCoMo
+	  chips. It is probably only usefull on the Sharp SL-5x00 PDA family.
+
 config SPI_MPC52xx
 	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
 	depends on PPC_MPC52xx
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 78f24ca..4f96197 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
+obj-$(CONFIG_SPI_LOCOMO)		+= spi-locomo.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
diff --git a/drivers/spi/spi-locomo.c b/drivers/spi/spi-locomo.c
new file mode 100644
index 0000000..8e9e5c4
--- /dev/null
+++ b/drivers/spi/spi-locomo.c
@@ -0,0 +1,370 @@
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/mfd/locomo.h>
+#include <linux/delay.h>
+
+struct locomospi_dev {
+	struct spi_bitbang bitbang;
+	void __iomem *base;
+	int clock_base;
+	int clock_div;
+
+	u16 save_ct;
+	u16 save_md;
+};
+
+static void locomospi_reg_open(struct locomospi_dev *spidev)
+{
+	u16 r;
+
+	spidev->clock_div = DIV_64;
+	spidev->clock_base = CLOCK_18MHZ;
+	writew(LOCOMO_SPIMD_MSB1ST | LOCOMO_SPIMD_DOSTAT | LOCOMO_SPIMD_RCPOL |
+		  LOCOMO_SPIMD_TCPOL | (spidev->clock_base << 3) |
+		  spidev->clock_div,
+		  spidev->base + LOCOMO_SPIMD);
+
+	/* if (locomospi_carddetect()) { */
+	r = readw(spidev->base + LOCOMO_SPIMD);
+	r |= LOCOMO_SPIMD_XON;
+	writew(r, spidev->base + LOCOMO_SPIMD);
+
+	r = readw(spidev->base + LOCOMO_SPIMD);
+	r |= LOCOMO_SPIMD_XEN;
+	writew(r, spidev->base + LOCOMO_SPIMD);
+	/* } */
+
+	writew(LOCOMO_SPICT_CS, spidev->base + LOCOMO_SPICT);
+
+	r = readw(spidev->base + LOCOMO_SPICT);
+	r |= (LOCOMO_SPICT_CEN | LOCOMO_SPICT_RXUEN | LOCOMO_SPICT_ALIGNEN);
+	writew(r, spidev->base + LOCOMO_SPICT);
+
+	udelay(200);
+
+	r = readw(spidev->base + LOCOMO_SPICT);
+	writew(r, spidev->base + LOCOMO_SPICT);
+
+	r = readw(spidev->base + LOCOMO_SPICT);
+	r &= ~LOCOMO_SPICT_CS;
+	writew(r, spidev->base + LOCOMO_SPICT);
+}
+
+static void locomospi_reg_release(struct locomospi_dev *spidev)
+{
+	u16 r;
+
+	r = readw(spidev->base + LOCOMO_SPICT);
+	r &= ~LOCOMO_SPICT_CEN;
+	writew(r, spidev->base + LOCOMO_SPICT);
+
+	r = readw(spidev->base + LOCOMO_SPIMD);
+	r &= ~LOCOMO_SPIMD_XEN;
+	writew(r, spidev->base + LOCOMO_SPIMD);
+
+	r = readw(spidev->base + LOCOMO_SPIMD);
+	r &= ~LOCOMO_SPIMD_XON;
+	writew(r, spidev->base + LOCOMO_SPIMD);
+
+	r = readw(spidev->base + LOCOMO_SPICT);
+	r |= LOCOMO_SPIMD_XEN; /* FIXME */
+	writew(r, spidev->base + LOCOMO_SPICT);
+}
+
+
+static void locomospi_chipselect(struct spi_device *spi, int is_active)
+{
+	struct locomospi_dev *spidev;
+	u16 r;
+
+	dev_dbg(&spi->dev, "SPI cs: %d\n", is_active);
+
+	spidev = spi_master_get_devdata(spi->master);
+
+	r = readw(spidev->base + LOCOMO_SPICT);
+	if (!!is_active ^ !!(spi->mode & SPI_CS_HIGH))
+		r &= ~LOCOMO_SPICT_CS;
+	else
+		r |= LOCOMO_SPICT_CS;
+	writew(r, spidev->base + LOCOMO_SPICT);
+}
+
+static u32 locomospi_txrx_word(struct spi_device *spi,
+		unsigned nsecs,
+		u32 word, u8 bits)
+{
+	struct locomospi_dev *spidev;
+	int wait;
+	int j;
+	u32 rx;
+
+	spidev = spi_master_get_devdata(spi->master);
+
+	if (spidev->clock_div == 4)
+		wait = 0x10000;
+	else
+		wait = 8;
+
+	for (j = 0; j < wait; j++) {
+		if (readw(spidev->base + LOCOMO_SPIST) & LOCOMO_SPI_RFW)
+			break;
+	}
+
+	writeb(word, spidev->base + LOCOMO_SPITD);
+	ndelay(nsecs);
+
+	for (j = 0; j < wait; j++) {
+		if (readw(spidev->base + LOCOMO_SPIST) & LOCOMO_SPI_RFR)
+			break;
+	}
+
+	rx = readb(spidev->base + LOCOMO_SPIRD);
+	ndelay(nsecs);
+
+	dev_dbg(&spi->dev, "SPI txrx: %02x/%02x\n", word, rx);
+
+	return rx;
+}
+
+static void locomo_spi_set_speed(struct locomospi_dev *spidev, u32 hz)
+{
+	u16 r;
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
+	r = readw(spidev->base + LOCOMO_SPIMD);
+	if ((r & LOCOMO_SPIMD_CLKSEL) == spidev->clock_div &&
+			(r & LOCOMO_SPIMD_XSEL) == (spidev->clock_div << 3))
+		return;
+
+	r &= ~(LOCOMO_SPIMD_XSEL | LOCOMO_SPIMD_CLKSEL | LOCOMO_SPIMD_XEN);
+	writew(r, spidev->base + LOCOMO_SPIMD);
+
+	r |= (spidev->clock_div | (spidev->clock_base << 3) | LOCOMO_SPIMD_XEN);
+	writew(r, spidev->base + LOCOMO_SPIMD);
+
+	udelay(300);
+}
+
+static int locomo_spi_setup_transfer(struct spi_device *spi,
+		struct spi_transfer *t)
+{
+	struct locomospi_dev *spidev;
+	u16 r;
+	u32 hz = 0;
+	int rc = spi_bitbang_setup_transfer(spi, t);
+
+	if (rc)
+		return rc;
+
+	if (t)
+		hz = t->speed_hz;
+	if (!hz)
+		hz = spi->max_speed_hz;
+
+	spidev = spi_master_get_devdata(spi->master);
+
+	r = readw(spidev->base + LOCOMO_SPIMD);
+	if (hz == 0) {
+		r &= ~LOCOMO_SPIMD_XON;
+		writew(r, spidev->base + LOCOMO_SPIMD);
+	} else {
+		r |= LOCOMO_SPIMD_XON;
+		writew(r, spidev->base + LOCOMO_SPIMD);
+		locomo_spi_set_speed(spidev, hz);
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
+	spidev->save_ct = readw(spidev->base + LOCOMO_SPICT);
+	writew(0x40, spidev->base + LOCOMO_SPICT);
+
+	spidev->save_md = readw(spidev->base + LOCOMO_SPIMD);
+	writew(0x3c14, spidev->base + LOCOMO_SPIMD);
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
+	writew(spidev->save_ct, spidev->base + LOCOMO_SPICT);
+	writew(spidev->save_md, spidev->base + LOCOMO_SPIMD);
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
+	struct resource *res;
+	struct spi_master *master;
+	struct locomospi_dev *spidev;
+	int ret;
+
+	dev_info(&pdev->dev, "LoCoO SPI Driver\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct locomospi_dev));
+	if (!master)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, master);
+
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 8);
+	master->bus_num = 0;
+	master->num_chipselect = 1;
+
+	spidev = spi_master_get_devdata(master);
+	spidev->bitbang.master = spi_master_get(master);
+
+	spidev->bitbang.setup_transfer = locomo_spi_setup_transfer;
+	spidev->bitbang.chipselect = locomospi_chipselect;
+	spidev->bitbang.txrx_word[SPI_MODE_0] = locomospi_txrx_word;
+	spidev->bitbang.txrx_word[SPI_MODE_1] = locomospi_txrx_word;
+	spidev->bitbang.txrx_word[SPI_MODE_2] = locomospi_txrx_word;
+	spidev->bitbang.txrx_word[SPI_MODE_3] = locomospi_txrx_word;
+
+	spidev->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+
+	spidev->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spidev->base)) {
+		ret = PTR_ERR(spidev->base);
+		goto out_put;
+	}
+
+	locomospi_reg_open(spidev);
+
+	ret = spi_bitbang_start(&spidev->bitbang);
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
+	spi_bitbang_stop(&spidev->bitbang);
+	locomospi_reg_release(spidev);
+	spi_master_put(master);
+
+
+	return 0;
+}
+
+static struct platform_driver locomo_spi_driver = {
+	.probe = locomo_spi_probe,
+	.remove = locomo_spi_remove,
+	.driver = {
+		.name = "locomo-spi",
+		.owner = THIS_MODULE,
+		.pm	= LOCOMO_SPI_PM_OPS,
+	},
+};
+module_platform_driver(locomo_spi_driver);
+
+MODULE_AUTHOR("Thomas Kunze thommy-Pp6lxjB34Lw@public.gmane.org");
+MODULE_DESCRIPTION("LoCoMo SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:locomo-spi");
diff --git a/include/linux/mfd/locomo.h b/include/linux/mfd/locomo.h
index 1f54300..f822d77 100644
--- a/include/linux/mfd/locomo.h
+++ b/include/linux/mfd/locomo.h
@@ -53,7 +53,37 @@
 /* SPI interface */
 #define LOCOMO_SPI	0x60
 #define LOCOMO_SPIMD	0x00		/* SPI mode setting */
+#define LOCOMO_SPIMD_LOOPBACK (1 << 15)	/* loopback tx to rx */
+#define LOCOMO_SPIMD_MSB1ST   (1 << 14)	/* send MSB first */
+#define LOCOMO_SPIMD_DOSTAT   (1 << 13)	/* transmit line is idle high */
+#define LOCOMO_SPIMD_TCPOL    (1 << 11)	/* transmit CPOL (maybe affects CPHA too) */
+#define LOCOMO_SPIMD_RCPOL    (1 << 10)	/* receive CPOL (maybe affects CPHA too) */
+#define	LOCOMO_SPIMD_TDINV    (1 << 9)	/* invert transmit line */
+#define LOCOMO_SPIMD_RDINV    (1 << 8)	/* invert receive line */
+#define LOCOMO_SPIMD_XON      (1 << 7)	/* enable spi controller clock */
+#define LOCOMO_SPIMD_XEN      (1 << 6)	/* clock bit write enable xon must be off, wait 300 us before xon->1 */
+#define LOCOMO_SPIMD_XSEL     0x0018	/* clock select */
+#define CLOCK_18MHZ	    0		/* 18,432 MHz clock */
+#define CLOCK_22MHZ	    1		/* 22,5792 MHz clock */
+#define CLOCK_25MHZ	    2		/* 24,576 MHz clock */
+#define LOCOMO_SPIMD_CLKSEL   0x7
+#define DIV_1		    0		/* don't divide clock   */
+#define DIV_2		    1		/* divide clock by two	*/
+#define DIV_4		    2		/* divide clock by four */
+#define DIV_8		    3		/* divide clock by eight*/
+#define DIV_64		    4		/* divide clock by 64 */
+
 #define LOCOMO_SPICT	0x04		/* SPI mode control */
+#define LOCOMO_SPICT_CRC16_7_B	(1 << 15)	/* 0: crc16 1: crc7 */
+#define LOCOMO_SPICT_CRCRX_TX_B	(1 << 14)
+#define LOCOMO_SPICT_CRCRESET_B	(1 << 13)
+#define LOCOMO_SPICT_CEN	(1 << 7)	/* ?? enable */
+#define LOCOMO_SPICT_CS		(1 << 6)	/* chip select */
+#define LOCOMO_SPICT_UNIT16	(1 << 5)	/* 0: 8 bit units, 1: 16 bit unit */
+#define LOCOMO_SPICT_ALIGNEN	(1 << 2)	/* align transfer enable */
+#define LOCOMO_SPICT_RXWEN	(1 << 1)	/* continous receive */
+#define LOCOMO_SPICT_RXUEN	(1 << 0)	/* aligned receive */
+
 #define LOCOMO_SPIST	0x08		/* SPI status */
 #define	LOCOMO_SPI_TEND	(1 << 3)	/* Transfer end bit */
 #define	LOCOMO_SPI_REND	(1 << 2)	/* Receive end bit */
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
