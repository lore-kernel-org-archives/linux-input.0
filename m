From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: s3c2410_ts: Move to
 clk_prepare_enable/clk_disable_unprepare
Date: Tue, 8 Jul 2014 18:00:49 -0700
Message-ID: <20140709010049.GC14935@core.coreip.homeip.net>
References: <1404155377-2862-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404155377-2862-1-git-send-email-anarsoul@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 30, 2014 at 10:09:37PM +0300, Vasily Khoruzhick wrote:
> Use clk_prepare_enable/clk_disable_unprepare to make the driver
> work properly with common clock framework.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/input/touchscreen/s3c2410_ts.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index 19cb247..c0e0baa 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -264,7 +264,7 @@ static int s3c2410ts_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	clk_enable(ts.clock);
> +	clk_prepare_enable(ts.clock);
>  	dev_dbg(dev, "got and enabled clocks\n");
>  
>  	ts.irq_tc = ret = platform_get_irq(pdev, 0);
> @@ -369,7 +369,7 @@ static int s3c2410ts_remove(struct platform_device *pdev)
>  	free_irq(ts.irq_tc, ts.input);
>  	del_timer_sync(&touch_timer);
>  
> -	clk_disable(ts.clock);
> +	clk_disable_unprepare(ts.clock);
>  	clk_put(ts.clock);
>  
>  	input_unregister_device(ts.input);
> @@ -383,7 +383,7 @@ static int s3c2410ts_suspend(struct device *dev)
>  {
>  	writel(TSC_SLEEP, ts.io + S3C2410_ADCTSC);
>  	disable_irq(ts.irq_tc);
> -	clk_disable(ts.clock);
> +	clk_disable_unprepare(ts.clock);

Do we really need to unprepare on suspend? Why simply disabling is not
enough here?

Thanks.

>  
>  	return 0;
>  }
> @@ -393,7 +393,7 @@ static int s3c2410ts_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct s3c2410_ts_mach_info *info = dev_get_platdata(&pdev->dev);
>  
> -	clk_enable(ts.clock);
> +	clk_prepare_enable(ts.clock);
>  	enable_irq(ts.irq_tc);
>  
>  	/* Initialise registers */
> -- 
> 2.0.0
> 

-- 
Dmitry
