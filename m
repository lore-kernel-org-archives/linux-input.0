From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next v2] input: touchscreen: mxs-lradc: Fix return value
 check in mxs_lradc_ts_probe()
Date: Thu, 27 Apr 2017 09:52:44 -0700
Message-ID: <20170427165244.GA33675@dtor-ws>
References: <20170425062646.26043-1-weiyj.lk@gmail.com>
 <20170427151352.23463-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36157 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966735AbdD0Qwr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2017 12:52:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so11898345pfd.3
        for <linux-input@vger.kernel.org>; Thu, 27 Apr 2017 09:52:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170427151352.23463-1-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Lee Jones <lee.jones@linaro.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Thu, Apr 27, 2017 at 03:13:52PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). Use devm_ioremap_resource() instead of devm_ioremap().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Lee, could you please pick this one up as well?

> ---
> v1 -> v2: use devm_ioremap_resource()
> ---
>  drivers/input/touchscreen/mxs-lradc-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index 4b4aebf..2c5076c 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -630,7 +630,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  	spin_lock_init(&ts->lock);
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
> +	ts->base = devm_ioremap_resource(dev, iores);
>  	if (IS_ERR(ts->base))
>  		return PTR_ERR(ts->base);
> 

-- 
Dmitry
