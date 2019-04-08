From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/6] Input: add IOC3 serio driver
Date: Mon, 8 Apr 2019 12:02:18 -0700
Message-ID: <20190408190218.GA200740@dtor-ws>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
 <20190408142100.27618-7-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408142100.27618-7-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Thomas,

On Mon, Apr 08, 2019 at 04:20:58PM +0200, Thomas Bogendoerfer wrote:
> This patch adds a platform driver for supporting keyboard and mouse
> interface of SGI IOC3 chips.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/input/serio/Kconfig   |  12 +++
>  drivers/input/serio/Makefile  |   1 +
>  drivers/input/serio/ioc3kbd.c | 183 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>  create mode 100644 drivers/input/serio/ioc3kbd.c
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index c9c7224d5ae0..ceb89d8b785d 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -164,6 +164,18 @@ config SERIO_MACEPS2
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called maceps2.
>  
> +config SERIO_SGI_IOC3
> +	tristate "SGI IOC3 PS/2 controller"
> +	depends on SGI_MFD_IOC3
> +	help
> +	  Say Y here if you have an SGI Onyx2, SGI Octane or IOC3 PCI card
> +	  and you want to attach and use a keyboard, mouse, or both.
> +
> +	  Do not use on an SGI Origin 2000, as the IO6 board in those
> +	  systems lacks the necessary PS/2 ports.  You will need to add
> +	  an IOC3 PCI card (CADduo) via a PCI Shoehorn XIO card or the
> +	  PCI Cardcage (shoebox) first.

To compile this driver as a module...

> +
>  config SERIO_LIBPS2
>  	tristate "PS/2 driver library"
>  	depends on SERIO_I8042 || SERIO_I8042=n
> diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> index 67950a5ccb3f..6d97bad7b844 100644
> --- a/drivers/input/serio/Makefile
> +++ b/drivers/input/serio/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_HIL_MLC)		+= hp_sdc_mlc.o hil_mlc.o
>  obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
>  obj-$(CONFIG_SERIO_PS2MULT)	+= ps2mult.o
>  obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
> +obj-$(CONFIG_SERIO_SGI_IOC3)	+= ioc3kbd.o
>  obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
>  obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
>  obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_serio.o
> diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
> new file mode 100644
> index 000000000000..8ff46a9f3d98
> --- /dev/null
> +++ b/drivers/input/serio/ioc3kbd.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SGI IOC3 PS/2 controller driver for linux
> + *
> + * Copyright (C) 2019 Thomas Bogendoerfer <tbogendoerfer@suse.de>
> + *
> + * Based on code Copyright (C) 2005 Stanislaw Skowronek <skylark@unaligned.org>
> + *               Copyright (C) 2009 Johannes Dickgreber <tanzy@gmx.de>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/serio.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/sn/ioc3.h>
> +
> +struct ioc3kbd_data {
> +	struct ioc3_serioregs __iomem *regs;
> +	struct serio *kbd, *aux;
> +};
> +
> +static int ioc3kbd_write(struct serio *dev, u8 val)
> +{
> +	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(dev->port_data);

serio->port_data is void pointer, no need to cast.

> +	unsigned long timeout = 0;
> +	u32 mask;
> +
> +	mask = (dev == d->aux) ? KM_CSR_M_WRT_PEND : KM_CSR_K_WRT_PEND;
> +	while ((readl(&d->regs->km_csr) & mask) && (timeout < 1000)) {
> +		udelay(100);
> +		timeout++;
> +	}
> +
> +	if (dev == d->aux)
> +		writel(((u32)val) & 0x000000ff, &d->regs->m_wd);
> +	else
> +		writel(((u32)val) & 0x000000ff, &d->regs->k_wd);

Why do you need to mask the upper bits if you start with u8? Can you
just say:

	writel(val, dev == d->aux ? &d->regs->m_wd, &d->regs->k_wd);


> +
> +	if (timeout >= 1000)
> +		return -1;

So you attempt to write even if controller indicates that it is busy?

> +	return 0;
> +}
> +
> +static irqreturn_t ioc3kbd_intr(int itq, void *dev_id)
> +{
> +	struct ioc3kbd_data *d = dev_id;
> +	u32 data_k, data_m;
> +
> +	data_k = readl(&d->regs->k_rd);
> +	data_m = readl(&d->regs->m_rd);
> +
> +	if (data_k & KM_RD_VALID_0)
> +		serio_interrupt(d->kbd,
> +		(data_k >> KM_RD_DATA_0_SHIFT) & 0xff, 0);
> +	if (data_k & KM_RD_VALID_1)
> +		serio_interrupt(d->kbd,
> +		(data_k >> KM_RD_DATA_1_SHIFT) & 0xff, 0);
> +	if (data_k & KM_RD_VALID_2)
> +		serio_interrupt(d->kbd,
> +		(data_k >> KM_RD_DATA_2_SHIFT) & 0xff, 0);
> +	if (data_m & KM_RD_VALID_0)
> +		serio_interrupt(d->aux,
> +		(data_m >> KM_RD_DATA_0_SHIFT) & 0xff, 0);
> +	if (data_m & KM_RD_VALID_1)
> +		serio_interrupt(d->aux,
> +		(data_m >> KM_RD_DATA_1_SHIFT) & 0xff, 0);
> +	if (data_m & KM_RD_VALID_2)
> +		serio_interrupt(d->aux,
> +		(data_m >> KM_RD_DATA_2_SHIFT) & 0xff, 0);
> +
> +	return 0;
> +}
> +
> +static int ioc3kbd_open(struct serio *dev)
> +{
> +	return 0;
> +}
> +
> +static void ioc3kbd_close(struct serio *dev)
> +{
> +	/* Empty */
> +}

