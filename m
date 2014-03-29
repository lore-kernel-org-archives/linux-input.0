From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH v3 04/10] input: misc: Add driver for
 AXP20x Power Enable Key
Date: Sat, 29 Mar 2014 12:05:11 -0700
Message-ID: <20140329190511.GA10710@core.coreip.homeip.net>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-5-git-send-email-carlo@caione.org>
 <20140328073803.GA22093@core.coreip.homeip.net>
 <20140329153624.GA3952@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDP6N55ZUYDRB3FS3SMQKGQE563P4SY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140329153624.GA3952-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 29, 2014 at 04:36:24PM +0100, Carlo Caione wrote:
> On Fri, Mar 28, 2014 at 12:38:03AM -0700, Dmitry Torokhov wrote:
> > Hi Carlo,
> 
> Hi Dmitry,
> 
> > 
> > On Thu, Mar 27, 2014 at 10:29:18PM +0100, Carlo Caione wrote:

[...]

> > > +
> > > +	error = devm_request_threaded_irq(&pdev->dev, axp20x_pek->irq_dbr,
> > > +					  NULL, axp20x_pek_irq, 0,
> > > +					  "axp20x-pek-dbr", idev);
> > 
> > Why does it have to be threaded IRQ?
> 
> Because this is already handled as a nested irq from a irq thread. The
> parent threaded irq is installed by regmap_add_irq_chip() in the MFD
> driver core.

Then you probably want to use devm_request_any_context_irq() - the
driver does not necessarily care if IRQ is threaded or not, t can work
either way.

> 
> > > +	if (error) {
> > > +		dev_err(axp20x->dev, "Failed to request dbr IRQ#%d: %d\n",
> > > +			axp20x_pek->irq_dbr, error);
> > > +
> > > +		return error;
> > > +	}
> > > +
> > > +	error = devm_request_threaded_irq(&pdev->dev, axp20x_pek->irq_dbf,
> > > +					  NULL, axp20x_pek_irq, 0,
> > > +					  "axp20x-pek-dbf", idev);
> > > +	if (error) {
> > > +		dev_err(axp20x->dev, "Failed to request dbf IRQ#%d: %d\n",
> > > +			axp20x_pek->irq_dbf, error);
> > > +		return error;
> > > +	}
> > > +
> > > +	idev->dev.groups = dev_attr_groups;
> > 
> > These are not generic input attributes so they should belong to the platform
> > device, not input device.
> 
> Ok. Can I ask why they cannot be considered an input attributes?

Input layer is an abstraction; I am trying to keep all attributes
generic and applicable to all input devices. If you look at other input
drivers you will see that attributes that control hardware behavior are
attached to the devices representing the hardware itself. For example
attributes to control report rate of PS/2 mouse belong to serio port
that represents the physical mouse device; typematic rate of AT
keyboards also tied to serio port, etc, etc.

Thanks.

-- 
Dmitry
