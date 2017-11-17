From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/10] Input: sun4i-ts: Handle return value of
 platform_get_irq
Date: Fri, 17 Nov 2017 11:56:00 -0800
Message-ID: <20171117195600.a3eiaflvifqwtopr@dtor-ws>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510946132-13554-8-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:41755 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdKQT4F (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:56:05 -0500
Content-Disposition: inline
In-Reply-To: <1510946132-13554-8-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Nov 18, 2017 at 12:45:29AM +0530, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/touchscreen/sun4i-ts.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> index d2e14d9..2753fd3 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -315,6 +315,9 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  		return PTR_ERR(ts->base);
>  
>  	ts->irq = platform_get_irq(pdev, 0);
> +	if (ts->irq < 0)

ts->irq is unsigned, you need to change it or use a temporary
(preferable).

> +		return ts->irq;
> +
>  	error = devm_request_irq(dev, ts->irq, sun4i_ts_irq, 0, "sun4i-ts", ts);
>  	if (error)
>  		return error;
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
