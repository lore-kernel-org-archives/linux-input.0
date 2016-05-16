From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: ti_am335x_tsc - Ack pending IRQs at probe and
 before suspend
Date: Mon, 16 May 2016 12:44:57 -0700
Message-ID: <20160516194457.GE12752@dtor-ws>
References: <1463397984-15766-1-git-send-email-vigneshr@ti.com>
 <1463397984-15766-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35377 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbcEPTpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2016 15:45:00 -0400
Content-Disposition: inline
In-Reply-To: <1463397984-15766-4-git-send-email-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 16, 2016 at 04:56:24PM +0530, Vignesh R wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> It is seen that just enabling the TSC module triggers a HW_PEN IRQ
> without any interaction with touchscreen by user. This results in first
> suspend/resume sequence to fail as system immediately wakes up from
> suspend as soon as HW_PEN IRQ is enabled in suspend handler. due to the
> pending IRQ. Therefore clear all IRQs at probe and also in suspend
> callback for sanity.

What if user touches the screen while device's suspend routine is
executing?

> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 ++
>  include/linux/mfd/ti_am335x_tscadc.h      | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 4683ed18b9f8..d2c55b5730e6 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -441,6 +441,7 @@ static int titsc_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "irq wake enable failed.\n");
>  	}
>  
> +	titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
>  	err = titsc_config_wires(ts_dev);
> @@ -506,6 +507,7 @@ static int __maybe_unused titsc_suspend(struct device *dev)
>  
>  	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
>  	if (device_may_wakeup(tscadc_dev->dev)) {
> +		titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);
>  		idle = titsc_readl(ts_dev, REG_IRQENABLE);
>  		titsc_writel(ts_dev, REG_IRQENABLE,
>  				(idle | IRQENB_HW_PEN));
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 1fd50dcfe47c..a7ca0f908ba8 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -60,6 +60,7 @@
>  #define IRQENB_FIFO1OVRRUN	BIT(6)
>  #define IRQENB_FIFO1UNDRFLW	BIT(7)
>  #define IRQENB_PENUP		BIT(9)
> +#define IRQENB_MASK		(0x7FF)
>  
>  /* Step Configuration */
>  #define STEPCONFIG_MODE_MASK	(3 << 0)
> -- 
> 2.8.2
> 

-- 
Dmitry
