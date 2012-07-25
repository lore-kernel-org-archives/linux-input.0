From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] input: rotary-encoder: switch to devm_*
 allocation of GPIOs and IRQs
Date: Wed, 25 Jul 2012 09:29:49 -0700
Message-ID: <20120725162948.GB6276@core.coreip.homeip.net>
References: <1343202228-1507-1-git-send-email-zonque@gmail.com>
 <20120725160510.GA6276@core.coreip.homeip.net>
 <501019BC.1070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40266 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427Ab2GYQ3y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 12:29:54 -0400
Received: by yenl2 with SMTP id l2so899381yen.19
        for <linux-input@vger.kernel.org>; Wed, 25 Jul 2012 09:29:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <501019BC.1070703@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, jhovold@gmail.com, hartleys@visionengravers.com

On Wed, Jul 25, 2012 at 06:07:24PM +0200, Daniel Mack wrote:
> On 25.07.2012 18:05, Dmitry Torokhov wrote:
> > On Wed, Jul 25, 2012 at 09:43:47AM +0200, Daniel Mack wrote:
> >> @@ -263,12 +243,7 @@ exit_free_mem:
> >>  static int __devexit rotary_encoder_remove(struct platform_device *pdev)
> >>  {
> >>  	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
> >> -	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> >>  
> >> -	free_irq(encoder->irq_a, encoder);
> >> -	free_irq(encoder->irq_b, encoder);
> >> -	gpio_free(pdata->gpio_a);
> >> -	gpio_free(pdata->gpio_b);
> >>  	input_unregister_device(encoder->input);
> > 
> > Another botched devm_ conversion. *sigh*
> > 
> > Input device gone, IRQ arrives, kernel goes oops, machine hangs hard.
> > 
> > Please, do not use devm_ interfaces unless... Actually, just do not use
> > nor suggest devm_interfaces until all resources are devm-ized. Mixing 2
> > styles of releasing resources leads to trouble.
> 
> Ok, makes sense. Thanks for noticing. Are you happy with the first
> version I submitted then?

I have a few issues with that version as well:

1. It writes over platform_data field in the device which does nto
belong to the driver (this field belongs to the platform/board code);

2. I believe we should favor kernel supplied data over firmware
allowing users to override DT bindings, if needed;

3. It still uses devm_* to allocate memory and as I said I do not like
mixing 2 styles of managign resources in one driver.

Thanks.

-- 
Dmitry
