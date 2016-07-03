From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Input: snvs_pwrkey - use devm_add_action_or_reset
Date: Sun, 03 Jul 2016 21:37:06 +0100
Message-ID: <57797772.9020504@gmail.com>
References: <1465742061-5360-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465742061-5360-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sunday 12 June 2016 03:34 PM, Sudip Mukherjee wrote:
> If devm_add_action() fails we are printing the error message and
> returning but we have already setup a timer. Lets now use the helper
> devm_add_action_or_reset() and return and so in case of error the
> cleanup function will be called by the helper to delete the timer.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---

A gentle ping.

Regards
Sudip


>   drivers/input/keyboard/snvs_pwrkey.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 24a9f59..c301419 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -150,7 +150,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>   	input_set_capability(input, EV_KEY, pdata->keycode);
>
>   	/* input customer action to cancel release timer */
> -	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
> +	error = devm_add_action_or_reset(&pdev->dev,
> +					 imx_snvs_pwrkey_act, pdata);
>   	if (error) {
>   		dev_err(&pdev->dev, "failed to register remove action\n");
>   		return error;
>
