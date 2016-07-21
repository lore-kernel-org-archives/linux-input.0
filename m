From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Thu, 21 Jul 2016 08:32:34 +0200
Message-ID: <20160721063234.GA14200@amd>
References: <20160717175257.GA26719@amd>
 <20160717182445.GA20058@deathstar>
 <20160717184209.GA30119@amd>
 <20160717185134.GA20462@deathstar>
 <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57293 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcGUGcj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2016 02:32:39 -0400
Content-Disposition: inline
In-Reply-To: <20160720214736.GA4321@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com

Hi!

> > In the mean time you can adjust the name or use XID instead.
> 
> X has partially fixed this a few years ago. All input drivers (that
> matter) export a Device Node property that sets the device node for each
> device.
> 
>  $ xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Node"
>         Device Node (261):      "/dev/input/event4"
> 
> Based on that you can get the udev device and work your way into any of the
> sysfs tree. Or do whatever else you want.
> 
> But other than that there isn't anything in X to fix. xinput is primarily a
> debugging tool and it does name resolution for convenience. But it's not a
> tool for complex configurations. It does exactly what it needs to do, if you
> need something that's more complicated and relies on information not
> available to the X device itself then you'll need to write a custom tool
> that does what you need. sorry.

Ok.. so out of the box, touchscreen is "upside down" and miscalibrated
on n900. So I need to run

xinput --set-prop --type=float 8 115  1.10 0.00 -0.05  0.00 1.18 -0.10 0.00 0.00 1.00
xinput --set-prop --type=int 8 249 0 1

(or equivalent with names) so that I can use the touchscreen. (And
that's quite important -- X is somehow unusable without pointing
device).

If xinput is not the right solution, what is the right solution?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
