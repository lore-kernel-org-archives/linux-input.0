From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 11/14] input: spear-keyboard: use __maybe_unused to hide
 pm functions
Date: Wed, 2 Mar 2016 09:12:57 -0800
Message-ID: <20160302171257.GB4318@dtor-ws>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-12-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33269 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbcCBRNB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 12:13:01 -0500
Content-Disposition: inline
In-Reply-To: <1456934350-1389172-12-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Rajeev Kumar <rajeevkumar.linux@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 02, 2016 at 04:59:03PM +0100, Arnd Bergmann wrote:
> The spear keyboard driver uses #ifdef CONFIG_PM to hide its
> power management functions, but then uses references from
> SIMPLE_DEV_PM_OPS that are only present if both CONFIG_PM
> and CONFIG_PM_SLEEP are set, resulting in a warning about unused
> functions:
> 
> drivers/input/keyboard/spear-keyboard.c:292:12: error: 'spear_kbd_suspend' defined but not used [-Werror=unused-function]
> drivers/input/keyboard/spear-keyboard.c:345:12: error: 'spear_kbd_resume' defined but not used [-Werror=unused-function]
> 
> This removes the #ifdef and instead uses a __maybe_unused
> annotation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

> ---
>  drivers/input/keyboard/spear-keyboard.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index 623d451767e3..8083eaa0524a 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -288,8 +288,7 @@ static int spear_kbd_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int spear_kbd_suspend(struct device *dev)
> +static int __maybe_unused spear_kbd_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct spear_kbd *kbd = platform_get_drvdata(pdev);
> @@ -342,7 +341,7 @@ static int spear_kbd_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int spear_kbd_resume(struct device *dev)
> +static int __maybe_unused spear_kbd_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct spear_kbd *kbd = platform_get_drvdata(pdev);
> @@ -368,7 +367,6 @@ static int spear_kbd_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
>  
> -- 
> 2.7.0
> 

-- 
Dmitry
