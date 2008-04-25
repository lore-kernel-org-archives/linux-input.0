From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL Touchscreen
Date: Fri, 25 Apr 2008 22:10:41 +0100
Message-ID: <20080425211041.GC28497@flint.arm.linux.org.uk>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com> <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52952 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757959AbYDYVLP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 17:11:15 -0400
Content-Disposition: inline
In-Reply-To: <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Justin Waters <justin.waters@timesys.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, dmitry.torokhov@gmail.com, linux@maxim.org.za

On Fri, Apr 25, 2008 at 02:56:37PM -0400, Justin Waters wrote:
> The atmel tsadcc is a touchscreen/adc controller found on the AT91SAM9RL
> SoC. This driver provides basic support for this controller for use as a
> touchscreen.  Some future improvements include suspend/resume capabilities
> and debugfs support.
>...
> +config TOUCHSCREEN_ATMEL_TSADCC
> +	tristate "Atmel Touchscreen Interface"

No dependencies.  So does this mean this'll build and link on an
x86 platform?

> +/* These values are dependent upon the performance of the ADC.  Ideally,
> + * These should be as close to the startup time and debounce time as
> + * possible (without going over).  These assume an optimally setup ADC as
> + * per the electrical characteristics of the AT91SAM9RL tsadcc module
> + */
> +#define TS_POLL_DELAY   (1 * 1000000)   /* ns delay before the first sample */
> +#define TS_POLL_PERIOD  (5 * 1000000)   /* ns delay between samples */

So 1ms and 5ms...  Not particularly high resolution...

> +static enum hrtimer_restart atmel_tsadcc_timer(struct hrtimer *handle)

So this uses the highres timer infrastructure.  Does this build if
CONFIG_HIGH_RES_TIMERS is not set?

> +static int __devinit atmel_tsadcc_probe(struct platform_device *pdev)
> +{
> +	struct atmel_tsadcc		*ts;
> +	struct input_dev	*input_dev;
> +	struct atmel_tsadcc_platform_data    *pdata = pdev->dev.platform_data;
> +	int			err;
> +	struct resource 	*res;
> +	unsigned int		regbuf;

This looks haphazard.

> +	/* Touchscreen Information */
> +        ts->pdev = pdev;
> +        ts->input = input_dev;

Weird indentation.

> +	/* Remap Register Memory */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ts->reg_start = res->start;
> +	ts->reg_length = res->end - res->start +1;

So if no memory resources were passed, this oopses.

> +	/* Setup Clock */
> +	ts->tsc_clk = clk_get(&pdev->dev,"tsc_clk");
> +	if (IS_ERR(ts->tsc_clk)) {

Great, nice to see a driver using the clock API properly.

> +		dev_err(&pdev->dev, "unable to get clock\n");
> +		err = PTR_ERR(ts->tsc_clk);
> +		goto err_iounmap;
> +        }

Odd indentation on the last line above.

> +	clk_enable(ts->tsc_clk);
> +
> +	regbuf = clk_get_rate(ts->tsc_clk);
> +	dev_dbg (&pdev->dev,"Master clock is set at: %d Hz\n",regbuf);
> +
> +	/* Setup IRQ */
> +	ts->irq = platform_get_irq(pdev, 0);
> +	if (ts->irq < 0) {
> +		dev_err(&pdev->dev, "unable to get IRQ\n");
> +		err = -EBUSY;
> +		goto err_clk_put;
> +        }

Ditto.
> +
> +	/* Fill in initial Register Data */
> +	ATMEL_TSADCC_RESET;
> +	regbuf = (0x01 & 0x3) |				/* TSAMOD	*/
> +		((0x0 & 0x1) << 5) |			/* SLEEP	*/

(0 & 1) << 5 ?  How about using a #define for bit 5 and simply
omitting it?

> +		((0x1 & 0x1) << 6) |			/* PENDET	*/

And a #define for bit 6 as well?

> +		((pdata->prescaler & 0x3F) << 8) |	/* PRESCAL	*/
> +		((pdata->startup & 0x7F) << 16) |	/* STARTUP	*/
> +		((pdata->debounce & 0x0F) << 28);	/* PENDBC	*/
> +	atmel_tsadcc_writereg(ATMEL_TSADCC_MR,regbuf);
> +
> +	regbuf = (0x4 & 0x7) |				/* TRGMOD	*/
> +		((0xFFFF & 0xFFFF) << 16);		/* TRGPER	*/
> +	atmel_tsadcc_writereg(ATMEL_TSADCC_TRGR,regbuf);
> +
> +	regbuf = ((pdata->tsshtim & 0xF) << 24);	/* TSSHTIM	*/
> +	atmel_tsadcc_writereg(ATMEL_TSADCC_TSR,regbuf);
> +
> +	regbuf = atmel_tsadcc_readreg(ATMEL_TSADCC_IMR);
> +	dev_dbg (&pdev->dev, "Initial IMR = %X\n", regbuf);
> +
> +	/* Register and enable IRQ */
> +	if (request_irq(ts->irq, atmel_tsadcc_irq, IRQF_TRIGGER_LOW,
> +		pdev->dev.driver->name, ts)) {
> +		dev_dbg(&pdev->dev, "IRQ %d busy!\n", ts->irq);
> +		err = -EBUSY;
> +		goto err_iounmap;
> +        }

Ditto.

> +	regbuf =	((0x1 & 0x1) << 20) |		/* PENCNT	*/
> +			((0x1 & 0x1) << 21);		/* NOCNT	*/

#defines... even more so then the comments become entirely unnecessary.

