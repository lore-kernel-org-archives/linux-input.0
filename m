From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/10] Input: serio: Fix platform_get_irq's error checking
Date: Fri, 17 Nov 2017 12:27:54 -0800
Message-ID: <20171117202754.5h7arnxqxck3yegm@dtor-ws>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510946132-13554-5-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:40356 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756456AbdKQU15 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 15:27:57 -0500
Content-Disposition: inline
In-Reply-To: <1510946132-13554-5-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Nov 18, 2017 at 12:45:26AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/serio/sun4i-ps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/sun4i-ps2.c b/drivers/input/serio/sun4i-ps2.c
> index 04b96fe..405c82f 100644
> --- a/drivers/input/serio/sun4i-ps2.c
> +++ b/drivers/input/serio/sun4i-ps2.c
> @@ -264,7 +264,7 @@ static int sun4i_ps2_probe(struct platform_device *pdev)
>  
>  	/* Get IRQ for the device */
>  	irq = platform_get_irq(pdev, 0);
> -	if (!irq) {
> +	if (irq < 0) {

irq is unsigned.

>  		dev_err(dev, "no IRQ found\n");
>  		error = -ENXIO;

I'd rather we did not clobber error.

>  		goto err_disable_clk;
> -- 
> 2.7.4
> 

-- 
Dmitry
