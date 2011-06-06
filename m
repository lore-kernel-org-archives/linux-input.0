From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH] INPUT: gpio_keys.c: Added OF support and enabled use
 with I2C GPIO expanders
Date: Mon, 6 Jun 2011 11:12:44 +0200
Message-ID: <20110606111244.406f0cd3@archvile>
References: <6613128190865466111@unknownmsgid>
	<BANLkTinNMeiimJqzFsWSS2zDggZ-o5k=fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:11121 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab1FFJMk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 05:12:40 -0400
In-Reply-To: <BANLkTinNMeiimJqzFsWSS2zDggZ-o5k=fA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org

On Thu, 2 Jun 2011 15:18:29 +0530
Shubhrajyoti Datta <omaplinuxkernel@gmail.com> wrote:

> On Wed, Jun 1, 2011 at 2:37 PM, <y@protonic.xs4all.nl> wrote:
> 
> > From: David Jander <david@protonic.nl>
> >
> > You may want to briefly explain the changes.
> 
> <Snip>
> 
> > +
> >        input = input_allocate_device();
> >        if (!ddata || !input) {
> >                dev_err(dev, "failed to allocate state\n");
> > @@ -465,12 +585,12 @@ static int __devinit gpio_keys_probe(struct
> > platform_device *pdev)
> >        ddata->disable = pdata->disable;
> >        mutex_init(&ddata->disable_lock);
> >
> > -       platform_set_drvdata(pdev, ddata);
> > +       dev_set_drvdata(dev, ddata);
> >        input_set_drvdata(input, ddata);
> >
> > -       input->name = pdev->name;
> > +       input->name = "GPIO_keyboard";
> >
> Why this change?

Good question.... somehow it isn't necessary anymore, and it was quite wrong
anyway. Thanks for pointing out, must have slipped over this....

Best regards,

-- 
David Jander
Protonic Holland.
