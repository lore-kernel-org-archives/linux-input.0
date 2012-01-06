From: Paul Parsons <lost.distance@yahoo.com>
Subject: [PATCH v6 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI)
 driver
Date: Fri, 6 Jan 2012 02:36:12 +0000 (GMT)
Message-ID: <1325817372.60830.YahooMailClassic@web29004.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: koen@dominion.thruhere.net, dmitry.torokhov@gmail.com, eric.y.miao@gmail.com, philipp.zabel@gmail.com, mad_soft@inbox.ru
List-Id: linux-input@vger.kernel.org

Add support for the Synaptics NavPoint touchpad connected to a PXA27x SSP port
in SPI slave mode. The driver implements a simple navigation pad. The four
raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the
touchpad is mapped to the ENTER button.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V6:
Added some help on module building as tristate.
Changed driver_data.pressed type from int to bool.
Added threaded irq handler for input_report_key() & input_sync() calls.
Added navpoint_open() & navpoint_close() for hardware up/down.
Corrected dev_id argument to free_irq().
Rebased to linux-3.2.

diff -uprN clean-3.2/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h linux-3.2/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
--- clean-3.2/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h	2012-01-04 23:55:44.000000000 +0000
+++ linux-3.2/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h	2012-01-06 02:08:14.689816477 +0000
@@ -206,6 +206,7 @@
 #define GPIO113_I2S_SYSCLK	MFP_CFG_OUT(GPIO113, AF1, DRIVE_LOW)
 
 /* SSP 1 */
+#define GPIO23_SSP1_SCLK_IN	MFP_CFG_IN(GPIO23, AF2)
 #define GPIO23_SSP1_SCLK	MFP_CFG_OUT(GPIO23, AF2, DRIVE_LOW)
 #define GPIO29_SSP1_SCLK	MFP_CFG_IN(GPIO29, AF3)
 #define GPIO27_SSP1_SYSCLK	MFP_CFG_OUT(GPIO27, AF1, DRIVE_LOW)
diff -uprN clean-3.2/drivers/input/mouse/Kconfig linux-3.2/drivers/input/mouse/Kconfig
--- clean-3.2/drivers/input/mouse/Kconfig	2012-01-04 23:55:44.000000000 +0000
+++ linux-3.2/drivers/input/mouse/Kconfig	2012-01-06 02:19:16.874081315 +0000
@@ -322,4 +322,16 @@ config MOUSE_SYNAPTICS_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called synaptics_i2c.
 
+config MOUSE_NAVPOINT_PXA27x
+	tristate "Synaptics NavPoint (PXA27x SSP/SPI)"
+	depends on PXA27x && PXA_SSP
+	help
+	  This option enables support for the Synaptics NavPoint connected to
+	  a PXA27x SSP port in SPI slave mode. The driver implements a simple
+	  navigation pad. The four raised dots are mapped to UP/DOWN/LEFT/RIGHT
+	  buttons and the centre of the touchpad is mapped to the ENTER button.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called navpoint.
+
 endif
diff -uprN clean-3.2/drivers/input/mouse/Makefile linux-3.2/drivers/input/mouse/Makefile
--- clean-3.2/drivers/input/mouse/Makefile	2012-01-04 23:55:44.000000000 +0000
+++ linux-3.2/drivers/input/mouse/Makefile	2012-01-06 02:08:14.689816477 +0000
@@ -12,6 +12,7 @@ obj-$(CONFIG_MOUSE_GPIO)		+= gpio_mouse.
 obj-$(CONFIG_MOUSE_INPORT)		+= inport.o
 obj-$(CONFIG_MOUSE_LOGIBM)		+= logibm.o
 obj-$(CONFIG_MOUSE_MAPLE)		+= maplemouse.o
+obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)	+= navpoint.o
 obj-$(CONFIG_MOUSE_PC110PAD)		+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)			+= psmouse.o
 obj-$(CONFIG_MOUSE_PXA930_TRKBALL)	+= pxa930_trkball.o
