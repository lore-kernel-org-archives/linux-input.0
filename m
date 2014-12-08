From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 2/3] sunxi:drivers:input:ps2 Added sunxi
 A10/A20 ps2 driver
Date: Mon, 8 Dec 2014 10:13:33 +0530
Message-ID: <CAEzqOZvQJQRuqnTPAcG6S8jHfKZcJhAFj_-YCNQ+g+FkrevnXg@mail.gmail.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
	<1417907719-26775-3-git-send-email-VishnuPatekar0510@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=f46d04388df1a889cc0509ad1167
Return-path: <linux-sunxi+bncBD64TFVR3YIBB5WYSSSAKGQEHFBZULQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1417907719-26775-3-git-send-email-VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org" <leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, vishnupatekar <VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--f46d04388df1a889cc0509ad1167
Content-Type: text/plain; charset=UTF-8

On Sunday, December 7, 2014, vishnupatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

>  -added compatible as allwinner,sun4i-a10-ps2 and allwinner,sun7i-a20-ps2.
>  - added default n depends on ARCH_SUNXI || COMPILE_TEST
>  in Kconfig.
>  -handled errors and free resources on errors.
>  -used BIT(x), DIV_ROUND_UP macros.
>  -corrected style errors.
>
> Signed-off-by: vishnupatekar <VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:;>>
> ---
>  drivers/input/serio/Kconfig     |   10 ++
>  drivers/input/serio/Makefile    |    1 +
>  drivers/input/serio/sunxi-ps2.c |  364
> +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 375 insertions(+)
>  create mode 100644 drivers/input/serio/sunxi-ps2.c
>
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index bc2d474..3a7599c 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -281,4 +281,14 @@ config HYPERV_KEYBOARD
>           To compile this driver as a module, choose M here: the module
> will
>           be called hyperv_keyboard.
>
> +config SERIO_SUNXI_PS2
> +       tristate "Allwinner Sun4i-A10/Sun7i-A20 PS/2 controller"
> +       default n
> +       depends on ARCH_SUNXI || COMPILE_TEST
> +       help
> +         Say Y here if you have Sun4i-A10/Sun7i-A20 Allwinner PS/2 ports.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called sunxi-ps2.
> +
>  endif
> diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> index 815d874..0fa0f78 100644
> --- a/drivers/input/serio/Makefile
> +++ b/drivers/input/serio/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_SERIO_ARC_PS2)   += arc_ps2.o
>  obj-$(CONFIG_SERIO_APBPS2)     += apbps2.o
>  obj-$(CONFIG_SERIO_OLPC_APSP)  += olpc_apsp.o
>  obj-$(CONFIG_HYPERV_KEYBOARD)  += hyperv-keyboard.o
> +obj-$(CONFIG_SERIO_SUNXI_PS2)  += sunxi-ps2.o
> diff --git a/drivers/input/serio/sunxi-ps2.c
> b/drivers/input/serio/sunxi-ps2.c
> new file mode 100644
> index 0000000..4cd89ae
> --- /dev/null
> +++ b/drivers/input/serio/sunxi-ps2.c
> @@ -0,0 +1,364 @@
> +/*
> + *     Driver for Allwinner A20 PS2 host controller
> + *
> + *     Author: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:;>
> >
> + *             Aaron.maoye <leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org <javascript:;>>
> + *
> + *             Based on 3.0 kernel
> + *
> + */
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
> +#define DRIVER_NAME            "sunxi-ps2"
> +
> +/* register offset definitions */
> +#define PS2_REG_GCTL           (0x00)  /*  PS2 Module Global Control Reg
> */
> +#define PS2_REG_DATA           (0x04)  /*  PS2 Module Data Reg         */
> +#define PS2_REG_LCTL           (0x08)  /*  PS2 Module Line Control Reg */
> +#define PS2_REG_LSTS           (0x0C)  /*  PS2 Module Line Status Reg  */
> +#define PS2_REG_FCTL           (0x10)  /*  PS2 Module FIFO Control Reg */
> +#define PS2_REG_FSTS           (0x14)  /*  PS2 Module FIFO Status Reg  */
> +#define PS2_REG_CLKDR          (0x18)  /*  PS2 Module Clock Divider Reg*/
> +
> +/*  PS2 GLOBAL CONTROL REGISTER PS2_GCTL */
> +#define PS2_GCTL_INTFLAG       BIT(4)
> +#define PS2_GCTL_INTEN         BIT(3)
> +#define PS2_GCTL_RESET         BIT(2)
> +#define PS2_GCTL_MASTER                BIT(1)
> +#define PS2_GCTL_BUSEN         BIT(0)
> +
> +/* PS2 LINE CONTROL REGISTER */
> +#define PS2_LCTL_NOACK         BIT(18)
> +#define PS2_LCTL_TXDTOEN       BIT(8)
> +#define PS2_LCTL_STOPERREN     BIT(3)
> +#define PS2_LCTL_ACKERREN      BIT(2)
> +#define PS2_LCTL_PARERREN      BIT(1)
> +#define PS2_LCTL_RXDTOEN       BIT(0)
> +
> +/* PS2 LINE STATUS REGISTER */
> +#define PS2_LSTS_TXTDO         BIT(8)
> +#define PS2_LSTS_STOPERR       BIT(3)
> +#define PS2_LSTS_ACKERR                BIT(2)
> +#define PS2_LSTS_PARERR                BIT(1)
> +#define PS2_LSTS_RXTDO         BIT(0)
> +
> +/* PS2 FIFO CONTROL REGISTER */
> +#define PS2_FCTL_TXRST         BIT(17)
> +#define PS2_FCTL_RXRST         BIT(16)
> +#define PS2_FCTL_TXUFIEN       BIT(10)
> +#define PS2_FCTL_TXOFIEN       BIT(9)
> +#define PS2_FCTL_TXRDYIEN      BIT(8)
> +#define PS2_FCTL_RXUFIEN       BIT(2)
> +#define PS2_FCTL_RXOFIEN       BIT(1)
> +#define PS2_FCTL_RXRDYIEN      BIT(0)
> +
> +/* PS2 FIFO STATUS REGISTER */
> +#define PS2_FSTS_TXUF          BIT(10)
> +#define PS2_FSTS_TXOF          BIT(9)
> +#define PS2_FSTS_TXRDY         BIT(8)
> +#define PS2_FSTS_RXUF          BIT(2)
> +#define PS2_FSTS_RXOF          BIT(1)
> +#define PS2_FSTS_RXRDY         BIT(0)
> +
> +
> +#define PS2_LINE_ERROR_BIT \
> +       (PS2_LSTS_TXTDO|PS2_LSTS_STOPERR|PS2_LSTS_ACKERR| \
> +       PS2_LSTS_PARERR|PS2_LSTS_RXTDO)
> +
> +#define PS2_FIFO_ERROR_BIT \
> +       (PS2_FSTS_TXUF|PS2_FSTS_TXOF|PS2_FSTS_TXRDY|PS2_FSTS_RXUF| \
> +       PS2_FSTS_RXOF|PS2_FSTS_RXRDY)
> +
> +#define PS2_SAMPLE_CLK         (1000000)
> +#define PS2_SCLK               (125000)
> +
> +struct sunxips2data {
> +       struct serio *serio;
> +       struct device *dev;
> +
> +       /* IO mapping base */
> +       void __iomem    *reg_base;
> +
> +       /* clock management */
> +       struct clk      *clk;
> +
> +       /* irq */
> +       spinlock_t      lock;
> +       int             irq;
> +};
> +
> +/*********************/
> +/* Interrupt handler */
> +/*********************/
> +static irqreturn_t sunxips2_interrupt(int irq, void *dev_id)
> +{
> +       struct sunxips2data *drvdata = dev_id;
> +       u32 intr_status;
> +       u32 fifo_status;
> +       unsigned char byte;
> +       u32 rval;
> +       u32 error = 0;
> +
> +       spin_lock(&drvdata->lock);
> +
> +       /* Get the PS/2 interrupts and clear them */
> +       intr_status  = readl(drvdata->reg_base + PS2_REG_LSTS);
> +       fifo_status  = readl(drvdata->reg_base + PS2_REG_FSTS);
> +
> +       /*Check Line Status Register*/
> +       if (intr_status & 0x10f) {
> +               if (intr_status & PS2_LSTS_STOPERR)
> +                       dev_info(drvdata->dev, "PS/2 Stop Bit Error!");
> +               if (intr_status & PS2_LSTS_ACKERR)
> +                       dev_info(drvdata->dev, "PS/2 Acknowledge
> Error!\n");
> +               if (intr_status & PS2_LSTS_PARERR)
> +                       dev_info(drvdata->dev, "PS/2 Parity Error!\n");
> +               if (intr_status & PS2_LSTS_TXTDO)
> +                       dev_info(drvdata->dev, "PS/2 Transmit Data
> Timeout!\n");
> +               if (intr_status & PS2_LSTS_RXTDO)
> +                       dev_info(drvdata->dev, "PS/2 Receive Data
> Timeout!\n");
> +
> +               /*reset PS/2 controller*/
> +               writel(readl(drvdata->reg_base + PS2_REG_GCTL) |
> PS2_GCTL_RESET,
> +                       drvdata->reg_base + PS2_REG_GCTL);
> +
> +               rval = PS2_LSTS_TXTDO | PS2_LSTS_STOPERR | PS2_LSTS_ACKERR
> |
> +                       PS2_LSTS_PARERR | PS2_LSTS_RXTDO;
> +               writel(rval, drvdata->reg_base + PS2_REG_LSTS);
> +               error = 1;
> +       }
> +
> +       /*Check FIFO Status Register*/
> +       if (fifo_status & 0x0606) {
> +               if (fifo_status & PS2_FSTS_TXUF)
> +                       dev_info(drvdata->dev, "PS/2 Tx FIFO
> Underflow!\n");
> +               if (fifo_status & PS2_FSTS_TXOF)
> +                       dev_info(drvdata->dev, "PS/2 Tx FIFO Overflow!\n");
> +               if (fifo_status & PS2_FSTS_RXUF)
> +                       dev_info(drvdata->dev, "PS/2 Rx FIFO
> Underflow!\n");
> +               if (fifo_status & PS2_FSTS_RXOF)
> +                       dev_info(drvdata->dev, "PS/2 Rx FIFO Overflow!\n");
> +               /*reset PS/2 controller*/
> +               writel(readl(drvdata->reg_base + PS2_REG_GCTL) |
> PS2_GCTL_RESET,
> +                       drvdata->reg_base + PS2_REG_GCTL);
> +
> +               rval = PS2_FSTS_TXUF | PS2_FSTS_TXOF | PS2_FSTS_TXRDY |
> +                       PS2_FSTS_RXUF | PS2_FSTS_RXOF | PS2_FSTS_RXRDY;
> +               writel(rval, drvdata->reg_base + PS2_REG_FSTS);
> +               error = 1;
> +       }
> +
> +       rval = (fifo_status >> 16) & 0x3;
> +       while (!error && rval--) {
> +               byte = readl(drvdata->reg_base + PS2_REG_DATA) & 0xff;
> +               /* dev_info(drvdata->dev, "PS/2 Receive %02x\n", byte); */
> +               serio_interrupt(drvdata->serio, byte, 0);
> +       }
> +
> +       writel(intr_status, drvdata->reg_base + PS2_REG_LSTS);
> +       writel(fifo_status, drvdata->reg_base + PS2_REG_FSTS);
> +
> +       spin_unlock(&drvdata->lock);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +
> +static int sunxips2_open(struct serio *pserio)
> +{
> +       struct sunxips2data *drvdata = pserio->port_data;
> +       u32 src_clk = 0;
> +       u32 clk_scdf;
> +       u32 clk_pcdf;
> +       u32 rval;
> +
> +       /*Set Line Control And Enable Interrupt*/
> +       rval = PS2_LCTL_TXDTOEN | PS2_LCTL_STOPERREN | PS2_LCTL_ACKERREN
> +               | PS2_LCTL_PARERREN | PS2_LCTL_RXDTOEN;
> +       writel(rval, drvdata->reg_base + PS2_REG_LCTL);
> +
> +       /*Reset FIFO*/
> +       rval =
> PS2_FCTL_TXRST|PS2_FCTL_RXRST|PS2_FCTL_TXUFIEN|PS2_FCTL_TXOFIEN
> +               |PS2_FCTL_RXUFIEN|PS2_FCTL_RXOFIEN|PS2_FCTL_RXRDYIEN;
> +       writel(rval, drvdata->reg_base + PS2_REG_FCTL);
> +
> +       src_clk = clk_get_rate(drvdata->clk);
> +
> +       if (!src_clk) {
> +               dev_info(drvdata->dev, "w_ps2c_set_sclk error, source
> clock is 0.");
> +               return -1;
> +       }

Ohh, I missed this!!. I'll  modify to return proper error code here.

> +
> +       /*Set Clock Divider Register*/
> +       clk_scdf = DIV_ROUND_UP(src_clk, PS2_SAMPLE_CLK) - 1;
> +       clk_pcdf = DIV_ROUND_UP(PS2_SAMPLE_CLK, PS2_SCLK) - 1;
> +       rval = (clk_scdf<<8) | clk_pcdf;
> +       writel(rval, drvdata->reg_base + PS2_REG_CLKDR);
> +
> +       /*Set Global Control Register*/
> +       rval = PS2_GCTL_RESET | PS2_GCTL_INTEN | PS2_GCTL_MASTER
> +               | PS2_GCTL_BUSEN;
> +       writel(rval, drvdata->reg_base + PS2_REG_GCTL);
> +
> +       return 0;
> +}
> +
> +static void sunxips2_close(struct serio *pserio)
> +{
> +       struct sunxips2data *drvdata = pserio->port_data;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +       /* Disable the PS2 interrupts */
> +       writel(0, drvdata->reg_base + PS2_REG_GCTL);
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +}
> +
> +static int sunxips2_write(struct serio *pserio, unsigned char val)
> +{
> +       unsigned long expire = jiffies + msecs_to_jiffies(10000);
> +       struct sunxips2data *drvdata = (struct sunxips2data
> *)pserio->port_data;
> +
> +       do {
> +               if (readl(drvdata->reg_base + PS2_REG_FSTS) &
> PS2_FSTS_TXRDY) {
> +                       writel(val, drvdata->reg_base + PS2_REG_DATA);
> +                       return 0;
> +               }
> +       } while (time_before(jiffies, expire));
> +
> +       return 0;
> +}
> +
> +static int sunxips2_probe(struct platform_device *pdev)
> +{
> +       struct resource *res; /* IO mem resources */
> +       struct sunxips2data *drvdata;
> +       struct serio *serio;
> +       struct device *dev = &pdev->dev;
> +       unsigned int irq;
> +       int error;
> +
> +       drvdata = devm_kzalloc(dev, sizeof(struct sunxips2data),
> GFP_KERNEL);
> +       serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
> +       if (!drvdata || !serio) {
> +               error = -ENOMEM;
> +               goto err_free_mem;
> +       }
> +
> +       spin_lock_init(&drvdata->lock);
> +
> +       /* IO */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       drvdata->reg_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(drvdata->reg_base)) {
> +               dev_err(dev, "failed to map registers\n");
> +               error = PTR_ERR(drvdata->reg_base);
> +               goto err_free_mem;
> +       }
> +
> +       drvdata->clk = devm_clk_get(dev, NULL);
> +       if (!IS_ERR(drvdata->clk)) {
> +               error = clk_prepare_enable(drvdata->clk);
> +               if (error < 0) {
> +                       dev_err(dev, "failed to enable clock %d\n", error);
> +                       goto err_free_mem;
> +               }
> +       } else {
> +               error = PTR_ERR(drvdata->clk);
> +               dev_err(dev, "couldn't get clock %d\n", error);
> +               goto err_free_mem;
> +       }
> +
> +       serio->id.type = SERIO_8042;
> +       serio->write = sunxips2_write;
> +       serio->open = sunxips2_open;
> +       serio->close = sunxips2_close;
> +       serio->port_data = drvdata;
> +       serio->dev.parent = dev;
> +       strlcpy(serio->name, dev_name(dev), sizeof(serio->name));
> +       strlcpy(serio->phys, dev_name(dev), sizeof(serio->phys));
> +
> +       /* Get IRQ for the device */
> +       irq = platform_get_irq(pdev, 0);
> +       if (!irq) {
> +               dev_err(dev, "no IRQ found\n");
> +               error = -ENXIO;
> +               goto error_disable_clk;
> +       }
> +
> +       drvdata->irq = irq;
> +       drvdata->serio = serio;
> +       drvdata->dev = dev;
> +       error = devm_request_threaded_irq(dev, drvdata->irq,
> +               sunxips2_interrupt, NULL, 0, DRIVER_NAME, drvdata);
> +
> +       if (error) {
> +               dev_err(drvdata->dev, "Interrupt alloc failed
> %d:error:%d\n",
> +                       drvdata->irq, error);
> +               goto error_disable_clk;
> +       }
> +
> +       serio_register_port(serio);
> +       platform_set_drvdata(pdev, drvdata);
> +
> +       return 0;       /* success */
> +
> +error_disable_clk:
> +       clk_disable_unprepare(drvdata->clk);
> +
> +err_free_mem:
> +       kfree(serio);
> +       return error;
> +}
> +
> +static int sunxips2_remove(struct platform_device *pdev)
> +{
> +       struct sunxips2data *drvdata = platform_get_drvdata(pdev);
> +
> +       serio_unregister_port(drvdata->serio);
> +       disable_irq(drvdata->irq);
> +
> +       if (!IS_ERR(drvdata->clk))
> +               clk_disable_unprepare(drvdata->clk);
> +       kfree(drvdata->serio);
> +
> +       return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id sunxips2_of_match[] = {
> +       { .compatible = "allwinner,sun7i-a20-ps2", },
> +       { .compatible = "allwinner,sun4i-a10-ps2", },
> +       { },
> +};
> +
> +MODULE_DEVICE_TABLE(of, sunxips2_of_match);
> +
> +/*platform driver structure*/
> +static struct platform_driver sunxips2_of_driver = {
> +       .probe          = sunxips2_probe,
> +       .remove         = sunxips2_remove,
> +       .driver = {
> +               .name = DRIVER_NAME,
> +               .of_match_table = sunxips2_of_match,
> +       },
> +};
> +module_platform_driver(sunxips2_of_driver);
> +
> +MODULE_AUTHOR("Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:;>
> >");
> +MODULE_AUTHOR("Aaron.maoye <leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org <javascript:;>>");
> +MODULE_DESCRIPTION("Sunxi PS/2 driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5
>
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--f46d04388df1a889cc0509ad1167
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 7, 2014, vishnupatekar &lt;<a href=3D"mailto:vi=
shnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">=C2=A0-added compatible as allwinner,sun4i-a10=
-ps2 and allwinner,sun7i-a20-ps2.<br>
=C2=A0- added default n depends on ARCH_SUNXI || COMPILE_TEST<br>
=C2=A0in Kconfig.<br>
=C2=A0-handled errors and free resources on errors.<br>
=C2=A0-used BIT(x), DIV_ROUND_UP macros.<br>
=C2=A0-corrected style errors.<br>
<br>
Signed-off-by: vishnupatekar &lt;<a href=3D"javascript:;" onclick=3D"_e(eve=
nt, &#39;cvml&#39;, &#39;VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)">VishnuPatekar05=
10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/input/serio/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A010 ++<br=
>
=C2=A0drivers/input/serio/Makefile=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/input/serio/sunxi-ps2.c |=C2=A0 364 +++++++++++++++++++++++++=
++++++++++++++<br>
=C2=A03 files changed, 375 insertions(+)<br>
=C2=A0create mode 100644 drivers/input/serio/sunxi-ps2.c<br>
<br>
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig<br>
index bc2d474..3a7599c 100644<br>
--- a/drivers/input/serio/Kconfig<br>
+++ b/drivers/input/serio/Kconfig<br>
@@ -281,4 +281,14 @@ config HYPERV_KEYBOARD<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choo=
se M here: the module will<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be called hyperv_keyboard.<br>
<br>
+config SERIO_SUNXI_PS2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;Allwinner Sun4i-A10/Sun7i-A20 PS=
/2 controller&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default n<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_SUNXI || COMPILE_TEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you have Sun4i-A10/Sun7i-A=
20 Allwinner PS/2 ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choo=
se M here: the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called sunxi-ps2.<br>
+<br>
=C2=A0endif<br>
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile<br=
>
index 815d874..0fa0f78 100644<br>
--- a/drivers/input/serio/Makefile<br>
+++ b/drivers/input/serio/Makefile<br>
@@ -29,3 +29,4 @@ obj-$(CONFIG_SERIO_ARC_PS2)=C2=A0 =C2=A0+=3D arc_ps2.o<br=
>
=C2=A0obj-$(CONFIG_SERIO_APBPS2)=C2=A0 =C2=A0 =C2=A0+=3D apbps2.o<br>
=C2=A0obj-$(CONFIG_SERIO_OLPC_APSP)=C2=A0 +=3D olpc_apsp.o<br>
=C2=A0obj-$(CONFIG_HYPERV_KEYBOARD)=C2=A0 +=3D hyperv-keyboard.o<br>
+obj-$(CONFIG_SERIO_SUNXI_PS2)=C2=A0 +=3D sunxi-ps2.o<br>
diff --git a/drivers/input/serio/sunxi-ps2.c b/drivers/input/serio/sunxi-ps=
2.c<br>
new file mode 100644<br>
index 0000000..4cd89ae<br>
--- /dev/null<br>
+++ b/drivers/input/serio/sunxi-ps2.c<br>
@@ -0,0 +1,364 @@<br>
+/*<br>
+ *=C2=A0 =C2=A0 =C2=A0Driver for Allwinner A20 PS2 host controller<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0Author: Vishnu Patekar &lt;<a href=3D"javascript:;" =
onclick=3D"_e(event, &#39;cvml&#39;, &#39;vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)=
">vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aaron.maoye &lt;<a href=
=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;leafy.myeh@newb=
ietech.com&#39;)">leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org</a>&gt;<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Based on 3.0 kernel<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/serio.h&gt;<br>
+#include &lt;linux/interrupt.h&gt;<br>
+#include &lt;linux/errno.h&gt;<br>
+#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/list.h&gt;<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/of_address.h&gt;<br>
+#include &lt;linux/of_device.h&gt;<br>
+#include &lt;linux/of_irq.h&gt;<br>
+#include &lt;linux/of_platform.h&gt;<br>
+#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+<br>
+#define DRIVER_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sunxi-p=
s2&quot;<br>
+<br>
+/* register offset definitions */<br>
+#define PS2_REG_GCTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00)=C2=A0 =
/*=C2=A0 PS2 Module Global Control Reg */<br>
+#define PS2_REG_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x04)=C2=A0 =
/*=C2=A0 PS2 Module Data Reg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+#define PS2_REG_LCTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x08)=C2=A0 =
/*=C2=A0 PS2 Module Line Control Reg */<br>
+#define PS2_REG_LSTS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0C)=C2=A0 =
/*=C2=A0 PS2 Module Line Status Reg=C2=A0 */<br>
+#define PS2_REG_FCTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x10)=C2=A0 =
/*=C2=A0 PS2 Module FIFO Control Reg */<br>
+#define PS2_REG_FSTS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x14)=C2=A0 =
/*=C2=A0 PS2 Module FIFO Status Reg=C2=A0 */<br>
+#define PS2_REG_CLKDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x18)=C2=A0 /*=C2=
=A0 PS2 Module Clock Divider Reg*/<br>
+<br>
+/*=C2=A0 PS2 GLOBAL CONTROL REGISTER PS2_GCTL */<br>
+#define PS2_GCTL_INTFLAG=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(4)<br>
+#define PS2_GCTL_INTEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(3)<br>
+#define PS2_GCTL_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(2)<br>
+#define PS2_GCTL_MASTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BIT(1)<br>
+#define PS2_GCTL_BUSEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+<br>
+/* PS2 LINE CONTROL REGISTER */<br>
+#define PS2_LCTL_NOACK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(18)<br>
+#define PS2_LCTL_TXDTOEN=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(8)<br>
+#define PS2_LCTL_STOPERREN=C2=A0 =C2=A0 =C2=A0BIT(3)<br>
+#define PS2_LCTL_ACKERREN=C2=A0 =C2=A0 =C2=A0 BIT(2)<br>
+#define PS2_LCTL_PARERREN=C2=A0 =C2=A0 =C2=A0 BIT(1)<br>
+#define PS2_LCTL_RXDTOEN=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+<br>
+/* PS2 LINE STATUS REGISTER */<br>
+#define PS2_LSTS_TXTDO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(8)<br>
+#define PS2_LSTS_STOPERR=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(3)<br>
+#define PS2_LSTS_ACKERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BIT(2)<br>
+#define PS2_LSTS_PARERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BIT(1)<br>
+#define PS2_LSTS_RXTDO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+<br>
+/* PS2 FIFO CONTROL REGISTER */<br>
+#define PS2_FCTL_TXRST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(17)<br>
+#define PS2_FCTL_RXRST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(16)<br>
+#define PS2_FCTL_TXUFIEN=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(10)<br>
+#define PS2_FCTL_TXOFIEN=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(9)<br>
+#define PS2_FCTL_TXRDYIEN=C2=A0 =C2=A0 =C2=A0 BIT(8)<br>
+#define PS2_FCTL_RXUFIEN=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(2)<br>
+#define PS2_FCTL_RXOFIEN=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(1)<br>
+#define PS2_FCTL_RXRDYIEN=C2=A0 =C2=A0 =C2=A0 BIT(0)<br>
+<br>
+/* PS2 FIFO STATUS REGISTER */<br>
+#define PS2_FSTS_TXUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(10)<br>
+#define PS2_FSTS_TXOF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(9)<br>
+#define PS2_FSTS_TXRDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(8)<br>
+#define PS2_FSTS_RXUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(2)<br>
+#define PS2_FSTS_RXOF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(1)<br>
+#define PS2_FSTS_RXRDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+<br>
+<br>
+#define PS2_LINE_ERROR_BIT \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0(PS2_LSTS_TXTDO|PS2_LSTS_STOPERR|PS2_LSTS_ACKER=
R| \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0PS2_LSTS_PARERR|PS2_LSTS_RXTDO)<br>
+<br>
+#define PS2_FIFO_ERROR_BIT \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0(PS2_FSTS_TXUF|PS2_FSTS_TXOF|PS2_FSTS_TXRDY|PS2=
_FSTS_RXUF| \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0PS2_FSTS_RXOF|PS2_FSTS_RXRDY)<br>
+<br>
+#define PS2_SAMPLE_CLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1000000)<br>
+#define PS2_SCLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(12=
5000)<br>
+<br>
+struct sunxips2data {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct serio *serio;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* IO mapping base */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 *reg_base;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* clock management */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 *clk;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* irq */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t=C2=A0 =C2=A0 =C2=A0 lock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0irq;<br>
+};<br>
+<br>
+/*********************/<br>
+/* Interrupt handler */<br>
+/*********************/<br>
+static irqreturn_t sunxips2_interrupt(int irq, void *dev_id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D dev_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 intr_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 fifo_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char byte;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 rval;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 error =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;drvdata-&gt;lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the PS/2 interrupts and clear them */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0intr_status=C2=A0 =3D readl(drvdata-&gt;reg_bas=
e + PS2_REG_LSTS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fifo_status=C2=A0 =3D readl(drvdata-&gt;reg_bas=
e + PS2_REG_FSTS);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*Check Line Status Register*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &amp; 0x10f) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &am=
p; PS2_LSTS_STOPERR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Stop Bit Error!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &am=
p; PS2_LSTS_ACKERR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Acknowledge Error!\n&quot;);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &am=
p; PS2_LSTS_PARERR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Parity Error!\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &am=
p; PS2_LSTS_TXTDO)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Transmit Data Timeout!\n&quo=
t;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &am=
p; PS2_LSTS_RXTDO)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Receive Data Timeout!\n&quot=
;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*reset PS/2 contro=
ller*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(readl(drvdat=
a-&gt;reg_base + PS2_REG_GCTL) | PS2_GCTL_RESET,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drvdata-&gt;reg_base + PS2_REG_GCTL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D PS2_LSTS_T=
XTDO | PS2_LSTS_STOPERR | PS2_LSTS_ACKERR |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PS2_LSTS_PARERR | PS2_LSTS_RXTDO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(rval, drvdat=
a-&gt;reg_base + PS2_REG_LSTS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*Check FIFO Status Register*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &amp; 0x0606) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &am=
p; PS2_FSTS_TXUF)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Tx FIFO Underflow!\n&quot;);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &am=
p; PS2_FSTS_TXOF)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Tx FIFO Overflow!\n&quot;);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &am=
p; PS2_FSTS_RXUF)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Rx FIFO Underflow!\n&quot;);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &am=
p; PS2_FSTS_RXOF)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Rx FIFO Overflow!\n&quot;);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*reset PS/2 contro=
ller*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(readl(drvdat=
a-&gt;reg_base + PS2_REG_GCTL) | PS2_GCTL_RESET,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drvdata-&gt;reg_base + PS2_REG_GCTL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D PS2_FSTS_T=
XUF | PS2_FSTS_TXOF | PS2_FSTS_TXRDY |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PS2_FSTS_RXUF | PS2_FSTS_RXOF | PS2_FSTS_RXRDY;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(rval, drvdat=
a-&gt;reg_base + PS2_REG_FSTS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D (fifo_status &gt;&gt; 16) &amp; 0x3;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (!error &amp;&amp; rval--) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0byte =3D readl(drvd=
ata-&gt;reg_base + PS2_REG_DATA) &amp; 0xff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* dev_info(drvdata=
-&gt;dev, &quot;PS/2 Receive %02x\n&quot;, byte); */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serio_interrupt(drv=
data-&gt;serio, byte, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(intr_status, drvdata-&gt;reg_base + PS2_=
REG_LSTS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(fifo_status, drvdata-&gt;reg_base + PS2_=
REG_FSTS);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;drvdata-&gt;lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
+}<br>
+<br>
+<br>
+static int sunxips2_open(struct serio *pserio)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D pserio-&gt;por=
t_data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 src_clk =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 clk_scdf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 clk_pcdf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 rval;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*Set Line Control And Enable Interrupt*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D PS2_LCTL_TXDTOEN | PS2_LCTL_STOPERREN =
| PS2_LCTL_ACKERREN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| PS2_LCTL_PARERREN=
 | PS2_LCTL_RXDTOEN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(rval, drvdata-&gt;reg_base + PS2_REG_LCT=
L);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*Reset FIFO*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D PS2_FCTL_TXRST|PS2_FCTL_RXRST|PS2_FCTL=
_TXUFIEN|PS2_FCTL_TXOFIEN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|PS2_FCTL_RXUFIEN|P=
S2_FCTL_RXOFIEN|PS2_FCTL_RXRDYIEN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(rval, drvdata-&gt;reg_base + PS2_REG_FCT=
L);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0src_clk =3D clk_get_rate(drvdata-&gt;clk);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!src_clk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(drvdata-&g=
t;dev, &quot;w_ps2c_set_sclk error, source clock is 0.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}</blockquote><div>Ohh, I missed this!!. I&#39;=
ll =C2=A0modify to return proper error code here.</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*Set Clock Divider Register*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_scdf =3D DIV_ROUND_UP(src_clk, PS2_SAMPLE_C=
LK) - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_pcdf =3D DIV_ROUND_UP(PS2_SAMPLE_CLK, PS2_S=
CLK) - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D (clk_scdf&lt;&lt;8) | clk_pcdf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(rval, drvdata-&gt;reg_base + PS2_REG_CLK=
DR);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*Set Global Control Register*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rval =3D PS2_GCTL_RESET | PS2_GCTL_INTEN | PS2_=
GCTL_MASTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| PS2_GCTL_BUSEN;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(rval, drvdata-&gt;reg_base + PS2_REG_GCT=
L);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static void sunxips2_close(struct serio *pserio)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D pserio-&gt;por=
t_data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;drvdata-&gt;lock, flags)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable the PS2 interrupts */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(0, drvdata-&gt;reg_base + PS2_REG_GCTL);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;drvdata-&gt;lock, f=
lags);<br>
+}<br>
+<br>
+static int sunxips2_write(struct serio *pserio, unsigned char val)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long expire =3D jiffies + msecs_to_jif=
fies(10000);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D (struct sunxip=
s2data *)pserio-&gt;port_data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (readl(drvdata-&=
gt;reg_base + PS2_REG_FSTS) &amp; PS2_FSTS_TXRDY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0writel(val, drvdata-&gt;reg_base + PS2_REG_DATA);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (time_before(jiffies, expire));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int sunxips2_probe(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *res; /* IO mem resources */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct serio *serio;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int irq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int error;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drvdata =3D devm_kzalloc(dev, sizeof(struct sun=
xips2data), GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio =3D kzalloc(sizeof(struct serio), GFP_KER=
NEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drvdata || !serio) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D -ENOMEM;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_mem;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;drvdata-&gt;lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* IO */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESOURCE_=
MEM, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drvdata-&gt;reg_base =3D devm_ioremap_resource(=
dev, res);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(drvdata-&gt;reg_base)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
failed to map registers\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D PTR_ERR(d=
rvdata-&gt;reg_base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_mem;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drvdata-&gt;clk =3D devm_clk_get(dev, NULL);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ERR(drvdata-&gt;clk)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D clk_prepa=
re_enable(drvdata-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error &lt; 0) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(dev, &quot;failed to enable clock %d\n&quot;, error);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto err_free_mem;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D PTR_ERR(d=
rvdata-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
couldn&#39;t get clock %d\n&quot;, error);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_mem;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio-&gt;id.type =3D SERIO_8042;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio-&gt;write =3D sunxips2_write;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio-&gt;open =3D sunxips2_open;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio-&gt;close =3D sunxips2_close;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio-&gt;port_data =3D drvdata;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio-&gt;dev.parent =3D dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0strlcpy(serio-&gt;name, dev_name(dev), sizeof(s=
erio-&gt;name));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0strlcpy(serio-&gt;phys, dev_name(dev), sizeof(s=
erio-&gt;phys));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get IRQ for the device */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D platform_get_irq(pdev, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!irq) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
no IRQ found\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D -ENXIO;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_disable_=
clk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drvdata-&gt;irq =3D irq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drvdata-&gt;serio =3D serio;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drvdata-&gt;dev =3D dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D devm_request_threaded_irq(dev, drvdat=
a-&gt;irq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sunxips2_interrupt,=
 NULL, 0, DRIVER_NAME, drvdata);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (error) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(drvdata-&gt=
;dev, &quot;Interrupt alloc failed %d:error:%d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drvdata-&gt;irq, error);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_disable_=
clk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio_register_port(serio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, drvdata);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* success =
*/<br>
+<br>
+error_disable_clk:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(drvdata-&gt;clk);<br>
+<br>
+err_free_mem:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(serio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return error;<br>
+}<br>
+<br>
+static int sunxips2_remove(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D platform_get_d=
rvdata(pdev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0serio_unregister_port(drvdata-&gt;serio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disable_irq(drvdata-&gt;irq);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ERR(drvdata-&gt;clk))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepa=
re(drvdata-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(drvdata-&gt;serio);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+/* Match table for of_platform binding */<br>
+static const struct of_device_id sunxips2_of_match[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;allwinner,sun7i-a20-ps2=
&quot;, },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;allwinner,sun4i-a10-ps2=
&quot;, },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ },<br>
+};<br>
+<br>
+MODULE_DEVICE_TABLE(of, sunxips2_of_match);<br>
+<br>
+/*platform driver structure*/<br>
+static struct platform_driver sunxips2_of_driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D su=
nxips2_probe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D su=
nxips2_remove,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D DRIVER_NA=
ME,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D=
 sunxips2_of_match,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+module_platform_driver(sunxips2_of_driver);<br>
+<br>
+MODULE_AUTHOR(&quot;Vishnu Patekar &lt;<a href=3D"javascript:;" onclick=3D=
"_e(event, &#39;cvml&#39;, &#39;vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)">vishnupa=
tekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&quot;);<br>
+MODULE_AUTHOR(&quot;Aaron.maoye &lt;<a href=3D"javascript:;" onclick=3D"_e=
(event, &#39;cvml&#39;, &#39;leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org&#39;)">leafy.myeh@ne=
wbietech.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;Sunxi PS/2 driver&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
--<br>
1.7.9.5<br>
<br>
</blockquote>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--f46d04388df1a889cc0509ad1167--
