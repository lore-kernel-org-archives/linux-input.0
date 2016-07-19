From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Tue, 19 Jul 2016 16:51:20 -0700
Message-ID: <20160719235120.GD19250@dtor-ws>
References: <20160717175257.GA26719@amd>
 <20160717182445.GA20058@deathstar>
 <20160717184209.GA30119@amd>
 <20160717185134.GA20462@deathstar>
 <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34578 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbcGSXvY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jul 2016 19:51:24 -0400
Content-Disposition: inline
In-Reply-To: <20160717225636.GB20462@deathstar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com

On Sun, Jul 17, 2016 at 05:56:36PM -0500, Michael Welling wrote:
> On Sun, Jul 17, 2016 at 10:03:39PM +0200, Pavel Machek wrote:
> > On Sun 2016-07-17 13:51:34, Michael Welling wrote:
> > > On Sun, Jul 17, 2016 at 08:42:09PM +0200, Pavel Machek wrote:
> > > > On Sun 2016-07-17 13:24:45, Michael Welling wrote:
> > > > > On Sun, Jul 17, 2016 at 07:52:57PM +0200, Pavel Machek wrote:
> > > > > > Hi!
> > > > > > 
> > > > > > tsc2005 driver changed input device name, from
> > > > > > 
> > > > > > drivers/input/touchscreen/tsc2005.c:	  input_dev->name = "TSC2005
> > > > > > touchscreen";
> > > > > > 
> > > > > > to "TSC200X touchscreen". Unfortunately, X seems to propagate that
> > > > > > name to userspace, where it is needed to be able to do

Technically X _is_ userspace.

> > > > > > 
> > > > > > xinput --set-prop --type=int ...
> > > > > > 
> > > > > > with the right arguments to calibrate touchscreen. (Touchscreen is
> > > > > > unusable without calibration).
> > > > > > 
> > > > > > What to do with that?

Hmm, I do not think we ever committed for the device names to be stable.
You are supposed to locate touchscreen device based on its properties
and you might need some heuristic if you encounter a system with more
than one such touchscreen.

> > > > > 
> > > > > The input_dev name could be passed to the common probe function.
> > > > > 
> > > > > http://lxr.free-electrons.com/source/drivers/input/touchscreen/tsc2005.c#L65
> > > > 
> > > > That would be preffered, I guess.
> > > > 
> > > > How many stable releases are affected?
> > > 
> > > Well this patch is 9 months old now. Lets see.
> > > 
> > > It was introduced in v4.4-rc1. So v4.4, v4.5 and v4.6.
> > 
> > Ok, thanks for the information. I believe changing it back to
> > "TSC2005" version makes sense (and then fixing it in stable).

Do we know how many users are affected?

> 
> Lets see if the maintainer has any input before I submit a patch.

I guess we could also pass the input_id structure to tsc200x_probe, fill
the proper product ID (2004 or 2005) and derive the name form it.

Thanks.

-- 
Dmitry