You do not need empty stubs.

> +
> +static struct ioc3kbd_data *ioc3kbd_alloc_port(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ioc3_serioregs __iomem *regs;
> +	struct ioc3kbd_data *d;
> +	struct serio *sk, *sa;
> +	struct resource *mem;
> +	int irq;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		return NULL;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return NULL;
> +
> +	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
> +	if (!regs)
> +		return NULL;
> +
> +	sk = devm_kzalloc(dev, sizeof(struct serio), GFP_KERNEL);
> +	if (!sk)
> +		return NULL;
> +
> +	sa = devm_kzalloc(dev, sizeof(struct serio), GFP_KERNEL);
> +	if (!sa)
> +		return NULL;

serio ports are refcounted, they must not be allocated with devm_* API
as their lifetime may extend past the remove() time.

> +
> +	d = devm_kzalloc(dev, sizeof(struct ioc3kbd_data),
> +			 GFP_KERNEL);
> +	if (!d)
> +		return NULL;
> +
> +	if (request_irq(irq, ioc3kbd_intr, IRQF_SHARED, "ioc3-kbd", d))
> +		return NULL;

This is unfortunate that you lose error code. You also fail to handle
-EPROPE_DEFER from request_irq().

> +
> +	sk->id.type = SERIO_8042;
> +	sk->write = ioc3kbd_write;
> +	sk->open = ioc3kbd_open;
> +	sk->close = ioc3kbd_close;
> +	snprintf(sk->name, sizeof(sk->name), "IOC3 keyboard %d", pdev->id);
> +	snprintf(sk->phys, sizeof(sk->phys), "ioc3/serio%dkbd", pdev->id);
> +	sk->port_data = d;
> +	sk->dev.parent = &pdev->dev;
> +
> +	sa->id.type = SERIO_8042;
> +	sa->write = ioc3kbd_write;
> +	sa->open = ioc3kbd_open;
> +	sa->close = ioc3kbd_close;
> +	snprintf(sa->name, sizeof(sa->name), "IOC3 auxiliary %d", pdev->id);
> +	snprintf(sa->phys, sizeof(sa->phys), "ioc3/serio%daux", pdev->id);
> +	sa->port_data = d;
> +	sa->dev.parent = dev;
> +
> +	d->regs = regs;
> +	d->kbd = sk;
> +	d->aux = sa;
> +	return d;
> +}
> +
> +static int ioc3kbd_probe(struct platform_device *pdev)
> +{
> +	struct ioc3kbd_data *d;
> +
> +	d = ioc3kbd_alloc_port(pdev);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, d);
> +	serio_register_port(d->kbd);
> +	serio_register_port(d->aux);
> +
> +	return 0;
> +}
> +
> +static int ioc3kbd_remove(struct platform_device *pdev)
> +{
> +	struct ioc3kbd_data *d = platform_get_drvdata(pdev);
> +
> +	serio_unregister_port(d->kbd);
> +	serio_unregister_port(d->aux);
> +	return 0;
> +}
> +
> +static struct platform_driver ioc3kbd_driver = {
> +	.probe          = ioc3kbd_probe,
> +	.remove         = ioc3kbd_remove,
> +	.driver = {
> +		.name = "ioc3-kbd",
> +	},
> +};
> +module_platform_driver(ioc3kbd_driver);
> +
> +MODULE_AUTHOR("Stanislaw Skowronek <skylark@unaligned.org>");
> +MODULE_DESCRIPTION("SGI IOC3 serio driver");
> +MODULE_LICENSE("GPL");

"GPL v2" to match SPDX header?

> -- 
> 2.13.7
> 

Thanks.

-- 
Dmitry
