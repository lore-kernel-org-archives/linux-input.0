From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: spear-keyboard - Add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Mon, 27 Oct 2014 16:37:44 -0700
Message-ID: <20141027233744.GC7594@dtor-ws>
References: <000801cff1e2$2427ba40$6c772ec0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44078 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbaJ0Xht (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2014 19:37:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id eu11so6462681pac.16
        for <linux-input@vger.kernel.org>; Mon, 27 Oct 2014 16:37:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000801cff1e2$2427ba40$6c772ec0$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>

Hi Jingoo,

On Mon, Oct 27, 2014 at 09:32:58PM +0900, Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions
> 
> Add CONFIG_PM_SLEEP to suspend/resume functions instead of
> CONFIG_PM to fix the following build warning when CONFIG_PM_SLEEP
> is not selected and CONFIG_PM is selected. This is because sleep
> PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when the
> CONFIG_PM_SLEEP is enabled.

Recently I've become a fan of __maybe_unused markings as they insulate
us from various CONFIG changes in unrelated subsystems, I'll transform
this patch to use them instead.

Thanks.

> 
> drivers/input/keyboard/spear-keyboard.c:292:12: warning: 'spear_kbd_suspend' defined but not used [-Wunused-function]
> drivers/input/keyboard/spear-keyboard.c:345:12: warning: 'spear_kbd_resume' defined but not used [-Wunused-function]
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/input/keyboard/spear-keyboard.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index 258af10..fc93e79 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -288,7 +288,7 @@ static int spear_kbd_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int spear_kbd_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -- 
> 1.7.9.5
> 
> 

-- 
Dmitry
