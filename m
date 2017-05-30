From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: s3c2410_ts - Handle return value of
 clk_prepare_enable
Date: Tue, 30 May 2017 09:48:45 -0700
Message-ID: <20170530164845.GC12922@dtor-ws>
References: <477d9b0992f4b16454ad1780eb4477433c075226.1496141406.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <477d9b0992f4b16454ad1780eb4477433c075226.1496141406.git.arvind.yadav.cs@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, May 30, 2017 at 04:22:57PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/s3c2410_ts.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index 41d58e8..3b3db8c 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -264,7 +264,11 @@ static int s3c2410ts_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	clk_prepare_enable(ts.clock);
> +	ret = clk_prepare_enable(ts.clock);
> +	if (ret) {
> +		dev_err(dev, "Failed! to enabled clocks\n");
> +		goto err_clk_get;
> +	}
>  	dev_dbg(dev, "got and enabled clocks\n");
>  
>  	ts.irq_tc = ret = platform_get_irq(pdev, 0);
> @@ -353,7 +357,9 @@ static int s3c2410ts_probe(struct platform_device *pdev)
>   err_iomap:
>  	iounmap(ts.io);
>   err_clk:
> +	clk_disable_unprepare(ts.clock);
>  	del_timer_sync(&touch_timer);
> + err_clk_get:
>  	clk_put(ts.clock);
>  	return ret;
>  }
> -- 
> 1.9.1
> 

-- 
Dmitry
