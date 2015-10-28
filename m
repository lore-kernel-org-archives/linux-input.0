From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Input: tsc2005 - Add support for tsc2004
Date: Tue, 27 Oct 2015 18:51:41 -0700
Message-ID: <20151028015141.GA11237@localhost>
References: <201510280724.dKfeR76E%fengguang.wu@intel.com>
 <1445991421-29938-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445991421-29938-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Michael,
On Tue, Oct 27, 2015 at 07:17:01PM -0500, Michael Welling wrote:
> Adds support for the i2c based tsc2004. Support was added to the tsc2005 driver
> due to the similarity of the devices.
> 
> Signed-off-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
> ---
> v2: Fixes Kconfig based on report for 0-day build bot.
> 
>  .../bindings/input/touchscreen/tsc2004.txt         |  38 ++++
>  drivers/input/touchscreen/Kconfig                  |   7 +-
>  drivers/input/touchscreen/tsc2005.c                | 206 ++++++++++++++++-----

Could we maybe split the code into core, spi and i2c drivers instead of
keeping everything together and rely on #ifdefs?

Thanks!

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
