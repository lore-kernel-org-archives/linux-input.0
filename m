From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] input: misc: max77693: Change Krzysztof Kozlowski's
 email to kernel.org
Date: Fri, 19 Aug 2016 10:16:31 -0700
Message-ID: <20160819171631.GG20499@dtor-ws>
References: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
 <1471435666-11880-5-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33579 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbcHSR3j (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 13:29:39 -0400
Content-Disposition: inline
In-Reply-To: <1471435666-11880-5-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Wed, Aug 17, 2016 at 02:07:45PM +0200, Krzysztof Kozlowski wrote:
> Change my email address to kernel.org instead of Samsung one for the
> purpose of any future contact.  The copyrights remain untouched and are
> attributed to Samsung.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied, thank you.

> ---
>  drivers/input/misc/max77693-haptic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> index 29ddeb7be84b..46b0f48fbf49 100644
> --- a/drivers/input/misc/max77693-haptic.c
> +++ b/drivers/input/misc/max77693-haptic.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 2014,2015 Samsung Electronics
>   * Jaewon Kim <jaewon02.kim@samsung.com>
> - * Krzysztof Kozlowski <k.kozlowski@samsung.com>
> + * Krzysztof Kozlowski <krzk@kernel.org>
>   *
>   * This program is not provided / owned by Maxim Integrated Products.
>   *
> @@ -426,7 +426,7 @@ static struct platform_driver max77693_haptic_driver = {
>  module_platform_driver(max77693_haptic_driver);
>  
>  MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
> -MODULE_AUTHOR("Krzysztof Kozlowski <k.kozlowski@samsung.com>");
> +MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
>  MODULE_DESCRIPTION("MAXIM 77693/77843 Haptic driver");
>  MODULE_ALIAS("platform:max77693-haptic");
>  MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
