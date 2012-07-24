From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 2/2] input: rotary-encoder: defer calls gpio_to_irq()
Date: Tue, 24 Jul 2012 14:45:18 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206AABE13B5@AUSP01VMBX24.collaborationhost.net>
References: <1343151487-27841-1-git-send-email-zonque@gmail.com>
 <1343151487-27841-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail127.messagelabs.com ([216.82.250.115]:64090 "EHLO
	mail127.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab2GXTpa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jul 2012 15:45:30 -0400
In-Reply-To: <1343151487-27841-2-git-send-email-zonque@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jhovold@gmail.com" <jhovold@gmail.com>

On Tuesday, July 24, 2012 10:38 AM, Daniel Mack wrote:
> Don't call gpio_to_irq() on GPIOs before gpio_request() succeeded on
> them. This avoids Ooopses with incorrect DT bindings.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/input/misc/rotary_encoder.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index 350cbd1..474b04f 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -223,8 +223,6 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  
>  	encoder->input = input;
>  	encoder->pdata = pdata;
> -	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> -	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
>  
>  	/* create and register the input driver */
>  	input->name = pdev->name;
> @@ -275,6 +273,9 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  		goto exit_free_gpio_a;
>  	}
>  
> +	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> +	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
> +
>  	/* request the IRQs */
>  	if (pdata->half_period) {
>  		handler = &rotary_encoder_half_period_irq;

Daniel,

You might want to put this patch first before adding the DT binding
stuff.

You also might consider using gpio_request_one() or even the
devm_* version, instead of doing the gpio_request() followed
by the  gpio_direction_input().

Actually, if you convert the probe to use the managed resource
devm_* stuff it would really cleanup the error path and the remove.

Regardless...

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>


