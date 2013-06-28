From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Add OLPC AP-SP input driver
Date: Fri, 28 Jun 2013 09:54:16 -0700
Message-ID: <20130628165415.GA14735@core.coreip.homeip.net>
References: <20130628151627.5228CFAAD5@dev.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49697 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab3F1QyV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 12:54:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2503146pbb.33
        for <linux-input@vger.kernel.org>; Fri, 28 Jun 2013 09:54:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130628151627.5228CFAAD5@dev.laptop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org, devicetree-discuss@lists.ozlabs.org


Hi Daniel,

On Fri, Jun 28, 2013 at 11:16:27AM -0400, Daniel Drake wrote:
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
>  drivers/input/serio/olpc_apsp.c                    | 276 +++++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
>  create mode 100644 drivers/input/serio/olpc_apsp.c
> 
> v2: Use dev_dbg(). Disable interrupts during unload, and remove bad use of
> devm. Thanks to Dmitry for the quick review.

Thank you for making the changes and I am sorry but I missed a couple of
things yesterday.

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
> index 0000000..9d65b6b
> --- /dev/null
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -0,0 +1,276 @@
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
> +#include <linux/slab.h>
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
> +	int irq;
> +};
> +
> +static int olpc_apsp_write(struct serio *port, unsigned char val)
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
> +	dev_dbg(priv->dev, "olpc_apsp_write which=%x val=%x\n", which, val);
> +	for (i = 0; i < 50; i++) {
> +		u32 sts = readl(priv->base + COMMAND_FIFO_STATUS);
> +		if ((sts & CMD_CNTR_MASK) < MAX_PENDING_CMDS) {
> +			writel(which | val,
> +			       priv->base + SECURE_PROCESSOR_COMMAND);
> +			return 0;
> +		}
> +		msleep(1);

serio_write() is allowed to be called from interrupt context so sleeping
here is not allowed.

> +	}
> +
> +	dev_dbg(priv->dev, "olpc_apsp_write timeout, status=%x\n",
> +	    readl(priv->base + COMMAND_FIFO_STATUS));
> +	return -ETIMEDOUT;
> +}
> +
> +static irqreturn_t olpc_apsp_rx(int irq, void *dev_id)
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
> +	dev_dbg(priv->dev, "olpc_apsp_rx %x\n", w);
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
> +static int olpc_apsp_open(struct serio *port)
> +{
> +	struct olpc_apsp *priv = port->port_data;
> +	unsigned int tmp;
> +
> +	/* Enable interrupt 0 by clearing its bit */
> +	tmp = readl(priv->base + PJ_INTERRUPT_MASK);
> +	writel(tmp & ~INT_0, priv->base + PJ_INTERRUPT_MASK);
> +
> +	return 0;
> +}
> +
> +static void olpc_apsp_close(struct serio *port)
> +{
> +	struct olpc_apsp *priv = port->port_data;
> +	unsigned int tmp;
> +
> +	/* Disable interrupt 0 */
> +	tmp = readl(priv->base + PJ_INTERRUPT_MASK);
> +	writel(tmp | INT_0, priv->base + PJ_INTERRUPT_MASK);

Hmm, so both ports share the same interrupt bit? Then you need to make
sure you handle when one port is opened and another is closed.

> +}
> +
> +static int olpc_apsp_probe(struct platform_device *pdev)
> +{
> +	struct serio *kb_serio, *pad_serio;
> +	struct olpc_apsp *priv;
> +	struct resource *res;
> +	struct device_node *np;
> +	unsigned long l;
> +	int error;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(struct olpc_apsp), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np = pdev->dev.of_node;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOENT;
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq < 0)
> +		return priv->irq;
> +
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!priv->base) {

devm_ioremap_resource() returns ERR_PTR-encoded errors, you need to use
IS_ERR/PTR_ERR here.

> +		dev_err(&pdev->dev, "Failed to map WTM registers\n");
> +		return -EIO;

Please return return code from devm_ioremap_resource().

> +	}
> +
> +	l = readl(priv->base + COMMAND_FIFO_STATUS);
> +	if (!(l & CMD_STS_MASK)) {
> +		dev_err(&pdev->dev, "SP cannot accept commands.\n");
> +		return -ENODEV;
> +	}
> +

We need to make sure interrupts are shut off before requesting IRQ here
since you allocate ports later.

> +	error = request_irq(priv->irq, olpc_apsp_rx, 0, "olpc-apsp", priv);

Now that you are actually supply the close() method so that interrupts
won't be generated past the port unregistration, you can actually use
devm for irq (not a requirement on my part though).

> +	if (error) {
> +		dev_err(&pdev->dev, "Failed to request IRQ\n");
> +		return error;
> +	}
> +
> +	/* KEYBOARD */
> +	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
> +	if (!kb_serio) {
> +		error = -ENOMEM;
> +		goto err_kb;
> +	}
> +	kb_serio->id.type	= SERIO_8042_XL;
> +	kb_serio->write		= olpc_apsp_write;
> +	kb_serio->open		= olpc_apsp_open;
> +	kb_serio->close		= olpc_apsp_close;
> +	kb_serio->port_data	= priv;
> +	kb_serio->dev.parent	= &pdev->dev;
> +	strlcpy(kb_serio->name, "sp keyboard", sizeof(kb_serio->name));
> +	strlcpy(kb_serio->phys, "sp/serio0", sizeof(kb_serio->phys));
> +	priv->kbio		= kb_serio;
> +	serio_register_port(kb_serio);
> +
> +	/* TOUCHPAD */
> +	pad_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
> +	if (!pad_serio) {
> +		error = -ENOMEM;
> +		goto err_pad;
> +	}
> +	pad_serio->id.type	= SERIO_PS_PSTHRU;

Why SERIO_PS_PSTHRU and not SERIO_8042? SERIO_PS_PSTHRU is really for
pass-through PS/2 ports on Synaptics (and maybe IBM trackpoint, but
nobody did that).

> +	pad_serio->write	= olpc_apsp_write;
> +	pad_serio->open		= olpc_apsp_open;
> +	pad_serio->close	= olpc_apsp_close;
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
> +	dev_dbg(&pdev->dev, "probed successfully.\n");
> +	return 0;
> +
> +err_pad:
> +	serio_unregister_port(kb_serio);
> +err_kb:
> +	free_irq(priv->irq, priv);
> +	return error;
> +}
> +
> +static int olpc_apsp_remove(struct platform_device *pdev)
> +{
> +	struct olpc_apsp *priv = platform_get_drvdata(pdev);
> +	free_irq(priv->irq, priv);
> +	serio_unregister_port(priv->kbio);
> +	serio_unregister_port(priv->padio);
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
