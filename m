From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers:input:ps2 Added sunxi A20 ps2
 driver, changed makefile and Kconfig
Date: Sat, 6 Dec 2014 19:01:50 +0530
Message-ID: <CAEzqOZtRV2L3UMwh=cfD1VkhRBMGkJkFAkYXa2w=Fi-BCApOVg@mail.gmail.com>
References: <1417647224-27950-1-git-send-email-VishnuPatekar0510@gmail.com>
	<20141205100151.GT30256@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=f46d043be0303a84ae05098c37a1
Return-path: <linux-sunxi+bncBD64TFVR3YIBBRUKRSSAKGQELP4G34A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141205100151.GT30256@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare-l3A5Bk7waGM@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--f46d043be0303a84ae05098c37a1
Content-Type: text/plain; charset=UTF-8

Hello Maxime,
Sorry for inconvenience. I'll follow the guidelines, will implement the
review comment and resubmit the patch for review.


On Fri, Dec 5, 2014 at 3:31 PM, Maxime Ripard <
maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi,
>
> Thanks for working on this.
>
> First, make sure to read Documentation/SubmittingPatches. The
> guidelines in there might seem tedious, but it's there to enforce that
> we keep the kernel homogenous.
>
> Most notably, you should make sure that:
>   - you run scripts/checkpatch.pl on your patches
>   - you have a commit log
>   - your commit title stays below 80 chars
>   - you have a Signed-off-by in your commit log
>
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
> > + *
> > + * Author: Aaron.maoye <leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org>
> > + *      Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > + * Based on sunxi-ps2.c 3.0 kernel
>
> Mentionning that it's Allwinner's 3.0 kernel would be good, it doesn't
> make much sense otherwise.
>
> Okie

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
> > +
> > +#define SW_PS2_GCTRL        (0x00)
> > +#define SW_PS2_DATA         (0x04)
> > +#define SW_PS2_LCTRL        (0x08)
> > +#define SW_PS2_LSTAT        (0x0c)
> > +#define SW_PS2_FCTRL        (0x10)
> > +#define SW_PS2_FSTAT        (0x14)
> > +#define SW_PS2_CLKDR        (0x18)
>
> The SW_ prefix is a left over from Allwinner I suppose?
>
> Using a prefix like sun4i_ps2/sun7i_ps2 depending on the outcome of
> the discussion you had with Hans would seem better, across all your
> driver.
>
> Agreed, as this PS2 driver can be applicable for A10 and A20, I'll keep it
as PS2_REG_* for registers, e.g. PS2_REG_GCTL  and PS2_GCTL_BUSEN for bits.
it is similar to SUNXI MMC driver.

> > +
> > +/* SW_PS2_GCTRL */
> > +#define SWPS2_BUSEN         (1 << 0)
> > +#define SWPS2_MASTER        (1 << 1)
> > +#define SWPS2_RESET         (1 << 2)
> > +#define SWPS2_INTEN         (1 << 3)
>
> We usually have the convention of having the register name mentionned
> in the bits offsets, and the bits declared right after their register.
>
> Something like:
>
> #define SUN4I_PS2_GCTRL_REG     0x00
> #define SUN4I_PS2_GCTRL_BUS_EN          BIT(0)
>
> #define SUN4I_PS2_LCTRL_REG     0x08
> #define SUN4I_PS2_LCTRL_PAR_ERR_EN      BIT(1)
>
> etc....
>
> Agreed, BIT(x) macros will be used.

> > +#define SWPS2_INTFLAG       (1 << 3)
>
> This is defined to the same value than _INTEN, is this intentionnal?
>
> This macro is not used, will be removed.


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
>
> What is this supposed to do? Calculating and rounding the dividers?
>
> You should look into DIV_ROUND_* if that's so
>
> Yes, Agreed, It'll be used as below, this solves purpose.

clk_scdf = DIV_ROUND_UP(src_clk, PS2_SAMPLE_CLK) -1 ;
clk_pcdf = DIV_ROUND_UP(PS2_SAMPLE_CLK, PS2_SCLK) -1;
rval = (clk_scdf<<8) | clk_pcdf;
writel(rval, drvdata->reg_base + PS2_CLKDR);


