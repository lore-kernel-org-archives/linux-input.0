From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm831x - Add driver for Wolfson WM831x PMIC
 touchscreen controllers
Date: Tue, 25 Jan 2011 09:07:29 -0800
Message-ID: <20110125170729.GD19701@core.coreip.homeip.net>
References: <1295964556-1024-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61620 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab1AYRHh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 12:07:37 -0500
Received: by gyb11 with SMTP id 11so1789982gyb.19
        for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 09:07:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295964556-1024-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

Hi Mark,

On Tue, Jan 25, 2011 at 02:09:16PM +0000, Mark Brown wrote:
> Some of the WM831x series of PMICs from Wolfson Microelectronics include
> a resistive touchscreen controller. Implement support for these controllers
> within the input API.
> 
> Platform data is supported to allow configuration of system parameters such
> as selection between four and five wire touchscreens and for specification
> of optional direct to CPU IRQs for sample availability and for pen down.
> Use of this feature for at least the data IRQ is strongly recommended.
> 
> Thanks to Julien Boibessot for extensive testing and detailed feedback.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Tested-by: Julien Boibessot <julien.boibessot@armadeus.com>

Just a couple small concerns here:

> +
> +struct wm831x_ts {
> +	struct input_dev *input_dev;
> +	struct wm831x *wm831x;
> +	int data_irq;
> +	int pd_irq;

Maybe make irqs unsigned?

> +
> +static void wm831x_ts_input_close(struct input_dev *idev)
> +{
> +	struct wm831x_ts *wm831x_ts = input_get_drvdata(idev);
> +	struct wm831x *wm831x = wm831x_ts->wm831x;
> +
> +	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
> +			WM831X_TCH_ENA | WM831X_TCH_CVT_ENA |
> +			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA |
> +			WM831X_TCH_Z_ENA, 0);
> +
> +	if (wm831x_ts->pen_down)
> +		disable_irq_nosync(wm831x_ts->data_irq);

Why nosync?

> +
> +	ret = request_threaded_irq(wm831x_ts->data_irq, NULL,
> +				   wm831x_ts_data_irq,
> +				   IRQF_ONESHOT,
> +				   "Touchscreen data", wm831x_ts);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request data IRQ %d: %d\n",
> +			wm831x_ts->data_irq, ret);
> +		goto err_alloc;
> +	}
> +	disable_irq(wm831x_ts->data_irq);
> +
> +	ret = request_threaded_irq(wm831x_ts->pd_irq, NULL,
> +				   wm831x_ts_pen_down_irq, IRQF_ONESHOT,
> +				   "Touchscreen pen down", wm831x_ts);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request pen down IRQ %d: %d\n",
> +			wm831x_ts->pd_irq, ret);
> +		goto err_data_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, wm831x_ts);
> +
> +	input_dev = input_allocate_device();

Are we 100% sure it is impossible for the 2 irqs above to fire up before
we get here? Like if we happen to have hardware in half-active state
while binding?

I'd feel safer if we allocated input device earlier, together with the
touchscreen structure.

Thanks.

-- 
Dmitry
