From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
Date: Tue, 28 Oct 2014 03:01:54 +0300
Message-ID: <1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
several design issues (special bus instead of platform bus, doesn't use
mfd-core, etc).

Implement 'core' parts of locomo support as an mfd driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/mfd/Kconfig        |   8 +
 drivers/mfd/Makefile       |   1 +
 drivers/mfd/locomo.c       | 644 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/locomo.h | 171 ++++++++++++
 4 files changed, 824 insertions(+)
 create mode 100644 drivers/mfd/locomo.c
 create mode 100644 include/linux/mfd/locomo.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1456ea7..1824a12 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1318,6 +1318,14 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_LOCOMO
+	bool "Sharp LoCoMo support"
+	depends on ARM
+	select MFD_CORE
+	help
+	  Support for Sharp LoCoMo Grid Array found in Sharp SL-5x00
+          PDA family.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8bd54b1..a4ea8de 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -174,6 +174,7 @@ obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
 obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_LOCOMO)	+= locomo.o
 
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
diff --git a/drivers/mfd/locomo.c b/drivers/mfd/locomo.c
new file mode 100644
index 0000000..16b0208
--- /dev/null
+++ b/drivers/mfd/locomo.c
@@ -0,0 +1,644 @@
+/*
+ * Sharp LoCoMo support
+ *
+ * Based on old driver at arch/arm/common/locomo.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file contains all generic LoCoMo support.
+ *
+ * All initialization functions provided here are intended to be called
+ * from machine specific code with proper arguments when required.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/locomo.h>
+
+/* LoCoMo Interrupts */
+#define IRQ_LOCOMO_KEY		(0)
+#define IRQ_LOCOMO_GPIO		(1)
+#define IRQ_LOCOMO_LT		(2)
+#define IRQ_LOCOMO_SPI		(3)
+
+#define LOCOMO_NR_IRQS		(4)
+
+/* the following is the overall data for the locomo chip */
+struct locomo {
+	unsigned int irq;
+	int irq_base;
+	spinlock_t lock;
+	void __iomem *base;
+
+	bool	has_amp_control;
+	int	gpio_amp1_on;
+	int	gpio_amp2_on;
+
+#ifdef CONFIG_PM_SLEEP
+	u16	LCM_ASD;
+#endif
+};
+
+static struct gpio locomo_amp_gpios[] = {
+	{ 0, GPIOF_OUT_INIT_LOW, "AMP1 ON" },
+	{ 0, GPIOF_OUT_INIT_LOW, "AMP2 ON" },
+};
+
+static struct resource locomo_kbd_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_KEYBOARD, 0x10),
+	DEFINE_RES_IRQ(IRQ_LOCOMO_KEY),
+};
+
+static struct resource locomo_gpio_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_GPIO, 0x28),
+	DEFINE_RES_IRQ(IRQ_LOCOMO_GPIO),
+};
+
+static struct resource locomo_lt_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_LTC, 0x8),
+	DEFINE_RES_IRQ(IRQ_LOCOMO_LT),
+};
+
+static struct resource locomo_spi_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_SPI, 0x30),
+	DEFINE_RES_IRQ(IRQ_LOCOMO_SPI),
+};
+
+static struct resource locomo_led_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_LED, 0x8),
+};
+
+static struct resource locomo_backlight_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_FRONTLIGHT, 0x08),
+};
+
+static struct resource locomo_lcd_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_TFT, 0x08),
+};
+
+static struct resource locomo_audio_resources[] = {
+	DEFINE_RES_MEM(LOCOMO_AUDIO, 0x04),
+	DEFINE_RES_MEM(LOCOMO_PAIF, 0x04),
+};
+
+static struct mfd_cell locomo_cells[] = {
+	{
+		.name = "locomo-kbd",
+		.resources = locomo_kbd_resources,
+		.num_resources = ARRAY_SIZE(locomo_kbd_resources),
+	},
+	{
+		.name = "locomo-gpio",
+		.resources = locomo_gpio_resources,
+		.num_resources = ARRAY_SIZE(locomo_gpio_resources),
+	},
+	{
+		.name = "locomo-lt", /* Long time timer */
+		.resources = locomo_lt_resources,
+		.num_resources = ARRAY_SIZE(locomo_lt_resources),
+	},
+	{
+		.name = "locomo-spi",
+		.resources = locomo_spi_resources,
+		.num_resources = ARRAY_SIZE(locomo_spi_resources),
+	},
+	{
+		.name = "locomo-led",
+		.resources = locomo_led_resources,
+		.num_resources = ARRAY_SIZE(locomo_led_resources),
+	},
+	{
+		.name = "locomo-backlight",
+		.resources = locomo_backlight_resources,
+		.num_resources = ARRAY_SIZE(locomo_backlight_resources),
+	},
+	{
+		.name = "locomo-lcd",
+		.resources = locomo_lcd_resources,
+		.num_resources = ARRAY_SIZE(locomo_lcd_resources),
+	},
+	{
+		.name = "locomo-audio",
+		.resources = locomo_audio_resources,
+		.num_resources = ARRAY_SIZE(locomo_audio_resources),
+	},
+};
+
+/* DAC send data */
+#define	M62332_SLAVE_ADDR	0x4e	/* Slave address  */
+#define	M62332_W_BIT		0x00	/* W bit (0 only) */
+#define	M62332_SUB_ADDR		0x00	/* Sub address    */
+#define	M62332_A_BIT		0x00	/* A bit (0 only) */
+
+/* DAC setup and hold times (expressed in us) */
+#define DAC_BUS_FREE_TIME	5	/*   4.7 us */
+#define DAC_START_SETUP_TIME	5	/*   4.7 us */
+#define DAC_STOP_SETUP_TIME	4	/*   4.0 us */
+#define DAC_START_HOLD_TIME	5	/*   4.7 us */
+#define DAC_SCL_LOW_HOLD_TIME	5	/*   4.7 us */
+#define DAC_SCL_HIGH_HOLD_TIME	4	/*   4.0 us */
+#define DAC_DATA_SETUP_TIME	1	/*   250 ns */
+#define DAC_DATA_HOLD_TIME	1	/*   300 ns */
+#define DAC_LOW_SETUP_TIME	1	/*   300 ns */
+#define DAC_HIGH_SETUP_TIME	1	/*  1000 ns */
+
+/* I2C dedicated to external DAC */
+static void locomo_m62332_sendbit(struct locomo *lchip, int bit)
+{
+	u16 r;
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SCLOEB);
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SDAOEB);
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
+
+	if (bit & 1) {
+		r = readw(lchip->base + LOCOMO_DAC);
+		r |=  LOCOMO_DAC_SDAOEB;
+		writew(r, lchip->base + LOCOMO_DAC);
+
+		udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
+	} else {
+		r = readw(lchip->base + LOCOMO_DAC);
+		r &=  ~(LOCOMO_DAC_SDAOEB);
+		writew(r, lchip->base + LOCOMO_DAC);
+
+		udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+	}
+	udelay(DAC_DATA_SETUP_TIME);	/* 250 nsec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r |=  LOCOMO_DAC_SCLOEB;
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
+	udelay(DAC_SCL_HIGH_HOLD_TIME);	/*  4.0 usec */
+}
+
+/* Start */
+static void locomo_m62332_start(struct locomo *lchip)
+{
+	u16 r;
+
+	udelay(DAC_BUS_FREE_TIME);	/* 5.0 usec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
+	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.0 usec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SDAOEB);
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_START_HOLD_TIME);	/* 5.0 usec */
+	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
+
+}
+
+/* Check A bit */
+static int locomo_m62332_check_a(struct locomo *lchip)
+{
+	u16 r;
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SCLOEB);
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SDAOEB);
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r |=  LOCOMO_DAC_SCLOEB;
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
+	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
+
+	return readw(lchip->base + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB;
+}
+
+/* Stop */
+static void locomo_m62332_stop(struct locomo *lchip)
+{
+	u16 r;
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r &=  ~(LOCOMO_DAC_SCLOEB);
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
+	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r |=  LOCOMO_DAC_SCLOEB;
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
+	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r |=  LOCOMO_DAC_SDAOEB;
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
+	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
+
+	r = readw(lchip->base + LOCOMO_DAC);
+	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	udelay(DAC_LOW_SETUP_TIME);	/* 1000 nsec */
+	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
+}
+
+void locomo_m62332_senddata(struct device *dev, unsigned int dac_data,
+		int channel)
+{
+	struct locomo *lchip = dev_get_drvdata(dev);
+	int i;
+	unsigned char data;
+	unsigned long flags;
+
+	/* This works for now */
+	if (lchip->has_amp_control && dac_data) {
+		gpio_set_value(lchip->gpio_amp1_on, 1);
+		gpio_set_value(lchip->gpio_amp2_on, 1);
+		mdelay(5);
+	}
+
+	spin_lock_irqsave(&lchip->lock, flags);
+
+	locomo_m62332_start(lchip);
+
+	/* Send slave address and W bit (LSB is W bit) */
+	data = (M62332_SLAVE_ADDR << 1) | M62332_W_BIT;
+	for (i = 1; i <= 8; i++)
+		locomo_m62332_sendbit(lchip, data >> (8 - i));
+
+	if (locomo_m62332_check_a(lchip)) {	/* High is error */
+		dev_warn(dev, "locomo: m62332_senddata Error 1\n");
+		goto out;
+	}
+
+	/* Send Sub address (LSB is channel select) */
+	/*    channel = 0 : ch1 select              */
+	/*            = 1 : ch2 select              */
+	data = M62332_SUB_ADDR + channel;
+	for (i = 1; i <= 8; i++)
+		locomo_m62332_sendbit(lchip, data >> (8 - i));
+
+	if (locomo_m62332_check_a(lchip)) {	/* High is error */
+		dev_warn(dev, "locomo: m62332_senddata Error 2\n");
+		goto out;
+	}
+
+	/* Send DAC data */
+	for (i = 1; i <= 8; i++)
+		locomo_m62332_sendbit(lchip, dac_data >> (8 - i));
+
+	if (locomo_m62332_check_a(lchip)) {	/* High is error */
+		dev_warn(dev, "locomo: m62332_senddata Error 3\n");
+		goto out;
+	}
+
+out:
+	locomo_m62332_stop(lchip);
+
+	spin_unlock_irqrestore(&lchip->lock, flags);
+
+	/* This works for now */
+	if (lchip->has_amp_control && !dac_data) {
+		mdelay(5);
+		gpio_set_value(lchip->gpio_amp1_on, 0);
+		gpio_set_value(lchip->gpio_amp2_on, 0);
+	}
+
+}
+EXPORT_SYMBOL(locomo_m62332_senddata);
+
+/* IRQ support */
+static void locomo_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct locomo *lchip = irq_get_handler_data(irq);
+	int req, i;
+
+	/* Acknowledge the parent IRQ */
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
+
+	/* check why this interrupt was generated */
+	req = readw(lchip->base + LOCOMO_ICR) & 0x0f00;
+
+	if (req) {
+		/* generate the next interrupt(s) */
+		irq = lchip->irq_base;
+		for (i = 0; i <= 3; i++, irq++) {
+			if (req & (0x0100 << i))
+				generic_handle_irq(irq);
+
+		}
+	}
+}
+
+static void locomo_ack_irq(struct irq_data *d)
+{
+}
+
+static void locomo_mask_irq(struct irq_data *d)
+{
+	struct locomo *lchip = irq_data_get_irq_chip_data(d);
+	unsigned int r;
+
+	r = readw(lchip->base + LOCOMO_ICR);
+	r &= ~(0x0010 << (d->irq - lchip->irq_base));
+	writew(r, lchip->base + LOCOMO_ICR);
+}
+
+static void locomo_unmask_irq(struct irq_data *d)
+{
+	struct locomo *lchip = irq_data_get_irq_chip_data(d);
+	unsigned int r;
+
+	r = readw(lchip->base + LOCOMO_ICR);
+	r |= (0x0010 << (d->irq - lchip->irq_base));
+	writew(r, lchip->base + LOCOMO_ICR);
+}
+
+static struct irq_chip locomo_chip = {
+	.name		= "LOCOMO",
+	.irq_ack	= locomo_ack_irq,
+	.irq_mask	= locomo_mask_irq,
+	.irq_unmask	= locomo_unmask_irq,
+};
+
+static void locomo_setup_irq(struct locomo *lchip)
+{
+	int irq;
+
+	lchip->irq_base = irq_alloc_descs(-1, 0, LOCOMO_NR_IRQS, -1);
+
+	/* Install handlers for IRQ_LOCOMO_* */
+	for (irq = lchip->irq_base;
+			irq < lchip->irq_base + LOCOMO_NR_IRQS;
+			irq++) {
+		irq_set_chip_and_handler(irq, &locomo_chip, handle_level_irq);
+		irq_set_chip_data(irq, lchip);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	}
+
+	/*
+	 * Install handler for IRQ_LOCOMO_HW.
+	 */
+	irq_set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
+	irq_set_handler_data(lchip->irq, lchip);
+	irq_set_chained_handler(lchip->irq, locomo_handler);
+}
+
+
+#ifdef CONFIG_PM_SLEEP
+static int locomo_suspend(struct device *dev)
+{
+	struct locomo *lchip = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&lchip->lock, flags);
+
+	/* ADSTART */
+	lchip->LCM_ASD = readw(lchip->base + LOCOMO_ASD);	/* ADSTART */
+	writew(0x00, lchip->base + LOCOMO_ASD);
+
+	/* AUDIO */
+	writew(0x00, lchip->base + LOCOMO_PAIF);
+	writew(0x00, lchip->base + LOCOMO_DAC);
+
+	if ((readw(lchip->base + LOCOMO_LED + LOCOMO_LPT0) & 0x88) &&
+	    (readw(lchip->base + LOCOMO_LED + LOCOMO_LPT1) & 0x88))
+		/* CLK32 off */
+		writew(0x00, lchip->base + LOCOMO_C32K);
+	else
+		/* 18MHz already enabled, so no wait */
+		/* CLK32 on */
+		writew(0xc1, lchip->base + LOCOMO_C32K);
+
+	/* 18MHz clock off*/
+	writew(0x00, lchip->base + LOCOMO_TADC);
+	/* 22MHz/24MHz clock off */
+	writew(0x00, lchip->base + LOCOMO_AUDIO + LOCOMO_ACC);
+
+	spin_unlock_irqrestore(&lchip->lock, flags);
+
+	return 0;
+}
+
+static int locomo_resume(struct device *dev)
+{
+	struct locomo *lchip = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&lchip->lock, flags);
+
+	writew(lchip->LCM_ASD, lchip->base + LOCOMO_ASD);
+
+	writew(0x00, lchip->base + LOCOMO_C32K);
+	writew(0x90, lchip->base + LOCOMO_TADC);
+
+	spin_unlock_irqrestore(&lchip->lock, flags);
+
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(locomo_pm, locomo_suspend, locomo_resume);
+#define LOCOMO_PM	(&locomo_pm)
+#else
+#define LOCOMO_PM	NULL
+#endif
+
+static int locomo_probe(struct platform_device *dev)
+{
+	struct locomo_platform_data *pdata = dev_get_platdata(&dev->dev);
+	struct resource *mem;
+	int irq;
+	struct locomo *lchip;
+	unsigned long r;
+	int ret = -ENODEV;
+
+	mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -EINVAL;
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	lchip = devm_kzalloc(&dev->dev, sizeof(struct locomo), GFP_KERNEL);
+	if (!lchip)
+		return -ENOMEM;
+
+	spin_lock_init(&lchip->lock);
+
+	/*
+	 * Map the whole region.  This also maps the
+	 * registers for our children.
+	 */
+	lchip->base = devm_ioremap(&dev->dev, mem->start, resource_size(mem));
+	if (!lchip->base)
+		return -ENOMEM;
+
+	lchip->irq = irq;
+	platform_set_drvdata(dev, lchip);
+
+	if (pdata) {
+		locomo_cells[1].platform_data = &pdata->gpio_data;
+		locomo_cells[1].pdata_size =
+			sizeof(struct locomo_gpio_platform_data);
+		locomo_cells[5].platform_data = &pdata->bl_data;
+		locomo_cells[5].pdata_size =
+			sizeof(struct locomo_bl_platform_data);
+		locomo_cells[6].platform_data = &pdata->lcd_data;
+		locomo_cells[6].pdata_size =
+			sizeof(struct locomo_lcd_platform_data);
+
+		lchip->gpio_amp1_on = pdata->gpio_amp1_on;
+		lchip->gpio_amp2_on = pdata->gpio_amp2_on;
+	}
+
+	if (gpio_is_valid(lchip->gpio_amp1_on) &&
+			gpio_is_valid(lchip->gpio_amp2_on)) {
+		lchip->has_amp_control = true;
+		locomo_amp_gpios[0].gpio = lchip->gpio_amp1_on;
+		locomo_amp_gpios[1].gpio = lchip->gpio_amp2_on;
+		ret = gpio_request_array(locomo_amp_gpios,
+				ARRAY_SIZE(locomo_amp_gpios));
+		if (ret)
+			return ret;
+	}
+
+	/* locomo initialize */
+	writew(0, lchip->base + LOCOMO_ICR);
+
+	/* Longtime timer */
+	writew(0, lchip->base + LOCOMO_LTINT);
+	/* SPI */
+	writew(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
+
+	writew(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
+	r = readw(lchip->base + LOCOMO_ASD);
+	r |= 0x8000;
+	writew(r, lchip->base + LOCOMO_ASD);
+
+	writew(6 + 8 + 320 + 30 - 10 - 128 + 4, lchip->base + LOCOMO_HSD);
+	r = readw(lchip->base + LOCOMO_HSD);
+	r |= 0x8000;
+	writew(r, lchip->base + LOCOMO_HSD);
+
+	writew(128 / 8, lchip->base + LOCOMO_HSC);
+
+	/* XON */
+	writew(0x80, lchip->base + LOCOMO_TADC);
+	udelay(1000);
+	/* CLK9MEN */
+	r = readw(lchip->base + LOCOMO_TADC);
+	r |= 0x10;
+	writew(r, lchip->base + LOCOMO_TADC);
+	udelay(100);
+
+	/* init DAC */
+	r = readw(lchip->base + LOCOMO_DAC);
+	r |= LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
+	writew(r, lchip->base + LOCOMO_DAC);
+
+	r = readw(lchip->base + LOCOMO_VER);
+	dev_info(&dev->dev, "LoCoMo Chip: %lu%lu\n", (r >> 8), (r & 0xff));
+
+	/*
+	 * The interrupt controller must be initialised before any
+	 * other device to ensure that the interrupts are available.
+	 */
+	if (lchip->irq != NO_IRQ)
+		locomo_setup_irq(lchip);
+
+	ret = mfd_add_devices(&dev->dev, dev->id,
+			locomo_cells, ARRAY_SIZE(locomo_cells),
+			mem, lchip->irq_base, NULL);
+	if (ret)
+		goto err_add;
+
+	return 0;
+
+err_add:
+	if (lchip->irq != NO_IRQ) {
+		irq_set_chained_handler(lchip->irq, NULL);
+		irq_set_handler_data(lchip->irq, NULL);
+		irq_free_descs(lchip->irq_base, LOCOMO_NR_IRQS);
+	}
+
+	if (lchip->has_amp_control)
+		gpio_free_array(locomo_amp_gpios,
+					ARRAY_SIZE(locomo_amp_gpios));
+	platform_set_drvdata(dev, NULL);
+
+	return ret;
+}
+
+static int locomo_remove(struct platform_device *dev)
+{
+	struct locomo *lchip = platform_get_drvdata(dev);
+
+	if (!lchip)
+		return 0;
+
+	mfd_remove_devices(&dev->dev);
+
+	if (lchip->irq != NO_IRQ) {
+		irq_set_chained_handler(lchip->irq, NULL);
+		irq_set_handler_data(lchip->irq, NULL);
+		irq_free_descs(lchip->irq_base, LOCOMO_NR_IRQS);
+	}
+
+	if (lchip->has_amp_control)
+		gpio_free_array(locomo_amp_gpios,
+					ARRAY_SIZE(locomo_amp_gpios));
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver locomo_device_driver = {
+	.probe		= locomo_probe,
+	.remove		= locomo_remove,
+	.driver		= {
+		.name	= "locomo",
+		.owner	= THIS_MODULE,
+		.pm	= LOCOMO_PM,
+	},
+};
+
+module_platform_driver(locomo_device_driver);
+
+MODULE_DESCRIPTION("Sharp LoCoMo core driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
+MODULE_ALIAS("platform:locomo");
diff --git a/include/linux/mfd/locomo.h b/include/linux/mfd/locomo.h
new file mode 100644
index 0000000..1f54300
--- /dev/null
+++ b/include/linux/mfd/locomo.h
@@ -0,0 +1,171 @@
+/*
+ * include/linux/mfd/locomo.h
+ *
+ * This file contains the definitions for the LoCoMo G/A Chip
+ *
+ * (C) Copyright 2004 John Lenz
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ *
+ * Based on sa1111.h
+ */
+#ifndef _ASM_ARCH_LOCOMO
+#define _ASM_ARCH_LOCOMO
+
+/* LOCOMO version */
+#define LOCOMO_VER	0x00
+
+/* Pin status */
+#define LOCOMO_ST	0x04
+
+/* Pin status */
+#define LOCOMO_C32K	0x08
+
+/* Interrupt controller */
+#define LOCOMO_ICR	0x0C
+
+/* MCS decoder for boot selecting */
+#define LOCOMO_MCSX0	0x10
+#define LOCOMO_MCSX1	0x14
+#define LOCOMO_MCSX2	0x18
+#define LOCOMO_MCSX3	0x1c
+
+/* Touch panel controller */
+#define LOCOMO_ASD	0x20		/* AD start delay */
+#define LOCOMO_HSD	0x28		/* HSYS delay */
+#define LOCOMO_HSC	0x2c		/* HSYS period */
+#define LOCOMO_TADC	0x30		/* tablet ADC clock */
+
+
+/* Long time timer */
+#define LOCOMO_LTC	0xd8		/* LTC interrupt setting */
+#define LOCOMO_LTINT	0xdc		/* LTC interrupt */
+
+/* DAC control signal for LCD (COMADJ ) */
+#define LOCOMO_DAC		0xe0
+/* DAC control */
+#define	LOCOMO_DAC_SCLOEB	0x08	/* SCL pin output data       */
+#define	LOCOMO_DAC_TEST		0x04	/* Test bit                  */
+#define	LOCOMO_DAC_SDA		0x02	/* SDA pin level (read-only) */
+#define	LOCOMO_DAC_SDAOEB	0x01	/* SDA pin output data       */
+
+/* SPI interface */
+#define LOCOMO_SPI	0x60
+#define LOCOMO_SPIMD	0x00		/* SPI mode setting */
+#define LOCOMO_SPICT	0x04		/* SPI mode control */
+#define LOCOMO_SPIST	0x08		/* SPI status */
+#define	LOCOMO_SPI_TEND	(1 << 3)	/* Transfer end bit */
+#define	LOCOMO_SPI_REND	(1 << 2)	/* Receive end bit */
+#define	LOCOMO_SPI_RFW	(1 << 1)	/* write buffer bit */
+#define	LOCOMO_SPI_RFR	(1)		/* read buffer bit */
+
+#define LOCOMO_SPIIS	0x10		/* SPI interrupt status */
+#define LOCOMO_SPIWE	0x14		/* SPI interrupt status write enable */
+#define LOCOMO_SPIIE	0x18		/* SPI interrupt enable */
+#define LOCOMO_SPIIR	0x1c		/* SPI interrupt request */
+#define LOCOMO_SPITD	0x20		/* SPI transfer data write */
+#define LOCOMO_SPIRD	0x24		/* SPI receive data read */
+#define LOCOMO_SPITS	0x28		/* SPI transfer data shift */
+#define LOCOMO_SPIRS	0x2C		/* SPI receive data shift */
+
+/* GPIO */
+#define LOCOMO_GPIO		0x90
+#define LOCOMO_GPD		0x00	/* GPIO direction */
+#define LOCOMO_GPE		0x04	/* GPIO input enable */
+#define LOCOMO_GPL		0x08	/* GPIO level */
+#define LOCOMO_GPO		0x0c	/* GPIO out data setting */
+#define LOCOMO_GRIE		0x10	/* GPIO rise detection */
+#define LOCOMO_GFIE		0x14	/* GPIO fall detection */
+#define LOCOMO_GIS		0x18	/* GPIO edge detection status */
+#define LOCOMO_GWE		0x1c	/* GPIO status write enable */
+#define LOCOMO_GIE		0x20	/* GPIO interrupt enable */
+#define LOCOMO_GIR		0x24	/* GPIO interrupt request */
+
+/* Start the definitions of the devices.  Each device has an initial
+ * base address and a series of offsets from that base address. */
+
+/* Keyboard controller */
+#define LOCOMO_KEYBOARD		0x40
+#define LOCOMO_KIB		0x00	/* KIB level */
+#define LOCOMO_KSC		0x04	/* KSTRB control */
+#define LOCOMO_KCMD		0x08	/* KSTRB command */
+#define LOCOMO_KIC		0x0c	/* Key interrupt */
+
+/* Front light adjustment controller */
+#define LOCOMO_FRONTLIGHT	0xc8
+#define LOCOMO_ALS		0x00	/* Adjust light cycle */
+#define LOCOMO_ALD		0x04	/* Adjust light duty */
+
+#define LOCOMO_ALC_EN		0x8000
+
+/* Backlight controller: TFT signal */
+#define LOCOMO_TFT		0x38
+#define LOCOMO_TC		0x00		/* TFT control signal */
+#define LOCOMO_CPSD		0x04		/* CPS delay */
+
+/* Audio controller */
+#define LOCOMO_AUDIO		0x54
+#define LOCOMO_ACC		0x00	/* Audio clock */
+#define LOCOMO_PAIF		0xD0	/* PCM audio interface */
+/* Audio clock */
+#define	LOCOMO_ACC_XON		0x80
+#define	LOCOMO_ACC_XEN		0x40
+#define	LOCOMO_ACC_XSEL0	0x00
+#define	LOCOMO_ACC_XSEL1	0x20
+#define	LOCOMO_ACC_MCLKEN	0x10
+#define	LOCOMO_ACC_64FSEN	0x08
+#define	LOCOMO_ACC_CLKSEL000	0x00	/* mclk  2 */
+#define	LOCOMO_ACC_CLKSEL001	0x01	/* mclk  3 */
+#define	LOCOMO_ACC_CLKSEL010	0x02	/* mclk  4 */
+#define	LOCOMO_ACC_CLKSEL011	0x03	/* mclk  6 */
+#define	LOCOMO_ACC_CLKSEL100	0x04	/* mclk  8 */
+#define	LOCOMO_ACC_CLKSEL101	0x05	/* mclk 12 */
+/* PCM audio interface */
+#define	LOCOMO_PAIF_SCINV	0x20
+#define	LOCOMO_PAIF_SCEN	0x10
+#define	LOCOMO_PAIF_LRCRST	0x08
+#define	LOCOMO_PAIF_LRCEVE	0x04
+#define	LOCOMO_PAIF_LRCINV	0x02
+#define	LOCOMO_PAIF_LRCEN	0x01
+
+/* LED controller */
+#define LOCOMO_LED		0xe8
+#define LOCOMO_LPT0		0x00
+#define LOCOMO_LPT1		0x04
+/* LED control */
+#define LOCOMO_LPT_TOFH		0x80
+#define LOCOMO_LPT_TOFL		0x08
+#define LOCOMO_LPT_TOH(TOH)	((TOH & 0x7) << 4)
+#define LOCOMO_LPT_TOL(TOL)	((TOL & 0x7))
+
+struct locomo_gpio_platform_data {
+	unsigned int gpio_base;
+};
+
+struct locomo_lcd_platform_data {
+	u8 comadj;
+	int gpio_lcd_vsha_on;
+	int gpio_lcd_vshd_on;
+	int gpio_lcd_vee_on;
+	int gpio_lcd_mod;
+};
+
+struct locomo_bl_platform_data {
+	int gpio_fl_vr;
+};
+
+struct locomo_platform_data {
+	struct locomo_gpio_platform_data gpio_data;
+	struct locomo_lcd_platform_data lcd_data;
+	struct locomo_bl_platform_data bl_data;
+
+	int gpio_amp1_on;
+	int gpio_amp2_on;
+};
+
+/* Send data to i2c DAC connected to LoCoMo i2c bus */
+extern void locomo_m62332_senddata(struct device *dev, unsigned int dac_data,
+		int channel);
+
+#endif
-- 
2.1.1
