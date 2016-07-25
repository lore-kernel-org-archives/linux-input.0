From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Mon, 25 Jul 2016 10:08:39 -0700
Message-ID: <20160725170839.GA27415@dtor-ws>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160721062950.GB5993@lukather>
 <20160721064140.GA17658@dtor-ws>
 <20160725094542.GI7419@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160725094542.GI7419@lukather>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 25, 2016 at 11:45:42AM +0200, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org wrote:
> Hi Dmitry,
> 
> On Wed, Jul 20, 2016 at 11:41:40PM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 21, 2016 at 08:29:50AM +0200, Maxime Ripard wrote:
> > > On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
> > > > +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> > > > +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> > > > +					   sunxi_gpadc_tp_up_irq_handler, 0,
> > > > +					   "tp_up", info);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&pdev->dev,
> > > > +			"could not request TP_UP_PENDING interrupt: %d\n", ret);
> > > > +		goto err;
> > > > +	}
> > > 
> > > You enable the interrupts...
> > > 
> > > > +	info->tp_up_irq = irq;
> > > > +	disable_irq(irq);
> > > > +
> > > > +	ret = input_register_device(input);
> > > > +	if (ret) {
> > > > +		dev_err(&pdev->dev, "failed to register input device\n");
> > > > +		goto err;
> > > > +	}
> > > 
> > > ... but your driver isn't registered yet. How does input_report and
> > > input_sync behave in such a case?
> > 
> > This is explicitly allowed:
> > 
> > "
> > ...
> >  * NOTE: input_event() may be safely used right after input device was
> >  * allocated with input_allocate_device(), even before it is registered
> >  * with input_register_device(), but the event will not reach any of the
> >  * input handlers. Such early invocation of input_event() may be used
> >  * to 'seed' initial state of a switch or initial position of absolute
> >  * axis, etc.
> >  */
> > "
> 
> Good to know. Still, it feels like it should be handled explicitly,
> instead of relying on the fact that we only call input_event in our
> handler and that it works that way.

Why? It is the documented property of input API and it is done so
precisely so that you can register interrupt before registering input
device. That is done because once registered input device is supposed to
be fully-functional.  It does not matter for this driver but there are
drivers out there that require interrupt handling as part of their
"open" method.

Thanks.

-- 
Dmitry
