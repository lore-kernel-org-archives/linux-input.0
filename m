From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers:input:ps2 Added sunxi A20 ps2
 driver, changed makefile and Kconfig
Date: Fri, 05 Dec 2014 11:33:11 +0100
Message-ID: <12237550.afophX20rO@wuerfel>
References: <1417647224-27950-1-git-send-email-VishnuPatekar0510@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDEKVJM7XAHRBBEUQ2SAKGQE4UTWTPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1417647224-27950-1-git-send-email-VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: vishnupatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vishnupatekar <VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jdelvare-l3A5Bk7waGM@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thursday 04 December 2014 04:23:44 vishnupatekar wrote:
> +
> +#define DRIVER_NAME		"sunxi-ps2"
> +
> +#define RESSIZE(res)        (((res)->end - (res)->start)+1)

Remove this and use the existing resource_size() function

> +
> +struct sunxips2data {
> +	int irq;
> +	spinlock_t ps2_lock;
> +	void __iomem *base_address;	/* virt address of control registers*/
> +	struct serio *serio;		/* serio*/
> +	struct device *dev;
> +	struct	clk	*pclk;
> +};

As this is dynamically allocated, better embed the serio member
directly to avoid allocating both separately.

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

100 microseconds is a rather long time to block the CPU for, so this
needs a comment explaining why the particular delay is needed and why
you can't use usleep_range() instead.

> +static void sunxips2_close(struct serio *pserio)
> +{
> +       struct sunxips2data *drvdata = pserio->port_data;
> +
> +       spin_lock(&drvdata->ps2_lock);
> +       /* Disable the PS2 interrupts */
> +       writel(0, drvdata->base_address + SW_PS2_GCTRL);
> +       spin_unlock(&drvdata->ps2_lock);
> +}

The locking is wrong here: you take the lock without disabling the
interrupts first, so if the interrupt happens between the spin_lock()
call and the writel(), the kernel will deadlock.

You will either have to use spin_lock_irq() here, or find a justification
for dropping the lock entirely.

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

We never return '-1' from in-kernel functions. Either make this a bool
argument, or return a proper errno.h value. This should probably return
-EIO.

> +	drvdata->irq = irq;
> +	drvdata->serio = serio;
> +	drvdata->dev = dev;
> +	error = devm_request_any_context_irq(drvdata->dev, drvdata->irq, &sunxips2_interrupt, 0,
> +				DRIVER_NAME, drvdata);
> +	if (error) {
> +		dev_err(drvdata->dev,
> +			"Couldn't allocate interrupt %d : error: %d\n", drvdata->irq, error);
> +		return error;
> +	}
> +	return 0;		/* success */
> +}

Why any_context?

	Arnd
