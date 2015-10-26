From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: snvs_pwrkey - remove duplicated semicolon
Date: Mon, 26 Oct 2015 01:46:51 -0700
Message-ID: <20151026084651.GD13056@localhost>
References: <1441935339-8257-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34184 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbJZIq7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 04:46:59 -0400
Content-Disposition: inline
In-Reply-To: <1441935339-8257-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Robin Gong <b38343@freescale.com>, Shawn Guo <shawnguo@kernel.org>, linux-input@vger.kernel.org, Frank Li <Frank.Li@freescale.com>

On Fri, Sep 11, 2015 at 03:35:39AM +0200, Javier Martinez Canillas wrote:
> Remove the unneded semicolon since it is clearly a typo error.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Applied, thank you.

> ---
> 
>  drivers/input/keyboard/snvs_pwrkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 78fd24ca3813..a4db65d67e1b 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -110,7 +110,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	if (!pdata)
>  		return -ENOMEM;
>  
> -	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");;
> +	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
>  
>  	if (!pdata->snvs) {
>  		dev_err(&pdev->dev, "Can't get snvs syscon\n");
> -- 
> 2.4.3
> 

-- 
Dmitry
