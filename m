From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] Input: mxs-lradc-ts.c: Use
 devm_platform_ioremap_resource()
Date: Tue, 16 Jul 2019 09:32:13 +0200
Message-ID: <20190716073213.GB1182@penguin>
References: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
 <1554362243-2888-3-git-send-email-mojha@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554362243-2888-3-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 04, 2019 at 12:47:20PM +0530, Mukesh Ojha wrote:
> devm_platform_ioremap_resource() internally have platform_get_resource()
> and devm_ioremap_resource() in it. So instead of calling them separately
> use devm_platform_ioremap_resource() directly.
> 
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  drivers/input/touchscreen/mxs-lradc-ts.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index c850b51..af047fa 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -615,7 +615,6 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->parent->of_node;
>  	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
>  	struct mxs_lradc_ts *ts;
> -	struct resource *iores;
>  	int ret, irq, virq, i;
>  	u32 ts_wires = 0, adapt;
>  
> @@ -629,10 +628,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  	ts->dev = dev;
>  	spin_lock_init(&ts->lock);
>  
> -	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!iores)
> -		return -EINVAL;
> -	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
> +	ts->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (!ts->base)
>  		return -ENOMEM;

This driver did not implement error handling properly (should have used
IS_ERR()/PTR_ERR()), I adjusted and applied.

Thanks.

-- 
Dmitry
