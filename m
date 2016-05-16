From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: ti_am335x_tsc - Mark IRQ as wakeup capable
Date: Mon, 16 May 2016 12:46:21 -0700
Message-ID: <20160516194621.GF12752@dtor-ws>
References: <1463397984-15766-1-git-send-email-vigneshr@ti.com>
 <1463397984-15766-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36853 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbcEPTqZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2016 15:46:25 -0400
Content-Disposition: inline
In-Reply-To: <1463397984-15766-2-git-send-email-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 16, 2016 at 04:56:22PM +0530, Vignesh R wrote:
> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.

I would love for platform core to do this for us, like I2C core does.

> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 8b3f15ca7725..f9fefbe337b9 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -27,6 +27,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/sort.h>
> +#include <linux/pm_wakeirq.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  
> @@ -432,6 +433,12 @@ static int titsc_probe(struct platform_device *pdev)
>  		goto err_free_mem;
>  	}
>  
> +	if (device_may_wakeup(tscadc_dev->dev)) {
> +		err = dev_pm_set_wake_irq(tscadc_dev->dev, ts_dev->irq);
> +		if (err)
> +			dev_err(&pdev->dev, "irq wake enable failed.\n");
> +	}
> +
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
>  	err = titsc_config_wires(ts_dev);
> @@ -462,6 +469,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_irq:
> +	dev_pm_clear_wake_irq(tscadc_dev->dev);
>  	free_irq(ts_dev->irq, ts_dev);
>  err_free_mem:
>  	input_free_device(input_dev);
> @@ -474,6 +482,7 @@ static int titsc_remove(struct platform_device *pdev)
>  	struct titsc *ts_dev = platform_get_drvdata(pdev);
>  	u32 steps;
>  
> +	dev_pm_clear_wake_irq(ts_dev->mfd_tscadc->dev);
>  	free_irq(ts_dev->irq, ts_dev);
>  
>  	/* total steps followed by the enable mask */
> -- 
> 2.8.2
> 

-- 
Dmitry
