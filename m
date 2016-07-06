From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - use devm_add_action_or_reset
Date: Wed, 6 Jul 2016 10:57:34 -0700
Message-ID: <20160706175734.GB5447@dtor-ws>
References: <1465741736-5166-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34421 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbcGFR5i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2016 13:57:38 -0400
Content-Disposition: inline
In-Reply-To: <1465741736-5166-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Jun 12, 2016 at 03:28:56PM +0100, Sudip Mukherjee wrote:
> If devm_add_action() fails we are printing the error message and
> returning but we have already setup a delayed work or a timer.
> Lets now use the helper devm_add_action_or_reset() and return and in
> case of error the cleanup function will be called by the helper to
> cancel the delayed work or to delete the timer.

We do not fire up timer/work unless IRQ triggers and we register it
afterwards so there is no need to quiesce the key if adding devm ction
fails.

Thanks.

> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/input/keyboard/gpio_keys.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 2909365..2b1d2e9 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -542,7 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	 * Install custom action to cancel release timer and
>  	 * workqueue item.
>  	 */
> -	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
> +	error = devm_add_action_or_reset(&pdev->dev,
> +					 gpio_keys_quiesce_key, bdata);
>  	if (error) {
>  		dev_err(&pdev->dev,
>  			"failed to register quiesce action, error: %d\n",
> -- 
> 1.9.1
> 

-- 
Dmitry
