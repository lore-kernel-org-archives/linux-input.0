From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: st-keyscan - Fix 'defined but not used' compiler
 warnings
Date: Sun, 20 Jul 2014 13:43:42 -0700
Message-ID: <20140720204342.GE18347@core.coreip.homeip.net>
References: <1404809278-2604-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53272 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbaGTUnp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 16:43:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so8589758pab.1
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 13:43:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404809278-2604-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-input@vger.kernel.org

On Tue, Jul 08, 2014 at 10:47:58AM +0200, Tobias Klauser wrote:
> Add #ifdef CONFIG_PM_SLEEP around keyscan_supend() and keyscan_resume() to fix
> the following compiler warnings occuring if CONFIG_PM_SLEEP is unset:
> 
>   + /scratch/kisskb/src/drivers/input/keyboard/st-keyscan.c: warning: 'keyscan_resume' defined but not used [-Wunused-function]:  => 235:12
>   + /scratch/kisskb/src/drivers/input/keyboard/st-keyscan.c: warning: 'keyscan_suspend' defined but not used [-Wunused-function]:  => 218:12
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lkml.org/lkml/2014/7/8/109
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>


Applied, thank you.

> ---
>  drivers/input/keyboard/st-keyscan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
> index 758b487..de7be4f 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -215,6 +215,7 @@ static int keyscan_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int keyscan_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -249,6 +250,7 @@ static int keyscan_resume(struct device *dev)
>  	mutex_unlock(&input->mutex);
>  	return retval;
>  }
> +#endif
>  
>  static SIMPLE_DEV_PM_OPS(keyscan_dev_pm_ops, keyscan_suspend, keyscan_resume);
>  
> -- 
> 2.0.1
> 
> 

-- 
Dmitry
