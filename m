From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: regulator-haptic: fix spelling mistake: "dveice"
 -> "device"
Date: Wed, 22 Jun 2016 17:03:29 -0700
Message-ID: <20160623000329.GC16965@dtor-ws>
References: <1466614949-23946-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35687 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbcFWADd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 20:03:33 -0400
Content-Disposition: inline
In-Reply-To: <1466614949-23946-1-git-send-email-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Luis de Bethencourt <luis@debethencourt.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 22, 2016 at 06:02:29PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/misc/regulator-haptic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
> index a804705..2e8f801 100644
> --- a/drivers/input/misc/regulator-haptic.c
> +++ b/drivers/input/misc/regulator-haptic.c
> @@ -124,7 +124,7 @@ regulator_haptic_parse_dt(struct device *dev, struct regulator_haptic *haptic)
>  
>  	node = dev->of_node;
>  	if(!node) {
> -		dev_err(dev, "Missing dveice tree data\n");
> +		dev_err(dev, "Missing device tree data\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.8.1
> 

-- 
Dmitry
