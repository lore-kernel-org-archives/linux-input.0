From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - use the preferred form for passing a
 size of a struct
Date: Sun, 4 Jan 2015 14:29:24 -0800
Message-ID: <20150104222924.GB31987@dtor-ws>
References: <1419947236-17328-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:50360 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbbADW33 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Jan 2015 17:29:29 -0500
Received: by mail-yk0-f176.google.com with SMTP id 79so2971373ykr.7
        for <linux-input@vger.kernel.org>; Sun, 04 Jan 2015 14:29:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419947236-17328-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Tue, Dec 30, 2014 at 11:47:16AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> According to Documentation/CodingStyle - Chapter 14:
> 
> "The preferred form for passing a size of a struct is the following:
> 
>         p = kmalloc(sizeof(*p), ...);
> 
> The alternative form where struct name is spelled out hurts readability and
> introduces an opportunity for a bug when the pointer variable type is changed
> but the corresponding sizeof that is passed to a memory allocator is not."
> 
> So do it as recommeded.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/imx_keypad.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index e53f232..2e855e6 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -448,8 +448,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	keypad = devm_kzalloc(&pdev->dev, sizeof(struct imx_keypad),
> -			      GFP_KERNEL);
> +	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
>  	if (!keypad) {
>  		dev_err(&pdev->dev, "not enough memory for driver data\n");
>  		return -ENOMEM;
> -- 
> 1.9.1
> 

-- 
Dmitry