> > +     writel(rval, drvdata->base_address + SW_PS2_CLKDR);
> > +
> > +     /*Set Global Control Register*/
> > +     rval = SWPS2_RESET|SWPS2_INTEN|SWPS2_MASTER|SWPS2_BUSEN;
> > +     writel(rval, drvdata->base_address + SW_PS2_GCTRL);
> > +
> > +     udelay(100);
>
> Why is that udelay needed?
>
> No need, will be removed.

> > +
> > +     return 0;
> > +}
> > +
> > +static void sunxips2_close(struct serio *pserio)
> > +{
> > +     struct sunxips2data *drvdata = pserio->port_data;
> > +
> > +     spin_lock(&drvdata->ps2_lock);
>
> spin_lock_irqsave would be better I guess.
>
> I'll use it.

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
>
> Please use time_before() here
>
> Agreed, time_before(jiffies, expire) will be used.

> > +     return -1;
>
> And return a meaningful error.
>
> Okie

> > +static int sunxips2_probe(struct platform_device *ofdev)
>
> The ofdev name is measleading. This is a platform_device structure, it
> could be probed by other mechanisms than OF, so please use a different
> name here. Usually pdev is used.
>
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
> > +     if (!drvdata || !serio)
> > +             error = -ENOMEM;
> > +
> > +     /* Request clock */
> > +     drvdata->pclk = clk_get(dev, NULL);
>
> You can use devm_clk_get.
>
> Agreed, devm_clk_get will be used.

> > +     if (IS_ERR(drvdata->pclk))
> > +             dev_dbg(dev, "couldn't get clock %li\n",
> > +                     PTR_ERR(drvdata->pclk));
>
> This is an error, you should treat it as such.
>
> > +     if (!IS_ERR(drvdata->pclk)) {
> > +             error = clk_prepare_enable(drvdata->pclk);
> > +             if (error < 0) {
> > +                     dev_err(dev, "failed to enable clock %d\n", error);
> > +                     return error;
> > +             }
> > +     }
> > +
> > +     /* IO */
> > +     res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> > +     drvdata->base_address = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(drvdata->base_address)) {
> > +             dev_err(dev, "failed to map registers\n");
> > +             error = PTR_ERR(drvdata->base_address);
> > +     }
>
> ditto.
>
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
> > +     }
>
> You can use platform_get_irq, for consistency with how you retrieve
> resources.
>
> You're also no unregistering the driver from the serio framework.
>
> I'll put code for error handling and freeing allocated resources.

> > +     drvdata->irq = irq;
> > +     drvdata->serio = serio;
> > +     drvdata->dev = dev;
> > +     error = devm_request_any_context_irq(drvdata->dev, drvdata->irq,
> &sunxips2_interrupt, 0,
> > +                             DRIVER_NAME, drvdata);
>
> request_irq is enough here.
>
> Okie, I'll use devm_request_threaded_irq as request_irq is just wrapper
arroud it.

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
> > +     }
> > +     serio_unregister_port(drvdata->serio);
> > +     mdelay(2);
>
> Why a mdelay?
>
No need, will be removed.

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
>
> You can drop the owner field, it's already set by
> module_platform_driver.
>
> Okie

