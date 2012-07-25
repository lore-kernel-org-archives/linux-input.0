From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] input: rotary-encoder: switch to devm_*
 allocation of GPIOs and IRQs
Date: Wed, 25 Jul 2012 09:05:10 -0700
Message-ID: <20120725160510.GA6276@core.coreip.homeip.net>
References: <1343202228-1507-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52059 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab2GYQF0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 12:05:26 -0400
Received: by pbbrp8 with SMTP id rp8so1613594pbb.19
        for <linux-input@vger.kernel.org>; Wed, 25 Jul 2012 09:05:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343202228-1507-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, jhovold@gmail.com, hartleys@visionengravers.com

On Wed, Jul 25, 2012 at 09:43:47AM +0200, Daniel Mack wrote:
> @@ -263,12 +243,7 @@ exit_free_mem:
>  static int __devexit rotary_encoder_remove(struct platform_device *pdev)
>  {
>  	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
> -	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
>  
> -	free_irq(encoder->irq_a, encoder);
> -	free_irq(encoder->irq_b, encoder);
> -	gpio_free(pdata->gpio_a);
> -	gpio_free(pdata->gpio_b);
>  	input_unregister_device(encoder->input);

Another botched devm_ conversion. *sigh*

Input device gone, IRQ arrives, kernel goes oops, machine hangs hard.

Please, do not use devm_ interfaces unless... Actually, just do not use
nor suggest devm_interfaces until all resources are devm-ized. Mixing 2
styles of releasing resources leads to trouble.

Thanks.

-- 
Dmitry