diff -uprN clean-3.2/drivers/input/mouse/navpoint.c linux-3.2/drivers/input/mouse/navpoint.c
--- clean-3.2/drivers/input/mouse/navpoint.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-3.2/drivers/input/mouse/navpoint.c	2012-01-06 02:15:31.444629423 +0000
@@ -0,0 +1,393 @@
+/*
+ *  Copyright (C) 2012 Paul Parsons <lost.distance@yahoo.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/input/navpoint.h>
+#include <linux/interrupt.h>
+#include <linux/pxa2xx_ssp.h>
+#include <linux/slab.h>
+
+/*
+ *	Synaptics NavPoint (PXA27x SSP/SPI) driver.
+ */
+
+/*
+ *	Synaptics Modular Embedded Protocol: Module Packet Format.
+ *	Module header byte 2:0 = Length (# bytes that follow)
+ *	Module header byte 4:3 = Control
+ *	Module header byte 7:5 = Module Address
+ */
+#define HEADER_LENGTH(byte)	((byte) & 0x07)
+#define HEADER_CONTROL(byte)	(((byte) >> 3) & 0x03)
+#define HEADER_ADDRESS(byte)	((byte) >> 5)
+
+/*
+ *	Two bitmaps represent the current and reported key press dispositions:
+ *	a producer bitmap maintained by navpoint_hardint(),
+ *	a consumer bitmap maintained by navpoint_softint().
+ */
+#define BIT_LEFT	(1<<0)
+#define BIT_RIGHT	(1<<1)
+#define BIT_DOWN	(1<<2)
+#define BIT_UP		(1<<3)
+#define BIT_ENTER	(1<<4)
+
+struct driver_data {
+	struct ssp_device	*ssp;
+	int			gpio;
+	struct input_dev	*input;
+	int			index;
+	uint8_t			data[1+HEADER_LENGTH(0xff)];
+	bool			pressed;	/* 1 = pressed, 0 = released */
+	int			bit;		/* Bit of last key pressed */
+	unsigned		prod;		/* Producer bitmap */
+	unsigned		cons;		/* Consumer bitmap */
+};
+
+static const u32 sscr0 = 0
+	| SSCR0_TUM		/* TIM = 1; No TUR interrupts */
+	| SSCR0_RIM		/* RIM = 1; No ROR interrupts */
+	| SSCR0_SSE		/* SSE = 1; SSP enabled */
+	| SSCR0_Motorola	/* FRF = 0; Motorola SPI */
+	| SSCR0_DataSize(16)	/* DSS = 15; Data size = 16-bit */
+	;
+static const u32 sscr1 = 0
+	| SSCR1_SCFR		/* SCFR = 1; SSPSCLK only during transfers */
+	| SSCR1_SCLKDIR		/* SCLKDIR = 1; Slave mode */
+	| SSCR1_SFRMDIR		/* SFRMDIR = 1; Slave mode */
+	| SSCR1_RWOT		/* RWOT = 1; Receive without transmit mode */
+	| SSCR1_RxTresh(1)	/* RFT = 0; Receive FIFO threshold = 1 */
+	| SSCR1_SPH		/* SPH = 1; SSPSCLK inactive 0.5 + 1 cycles */
+	| SSCR1_RIE		/* RIE = 1; Receive FIFO interrupt enabled */
+	;
+static const u32 sssr = 0
+	| SSSR_BCE		/* BCE = 1; Clear BCE */
+	| SSSR_TUR		/* TUR = 1; Clear TUR */
+	| SSSR_EOC		/* EOC = 1; Clear EOC */
+	| SSSR_TINT		/* TINT = 1; Clear TINT */
+	| SSSR_PINT		/* PINT = 1; Clear PINT */
+	| SSSR_ROR		/* ROR = 1; Clear ROR */
+	;
+
+/*
+ *	MEP Query $22: Touchpad Coordinate Range Query is not supported by
+ *	the NavPoint module, so sampled values provide the default limits.
+ */
+static int west = 2416;		/* 1/3 width */
+module_param(west, int, 0644);
+MODULE_PARM_DESC(west, "X coordinate limit for KEY_LEFT. Default = 2416");
+static int east = 3904;		/* 2/3 width */
+module_param(east, int, 0644);
+MODULE_PARM_DESC(east, "X coordinate limit for KEY_RIGHT. Default = 3904");
+static int south = 2480;	/* 1/3 height */
+module_param(south, int, 0644);
+MODULE_PARM_DESC(south, "Y coordinate limit for KEY_DOWN. Default = 2480");
+static int north = 3424;	/* 2/3 height */
+module_param(north, int, 0644);
+MODULE_PARM_DESC(north, "Y coordinate limit for KEY_UP. Default = 3424");
+
+static bool navpoint_packet(struct device *dev)
+{
+	struct driver_data *drv_data = dev_get_drvdata(dev);
+	bool ret;
+	bool pressed;
+	int bit;
+
+	ret = false;
+
+	switch (drv_data->data[0]) {
+	case 0xff:	/* Garbage (packet?) between reset and Hello packet */
+	case 0x00:	/* Module 0, NULL packet */
+		break;
+	case 0x0e:	/* Module 0, Absolute packet */
+		pressed = (drv_data->data[1] & 0x01);
+		if (drv_data->pressed == pressed)	/* No change */
+			break;
+		drv_data->pressed = pressed;
+		if (pressed) {
+			unsigned x, y;
+
+			x = ((drv_data->data[2] & 0x1f) << 8)
+				| drv_data->data[3];
+			y = ((drv_data->data[4] & 0x1f) << 8)
+				| drv_data->data[5];
+			if (x < west)
+				bit = BIT_LEFT;
+			else if (x >= east)
+				bit = BIT_RIGHT;
+			else if (y < south)
+				bit = BIT_DOWN;
+			else if (y >= north)
+				bit = BIT_UP;
+			else /* Middle */
+				bit = BIT_ENTER;
+			drv_data->bit = bit;
+		} else {
+			/* Released: use last key pressed */
+			bit = drv_data->bit;
+		}
+		drv_data->prod ^= bit;
+		ret = true;
+		break;
+	case 0x19:	/* Module 0, Hello packet */
+		if ((drv_data->data[1] & 0xf0) == 0x10)
+			break;
+		/* FALLTHROUGH */
+	default:
+		dev_warn(dev, "spurious packet: 0x%02x,0x%02x,...\n",
+			drv_data->data[0],
+			drv_data->data[1]);
+		break;
+	}
+
+	return ret;
+}
+
+static irqreturn_t navpoint_hardint(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct driver_data *drv_data = dev_get_drvdata(dev);
+	struct ssp_device *ssp = drv_data->ssp;
+	u32 status;
+	irqreturn_t ret;
+
+	status = pxa_ssp_read_reg(ssp, SSSR);
+	ret = IRQ_NONE;
+
+	if (status & sssr) {
+		dev_warn(dev, "spurious interrupt: 0x%02x\n", status);
+		pxa_ssp_write_reg(ssp, SSSR, (status & sssr));
+		ret = IRQ_HANDLED;
+	}
+
+	while (status & SSSR_RNE) {
+		u32 data;
+
+		data = pxa_ssp_read_reg(ssp, SSDR);
+		drv_data->data[drv_data->index + 0] = (data >> 8);
+		drv_data->data[drv_data->index + 1] = data;
+		drv_data->index += 2;
+		if (HEADER_LENGTH(drv_data->data[0]) < drv_data->index) {
+			if (navpoint_packet(dev))
+				ret = IRQ_WAKE_THREAD;
+			drv_data->index = 0;
+		}
+		status = pxa_ssp_read_reg(ssp, SSSR);
+	}
+
+	return ret;
+}
+
+static irqreturn_t navpoint_softint(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct driver_data *drv_data = dev_get_drvdata(dev);
+	unsigned prod;
+	unsigned diff;
+
+	prod = drv_data->prod;
+	diff = drv_data->cons ^ prod;
+	drv_data->cons = prod;
+
+	if (diff & BIT_LEFT)
+		input_report_key(drv_data->input, KEY_LEFT, prod & BIT_LEFT);
+	if (diff & BIT_RIGHT)
+		input_report_key(drv_data->input, KEY_RIGHT, prod & BIT_RIGHT);
+	if (diff & BIT_DOWN)
+		input_report_key(drv_data->input, KEY_DOWN, prod & BIT_DOWN);
+	if (diff & BIT_UP)
+		input_report_key(drv_data->input, KEY_UP, prod & BIT_UP);
+	if (diff & BIT_ENTER)
+		input_report_key(drv_data->input, KEY_ENTER, prod & BIT_ENTER);
+	input_sync(drv_data->input);
+
+	return IRQ_HANDLED;
+}
+
+static int navpoint_suspend(struct device *dev)
+{
+	struct driver_data *drv_data = dev_get_drvdata(dev);
+	struct ssp_device *ssp = drv_data->ssp;
+
+	gpio_set_value(drv_data->gpio, 0);
+
+	pxa_ssp_write_reg(ssp, SSCR0, 0);
+
+	clk_disable(ssp->clk);
+
+	return 0;
+}
+
+static int navpoint_resume(struct device *dev)
+{
+	struct driver_data *drv_data = dev_get_drvdata(dev);
+	struct ssp_device *ssp = drv_data->ssp;
+	int timeout;
+
+	clk_enable(ssp->clk);
+
+	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
+	pxa_ssp_write_reg(ssp, SSSR, sssr);
+	pxa_ssp_write_reg(ssp, SSTO, 0);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);	/* SSCR0_SSE written last */
+
+	/* Wait until SSP port is ready for slave clock operations */
+	for (timeout = 100; timeout != 0; --timeout) {
+		if (!(pxa_ssp_read_reg(ssp, SSSR) & SSSR_CSS))
+			break;
+		msleep(1);
+	}
+	if (timeout == 0)
+		dev_err(dev, "timeout waiting for SSSR[CSS] to clear\n");
+
+	gpio_set_value(drv_data->gpio, 1);
+
+	return 0;
+}
+
+#ifdef CONFIG_SUSPEND
+static const struct dev_pm_ops navpoint_pm_ops = {
+	.suspend	= navpoint_suspend,
+	.resume		= navpoint_resume,
+};
+#endif
+
+static int navpoint_open(struct input_dev *input)
+{
+	return navpoint_resume(input->dev.parent);
+}
+
+static void navpoint_close(struct input_dev *input)
+{
+	navpoint_suspend(input->dev.parent);
+}
+
+static int __devinit navpoint_probe(struct platform_device *pdev)
+{
+	struct navpoint_platform_data *pdata = pdev->dev.platform_data;
+	int ret;
+	struct ssp_device *ssp;
+	struct input_dev *input;
+	struct driver_data *drv_data;
+
+	ssp = pxa_ssp_request(pdata->port, pdev->name);
+	if (!ssp) {
+		ret = -ENODEV;
+		goto ret0;
+	}
+
+	/* HaRET does not disable devices before jumping into Linux */
+	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
+		gpio_set_value(pdata->gpio, 0);
+		pxa_ssp_write_reg(ssp, SSCR0, 0);
+		dev_warn(&pdev->dev, "ssp%d already enabled\n", pdata->port);
+	}
+
+	input = input_allocate_device();
+	if (!input) {
+		ret = -ENOMEM;
+		goto ret1;
+	}
+	input->name = pdev->name;
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(KEY_ENTER, input->keybit);
+	__set_bit(KEY_UP, input->keybit);
+	__set_bit(KEY_LEFT, input->keybit);
+	__set_bit(KEY_RIGHT, input->keybit);
+	__set_bit(KEY_DOWN, input->keybit);
+	input->open = navpoint_open;
+	input->close = navpoint_close;
+	input->dev.parent = &pdev->dev;
+
+	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
+	if (!drv_data) {
+		ret = -ENOMEM;
+		goto ret2;
+	}
+	drv_data->ssp = ssp;
+	drv_data->gpio = pdata->gpio;
+	drv_data->input = input;
+	platform_set_drvdata(pdev, drv_data);
+
+	ret = request_threaded_irq(ssp->irq, navpoint_hardint, navpoint_softint,
+		0, pdev->name, &pdev->dev);
+	if (ret)
+		goto ret3;
+
+	ret = input_register_device(input);
+	if (ret)
+		goto ret4;
+
+	dev_info(&pdev->dev, "ssp%d, irq %d\n", pdata->port, ssp->irq);
+
+	return 0;
+
+ret4:
+	free_irq(ssp->irq, &pdev->dev);
+ret3:
+	kfree(drv_data);
+ret2:
+	input_free_device(input);
+ret1:
+	pxa_ssp_free(ssp);
+ret0:
+	return ret;
+}
+
+static int __devexit navpoint_remove(struct platform_device *pdev)
+{
+	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct input_dev *input = drv_data->input;
+	struct ssp_device *ssp = drv_data->ssp;
+
+	input_unregister_device(input);
+
+	free_irq(ssp->irq, &pdev->dev);
+
+	kfree(drv_data);
+
+	pxa_ssp_free(ssp);
+
+	return 0;
+}
+
+static struct platform_driver navpoint_driver = {
+	.probe		= navpoint_probe,
+	.remove		= __devexit_p(navpoint_remove),
+	.driver = {
+		.name	= "navpoint",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_SUSPEND
+		.pm	= &navpoint_pm_ops,
+#endif
+	},
+};
+
+static int __init navpoint_init(void)
+{
+	return platform_driver_register(&navpoint_driver);
+}
+
+static void __exit navpoint_exit(void)
+{
+	platform_driver_unregister(&navpoint_driver);
+}
+
+module_init(navpoint_init);
+module_exit(navpoint_exit);
+
+MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
+MODULE_DESCRIPTION("Synaptics NavPoint (PXA27x SSP/SPI) driver");
+MODULE_LICENSE("GPL");
diff -uprN clean-3.2/include/linux/input/navpoint.h linux-3.2/include/linux/input/navpoint.h
--- clean-3.2/include/linux/input/navpoint.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-3.2/include/linux/input/navpoint.h	2012-01-06 02:13:08.751710401 +0000
@@ -0,0 +1,12 @@
+/*
+ *  Copyright (C) 2012 Paul Parsons <lost.distance@yahoo.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+struct navpoint_platform_data {
+	int		port;		/* PXA SSP port for pxa_ssp_request() */
+	int		gpio;		/* GPIO for power on/off */
+};
