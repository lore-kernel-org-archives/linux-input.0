From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers:input:ps2 Added sunxi A20 ps2
 driver, changed makefile and Kconfig
Date: Wed, 3 Dec 2014 15:23:34 -0800
Message-ID: <20141203232334.GG16951@dtor-ws>
References: <1417647224-27950-1-git-send-email-VishnuPatekar0510@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRB6VW72RQKGQEZAIAVZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417647224-27950-1-git-send-email-VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: vishnupatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 04, 2014 at 04:23:44AM +0530, vishnupatekar wrote:
> ---
>  drivers/input/serio/Kconfig     |    9 ++
>  drivers/input/serio/Makefile    |    1 +
>  drivers/input/serio/sunxi-ps2.c |  305 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 315 insertions(+)
>  create mode 100644 drivers/input/serio/sunxi-ps2.c
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index bc2d474..1a86e41 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -281,4 +281,13 @@ config HYPERV_KEYBOARD
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called hyperv_keyboard.
>  
> +config SERIO_SUNXI_PS2
> +	tristate "Allwinner Sun7i-A20 PS/2 controller"
> +	default m

Why default m? Default should be n. Also it seems it has to depend on
OF. And what about depending on <arch> || COMPILE_TEST?

> +	help
> +	  Say Y here if you have Sun7i-A20 Allwinner PS/2 ports.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sunxi-ps2.
> +
>  endif
> diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> index 815d874..0fa0f78 100644
> --- a/drivers/input/serio/Makefile
> +++ b/drivers/input/serio/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_SERIO_ARC_PS2)	+= arc_ps2.o
>  obj-$(CONFIG_SERIO_APBPS2)	+= apbps2.o
>  obj-$(CONFIG_SERIO_OLPC_APSP)	+= olpc_apsp.o
>  obj-$(CONFIG_HYPERV_KEYBOARD)	+= hyperv-keyboard.o
> +obj-$(CONFIG_SERIO_SUNXI_PS2)	+= sunxi-ps2.o
> diff --git a/drivers/input/serio/sunxi-ps2.c b/drivers/input/serio/sunxi-ps2.c
> new file mode 100644
> index 0000000..ccd7b29
> --- /dev/null
> +++ b/drivers/input/serio/sunxi-ps2.c
> @@ -0,0 +1,305 @@
> +/*
> + * sunxi-ps2.c Support for Allwinner A20 PS2 host controller

No file names in sources please.

> + *
> + * Author: Aaron.maoye <leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org>
> + *	   Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + * Based on sunxi-ps2.c 3.0 kernel
> + *
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/serio.h>
> +#include <linux/interrupt.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +
> +#define DRIVER_NAME		"sunxi-ps2"
> +
> +#define RESSIZE(res)        (((res)->end - (res)->start)+1)

I am sure we have something generic for it, no?

> +
> +#define SW_PS2_GCTRL        (0x00)
> +#define SW_PS2_DATA         (0x04)
> +#define SW_PS2_LCTRL        (0x08)
> +#define SW_PS2_LSTAT        (0x0c)
> +#define SW_PS2_FCTRL        (0x10)
> +#define SW_PS2_FSTAT        (0x14)
> +#define SW_PS2_CLKDR        (0x18)
> +
> +/* SW_PS2_GCTRL */
> +#define SWPS2_BUSEN         (1 << 0)
> +#define SWPS2_MASTER        (1 << 1)
> +#define SWPS2_RESET         (1 << 2)
> +#define SWPS2_INTEN         (1 << 3)
> +#define SWPS2_INTFLAG       (1 << 3)
> +
> +/* SW_PS2_LCTRL */
> +#define SWPS2_LCTL_NOACK        (0x0 << 18)
> +#define SWPS2_LCTL_TXDTOEN      (0x1 << 8)
> +#define SWPS2_LCTL_STOPERREN    (0x1 << 3)
> +#define SWPS2_LCTL_ACKERREN     (0x1 << 2)
> +#define SWPS2_LCTL_PARERREN     (0x1 << 1)
> +#define SWPS2_LCTL_RXDTOEN      (0x1 << 0)
> +
> +/* SW_PS2_FSTAT */
> +#define SWPS2_FSTA_RXRDY        (1 << 0)
> +#define SWPS2_FSTA_RXOF         (1 << 1)
> +#define SWPS2_FSTA_RXUF         (1 << 2)
> +#define SWPS2_FSTA_TXRDY        (1 << 8)
> +#define SWPS2_FSTA_TXOF         (1 << 9)
> +#define SWPS2_FSTA_TXUF         (1 << 10)
> +
> +#define SW_PS2_SAMPLE_CLK      (1000000)
> +#define SW_PS2_SCLK            (125000)
> +
> +struct sunxips2data {
> +	int irq;
> +	spinlock_t ps2_lock;
> +	void __iomem *base_address;	/* virt address of control registers*/
> +	struct serio *serio;		/* serio*/
> +	struct device *dev;
> +	struct	clk	*pclk;
> +};
> +
> +/*********************/
> +/* Interrupt handler */
> +/*********************/
> +static irqreturn_t sunxips2_interrupt(int irq, void *dev_id)
> +{
> +	struct sunxips2data *drvdata = dev_id;
> +	u32 intr_status;
> +	u32 fifo_status;
> +	unsigned char byte;
> +	u32 rval;
> +	u32 error = 0;
> +
> +	spin_lock(&drvdata->ps2_lock);
> +
> +	/* Get the PS/2 interrupts and clear them */
> +	intr_status  = readl(drvdata->base_address + SW_PS2_LSTAT);
> +	fifo_status  = readl(drvdata->base_address + SW_PS2_FSTAT);
> +
> +	/*Check Line Status Register*/
> +	if (intr_status & 0x10f) {
> +		if (intr_status & 0x08)
> +			dev_info(drvdata->dev, "PS/2 Stop Bit Error!");
> +		if (intr_status & 0x04)
> +			dev_info(drvdata->dev, "PS/2 Acknowledge Error!\n");
> +		if (intr_status & 0x02)
> +			dev_info(drvdata->dev, "PS/2 Parity Error!\n");
> +		if (intr_status & 0x100)
> +			dev_info(drvdata->dev, "PS/2 Transmit Data Timeout!\n");
> +		if (intr_status & 0x01)
> +			dev_info(drvdata->dev, "PS/2 Receive Data Timeout!\n");
> +
> +		writel(readl(drvdata->base_address + SW_PS2_GCTRL)|0x4, drvdata->base_address + SW_PS2_GCTRL);/*reset PS/2 controller*/
> +		writel(0x10f, drvdata->base_address + SW_PS2_LSTAT);
> +
> +		error = 1;
> +	}
> +
> +    /*Check FIFO Status Register*/
> +	if (fifo_status & 0x0606) {
> +		if (fifo_status & 0x400)
> +			dev_info(drvdata->dev, "PS/2 Tx FIFO Underflow!\n");
> +		if (fifo_status & 0x200)
> +			dev_info(drvdata->dev, "PS/2 Tx FIFO Overflow!\n");
> +		if (fifo_status & 0x04)
> +			dev_info(drvdata->dev, "PS/2 Rx FIFO Underflow!\n");
> +		if (fifo_status & 0x02)
> +			dev_info(drvdata->dev, "PS/2 Rx FIFO Overflow!\n");
> +
> +		writel(readl(drvdata->base_address + SW_PS2_GCTRL)|0x4, drvdata->base_address + SW_PS2_GCTRL); /*reset PS/2 controller*/
> +		writel(0x707, drvdata->base_address + SW_PS2_FSTAT);
> +		error = 1;
> +	}
> +
> +	rval = (fifo_status >> 16) & 0x3;
> +	while (!error && rval--) {
> +		byte = readl(drvdata->base_address + SW_PS2_DATA) & 0xff;
> +		dev_info(drvdata->dev, "PS/2 Receive %02x\n", byte);

You really want to log every input byte in the logs?

> +		serio_interrupt(drvdata->serio, byte, 0);
> +	}
> +
> +	writel(intr_status, drvdata->base_address + SW_PS2_LSTAT);
> +	writel(fifo_status, drvdata->base_address + SW_PS2_FSTAT);
> +
> +	spin_unlock(&drvdata->ps2_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunxips2_open(struct serio *pserio)
> +{
> +	struct sunxips2data *drvdata = pserio->port_data;
> +	u32 src_clk = 0;
> +	u32 clk_scdf;
> +	u32 clk_pcdf;
> +	u32 rval;
> +
> +	/*Set Line Control And Enable Interrupt*/
> +	rval = SWPS2_LCTL_TXDTOEN|SWPS2_LCTL_STOPERREN|SWPS2_LCTL_ACKERREN|SWPS2_LCTL_PARERREN|SWPS2_LCTL_RXDTOEN;
> +	writel(rval, drvdata->base_address + SW_PS2_LCTRL);
> +
> +	/*Reset FIFO*/
> +	writel(0x3<<16 | 0x607, drvdata->base_address + SW_PS2_FCTRL);
> +
> +	src_clk = clk_get_rate(drvdata->pclk);
> +
> +	if (!src_clk) {
> +		dev_info(drvdata->dev, "w_ps2c_set_sclk error, source clock is 0.");
> +		return -1;
> +	}
> +
> +	/*Set Clock Divider Register*/
> +	clk_scdf = ((src_clk + (SW_PS2_SAMPLE_CLK>>1)) / SW_PS2_SAMPLE_CLK - 1);
> +	clk_pcdf = ((SW_PS2_SAMPLE_CLK + (SW_PS2_SCLK>>1)) / SW_PS2_SCLK - 1);
> +	rval = (clk_scdf<<8) | clk_pcdf;/* | (PS2_DEBUG_SEL<<16);*/
> +	writel(rval, drvdata->base_address + SW_PS2_CLKDR);
> +
> +	/*Set Global Control Register*/
> +	rval = SWPS2_RESET|SWPS2_INTEN|SWPS2_MASTER|SWPS2_BUSEN;
> +	writel(rval, drvdata->base_address + SW_PS2_GCTRL);
> +
> +	udelay(100);
> +
> +	return 0;
> +}
> +
> +static void sunxips2_close(struct serio *pserio)
> +{
> +	struct sunxips2data *drvdata = pserio->port_data;
> +
> +	spin_lock(&drvdata->ps2_lock);
> +	/* Disable the PS2 interrupts */
> +	writel(0, drvdata->base_address + SW_PS2_GCTRL);
> +	spin_unlock(&drvdata->ps2_lock);
> +}
> +
> +static int sunxips2_write(struct serio *pserio, unsigned char val)
> +{
> +	struct sunxips2data *drvdata = (struct sunxips2data *)pserio->port_data;
> +	u32 timeout = 10000;
> +
> +	do {
> +		if (readl(drvdata->base_address + SW_PS2_FSTAT) & SWPS2_FSTA_TXRDY) {
> +			writel(val, drvdata->base_address + SW_PS2_DATA);
> +			return 0;
> +		}
> +	} while (timeout--);
> +
> +	return -1;
> +}
> +
> +static int sunxips2_probe(struct platform_device *ofdev)
> +{
> +	struct resource *res; /* IO mem resources */
> +	struct sunxips2data *drvdata;
> +	struct serio *serio;
> +	struct device *dev = &ofdev->dev;
> +	unsigned int irq;
> +	int error;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(struct sunxips2data), GFP_KERNEL);
> +	serio = devm_kzalloc(dev, sizeof(struct serio), GFP_KERNEL);

serio is a refcounted structure, it should not be allocated with devm.

> +	if (!drvdata || !serio)
> +		error = -ENOMEM;

		and...?

> +
> +	/* Request clock */
> +	drvdata->pclk = clk_get(dev, NULL);
> +	if (IS_ERR(drvdata->pclk))
> +		dev_dbg(dev, "couldn't get clock %li\n",
> +			PTR_ERR(drvdata->pclk));

Why %li?

> +
> +	if (!IS_ERR(drvdata->pclk)) {

"} else {"


> +		error = clk_prepare_enable(drvdata->pclk);
> +		if (error < 0) {
> +			dev_err(dev, "failed to enable clock %d\n", error);
> +			return error;

Leaking clk here.

> +		}
> +	}
> +
> +	/* IO */
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> +	drvdata->base_address = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(drvdata->base_address)) {
> +		dev_err(dev, "failed to map registers\n");
> +		error = PTR_ERR(drvdata->base_address);

		aaaand...?

> +	}
> +
> +	serio->id.type = SERIO_8042;
> +	serio->write = sunxips2_write;
> +	serio->open = sunxips2_open;
> +	serio->close = sunxips2_close;
> +	serio->port_data = drvdata;
> +	serio->dev.parent = dev;
> +	strlcpy(serio->name, dev_name(dev), sizeof(serio->name));
> +	strlcpy(serio->phys, dev_name(dev), sizeof(serio->phys));
> +
> +	platform_set_drvdata(ofdev, drvdata);
> +	serio_register_port(serio);
> +
> +	/* Get IRQ for the device */
> +	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +	if (!irq) {
> +		dev_err(dev, "no IRQ found\n");
> +		return -ENODEV;

Leaking clk and serio here.

> +	}
> +
> +	drvdata->irq = irq;
> +	drvdata->serio = serio;
> +	drvdata->dev = dev;
> +	error = devm_request_any_context_irq(drvdata->dev, drvdata->irq, &sunxips2_interrupt, 0,
> +				DRIVER_NAME, drvdata);

Please try to fit in 80 columns.

> +	if (error) {
> +		dev_err(drvdata->dev,
> +			"Couldn't allocate interrupt %d : error: %d\n", drvdata->irq, error);
> +		return error;
> +	}
> +	return 0;		/* success */
> +}
> +
> +static int sunxips2_remove(struct platform_device *of_dev)
> +{
> +	struct sunxips2data *drvdata = platform_get_drvdata(of_dev);
> +
> +	if (!IS_ERR(drvdata->pclk)) {
> +		clk_disable_unprepare(drvdata->pclk);
> +		clk_put(drvdata->pclk);

If serio write comes here what will happen?

> +	}
> +	serio_unregister_port(drvdata->serio);

If interrupt comes here  what will happen?

> +	mdelay(2);

Why do you need mdelay?

> +	return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id sunxips2_of_match[] = {
> +	{ .compatible = "allwinner,sun7i-a20-ps2", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, sunxips2_of_match);
> +
> +/*platform driver structure*/
> +static struct platform_driver sunxips2_of_driver = {
> +	.probe		= sunxips2_probe,
> +	.remove		= sunxips2_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = sunxips2_of_match,
> +	},
> +};
> +module_platform_driver(sunxips2_of_driver);
> +
> +MODULE_AUTHOR("Aaron.maoye<leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org, "

Space before "<", closing ">" are missing.

> +		"Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("Sunxi PS/2 driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
