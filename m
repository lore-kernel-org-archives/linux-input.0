From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: s3c2410_ts: Constify platform_device_id
Date: Wed, 6 May 2015 16:55:47 -0700
Message-ID: <20150506235547.GF5580@dtor-ws>
References: <1430495587-31762-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495587-31762-2-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33229 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbEFXzv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 19:55:51 -0400
Content-Disposition: inline
In-Reply-To: <1430495587-31762-2-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

On Sat, May 02, 2015 at 12:53:07AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/input/touchscreen/s3c2410_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index bdfa27dc097b..a4a103e1d11b 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -411,7 +411,7 @@ static const struct dev_pm_ops s3c_ts_pmops = {
>  };
>  #endif
>  
> -static struct platform_device_id s3cts_driver_ids[] = {
> +static const struct platform_device_id s3cts_driver_ids[] = {
>  	{ "s3c2410-ts", 0 },
>  	{ "s3c2440-ts", 0 },
>  	{ "s3c64xx-ts", FEAT_PEN_IRQ },
> -- 
> 2.1.4
> 

Applied both, thank you.

-- 
Dmitry
