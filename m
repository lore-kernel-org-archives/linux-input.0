From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: touchscreen: mxs-lradc: Do a NULL check on
 iores
Date: Mon, 14 Aug 2017 10:26:54 -0700
Message-ID: <20170814172654.GA15368@dtor-ws>
References: <1498099872-16959-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33937 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdHNR06 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Aug 2017 13:26:58 -0400
Received: by mail-pg0-f65.google.com with SMTP id y192so11671603pgd.1
        for <linux-input@vger.kernel.org>; Mon, 14 Aug 2017 10:26:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1498099872-16959-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, ksenija.stanojevic@gmail.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

On Wed, Jun 21, 2017 at 11:51:12PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> platform_get_resource() may fail, so we should better do a NULL check
> and return error on failure.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thank you.

> ---
> Changes since v1:
> - Instead of using devm_ioremap_resource, do a NULL check on iores
> 
>  drivers/input/touchscreen/mxs-lradc-ts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index 58c016c..71bf493 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -630,6 +630,8 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  	spin_lock_init(&ts->lock);
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iores)
> +		return -EINVAL;
>  	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
>  	if (IS_ERR(ts->base))
>  		return PTR_ERR(ts->base);
> -- 
> 2.7.4
> 

-- 
Dmitry
