From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC v2] input: Add new driver for GPIO beeper
Date: Fri, 30 Nov 2012 09:30:38 -0800
Message-ID: <1536835.oRFxdYCaAT@dtor-d630.eng.vmware.com>
References: <1354210139-25374-1-git-send-email-shc_work@mail.ru> <20121130164435.GA28721@core.coreip.homeip.net> <1354295037.675775679@f186.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64504 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab2K3Rao (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Nov 2012 12:30:44 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so487949pad.19
        for <linux-input@vger.kernel.org>; Fri, 30 Nov 2012 09:30:44 -0800 (PST)
In-Reply-To: <1354295037.675775679@f186.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Friday, November 30, 2012 09:03:57 PM Alexander Shiyan wrote:
> ...
> 
> > On Fri, Nov 30, 2012 at 02:18:00PM +0400, Alexander Shiyan wrote:
> > > > On Thu, Nov 29, 2012 at 09:28:59PM +0400, Alexander Shiyan wrote:
> > > > > This patch adds a new driver for the beeper controlled via GPIO pin.
> > > > > The driver does not depend on the architecture and is positioned as
> > > > > a replacement for the specific drivers that are used for this
> > > > > function,
> > > > > for example drivers/input/misc/ixp4xx-beeper.
> 
> ...
> 
> > > > I think the driver should look like in the patch below. Can you please
> > > > tell me if it works for you?
> > > 
> > > Works. The test was on ARM CLPS711X board with the driver is compiled
> > > into the kernel, ie without modules. Non-critical comments inlined.
> > 
> > Excellent, thank you.
> > 
> > > > +	beeper = devm_kzalloc(&pdev->dev, sizeof(struct gpio_beeper),
> > > > +				GFP_KERNEL);
> > > 
> > > I would prefer to do when moving padding on brackets.
> > 
> > I am not sure what you were trying to say here... Are you saying
> > GFP_KERNEL should be aligned with opening parenthesis?
> 
> Yes.  This not important, but just looks better.  :)
> 
> > > > +	input = devm_input_allocate_device(dev);
> > > 
> > > I am temporaty replace this function to input_allocate_device() because
> > > I am tested this driver on 2.6.8.
> > 
> > Surely not 2.6? Anyway for devm_input_allocate_device() support you need
> > the following commit from my 'next' branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> 
> Sorry. Of course I meant 3.6.8.
> 
> > > > +static struct platform_driver gpio_beeper_platform_driver = {
> > > > +	.driver	= {
> > > > +		.name	= "gpio-beeper",
> > > > +		.owner	= THIS_MODULE,
> > > > +	},
> > > > +	.probe		= gpio_beeper_probe,
> > > > +	.shutdown	= gpio_beeper_shutdown,
> > > > +};
> > > > +module_platform_driver(gpio_beeper_platform_driver);
> > > 
> > > No "remove" function?
> > 
> > With all resources being devm_* managed (and shuttign off beeper
> > happening in gpio_keys_close()) the remove function would be just an
> > empty stub. As far as I can see platform devices not have to have a
> > remove function, but testing this by unloading the driver or unbinding
> > it via sysfs would be nice.
> 
> Unfortunately, I am unable to check in as a module.
> Otherwise, you're right, because there will be no input_unregister_device,
> we can not use the "remove".

You can still use input_unregister_device() even if you used
devm_input_allocate_device() to allocate it. But most often you do not
have to, as with this driver.

> 
> You commit the result? Or I should remade complete non-RFC patch?

I will commit, I just need your "Signed-off-by: ..." as you are the author.

Thanks.

-- 
Dmitry
