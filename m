From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Input: jornada720_ts - get rid of mach/irqs.h include
Date: Fri, 19 Aug 2016 17:40:56 +0100
Message-ID: <20160819164056.GS1041@n2100.armlinux.org.uk>
References: <E1bamhR-0004We-61@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35062 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753911AbcHSQlh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 12:41:37 -0400
Content-Disposition: inline
In-Reply-To: <E1bamhR-0004We-61@rmk-PC.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Aug 19, 2016 at 05:31:17PM +0100, Russell King wrote:
> Switch the jornada720 touchscreen driver to obtain its interrupt from
> the platform device, rather than via a hard-coded interrupt number
> obtained from the mach/irqs.h header.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Looking deeper at this driver, this probably isn't an entirely correct
way to go about this, because the interrupt handler does this:

        /* If GPIO_GPIO9 is set to high then report pen up */
        if (GPLR & GPIO_GPIO(9)) {

so we should be grabbing the GPIO via the gpio layer and testing
the value there.

_However_, having discovered this, along with the interrupt handler
being registered with:

        error = devm_request_irq(&pdev->dev, irq, jornada720_ts_interrupt,
                                 IRQF_TRIGGER_RISING,
                                 "HP7XX Touchscreen driver", pdev);

this brings up the question: if the trigger is always a rising edge
on GPIO 9, it is very unlikely that GPLR & GPIO_GPIO(9) will be
false.  So how can this code have worked in the first place?

I've checked the history, and I see nothing which changes this state
of affairs back to 2.6.12-rc2.

> ---
>  arch/arm/mach-sa1100/jornada720.c         |  6 ++++++
>  drivers/input/touchscreen/jornada720_ts.c | 10 ++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
> index 2b96f7bc16bd..010eaea04c69 100644
> --- a/arch/arm/mach-sa1100/jornada720.c
> +++ b/arch/arm/mach-sa1100/jornada720.c
> @@ -228,9 +228,15 @@ static struct platform_device jornada_kbd_device = {
>  	.resource	= jornada_kbd_resources,
>  };
>  
> +static struct resource jornada_ts_resources[] = {
> +	DEFINE_RES_IRQ(IRQ_GPIO9),
> +};
> +
>  static struct platform_device jornada_ts_device = {
>  	.name		= "jornada_ts",
>  	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(jornada_ts_resources),
> +	.resource	= jornada_ts_resources,
>  };
>  
>  static struct platform_device *devices[] __initdata = {
> diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
> index ea3b6a5b83e6..7e196f8e5661 100644
> --- a/drivers/input/touchscreen/jornada720_ts.c
> +++ b/drivers/input/touchscreen/jornada720_ts.c
> @@ -22,7 +22,6 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/jornada720.h>
> -#include <mach/irqs.h>
>  
>  MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
>  MODULE_DESCRIPTION("HP Jornada 710/720/728 touchscreen driver");
> @@ -101,7 +100,11 @@ static int jornada720_ts_probe(struct platform_device *pdev)
>  {
>  	struct jornada_ts *jornada_ts;
>  	struct input_dev *input_dev;
> -	int error;
> +	int error, irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return irq < 0 ? irq : -EINVAL;
>  
>  	jornada_ts = devm_kzalloc(&pdev->dev, sizeof(*jornada_ts), GFP_KERNEL);
>  	if (!jornada_ts)
> @@ -125,8 +128,7 @@ static int jornada720_ts_probe(struct platform_device *pdev)
>  	input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0);
>  	input_set_abs_params(input_dev, ABS_Y, 180, 3700, 0, 0);
>  
> -	error = devm_request_irq(&pdev->dev, IRQ_GPIO9,
> -				 jornada720_ts_interrupt,
> +	error = devm_request_irq(&pdev->dev, irq, jornada720_ts_interrupt,
>  				 IRQF_TRIGGER_RISING,
>  				 "HP7XX Touchscreen driver", pdev);
>  	if (error) {
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
