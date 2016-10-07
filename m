From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
Date: Fri, 7 Oct 2016 18:01:23 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE282C@SW-EX-MBX02.diasemi.com>
References: <6ED8E3B22081A4459DAC7699F3695FB7018CCE242C@SW-EX-MBX02.diasemi.com>
 <20161006184927.GB11915@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCE2732@SW-EX-MBX02.diasemi.com>
 <20161007170214.GA21349@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161007170214.GA21349-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 07 October 2016 18:02, Guenter Roeck wrote:

> > On 06 October 2016 19:49, Guenter Roeck wrote:
> > > On Thu, Oct 06, 2016 at 04:28:14PM +0000, Steve Twiss wrote:
> > > > I am using the compatible string to pick a different configuration .data block:
> > > > { .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
> > > > { .compatible = "dlg,da9061-watchdog", .data = &da9061_watchdog_info },
> > > >
> > > > But, it is just my opinion to keep the "name" different.
> > > > This will not be my decision if accepted into the Linux kernel, but I would like to
> > > > at least be consistent for DA9061 and DA9062 so ... is this an issue?
> > >
> > > FWIW the driver doesn't really need to be updated in the first place.
> > > A compatible statement listing both da9061 and da9062 would do it.
> >
> > I will make the changes you requested: deprecate the existing compatibility
> > for da9062-watchdog and make a new compatibility string which combines both
> > da9061 and da9062.
> >
> That is not what I asked for.

Ok. Did you mean separate compatible statements with data sections pointing at 
the same structure?

Like this:
{ .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
{ .compatible = "dlg,da9061-watchdog", .data = &da9062_watchdog_info },

So this would be the only change needed in the device driver.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
