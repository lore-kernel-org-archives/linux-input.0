From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - use devm_add_action_or_reset
Date: Sun, 03 Jul 2016 21:38:51 +0100
Message-ID: <577977DB.3020008@gmail.com>
References: <1465741736-5166-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35412 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcGCUiy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jul 2016 16:38:54 -0400
In-Reply-To: <1465741736-5166-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sunday 12 June 2016 03:28 PM, Sudip Mukherjee wrote:
> If devm_add_action() fails we are printing the error message and
> returning but we have already setup a delayed work or a timer.
> Lets now use the helper devm_add_action_or_reset() and return and in
> case of error the cleanup function will be called by the helper to
> cancel the delayed work or to delete the timer.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---

A gentle ping.

Regards
Sudip


>   drivers/input/keyboard/gpio_keys.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 2909365..2b1d2e9 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -542,7 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>   	 * Install custom action to cancel release timer and
>   	 * workqueue item.
>   	 */
> -	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
> +	error = devm_add_action_or_reset(&pdev->dev,
> +					 gpio_keys_quiesce_key, bdata);
>   	if (error) {
>   		dev_err(&pdev->dev,
>   			"failed to register quiesce action, error: %d\n",
>

