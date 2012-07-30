From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 1/3] input: rotary-encoder: defer calls gpio_to_irq()
Date: Mon, 30 Jul 2012 11:39:10 +0200
Message-ID: <5016563E.8020300@gmail.com>
References: <1343240714-11399-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40706 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab2G3JjQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jul 2012 05:39:16 -0400
Received: by weyx8 with SMTP id x8so3468507wey.19
        for <linux-input@vger.kernel.org>; Mon, 30 Jul 2012 02:39:15 -0700 (PDT)
In-Reply-To: <1343240714-11399-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jhovold@gmail.com, hartleys@visionengravers.com

Hi Dmitry and Hartley,

does that new approach look better to you?


Daniel

On 25.07.2012 20:25, Daniel Mack wrote:
> Don't call gpio_to_irq() on GPIOs before gpio_request() succeeded on
> them. This avoids Ooopses with incorrect DT bindings.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/input/misc/rotary_encoder.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index f07f784..00a7bda 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -163,8 +163,6 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  
>  	encoder->input = input;
>  	encoder->pdata = pdata;
> -	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> -	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
>  
>  	/* create and register the input driver */
>  	input->name = pdev->name;
> @@ -215,6 +213,9 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  		goto exit_free_gpio_a;
>  	}
>  
> +	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> +	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
> +
>  	/* request the IRQs */
>  	if (pdata->half_period) {
>  		handler = &rotary_encoder_half_period_irq;
> 

