From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: snvs_pwrkey: fix returned value check of
 syscon_regmap_lookup_by_phandle()
Date: Tue, 8 Mar 2016 11:06:59 -0800
Message-ID: <20160308190659.GC24317@dtor-ws>
References: <1457455864-32077-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35603 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcCHTHC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 14:07:02 -0500
Received: by mail-pa0-f43.google.com with SMTP id bj10so18717157pad.2
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2016 11:07:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1457455864-32077-1-git-send-email-vz@mleia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-input@vger.kernel.org

On Tue, Mar 08, 2016 at 06:51:04PM +0200, Vladimir Zapolskiy wrote:
> On error syscon_regmap_lookup_by_phandle() returns ERR_PTR() value,
> which makes a check for NULL invalid and may lead to oops on error
> path.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 9adf13a..9e92206 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -111,9 +111,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
> -	if (!pdata->snvs) {
> +	if (IS_ERR(pdata->snvs)) {
>  		dev_err(&pdev->dev, "Can't get snvs syscon\n");
> -		return -ENODEV;
> +		return PTR_ERR(pdata->snvs);
>  	}
>  
>  	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
> -- 
> 2.1.4
> 

-- 
Dmitry
