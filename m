From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: introduce managed input devices (add devres
 support)
Date: Mon, 29 Oct 2012 21:02:26 +0100
Message-ID: <20121029200226.GA15156@polaris.bitmath.org>
References: <20121023053513.GA15642@core.coreip.homeip.net>
 <20121029182253.GA8015@polaris.bitmath.org>
 <20121029185919.GA13256@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:59519 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab2J2T5t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Oct 2012 15:57:49 -0400
Content-Disposition: inline
In-Reply-To: <20121029185919.GA13256@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

> > > @@ -1766,8 +1830,14 @@ EXPORT_SYMBOL(input_allocate_device);
> > >   */
> > >  void input_free_device(struct input_dev *dev)
> > >  {
> > > -	if (dev)
> > > +	if (dev) {
> > > +		if (dev->devres_managed)
> > > +			WARN_ON(devres_destroy(dev->dev.parent,
> > > +						devm_input_device_release,
> > > +						devm_input_device_match,
> > > +						dev));
> > >  		input_put_device(dev);
> > 
> > Device is put twice?
> 
> No, devres_destroy() does not actually run the release handler so we
> need to call it explicitly.

Ok, I see it now - it merely uses the handler to qualify the matching object.

> > Why not add the resource to the input device instead? For one, it
> > would make the order of unregister and release more apparent.
> 
> And what would that achieve? What would trigger unregistration?

As you say, it is a matter of view. We do not want to replay the whole
"function with object argument or object with member function"
debate. :-)

> > Right
> > now, the code seems to rely on the reverse for-loop in the devres
> > implementation.
> 
> That is the whole point of devres: it releases resources attached to
> the parent device (either when ->probe() fails or after ->remove() is
> called) in the opposed order of acquiring said resources. Think of it as
> calling destructors in C++ code.

That's what I did, but I mapped register() to a member of the input
resource, rather than to the parent device. If the parent device does
not need to know how to unregister the input device, it makes sense to
do so.

Either way, the code looks functional to me.

Thanks,
Henrik
