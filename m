From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Sun, 17 Jul 2016 20:42:09 +0200
Message-ID: <20160717184209.GA30119@amd>
References: <20160717175257.GA26719@amd>
 <20160717182445.GA20058@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39328 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcGQSmM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jul 2016 14:42:12 -0400
Content-Disposition: inline
In-Reply-To: <20160717182445.GA20058@deathstar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com

On Sun 2016-07-17 13:24:45, Michael Welling wrote:
> On Sun, Jul 17, 2016 at 07:52:57PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > tsc2005 driver changed input device name, from
> > 
> > drivers/input/touchscreen/tsc2005.c:	  input_dev->name = "TSC2005
> > touchscreen";
> > 
> > to "TSC200X touchscreen". Unfortunately, X seems to propagate that
> > name to userspace, where it is needed to be able to do
> > 
> > xinput --set-prop --type=int ...
> > 
> > with the right arguments to calibrate touchscreen. (Touchscreen is
> > unusable without calibration).
> > 
> > What to do with that?
> 
> The input_dev name could be passed to the common probe function.
> 
> http://lxr.free-electrons.com/source/drivers/input/touchscreen/tsc2005.c#L65

That would be preffered, I guess.

How many stable releases are affected?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
