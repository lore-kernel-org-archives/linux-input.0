From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: pxa27x_keypad: Handle return value of
 clk_prepare_enable.
Date: Thu, 31 Aug 2017 11:50:54 -0700
Message-ID: <20170831185054.GC14370@dtor-ws>
References: <e18b64df1c144ac6ac05bd16e0d5d0cd59a20d13.1501581502.git.arvind.yadav.cs@gmail.com>
 <462d2ba4a19174ca1af9efe74f57fd815c0034d1.1501581502.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34066 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbdHaSu6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 31 Aug 2017 14:50:58 -0400
Content-Disposition: inline
In-Reply-To: <462d2ba4a19174ca1af9efe74f57fd815c0034d1.1501581502.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 01, 2017 at 03:34:10PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/keyboard/pxa27x_keypad.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 3841fa3..a3396a7 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -644,9 +644,12 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
>  static int pxa27x_keypad_open(struct input_dev *dev)
>  {
>  	struct pxa27x_keypad *keypad = input_get_drvdata(dev);
> -
> +	int ret;
>  	/* Enable unit clock */
> -	clk_prepare_enable(keypad->clk);
> +	ret = clk_prepare_enable(keypad->clk);
> +	if (ret)
> +		return ret;
> +
>  	pxa27x_keypad_config(keypad);
>  
>  	return 0;
> @@ -683,6 +686,7 @@ static int pxa27x_keypad_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
>  	struct input_dev *input_dev = keypad->input_dev;
> +	int ret;
>  
>  	/*
>  	 * If the keypad is used as wake up source, the clock is not turned
> @@ -695,7 +699,11 @@ static int pxa27x_keypad_resume(struct device *dev)
>  
>  		if (input_dev->users) {
>  			/* Enable unit clock */
> -			clk_prepare_enable(keypad->clk);
> +			ret = clk_prepare_enable(keypad->clk);
> +			if (ret) {
> +				mutex_unlock(&input_dev->mutex);
> +				return ret;
> +			}
>  			pxa27x_keypad_config(keypad);
>  		}

Rewrote as

	int ret = 0;

	...

		mutex_lock(&input_dev->mutex);

		if (input_dev->users) {
			/* Enable unit clock */
			ret = clk_prepare_enable(keypad->clk);
			if (!ret)
				pxa27x_keypad_config(keypad);
		}

		mutex_unlock(&input_dev->mutex);

	...
	return ret;

to avoid unlocking mutex in 2 places and applied, thanks.

-- 
Dmitry
