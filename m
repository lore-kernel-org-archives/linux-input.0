From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
Date: Tue, 11 Mar 2014 22:06:59 +0100
Message-ID: <20140311210659.GA10961@localhost.fastwebnet.it>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140303015616.GN2411@sirena.org.uk>
 <20140311192411.GA4193@localhost.fastwebnet.it>
 <20140311192940.GA28112@sirena.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBOPV7WMAKGQEJVPIVCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140311192940.GA28112-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 11, 2014 at 07:29:40PM +0000, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 08:24:11PM +0100, Carlo Caione wrote:
> > On Mon, Mar 03, 2014 at 10:56:16AM +0900, Mark Brown wrote:
> 
> > > > +	regulators = of_find_node_by_name(np, "regulators");
> > > > +	if (!regulators) {
> > > > +		dev_err(&pdev->dev, "regulators node not found\n");
> > > > +		return -EINVAL;
> > > > +	}
> 
> > > The driver should be able to start up with no configuration provided at
> > > all except for the device being registered - the user won't be able to
> > > change anything but they will be able to read the current state of the
> > > hardware which can be useful for diagnostics.
> 
> > If the device is DT enabled and no configuration is provided for
> > regulators, these are disabled according to:
> 
> > http://lxr.linux.no/linux+v3.13.5/drivers/regulator/core.c#L3797
> 
> > Am I missing something or do you have any pointer?
> 
> With the above code the driver will return an error and never get as far
> as registering the regulator.

I agree, but if I register the regulators without having the constrains
defined in the DT, when regulator_init_complete() is
called, the regulators are disabled powering off the SoC (at least for
DCDC2 and DCDC3).

Thanks,

-- 
Carlo Caione
