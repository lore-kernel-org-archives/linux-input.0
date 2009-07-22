From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - swtich to dev_pm_ops
Date: Wed, 22 Jul 2009 09:41:16 -0700
Message-ID: <20090722164116.GC2775@dtor-d630.eng.vmware.com>
References: <1248184750-22274-1-git-send-email-mike@compulab.co.il> <20090721154848.GB4352@dtor-d630.eng.vmware.com> <4A65E58B.6010406@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:11348 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbZGVQlT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 12:41:19 -0400
Received: by rv-out-0506.google.com with SMTP id f6so99116rvb.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2009 09:41:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A65E58B.6010406@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-input@vger.kernel.org

On Tue, Jul 21, 2009 at 06:58:03PM +0300, Mike Rapoport wrote:
> 
> 
> Dmitry Torokhov wrote:
> > Hi Mike,
> > 
> > On Tue, Jul 21, 2009 at 04:59:10PM +0300, Mike Rapoport wrote:
> >> +
> >> +static struct dev_pm_ops gpio_keys_pm_ops = {
> >> +	.suspend	= gpio_keys_suspend,
> >> +	.resume		= gpio_keys_resume,
> >> +};
> >>  
> > 
> > This is not 100% equivalent conversion since we are now only handling
> > s2r, not s2d.. My question though is whether we care or not...
> 
> I doubt that systems that use gpio-keys ever supported s2d...
> If you apply it we'll know soon :)
> 
> >>  static struct platform_driver gpio_keys_device_driver = {
> >>  	.probe		= gpio_keys_probe,
> >> -	.remove		= __devexit_p(gpio_keys_remove),
> >> -	.suspend	= gpio_keys_suspend,
> >>  	.resume		= gpio_keys_resume,

I don't think you tried compiling this patch ;( We still need the
remove() method and I think we should keep the CONFIG_PM guards.

I will fix locally.

-- 
Dmitry
