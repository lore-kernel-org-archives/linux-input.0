From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 18/33] Input: soc_button_array - Use 'dev' instead of
 dereferencing it and other changes
Date: Wed, 18 Jan 2017 11:42:16 -0800
Message-ID: <20170118194216.GJ33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-19-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35251 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdARTmT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 14:42:19 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-19-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Wed, Jan 18, 2017 at 09:46:39AM -0800, Guenter Roeck wrote:
> Use local variable 'dev' instead of dereferencing it several times.
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Use local variable 'struct device *dev' consistently

Applied, thank you.

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/input/misc/soc_button_array.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 908b51089dee..fb3219a8d3c0 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -167,12 +167,12 @@ static int soc_button_probe(struct platform_device *pdev)
>  
>  	button_info = (struct soc_button_info *)id->driver_data;
>  
> -	if (gpiod_count(&pdev->dev, KBUILD_MODNAME) <= 0) {
> -		dev_dbg(&pdev->dev, "no GPIO attached, ignoring...\n");
> +	if (gpiod_count(dev, KBUILD_MODNAME) <= 0) {
> +		dev_dbg(dev, "no GPIO attached, ignoring...\n");
>  		return -ENODEV;
>  	}
>  
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
