From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio-keys: report error when invalid key number
Date: Mon, 24 Aug 2015 10:48:20 -0700
Message-ID: <20150824174820.GA22442@dtor-ws>
References: <1440418064-15971-1-git-send-email-van.freenix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36098 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbbHXRsY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Aug 2015 13:48:24 -0400
Content-Disposition: inline
In-Reply-To: <1440418064-15971-1-git-send-email-van.freenix@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peng Fan <van.freenix@gmail.com>
Cc: linus.walleij@linaro.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wolfram Sang <wsa@the-dreams.de>, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Aug 24, 2015 at 08:07:44PM +0800, Peng Fan wrote:
> When the input key number is not valid one of
> '/sys/devices/soc0/gpio-keys/keys', need to report
> an error, but not continue.
> 
> See the following example:
> root@yocto:/sys/devices/soc0/gpio-keys# cat keys
> 114-116
> root@yocto:/sys/devices/soc0/gpio-keys# echo 77 > keys
> root@yocto:/sys/devices/soc0/gpio-keys#
> 
> we want 'echo 77 > keys' to report an error, but not
> silence to give us an fake illusion that all is 'ok'.
> 
> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexander Stein <alexander.stein@systec-electronic.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/gpio_keys.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index ddf4045..b98f3b4 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -239,6 +239,11 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
>  		}
>  	}
>  
> +	if (i == ddata->pdata->nbuttons) {
> +		error = -EINVAL;
> +		goto out;
> +	}
> +
>  	mutex_lock(&ddata->disable_lock);
>  
>  	for (i = 0; i < ddata->pdata->nbuttons; i++) {
> -- 
> 1.8.4.5
> 

-- 
Dmitry
