From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/13] Input: clps711x-keypad - Make of_device_id array
 const
Date: Thu, 8 May 2014 08:52:56 -0700
Message-ID: <20140508155256.GB11231@core.coreip.homeip.net>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36554 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaEHPxB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 11:53:01 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so2462515pde.13
        for <linux-input@vger.kernel.org>; Thu, 08 May 2014 08:53:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org, 'Alexander Shiyan' <shc_work@mail.ru>

On Wed, May 07, 2014 at 06:11:52PM +0900, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied the whole lot, thank you.

> ---
>  drivers/input/keyboard/clps711x-keypad.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
> index 3955aec..552b65c 100644
> --- a/drivers/input/keyboard/clps711x-keypad.c
> +++ b/drivers/input/keyboard/clps711x-keypad.c
> @@ -185,7 +185,7 @@ static int clps711x_keypad_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct of_device_id clps711x_keypad_of_match[] = {
> +static const struct of_device_id clps711x_keypad_of_match[] = {
>  	{ .compatible = "cirrus,clps711x-keypad", },
>  	{ }
>  };
> -- 
> 1.7.10.4
> 
> 

-- 
Dmitry
