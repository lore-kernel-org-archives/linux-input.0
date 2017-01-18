From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/33] Input: cros_ec_keyb - Drop unnecessary call to
 dev_set_drvdata and other changes
Date: Wed, 18 Jan 2017 10:39:02 -0800
Message-ID: <20170118183902.GA9584@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-5-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36835 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbdARSjF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 13:39:05 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-5-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Lee Jones <lee.jones@linaro.org>, Vic Yang <victoryang@google.com>

On Wed, Jan 18, 2017 at 09:46:25AM -0800, Guenter Roeck wrote:
> There is no call to platform_get_drvdata() or dev_get_drvdata().
> Drop the unnecessary call to dev_set_drvdata().
> Other relevant changes:
>   Use existing variable 'dev' instead of dereferencing it several times
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop dev_set_drvdata()
> - Use local variable 'struct device *dev' consistently
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 25943e9bc8bf..87d071ae21da 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -222,7 +222,7 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
>  	struct device_node *np;
>  	int err;
>  
> -	np = pdev->dev.of_node;
> +	np = dev->of_node;
>  	if (!np)
>  		return -ENODEV;
>  
> @@ -248,7 +248,6 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
>  	ckdev->ec = ec;
>  	ckdev->notifier.notifier_call = cros_ec_keyb_work;
>  	ckdev->dev = dev;
> -	dev_set_drvdata(dev, ckdev);
>  
>  	idev->name = CROS_EC_DEV_NAME;
>  	idev->phys = ec->phys_name;
> -- 
> 2.7.4
> 

-- 
Dmitry
