From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 09/10] Input: sirfsoc-onkey: Handle return value of
 platform_get_irq
Date: Fri, 17 Nov 2017 11:58:59 -0800
Message-ID: <20171117195859.x34mmfrbhnvh5gpq@dtor-ws>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510946132-13554-10-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:32962 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdKQT7C (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:59:02 -0500
Content-Disposition: inline
In-Reply-To: <1510946132-13554-10-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Nov 18, 2017 at 12:45:31AM +0530, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/sirfsoc-onkey.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
> index 4fd038d..de04b48 100644
> --- a/drivers/input/misc/sirfsoc-onkey.c
> +++ b/drivers/input/misc/sirfsoc-onkey.c
> @@ -149,6 +149,9 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
>  	sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
>  
>  	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
>  	error = devm_request_irq(&pdev->dev, irq,
>  				 sirfsoc_pwrc_isr, 0,
>  				 "sirfsoc_pwrc_int", pwrcdrv);
> -- 
> 2.7.4
> 

-- 
Dmitry
