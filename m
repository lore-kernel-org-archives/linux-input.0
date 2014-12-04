From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers:input:ps2 Added sunxi A20 ps2
 driver, changed makefile and Kconfig
Date: Thu, 4 Dec 2014 08:38:52 +0530
Message-ID: <CAEzqOZv9Qnz1zjqk7+OwCmrMonb8shCcdTzmHG3SZSedyEt5qg@mail.gmail.com>
References: <1417647224-27950-1-git-send-email-VishnuPatekar0510@gmail.com>
	<20141203232334.GG16951@dtor-ws>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=f46d041825e8ae080b05095b4715
Return-path: <linux-sunxi+bncBD64TFVR3YIBBRNA76RQKGQEQ7ZR5EY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141203232334.GG16951@dtor-ws>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare-l3A5Bk7waGM@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--f46d041825e8ae080b05095b4715
Content-Type: text/plain; charset=UTF-8

Hello Dmitry,
Thank you for comments.

I'll implement these comments and resend it for review.

On Thursday, December 4, 2014, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On Thu, Dec 04, 2014 at 04:23:44AM +0530, vishnupatekar wrote:
> > ---
> >  drivers/input/serio/Kconfig     |    9 ++
> >  drivers/input/serio/Makefile    |    1 +
> >  drivers/input/serio/sunxi-ps2.c |  305
> +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 315 insertions(+)
> >  create mode 100644 drivers/input/serio/sunxi-ps2.c
> >
> > diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> > index bc2d474..1a86e41 100644
> > --- a/drivers/input/serio/Kconfig
> > +++ b/drivers/input/serio/Kconfig
> > @@ -281,4 +281,13 @@ config HYPERV_KEYBOARD
> >         To compile this driver as a module, choose M here: the module
> will
> >         be called hyperv_keyboard.
> >
> > +config SERIO_SUNXI_PS2
> > +     tristate "Allwinner Sun7i-A20 PS/2 controller"
> > +     default m
>
> Why default m? Default should be n. Also it seems it has to depend on
> OF. And what about depending on <arch> || COMPILE_TEST?
>
> > +     help
> > +       Say Y here if you have Sun7i-A20 Allwinner PS/2 ports.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called sunxi-ps2.
> > +
> >  endif
> > diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> > index 815d874..0fa0f78 100644
> > --- a/drivers/input/serio/Makefile
> > +++ b/drivers/input/serio/Makefile
> > @@ -29,3 +29,4 @@ obj-$(CONFIG_SERIO_ARC_PS2) += arc_ps2.o
> >  obj-$(CONFIG_SERIO_APBPS2)   += apbps2.o
> >  obj-$(CONFIG_SERIO_OLPC_APSP)        += olpc_apsp.o
> >  obj-$(CONFIG_HYPERV_KEYBOARD)        += hyperv-keyboard.o
> > +obj-$(CONFIG_SERIO_SUNXI_PS2)        += sunxi-ps2.o
> > diff --git a/drivers/input/serio/sunxi-ps2.c
> b/drivers/input/serio/sunxi-ps2.c
> > new file mode 100644
> > index 0000000..ccd7b29
> > --- /dev/null
> > +++ b/drivers/input/serio/sunxi-ps2.c
> > @@ -0,0 +1,305 @@
> > +/*
> > + * sunxi-ps2.c Support for Allwinner A20 PS2 host controller
>
> No file names in sources please.
>
> > + *
> > + * Author: Aaron.maoye <leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org <javascript:;>>
> > + *      Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:;>>
> > + * Based on sunxi-ps2.c 3.0 kernel
> > + *
> > +*/
> > +
> > +#include <linux/module.h>
> > +#include <linux/serio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/errno.h>
> > +#include <linux/slab.h>
> > +#include <linux/list.h>
> > +#include <linux/io.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +
> > +#define DRIVER_NAME          "sunxi-ps2"
> > +
> > +#define RESSIZE(res)        (((res)->end - (res)->start)+1)
>
> I am sure we have something generic for it, no?
>
> > +
> > +#define SW_PS2_GCTRL        (0x00)
> > +#define SW_PS2_DATA         (0x04)
> > +#define SW_PS2_LCTRL        (0x08)
> > +#define SW_PS2_LSTAT        (0x0c)
> > +#define SW_PS2_FCTRL        (0x10)
> > +#define SW_PS2_FSTAT        (0x14)
> > +#define SW_PS2_CLKDR        (0x18)
> > +
> > +/* SW_PS2_GCTRL */
> > +#define SWPS2_BUSEN         (1 << 0)
> > +#define SWPS2_MASTER        (1 << 1)
> > +#define SWPS2_RESET         (1 << 2)
> > +#define SWPS2_INTEN         (1 << 3)
> > +#define SWPS2_INTFLAG       (1 << 3)
> > +
> > +/* SW_PS2_LCTRL */
> > +#define SWPS2_LCTL_NOACK        (0x0 << 18)
> > +#define SWPS2_LCTL_TXDTOEN      (0x1 << 8)
> > +#define SWPS2_LCTL_STOPERREN    (0x1 << 3)
> > +#define SWPS2_LCTL_ACKERREN     (0x1 << 2)
> > +#define SWPS2_LCTL_PARERREN     (0x1 << 1)
> > +#define SWPS2_LCTL_RXDTOEN      (0x1 << 0)
> > +
> > +/* SW_PS2_FSTAT */
> > +#define SWPS2_FSTA_RXRDY        (1 << 0)
> > +#define SWPS2_FSTA_RXOF         (1 << 1)
> > +#define SWPS2_FSTA_RXUF         (1 << 2)
> > +#define SWPS2_FSTA_TXRDY        (1 << 8)
> > +#define SWPS2_FSTA_TXOF         (1 << 9)
> > +#define SWPS2_FSTA_TXUF         (1 << 10)
> > +
> > +#define SW_PS2_SAMPLE_CLK      (1000000)
> > +#define SW_PS2_SCLK            (125000)
> > +
> > +struct sunxips2data {
> > +     int irq;
> > +     spinlock_t ps2_lock;
> > +     void __iomem *base_address;     /* virt address of control
> registers*/
> > +     struct serio *serio;            /* serio*/
> > +     struct device *dev;
> > +     struct  clk     *pclk;
> > +};
> > +
> > +/*********************/
> > +/* Interrupt handler */
> > +/*********************/
> > +static irqreturn_t sunxips2_interrupt(int irq, void *dev_id)
> > +{
> > +     struct sunxips2data *drvdata = dev_id;
> > +     u32 intr_status;
> > +     u32 fifo_status;
> > +     unsigned char byte;
> > +     u32 rval;
> > +     u32 error = 0;
> > +
> > +     spin_lock(&drvdata->ps2_lock);
> > +
> > +     /* Get the PS/2 interrupts and clear them */
> > +     intr_status  = readl(drvdata->base_address + SW_PS2_LSTAT);
> > +     fifo_status  = readl(drvdata->base_address + SW_PS2_FSTAT);
> > +
> > +     /*Check Line Status Register*/
> > +     if (intr_status & 0x10f) {
> > +             if (intr_status & 0x08)
> > +                     dev_info(drvdata->dev, "PS/2 Stop Bit Error!");
> > +             if (intr_status & 0x04)
> > +                     dev_info(drvdata->dev, "PS/2 Acknowledge
> Error!\n");
> > +             if (intr_status & 0x02)
> > +                     dev_info(drvdata->dev, "PS/2 Parity Error!\n");
> > +             if (intr_status & 0x100)
> > +                     dev_info(drvdata->dev, "PS/2 Transmit Data
> Timeout!\n");
> > +             if (intr_status & 0x01)
> > +                     dev_info(drvdata->dev, "PS/2 Receive Data
> Timeout!\n");
> > +
> > +             writel(readl(drvdata->base_address + SW_PS2_GCTRL)|0x4,
> drvdata->base_address + SW_PS2_GCTRL);/*reset PS/2 controller*/
> > +             writel(0x10f, drvdata->base_address + SW_PS2_LSTAT);
> > +
> > +             error = 1;
> > +     }
> > +
> > +    /*Check FIFO Status Register*/
> > +     if (fifo_status & 0x0606) {
> > +             if (fifo_status & 0x400)
> > +                     dev_info(drvdata->dev, "PS/2 Tx FIFO
> Underflow!\n");
> > +             if (fifo_status & 0x200)
> > +                     dev_info(drvdata->dev, "PS/2 Tx FIFO Overflow!\n");
> > +             if (fifo_status & 0x04)
> > +                     dev_info(drvdata->dev, "PS/2 Rx FIFO
> Underflow!\n");
> > +             if (fifo_status & 0x02)
> > +                     dev_info(drvdata->dev, "PS/2 Rx FIFO Overflow!\n");
> > +
> > +             writel(readl(drvdata->base_address + SW_PS2_GCTRL)|0x4,
> drvdata->base_address + SW_PS2_GCTRL); /*reset PS/2 controller*/
> > +             writel(0x707, drvdata->base_address + SW_PS2_FSTAT);
> > +             error = 1;
> > +     }
> > +
> > +     rval = (fifo_status >> 16) & 0x3;
> > +     while (!error && rval--) {
> > +             byte = readl(drvdata->base_address + SW_PS2_DATA) & 0xff;
> > +             dev_info(drvdata->dev, "PS/2 Receive %02x\n", byte);
>
> You really want to log every input byte in the logs?
>
> > +             serio_interrupt(drvdata->serio, byte, 0);
> > +     }
> > +
> > +     writel(intr_status, drvdata->base_address + SW_PS2_LSTAT);
> > +     writel(fifo_status, drvdata->base_address + SW_PS2_FSTAT);
> > +
> > +     spin_unlock(&drvdata->ps2_lock);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int sunxips2_open(struct serio *pserio)
> > +{
> > +     struct sunxips2data *drvdata = pserio->port_data;
> > +     u32 src_clk = 0;
> > +     u32 clk_scdf;
> > +     u32 clk_pcdf;
> > +     u32 rval;
> > +
> > +     /*Set Line Control And Enable Interrupt*/
> > +     rval =
> SWPS2_LCTL_TXDTOEN|SWPS2_LCTL_STOPERREN|SWPS2_LCTL_ACKERREN|SWPS2_LCTL_PARERREN|SWPS2_LCTL_RXDTOEN;
> > +     writel(rval, drvdata->base_address + SW_PS2_LCTRL);
> > +
> > +     /*Reset FIFO*/
> > +     writel(0x3<<16 | 0x607, drvdata->base_address + SW_PS2_FCTRL);
> > +
> > +     src_clk = clk_get_rate(drvdata->pclk);
> > +
> > +     if (!src_clk) {
> > +             dev_info(drvdata->dev, "w_ps2c_set_sclk error, source
> clock is 0.");
> > +             return -1;
> > +     }
> > +
> > +     /*Set Clock Divider Register*/
> > +     clk_scdf = ((src_clk + (SW_PS2_SAMPLE_CLK>>1)) / SW_PS2_SAMPLE_CLK
> - 1);
> > +     clk_pcdf = ((SW_PS2_SAMPLE_CLK + (SW_PS2_SCLK>>1)) / SW_PS2_SCLK -
> 1);
> > +     rval = (clk_scdf<<8) | clk_pcdf;/* | (PS2_DEBUG_SEL<<16);*/
> > +     writel(rval, drvdata->base_address + SW_PS2_CLKDR);
> > +
> > +     /*Set Global Control Register*/
> > +     rval = SWPS2_RESET|SWPS2_INTEN|SWPS2_MASTER|SWPS2_BUSEN;
> > +     writel(rval, drvdata->base_address + SW_PS2_GCTRL);
> > +
> > +     udelay(100);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sunxips2_close(struct serio *pserio)
> > +{
> > +     struct sunxips2data *drvdata = pserio->port_data;
> > +
> > +     spin_lock(&drvdata->ps2_lock);
> > +     /* Disable the PS2 interrupts */
> > +     writel(0, drvdata->base_address + SW_PS2_GCTRL);
> > +     spin_unlock(&drvdata->ps2_lock);
> > +}
> > +
> > +static int sunxips2_write(struct serio *pserio, unsigned char val)
> > +{
> > +     struct sunxips2data *drvdata = (struct sunxips2data
> *)pserio->port_data;
> > +     u32 timeout = 10000;
> > +
> > +     do {
> > +             if (readl(drvdata->base_address + SW_PS2_FSTAT) &
> SWPS2_FSTA_TXRDY) {
> > +                     writel(val, drvdata->base_address + SW_PS2_DATA);
> > +                     return 0;
> > +             }
> > +     } while (timeout--);
> > +
> > +     return -1;
> > +}
> > +
> > +static int sunxips2_probe(struct platform_device *ofdev)
> > +{
> > +     struct resource *res; /* IO mem resources */
> > +     struct sunxips2data *drvdata;
> > +     struct serio *serio;
> > +     struct device *dev = &ofdev->dev;
> > +     unsigned int irq;
> > +     int error;
> > +
> > +     drvdata = devm_kzalloc(dev, sizeof(struct sunxips2data),
> GFP_KERNEL);
> > +     serio = devm_kzalloc(dev, sizeof(struct serio), GFP_KERNEL);
>
> serio is a refcounted structure, it should not be allocated with devm.
>
> > +     if (!drvdata || !serio)
> > +             error = -ENOMEM;
>
>                 and...?
>
> > +
> > +     /* Request clock */
> > +     drvdata->pclk = clk_get(dev, NULL);
> > +     if (IS_ERR(drvdata->pclk))
> > +             dev_dbg(dev, "couldn't get clock %li\n",
> > +                     PTR_ERR(drvdata->pclk));
>
> Why %li?
>
> > +
> > +     if (!IS_ERR(drvdata->pclk)) {
>
> "} else {"
>
>
> > +             error = clk_prepare_enable(drvdata->pclk);
> > +             if (error < 0) {
> > +                     dev_err(dev, "failed to enable clock %d\n", error);
> > +                     return error;
>
> Leaking clk here.
>
> > +             }
> > +     }
> > +
> > +     /* IO */
> > +     res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> > +     drvdata->base_address = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(drvdata->base_address)) {
> > +             dev_err(dev, "failed to map registers\n");
> > +             error = PTR_ERR(drvdata->base_address);
>
>                 aaaand...?
>
> > +     }
> > +
> > +     serio->id.type = SERIO_8042;
> > +     serio->write = sunxips2_write;
> > +     serio->open = sunxips2_open;
> > +     serio->close = sunxips2_close;
> > +     serio->port_data = drvdata;
> > +     serio->dev.parent = dev;
> > +     strlcpy(serio->name, dev_name(dev), sizeof(serio->name));
> > +     strlcpy(serio->phys, dev_name(dev), sizeof(serio->phys));
> > +
> > +     platform_set_drvdata(ofdev, drvdata);
> > +     serio_register_port(serio);
> > +
> > +     /* Get IRQ for the device */
> > +     irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> > +     if (!irq) {
> > +             dev_err(dev, "no IRQ found\n");
> > +             return -ENODEV;
>
> Leaking clk and serio here.
>
> > +     }
> > +
> > +     drvdata->irq = irq;
> > +     drvdata->serio = serio;
> > +     drvdata->dev = dev;
> > +     error = devm_request_any_context_irq(drvdata->dev, drvdata->irq,
> &sunxips2_interrupt, 0,
> > +                             DRIVER_NAME, drvdata);
>
> Please try to fit in 80 columns.
>
> > +     if (error) {
> > +             dev_err(drvdata->dev,
> > +                     "Couldn't allocate interrupt %d : error: %d\n",
> drvdata->irq, error);
> > +             return error;
> > +     }
> > +     return 0;               /* success */
> > +}
> > +
> > +static int sunxips2_remove(struct platform_device *of_dev)
> > +{
> > +     struct sunxips2data *drvdata = platform_get_drvdata(of_dev);
> > +
> > +     if (!IS_ERR(drvdata->pclk)) {
> > +             clk_disable_unprepare(drvdata->pclk);
> > +             clk_put(drvdata->pclk);
>
> If serio write comes here what will happen?
>
> > +     }
> > +     serio_unregister_port(drvdata->serio);
>
> If interrupt comes here  what will happen?
>
> > +     mdelay(2);
>
> Why do you need mdelay?
>
> > +     return 0;
> > +}
> > +
> > +/* Match table for of_platform binding */
> > +static const struct of_device_id sunxips2_of_match[] = {
> > +     { .compatible = "allwinner,sun7i-a20-ps2", },
> > +     { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, sunxips2_of_match);
> > +
> > +/*platform driver structure*/
> > +static struct platform_driver sunxips2_of_driver = {
> > +     .probe          = sunxips2_probe,
> > +     .remove         = sunxips2_remove,
> > +     .driver = {
> > +             .name = DRIVER_NAME,
> > +             .owner = THIS_MODULE,
> > +             .of_match_table = sunxips2_of_match,
> > +     },
> > +};
> > +module_platform_driver(sunxips2_of_driver);
> > +
> > +MODULE_AUTHOR("Aaron.maoye<leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org <javascript:;>, "
>
> Space before "<", closing ">" are missing.
>
> > +             "Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> <javascript:;>>");
> > +MODULE_DESCRIPTION("Sunxi PS/2 driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 1.7.9.5
> >
>
> Thanks.
>
> --
> Dmitry
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org <javascript:;>.
> For more options, visit https://groups.google.com/d/optout.
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--f46d041825e8ae080b05095b4715
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,<div>Thank you for comments.</div><div><br></div><div>I&#39;ll=
 implement these comments and resend it for review.<br><br>On Thursday, Dec=
ember 4, 2014, Dmitry Torokhov &lt;<a href=3D"mailto:dmitry.torokhov@gmail.=
com">dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">On Thu, Dec 04, 2014 at 04:23:44AM +0530, vishnupatekar wrote:<br>
&gt; ---<br>
&gt;=C2=A0 drivers/input/serio/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 =
++<br>
&gt;=C2=A0 drivers/input/serio/Makefile=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 drivers/input/serio/sunxi-ps2.c |=C2=A0 305 ++++++++++++++++++++=
+++++++++++++++++++<br>
&gt;=C2=A0 3 files changed, 315 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/input/serio/sunxi-ps2.c<br>
&gt;<br>
&gt; diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig=
<br>
&gt; index bc2d474..1a86e41 100644<br>
&gt; --- a/drivers/input/serio/Kconfig<br>
&gt; +++ b/drivers/input/serio/Kconfig<br>
&gt; @@ -281,4 +281,13 @@ config HYPERV_KEYBOARD<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, c=
hoose M here: the module will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be called hyperv_keyboard.<br>
&gt;<br>
&gt; +config SERIO_SUNXI_PS2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;Allwinner Sun7i-A20 PS/2 controlle=
r&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default m<br>
<br>
Why default m? Default should be n. Also it seems it has to depend on<br>
OF. And what about depending on &lt;arch&gt; || COMPILE_TEST?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you have Sun7i-A20 Allwinner=
 PS/2 ports.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choose=
 M here: the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called sunxi-ps2.<br>
&gt; +<br>
&gt;=C2=A0 endif<br>
&gt; diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefi=
le<br>
&gt; index 815d874..0fa0f78 100644<br>
&gt; --- a/drivers/input/serio/Makefile<br>
&gt; +++ b/drivers/input/serio/Makefile<br>
&gt; @@ -29,3 +29,4 @@ obj-$(CONFIG_SERIO_ARC_PS2) +=3D arc_ps2.o<br>
&gt;=C2=A0 obj-$(CONFIG_SERIO_APBPS2)=C2=A0 =C2=A0+=3D apbps2.o<br>
&gt;=C2=A0 obj-$(CONFIG_SERIO_OLPC_APSP)=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D ol=
pc_apsp.o<br>
&gt;=C2=A0 obj-$(CONFIG_HYPERV_KEYBOARD)=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D hy=
perv-keyboard.o<br>
&gt; +obj-$(CONFIG_SERIO_SUNXI_PS2)=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D sunxi-p=
s2.o<br>
&gt; diff --git a/drivers/input/serio/sunxi-ps2.c b/drivers/input/serio/sun=
xi-ps2.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..ccd7b29<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/input/serio/sunxi-ps2.c<br>
&gt; @@ -0,0 +1,305 @@<br>
&gt; +/*<br>
&gt; + * sunxi-ps2.c Support for Allwinner A20 PS2 host controller<br>
<br>
No file names in sources please.<br>
<br>
&gt; + *<br>
&gt; + * Author: Aaron.maoye &lt;<a href=3D"javascript:;" onclick=3D"_e(eve=
nt, &#39;cvml&#39;, &#39;leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org&#39;)">leafy.myeh@newbie=
tech.com</a>&gt;<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 Vishnu Patekar &lt;<a href=3D"javascript:;" on=
click=3D"_e(event, &#39;cvml&#39;, &#39;vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)">=
vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; + * Based on sunxi-ps2.c 3.0 kernel<br>
&gt; + *<br>
&gt; +*/<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/serio.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/errno.h&gt;<br>
&gt; +#include &lt;linux/slab.h&gt;<br>
&gt; +#include &lt;linux/list.h&gt;<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/of_address.h&gt;<br>
&gt; +#include &lt;linux/of_device.h&gt;<br>
&gt; +#include &lt;linux/of_irq.h&gt;<br>
&gt; +#include &lt;linux/of_platform.h&gt;<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +<br>
&gt; +#define DRIVER_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sunxi-ps2=
&quot;<br>
&gt; +<br>
&gt; +#define RESSIZE(res)=C2=A0 =C2=A0 =C2=A0 =C2=A0 (((res)-&gt;end - (re=
s)-&gt;start)+1)<br>
<br>
I am sure we have something generic for it, no?<br>
<br>
&gt; +<br>
&gt; +#define SW_PS2_GCTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00)<br>
&gt; +#define SW_PS2_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x04)<br>
&gt; +#define SW_PS2_LCTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x08)<br>
&gt; +#define SW_PS2_LSTAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0c)<br>
&gt; +#define SW_PS2_FCTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x10)<br>
&gt; +#define SW_PS2_FSTAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x14)<br>
&gt; +#define SW_PS2_CLKDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x18)<br>
&gt; +<br>
&gt; +/* SW_PS2_GCTRL */<br>
&gt; +#define SWPS2_BUSEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<b=
r>
&gt; +#define SWPS2_MASTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 1)<br>
&gt; +#define SWPS2_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 2)<b=
r>
&gt; +#define SWPS2_INTEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 3)<b=
r>
&gt; +#define SWPS2_INTFLAG=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 3)<br>
&gt; +<br>
&gt; +/* SW_PS2_LCTRL */<br>
&gt; +#define SWPS2_LCTL_NOACK=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0 &lt;&lt; 18)=
<br>
&gt; +#define SWPS2_LCTL_TXDTOEN=C2=A0 =C2=A0 =C2=A0 (0x1 &lt;&lt; 8)<br>
&gt; +#define SWPS2_LCTL_STOPERREN=C2=A0 =C2=A0 (0x1 &lt;&lt; 3)<br>
&gt; +#define SWPS2_LCTL_ACKERREN=C2=A0 =C2=A0 =C2=A0(0x1 &lt;&lt; 2)<br>
&gt; +#define SWPS2_LCTL_PARERREN=C2=A0 =C2=A0 =C2=A0(0x1 &lt;&lt; 1)<br>
&gt; +#define SWPS2_LCTL_RXDTOEN=C2=A0 =C2=A0 =C2=A0 (0x1 &lt;&lt; 0)<br>
&gt; +<br>
&gt; +/* SW_PS2_FSTAT */<br>
&gt; +#define SWPS2_FSTA_RXRDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)<br=
>
&gt; +#define SWPS2_FSTA_RXOF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; =
1)<br>
&gt; +#define SWPS2_FSTA_RXUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; =
2)<br>
&gt; +#define SWPS2_FSTA_TXRDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 8)<br=
>
&gt; +#define SWPS2_FSTA_TXOF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; =
9)<br>
&gt; +#define SWPS2_FSTA_TXUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; =
10)<br>
&gt; +<br>
&gt; +#define SW_PS2_SAMPLE_CLK=C2=A0 =C2=A0 =C2=A0 (1000000)<br>
&gt; +#define SW_PS2_SCLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (125000)=
<br>
&gt; +<br>
&gt; +struct sunxips2data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spinlock_t ps2_lock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base_address;=C2=A0 =C2=A0 =C2=A0/*=
 virt address of control registers*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct serio *serio;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* serio*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct=C2=A0 clk=C2=A0 =C2=A0 =C2=A0*pclk;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/*********************/<br>
&gt; +/* Interrupt handler */<br>
&gt; +/*********************/<br>
&gt; +static irqreturn_t sunxips2_interrupt(int irq, void *dev_id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D dev_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 intr_status;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 fifo_status;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char byte;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 rval;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 error =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_lock(&amp;drvdata-&gt;ps2_lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Get the PS/2 interrupts and clear them */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0intr_status=C2=A0 =3D readl(drvdata-&gt;base_addr=
ess + SW_PS2_LSTAT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fifo_status=C2=A0 =3D readl(drvdata-&gt;base_addr=
ess + SW_PS2_FSTAT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*Check Line Status Register*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (intr_status &amp; 0x10f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &amp;=
 0x08)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Stop Bit Error!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &amp;=
 0x04)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Acknowledge Error!\n&quot;);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &amp;=
 0x02)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Parity Error!\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &amp;=
 0x100)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Transmit Data Timeout!\n&quot;)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (intr_status &amp;=
 0x01)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Receive Data Timeout!\n&quot;);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(readl(drvdata-=
&gt;base_address + SW_PS2_GCTRL)|0x4, drvdata-&gt;base_address + SW_PS2_GCT=
RL);/*reset PS/2 controller*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(0x10f, drvdata=
-&gt;base_address + SW_PS2_LSTAT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*Check FIFO Status Register*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (fifo_status &amp; 0x0606) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &amp;=
 0x400)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Tx FIFO Underflow!\n&quot;);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &amp;=
 0x200)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Tx FIFO Overflow!\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &amp;=
 0x04)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Rx FIFO Underflow!\n&quot;);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fifo_status &amp;=
 0x02)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(drvdata-&gt;dev, &quot;PS/2 Rx FIFO Overflow!\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(readl(drvdata-=
&gt;base_address + SW_PS2_GCTRL)|0x4, drvdata-&gt;base_address + SW_PS2_GCT=
RL); /*reset PS/2 controller*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(0x707, drvdata=
-&gt;base_address + SW_PS2_FSTAT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rval =3D (fifo_status &gt;&gt; 16) &amp; 0x3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (!error &amp;&amp; rval--) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0byte =3D readl(drvdat=
a-&gt;base_address + SW_PS2_DATA) &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(drvdata-&gt;=
dev, &quot;PS/2 Receive %02x\n&quot;, byte);<br>
<br>
You really want to log every input byte in the logs?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serio_interrupt(drvda=
ta-&gt;serio, byte, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(intr_status, drvdata-&gt;base_address + SW=
_PS2_LSTAT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(fifo_status, drvdata-&gt;base_address + SW=
_PS2_FSTAT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;drvdata-&gt;ps2_lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sunxips2_open(struct serio *pserio)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D pserio-&gt;port_=
data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 src_clk =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 clk_scdf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 clk_pcdf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 rval;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*Set Line Control And Enable Interrupt*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rval =3D SWPS2_LCTL_TXDTOEN|SWPS2_LCTL_STOPERREN|=
SWPS2_LCTL_ACKERREN|SWPS2_LCTL_PARERREN|SWPS2_LCTL_RXDTOEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(rval, drvdata-&gt;base_address + SW_PS2_LC=
TRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*Reset FIFO*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(0x3&lt;&lt;16 | 0x607, drvdata-&gt;base_ad=
dress + SW_PS2_FCTRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0src_clk =3D clk_get_rate(drvdata-&gt;pclk);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!src_clk) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(drvdata-&gt;=
dev, &quot;w_ps2c_set_sclk error, source clock is 0.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*Set Clock Divider Register*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_scdf =3D ((src_clk + (SW_PS2_SAMPLE_CLK&gt;&g=
t;1)) / SW_PS2_SAMPLE_CLK - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_pcdf =3D ((SW_PS2_SAMPLE_CLK + (SW_PS2_SCLK&g=
t;&gt;1)) / SW_PS2_SCLK - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rval =3D (clk_scdf&lt;&lt;8) | clk_pcdf;/* | (PS2=
_DEBUG_SEL&lt;&lt;16);*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(rval, drvdata-&gt;base_address + SW_PS2_CL=
KDR);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*Set Global Control Register*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rval =3D SWPS2_RESET|SWPS2_INTEN|SWPS2_MASTER|SWP=
S2_BUSEN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(rval, drvdata-&gt;base_address + SW_PS2_GC=
TRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0udelay(100);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void sunxips2_close(struct serio *pserio)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D pserio-&gt;port_=
data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_lock(&amp;drvdata-&gt;ps2_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disable the PS2 interrupts */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(0, drvdata-&gt;base_address + SW_PS2_GCTRL=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;drvdata-&gt;ps2_lock);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sunxips2_write(struct serio *pserio, unsigned char val)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D (struct sunxips2=
data *)pserio-&gt;port_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 timeout =3D 10000;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (readl(drvdata-&gt=
;base_address + SW_PS2_FSTAT) &amp; SWPS2_FSTA_TXRDY) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0writel(val, drvdata-&gt;base_address + SW_PS2_DATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} while (timeout--);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sunxips2_probe(struct platform_device *ofdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource *res; /* IO mem resources */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct serio *serio;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;ofdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int error;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata =3D devm_kzalloc(dev, sizeof(struct sunxi=
ps2data), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio =3D devm_kzalloc(dev, sizeof(struct serio),=
 GFP_KERNEL);<br>
<br>
serio is a refcounted structure, it should not be allocated with devm.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!drvdata || !serio)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D -ENOMEM;<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and...?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Request clock */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;pclk =3D clk_get(dev, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(drvdata-&gt;pclk))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(dev, &quot;co=
uldn&#39;t get clock %li\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PTR_ERR(drvdata-&gt;pclk));<br>
<br>
Why %li?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!IS_ERR(drvdata-&gt;pclk)) {<br>
<br>
&quot;} else {&quot;<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D clk_prepare=
_enable(drvdata-&gt;pclk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error &lt; 0) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(dev, &quot;failed to enable clock %d\n&quot;, error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return error;<br>
<br>
Leaking clk here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* IO */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(ofdev, IORESOURCE_M=
EM, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;base_address =3D devm_ioremap_resourc=
e(dev, res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(drvdata-&gt;base_address)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to map registers\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D PTR_ERR(drv=
data-&gt;base_address);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aaaand...?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio-&gt;id.type =3D SERIO_8042;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio-&gt;write =3D sunxips2_write;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio-&gt;open =3D sunxips2_open;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio-&gt;close =3D sunxips2_close;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio-&gt;port_data =3D drvdata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio-&gt;dev.parent =3D dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0strlcpy(serio-&gt;name, dev_name(dev), sizeof(ser=
io-&gt;name));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0strlcpy(serio-&gt;phys, dev_name(dev), sizeof(ser=
io-&gt;phys));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(ofdev, drvdata);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio_register_port(serio);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Get IRQ for the device */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq =3D irq_of_parse_and_map(ofdev-&gt;dev.of_nod=
e, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!irq) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;no=
 IRQ found\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
<br>
Leaking clk and serio here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;irq =3D irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;serio =3D serio;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;dev =3D dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D devm_request_any_context_irq(drvdata-&g=
t;dev, drvdata-&gt;irq, &amp;sunxips2_interrupt, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRIVER_NAME, drvdata);<br>
<br>
Please try to fit in 80 columns.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (error) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(drvdata-&gt;d=
ev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;Couldn&#39;t allocate interrupt %d : error: %d\n&quot;, drvdat=
a-&gt;irq, error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* success */<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sunxips2_remove(struct platform_device *of_dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sunxips2data *drvdata =3D platform_get_drv=
data(of_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!IS_ERR(drvdata-&gt;pclk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare=
(drvdata-&gt;pclk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_put(drvdata-&gt;p=
clk);<br>
<br>
If serio write comes here what will happen?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio_unregister_port(drvdata-&gt;serio);<br>
<br>
If interrupt comes here=C2=A0 what will happen?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mdelay(2);<br>
<br>
Why do you need mdelay?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Match table for of_platform binding */<br>
&gt; +static const struct of_device_id sunxips2_of_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;allwinner,sun7i-a20-ps2&q=
uot;, },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ },<br>
&gt; +};<br>
&gt; +<br>
&gt; +MODULE_DEVICE_TABLE(of, sunxips2_of_match);<br>
&gt; +<br>
&gt; +/*platform driver structure*/<br>
&gt; +static struct platform_driver sunxips2_of_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D sunx=
ips2_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sunx=
ips2_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D DRIVER_NAME=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODUL=
E,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D s=
unxips2_of_match,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +module_platform_driver(sunxips2_of_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Aaron.maoye&lt;<a href=3D"javascript:;" onclick=
=3D"_e(event, &#39;cvml&#39;, &#39;leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org&#39;)">leafy.m=
yeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org</a>, &quot;<br>
<br>
Space before &quot;&lt;&quot;, closing &quot;&gt;&quot; are missing.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Vishnu Patekar =
&lt;<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;vish=
nupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)">vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&quot;);<=
br>
&gt; +MODULE_DESCRIPTION(&quot;Sunxi PS/2 driver&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt; --<br>
&gt; 1.7.9.5<br>
&gt;<br>
<br>
Thanks.<br>
<br>
--<br>
Dmitry<br>
<br>
--<br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;=
linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org&#39;)">linux-sunxi+unsubscribe@goo=
glegroups.com</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" targ=
et=3D"_blank">https://groups.google.com/d/optout</a>.<br>
</blockquote></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--f46d041825e8ae080b05095b4715--
