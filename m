From: Michael Welling <mwelling@ieee.org>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Sun, 17 Jul 2016 13:24:45 -0500
Message-ID: <20160717182445.GA20058@deathstar>
References: <20160717175257.GA26719@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160717175257.GA26719@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-input@vger.kernel.org

On Sun, Jul 17, 2016 at 07:52:57PM +0200, Pavel Machek wrote:
> Hi!
> 
> tsc2005 driver changed input device name, from
> 
> drivers/input/touchscreen/tsc2005.c:	  input_dev->name = "TSC2005
> touchscreen";
> 
> to "TSC200X touchscreen". Unfortunately, X seems to propagate that
> name to userspace, where it is needed to be able to do
> 
> xinput --set-prop --type=int ...
> 
> with the right arguments to calibrate touchscreen. (Touchscreen is
> unusable without calibration).
> 
> What to do with that?

The input_dev name could be passed to the common probe function.

http://lxr.free-electrons.com/source/drivers/input/touchscreen/tsc2005.c#L65

It could also be inferred from the bus_type or dev_name.

http://lxr.free-electrons.com/source/drivers/input/touchscreen/tsc200x-core.c#L547

Pick a method and I will provide a patch.

> 
> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