> > +             .of_match_table = sunxips2_of_match,
> > +     },
> > +};
> > +module_platform_driver(sunxips2_of_driver);
> > +
> > +MODULE_AUTHOR("Aaron.maoye<leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org, "
> > +             "Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
>
> Usually, you define two MODULE_AUTHOR.
>
> Okie

> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--f46d043be0303a84ae05098c37a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Maxime,</div><div>Sorry for inconvenience. I&#3=
9;ll follow the guidelines, will implement the review comment and resubmit =
the patch for review.</div><div><br></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Fri, Dec 5, 2014 at 3:31 PM, Maxime Ripard <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" targe=
t=3D"_blank">maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex">Hi,<br>
<br>
Thanks for working on this.<br>
<br>
First, make sure to read Documentation/SubmittingPatches. The<br>
guidelines in there might seem tedious, but it&#39;s there to enforce that<=
br>
we keep the kernel homogenous.<br>
<br>
Most notably, you should make sure that:<br>
=C2=A0 - you run scripts/<a href=3D"http://checkpatch.pl" target=3D"_blank"=
>checkpatch.pl</a> on your patches<br>
=C2=A0 - you have a commit log<br>
=C2=A0 - your commit title stays below 80 chars<br>
=C2=A0 - you have a Signed-off-by in your commit log<br>
<span class=3D""><br>
On Thu, Dec 04, 2014 at 04:23:44AM +0530, vishnupatekar wrote:<br>
</span><div><div class=3D"h5">&gt; ---<br>
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
&gt; + *<br>
&gt; + * Author: Aaron.maoye &lt;<a href=3D"mailto:leafy.myeh-Q9AEpCAkrShYLFMOSSmIcA@public.gmane.org=
m">leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org</a>&gt;<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 Vishnu Patekar &lt;<a href=3D"mailto:vishnupat=
ekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; + * Based on sunxi-ps2.c 3.0 kernel<br>
<br>
</div></div>Mentionning that it&#39;s Allwinner&#39;s 3.0 kernel would be g=
ood, it doesn&#39;t<br>
make much sense otherwise.<br>
<div><div class=3D"h5"><br></div></div></blockquote><div>Okie=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pad=
ding-left:1ex"><div><div class=3D"h5">
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
&gt; +<br>
&gt; +#define SW_PS2_GCTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00)<br>
&gt; +#define SW_PS2_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x04)<br>
&gt; +#define SW_PS2_LCTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x08)<br>
&gt; +#define SW_PS2_LSTAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0c)<br>
&gt; +#define SW_PS2_FCTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x10)<br>
&gt; +#define SW_PS2_FSTAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x14)<br>
&gt; +#define SW_PS2_CLKDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x18)<br>
<br>
</div></div>The SW_ prefix is a left over from Allwinner I suppose?<br>
<br>
Using a prefix like sun4i_ps2/sun7i_ps2 depending on the outcome of<br>
the discussion you had with Hans would seem better, across all your<br>
driver.<br>
<span class=3D""><br></span></blockquote><div>Agreed, as this PS2 driver ca=
n be applicable for A10 and A20, I&#39;ll keep it as PS2_REG_* for register=
s, e.g. PS2_REG_GCTL =C2=A0and PS2_GCTL_BUSEN for bits. it is similar to SU=
NXI MMC driver.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><span class=3D"">
&gt; +<br>
&gt; +/* SW_PS2_GCTRL */<br>
&gt; +#define SWPS2_BUSEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<b=
r>
&gt; +#define SWPS2_MASTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 1)<br>
&gt; +#define SWPS2_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 2)<b=
r>
&gt; +#define SWPS2_INTEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 3)<b=
r>
<br>
</span>We usually have the convention of having the register name mentionne=
d<br>
in the bits offsets, and the bits declared right after their register.<br>
<br>
Something like:<br>
<br>
#define SUN4I_PS2_GCTRL_REG=C2=A0 =C2=A0 =C2=A00x00<br>
#define SUN4I_PS2_GCTRL_BUS_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(0)<br>
<br>
#define SUN4I_PS2_LCTRL_REG=C2=A0 =C2=A0 =C2=A00x08<br>
#define SUN4I_PS2_LCTRL_PAR_ERR_EN=C2=A0 =C2=A0 =C2=A0 BIT(1)<br>
<br>
etc....<br>
<br></blockquote><div><span style=3D"font-size:13px">Agreed, BIT(x) macros =
will be used. =C2=A0</span>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb=
(204,204,204);border-left-style:solid;padding-left:1ex">
&gt; +#define SWPS2_INTFLAG=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 3)<br>
<br>
This is defined to the same value than _INTEN, is this intentionnal?<br>
<div><div class=3D"h5"><br></div></div></blockquote><div><span style=3D"fon=
t-size:13px">This macro is not used, will be removed.</span></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><div><div class=3D"h5">
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
<br>
</div></div>What is this supposed to do? Calculating and rounding the divid=
ers?<br>
<br>
You should look into DIV_ROUND_* if that&#39;s so<br>
<span class=3D""><br></span></blockquote><div>Yes, Agreed, It&#39;ll be use=
d as below, this solves purpose.</div><div><br></div><div><span class=3D"" =
style=3D"white-space:pre">	</span>clk_scdf =3D DIV_ROUND_UP(src_clk, PS2_SA=
MPLE_CLK) -1 ;</div><div><span class=3D"" style=3D"white-space:pre">	</span=
>clk_pcdf =3D DIV_ROUND_UP(PS2_SAMPLE_CLK, PS2_SCLK) -1;</div><div><span cl=
ass=3D"" style=3D"white-space:pre">	</span>rval =3D (clk_scdf&lt;&lt;8) | c=
lk_pcdf;</div><div><span class=3D"" style=3D"white-space:pre">	</span>write=
l(rval, drvdata-&gt;reg_base + PS2_CLKDR);</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-lef=
t:1ex"><span class=3D"">
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
<br>
</span>Why is that udelay needed?<br>
<span class=3D""><br></span></blockquote><div><span style=3D"font-size:13px=
">No need, will be removed.=C2=A0</span>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span =
class=3D"">
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
<br>
</span>spin_lock_irqsave would be better I guess.<br>
<span class=3D""><br></span></blockquote><div><span style=3D"font-size:13px=
">I&#39;ll use it.=C2=A0</span>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span class=3D"=
">
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
<br>
</span>Please use time_before() here<br>
<br></blockquote><div><span style=3D"font-size:13px">Agreed, time_before(ji=
ffies, expire) will be used.=C2=A0</span>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0return -1;<br>
<br>
And return a meaningful error.<br>
<span class=3D""><br></span></blockquote><div>Okie=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex"><span class=3D"">
&gt; +static int sunxips2_probe(struct platform_device *ofdev)<br>
<br>
</span>The ofdev name is measleading. This is a platform_device structure, =
it<br>
could be probed by other mechanisms than OF, so please use a different<br>
name here. Usually pdev is used.<br>
<span class=3D""><br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0if (!drvdata || !serio)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D -ENOMEM;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Request clock */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;pclk =3D clk_get(dev, NULL);<br>
<br>
</span>You can use devm_clk_get.<br>
<span class=3D""><br></span></blockquote><div><span style=3D"font-size:13px=
">Agreed, devm_clk_get will be used.</span>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><sp=
an class=3D"">
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(drvdata-&gt;pclk))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(dev, &quot;co=
uldn&#39;t get clock %li\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PTR_ERR(drvdata-&gt;pclk));<br>
<br>
</span>This is an error, you should treat it as such.<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!IS_ERR(drvdata-&gt;pclk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D clk_prepare=
_enable(drvdata-&gt;pclk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error &lt; 0) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(dev, &quot;failed to enable clock %d\n&quot;, error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return error;<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
</span>ditto.<br>
<span class=3D""><br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
</span>You can use platform_get_irq, for consistency with how you retrieve<=
br>
resources.<br>
<br>
You&#39;re also no unregistering the driver from the serio framework.<br>
<span class=3D""><br></span></blockquote><div><span style=3D"font-size:13px=
">I&#39;ll put code for error handling and freeing allocated resources.=C2=
=A0</span>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><span class=3D"">
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;irq =3D irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;serio =3D serio;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drvdata-&gt;dev =3D dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D devm_request_any_context_irq(drvdata-&g=
t;dev, drvdata-&gt;irq, &amp;sunxips2_interrupt, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRIVER_NAME, drvdata);<br>
<br>
</span>request_irq is enough here.<br>
<span class=3D""><br></span></blockquote><div><span style=3D"font-size:13px=
">Okie, I&#39;ll use devm_request_threaded_irq as request_irq is just wrapp=
er arroud it.</span>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex"><span class=3D"">
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
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0serio_unregister_port(drvdata-&gt;serio);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mdelay(2);<br>
<br>
</span>Why a mdelay?<br></blockquote><div><span style=3D"font-size:13px">No=
 need, will be removed.=C2=A0</span>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<span class=3D""><br>
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
<br>
</span>You can drop the owner field, it&#39;s already set by<br>
module_platform_driver.<br>
<span class=3D""><br></span></blockquote><div>Okie=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex"><span class=3D"">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D s=
unxips2_of_match,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +module_platform_driver(sunxips2_of_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Aaron.maoye&lt;<a href=3D"mailto:leafy.myeh@newbi=
etech.com">leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org</a>, &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Vishnu Patekar =
&lt;<a href=3D"mailto:vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">vishnupatekar0510@gmail.=
com</a>&gt;&quot;);<br>
<br>
</span>Usually, you define two MODULE_AUTHOR.<br>
<span class=3D""><font color=3D"#888888"><br></font></span></blockquote><di=
v>Okie=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex"><span class=3D""><font color=3D"#888888"=
>
Maxime<br>
<br>
--<br>
Maxime Ripard, Free Electrons<br>
Embedded Linux, Kernel and Android engineering<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
</font></span></blockquote></div><br></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--f46d043be0303a84ae05098c37a1--
