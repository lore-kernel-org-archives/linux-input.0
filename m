From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: snvs_pwrkey - use devm_add_action_or_reset
Date: Wed, 6 Jul 2016 10:59:16 -0700
Message-ID: <20160706175916.GC5447@dtor-ws>
References: <1465742061-5360-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33652 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbcGFR73 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2016 13:59:29 -0400
Content-Disposition: inline
In-Reply-To: <1465742061-5360-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Jun 12, 2016 at 03:34:21PM +0100, Sudip Mukherjee wrote:
> If devm_add_action() fails we are printing the error message and
> returning but we have already setup a timer. Lets now use the helper
> devm_add_action_or_reset() and return and so in case of error the
> cleanup function will be called by the helper to delete the timer.
> 

We set up timer, that is correct, however the timer will not run so
there is no need to stop it.

Thanks.

> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 24a9f59..c301419 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -150,7 +150,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	input_set_capability(input, EV_KEY, pdata->keycode);
>  
>  	/* input customer action to cancel release timer */
> -	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
> +	error = devm_add_action_or_reset(&pdev->dev,
> +					 imx_snvs_pwrkey_act, pdata);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to register remove action\n");
>  		return error;
> -- 
> 1.9.1
> 

-- 
Dmitry
