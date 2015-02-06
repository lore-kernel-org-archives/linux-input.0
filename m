From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH] Input: bfin_rotary - mark suspend and resume code as __maybe_unused
Date: Fri, 6 Feb 2015 17:06:58 +0800
Message-ID: <CAJxxZ0PetVdf+=E1in0PcPZW3k3XsE903+NSeYGsEguBQtnzag@mail.gmail.com>
References: <20150206060953.GA34087@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:55152 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbbBFJG7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 04:06:59 -0500
In-Reply-To: <20150206060953.GA34087@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sonic Zhang <sonic.zhang@analog.com>, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Dmitry,

On Fri, Feb 6, 2015 at 2:09 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Instead of using #ifdef to guard potentially unused suspend and resume code
> let's mark them as __maybe_unused so they still get discarded if they are
> not used but we do not get warning. This allows for better compile coverage.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/bfin_rotary.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> index a39793c..09d7612 100644
> --- a/drivers/input/misc/bfin_rotary.c
> +++ b/drivers/input/misc/bfin_rotary.c
> @@ -232,8 +232,7 @@ static int bfin_rotary_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int bfin_rotary_suspend(struct device *dev)
> +static int __maybe_unused bfin_rotary_suspend(struct device *dev)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct bfin_rot *rotary = platform_get_drvdata(pdev);
> @@ -248,7 +247,7 @@ static int bfin_rotary_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int bfin_rotary_resume(struct device *dev)
> +static int __maybe_unused bfin_rotary_resume(struct device *dev)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct bfin_rot *rotary = platform_get_drvdata(pdev);
> @@ -266,20 +265,15 @@ static int bfin_rotary_resume(struct device *dev)
>         return 0;
>  }
>
> -static const struct dev_pm_ops bfin_rotary_pm_ops = {
> -       .suspend        = bfin_rotary_suspend,
> -       .resume         = bfin_rotary_resume,
> -};
> -#endif
> +static SIMPLE_DEV_PM_OPS(bfin_rotary_pm_ops,
> +                        bfin_rotary_suspend, bfin_rotary_resume);
>
>  static struct platform_driver bfin_rotary_device_driver = {
>         .probe          = bfin_rotary_probe,
>         .remove         = bfin_rotary_remove,
>         .driver         = {
>                 .name   = "bfin-rotary",

You missed
                   .owner  = THIS_MODULE,
here.


> -#ifdef CONFIG_PM
>                 .pm     = &bfin_rotary_pm_ops,
> -#endif
>         },
>  };
>  module_platform_driver(bfin_rotary_device_driver);
> --
> 2.2.0.rc0.207.ga3a616c
>
>

Regards,

Sonic
