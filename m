From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add OLPC AP-SP input driver
Date: Thu, 27 Jun 2013 23:22:04 -0700
Message-ID: <20130628062204.GB17523@core.coreip.homeip.net>
References: <20130627174200.5F1B9FAAD4@dev.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45172 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab3F1GWI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 02:22:08 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so2031257pad.4
        for <linux-input@vger.kernel.org>; Thu, 27 Jun 2013 23:22:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130627174200.5F1B9FAAD4@dev.laptop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org, devicetree-discuss@lists.ozlabs.org

Hi Daniel,

On Thu, Jun 27, 2013 at 01:42:00PM -0400, Daniel Drake wrote:
> The OLPC XO-1.75 and XO-4 laptops include a PS/2 touchpad and an AT
> keyboard, yet they do not have a hardware PS/2 controller. Instead, a
> firmware runs on a dedicated core ("Security Processor", part of the SoC)
> that acts as a PS/2 controller through bit-banging.
> 
> Communication between the main cpu (Application Processor) and the
> Security Processor happens via a standard command mechanism implemented
> by the SoC. Add a driver for this interface to enable keyboard/mouse
> input on this platform.
> 
> Original author: Saadia Baloch
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  .../devicetree/bindings/serio/olpc,ap-sp.txt       |  13 +
>  drivers/input/serio/Kconfig                        |  10 +
>  drivers/input/serio/Makefile                       |   1 +
>  drivers/input/serio/olpc_apsp.c                    | 264 +++++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
>  create mode 100644 drivers/input/serio/olpc_apsp.c
> 
> diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
> new file mode 100644
> index 0000000..0e72183
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
> @@ -0,0 +1,13 @@
> +OLPC AP-SP serio interface
> +
> +Required properties:
> +- compatible : "olpc,ap-sp"
> +- reg : base address and length of SoC's WTM registers
> +- interrupts : SP-AP interrupt
> +
> +Example:
> +	ap-sp@d4290000 {
> +		compatible = "olpc,ap-sp";
> +		reg = <0xd4290000 0x1000>;
> +		interrupts = <40>;
> +	}
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 1bda828..94c17c2 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -256,4 +256,14 @@ config SERIO_APBPS2
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called apbps2.
>  
> +config SERIO_OLPC_APSP
> +	tristate "OLPC AP-SP input support"
> +	depends on OF
> +	help
> +	  Say Y here if you want support for the keyboard and touchpad included
> +	  in the OLPC XO-1.75 and XO-4 laptops.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called olpc_apsp.
> +
>  endif
> diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> index 8edb36c..12298b1 100644
> --- a/drivers/input/serio/Makefile
> +++ b/drivers/input/serio/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o
>  obj-$(CONFIG_SERIO_ALTERA_PS2)	+= altera_ps2.o
>  obj-$(CONFIG_SERIO_ARC_PS2)	+= arc_ps2.o
>  obj-$(CONFIG_SERIO_APBPS2)	+= apbps2.o
> +obj-$(CONFIG_SERIO_OLPC_APSP)	+= olpc_apsp.o
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> new file mode 100644
> index 0000000..068195c
> --- /dev/null
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -0,0 +1,264 @@
> +/*
> + * OLPC serio driver for multiplexed input from Marvell MMP security processor
> + *
> + * Copyright (C) 2011-2013 One Laptop Per Child
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/serio.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <asm/irq.h>
> +#include <linux/delay.h>
> +
> +/*
> + * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
> + * Instead, the OLPC firmware runs a bit-banging PS/2 implementation on an
> + * otherwise-unused slow processor which is included in the Marvell MMP2/MMP3
> + * SoC, known as the "Security Processor" (SP) or "Wireless Trusted Module"
> + * (WTM). This firmware then reports its results via the WTM registers,
> + * which we read from the Application Processor (AP, i.e. main CPU) in this
> + * driver.
> + *
> + * On the hardware side we have a PS/2 mouse and an AT keyboard, the data
> + * is multiplexed through this system. We create a serio port for each one,
> + * and demultiplex the data accordingly.
> + */
> +
> +static bool apsp_debug;
> +module_param_named(debug, apsp_debug, bool, 0600);
> +MODULE_PARM_DESC(debug, "Turn debugging mode on and off");
> +
> +#define dbg(format, arg...)						\
> +	do {								\
> +		if (apsp_debug)						\
> +			pr_info(KBUILD_MODNAME ": " format, ##arg);	\
> +	} while (0)

I think with dynamic debug being quite ubiquitous we can do away with
this kind of debugging. Please just switch to dev_dbg(). 

> +
> +
> +/* WTM register offsets */
> +#define SECURE_PROCESSOR_COMMAND	0x40
> +#define COMMAND_RETURN_STATUS		0x80
> +#define COMMAND_FIFO_STATUS		0xc4
> +#define PJ_RST_INTERRUPT		0xc8
> +#define PJ_INTERRUPT_MASK		0xcc
> +
> +/* The upper byte of SECURE_PROCESSOR_COMMAND and COMMAND_RETURN_STATUS is
> + * used to identify which port (device) is being talked to. The lower byte
> + * is the data being sent/received. */
> +#define PORT_MASK	0xff00
> +#define DATA_MASK	0x00ff
> +#define PORT_SHIFT	8
> +#define KEYBOARD_PORT	0
> +#define TOUCHPAD_PORT	1
> +
> +/* COMMAND_FIFO_STATUS */
> +#define CMD_CNTR_MASK		0x7 /* Number of pending/unprocessed commands */
> +#define MAX_PENDING_CMDS	4 /* from device specs */
> +
> +/* PJ_RST_INTERRUPT */
> +#define SP_COMMAND_COMPLETE_RESET	0x1
> +
> +/* PJ_INTERRUPT_MASK */
> +#define INT_0	(1 << 0)
> +
> +/* COMMAND_FIFO_STATUS */
> +#define CMD_STS_MASK	0x100
> +
> +struct olpc_apsp {
> +	struct device *dev;
> +	struct serio *kbio;
> +	struct serio *padio;
> +	void __iomem *base;
> +};
> +
> +static int olpc_apsp_pad_write(struct serio *port, unsigned char val)
> +{
> +	struct olpc_apsp *priv = port->port_data;
> +	unsigned int i;
> +	u32 which = 0;
> +
> +	if (port == priv->padio)
> +		which = TOUCHPAD_PORT << PORT_SHIFT;
> +	else
> +		which = KEYBOARD_PORT << PORT_SHIFT;
> +
> +	dbg("olpc_apsp_pad_write which=%x val=%x\n", which, val);
> +	for (i = 0; i < 50; i++) {
> +		u32 sts = readl(priv->base + COMMAND_FIFO_STATUS);
> +		if ((sts & CMD_CNTR_MASK) < MAX_PENDING_CMDS) {
> +			writel(which | val,
> +			       priv->base + SECURE_PROCESSOR_COMMAND);
> +			return 0;
> +		}
> +		msleep(1);
> +	}
> +
> +	dbg("olpc_apsp_pad_write timeout, status=%x\n",
> +	    readl(priv->base + COMMAND_FIFO_STATUS));
> +	return -ETIMEDOUT;
> +}
> +
> +static irqreturn_t olpc_input_rx(int irq, void *dev_id)
> +{
> +	struct olpc_apsp *priv = dev_id;
> +	unsigned int w, tmp;
> +	struct serio *serio;
> +
> +	/*
> +	 * Write 1 to PJ_RST_INTERRUPT to acknowledge and clear the interrupt
> +	 * Write 0xff00 to SECURE_PROCESSOR_COMMAND.
> +	 */
> +	tmp = readl(priv->base + PJ_RST_INTERRUPT);
> +	if (!(tmp & SP_COMMAND_COMPLETE_RESET)) {
> +		dev_warn(priv->dev, "spurious interrupt?\n");
> +		return IRQ_NONE;
> +	}
> +
> +	w = readl(priv->base + COMMAND_RETURN_STATUS);
> +	dbg("olpc_input_rx %x\n", w);
> +
> +	if (w >> PORT_SHIFT == KEYBOARD_PORT)
> +		serio = priv->kbio;
> +	else
> +		serio = priv->padio;
> +
> +	serio_interrupt(serio, w & DATA_MASK, 0);
> +
> +	/* Ack and clear interrupt */
> +	writel(tmp | SP_COMMAND_COMPLETE_RESET, priv->base + PJ_RST_INTERRUPT);
> +	writel(PORT_MASK, priv->base + SECURE_PROCESSOR_COMMAND);
> +
> +	pm_wakeup_event(priv->dev, 1000);
> +	return IRQ_HANDLED;
> +}
> +
> +static int olpc_apsp_pad_open(struct serio *port)
> +{
> +	unsigned int tmp;
> +	struct olpc_apsp *priv = port->port_data;
> +
> +	/* Enable interrupt 0 by clearing its bit */
> +	tmp = readl(priv->base + PJ_INTERRUPT_MASK);
> +	writel(tmp & ~INT_0, priv->base + PJ_INTERRUPT_MASK);
> +
> +	return 0;
> +}
> +
> +static int olpc_apsp_probe(struct platform_device *pdev)
> +{
> +	struct serio *kb_serio, *pad_serio;
> +	struct olpc_apsp *priv;
> +	struct resource *res;
> +	struct device_node *np;
> +	unsigned long l;
> +	int ret;
> +	int irq;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(struct olpc_apsp),
> +			       GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np = pdev->dev.of_node;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (WARN_ON(!res))
> +		return -ENOENT;
> +
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (WARN_ON(!priv->base))
> +		return -EIO;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (WARN_ON(irq < 0))
> +		return irq;
> +
> +	l = readl(priv->base + COMMAND_FIFO_STATUS);
> +	if (!(l & CMD_STS_MASK)) {
> +		dev_err(&pdev->dev, "SP cannot accept commands.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, olpc_input_rx, 0, "olpc-apsp",
> +			       priv);
> +	if (WARN_ON(ret))


Would prefer a normal message instead, or simple return, but not
WARN_ON. Would also prefer 'error' instead of 'ret' as it really carries
error code.

> +		return ret;
> +
> +	/* KEYBOARD */
> +	kb_serio = devm_kzalloc(&pdev->dev, sizeof(struct serio), GFP_KERNEL);
> +	if (!kb_serio)
> +		return -ENOMEM;
> +	kb_serio->id.type	= SERIO_8042_XL;
> +	kb_serio->write		= olpc_apsp_pad_write;
> +	kb_serio->open		= olpc_apsp_pad_open;
> +	kb_serio->port_data	= priv;
> +	kb_serio->dev.parent	= &pdev->dev;
> +	strlcpy(kb_serio->name, "sp keyboard", sizeof(kb_serio->name));
> +	strlcpy(kb_serio->phys, "sp/serio0", sizeof(kb_serio->phys));
> +	priv->kbio		= kb_serio;
> +	serio_register_port(kb_serio);
> +
> +	/* TOUCHPAD */
> +	pad_serio = devm_kzalloc(&pdev->dev, sizeof(struct serio), GFP_KERNEL);
> +	if (!pad_serio) {
> +		serio_unregister_port(kb_serio);
> +		return -ENOMEM;
> +	}
> +	pad_serio->id.type	= SERIO_PS_PSTHRU;
> +	pad_serio->write	= olpc_apsp_pad_write;
> +	pad_serio->open		= olpc_apsp_pad_open;
> +	pad_serio->port_data	= priv;
> +	pad_serio->dev.parent	= &pdev->dev;
> +	strlcpy(pad_serio->name, "sp touchpad", sizeof(pad_serio->name));
> +	strlcpy(pad_serio->phys, "sp/serio1", sizeof(pad_serio->phys));
> +	priv->padio		= pad_serio;
> +	serio_register_port(pad_serio);
> +
> +	priv->dev = &pdev->dev;
> +	device_init_wakeup(priv->dev, 1);
> +	platform_set_drvdata(pdev, priv);
> +	dev_info(&pdev->dev, "probed successfully.\n");

dev_dbg() please.

> +	return 0;
> +}
> +
> +static int olpc_apsp_remove(struct platform_device *pdev)
> +{
> +	struct olpc_apsp *priv = platform_get_drvdata(pdev);
> +	serio_unregister_port(priv->kbio);
> +	serio_unregister_port(priv->padio);

This is quite broken. You have interrupt handler allocated with devm,
which means it will get uninstalled after calls to
serio_unregister_port(), i.e. after serio port most likely have been
destroyed. You, however, do not shut off ports, so interrupt may still
be raised, causing crash.

Also, serio ports are refcounted and are deleted by serio core, but you
allocate them with devm, which will surely clash with serio core.

> +	return 0;
> +}
> +
> +static struct of_device_id olpc_apsp_dt_ids[] = {
> +	{ .compatible = "olpc,ap-sp", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, olpc_apsp_driver_dt_ids);
> +
> +static struct platform_driver olpc_apsp_driver = {
> +	.probe		= olpc_apsp_probe,
> +	.remove		= olpc_apsp_remove,
> +	.driver		= {
> +		.name	= "olpc-apsp",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = olpc_apsp_dt_ids,
> +	},
> +};
> +
> +MODULE_DESCRIPTION("OLPC AP-SP serio driver");
> +MODULE_LICENSE("GPL");
> +module_platform_driver(olpc_apsp_driver);
> -- 
> 1.8.1.4
> 

Thanks.

-- 
Dmitry
