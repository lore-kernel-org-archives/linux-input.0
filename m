From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
Date: Fri, 7 Oct 2016 10:02:14 -0700
Message-ID: <20161007170214.GA21349@roeck-us.net>
References: <6ED8E3B22081A4459DAC7699F3695FB7018CCE242C@SW-EX-MBX02.diasemi.com>
 <20161006184927.GB11915@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCE2732@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CCE2732@SW-EX-MBX02.diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 07, 2016 at 02:56:17PM +0000, Steve Twiss wrote:
> On 06 October 2016 19:49, Guenter Roeck wrote:
> > Subject: Re: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
> > 
> > Hi Steve,
> 
> [...]
> 
> > On Thu, Oct 06, 2016 at 04:28:14PM +0000, Steve Twiss wrote:
> > > I am using the compatible string to pick a different configuration .data block:
> > >
> > > { .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
> > > { .compatible = "dlg,da9061-watchdog", .data = &da9061_watchdog_info },
> > >
> > > when the only real difference between the DA9061 and DA9062 watchdog driver
> > > is the name. Functionally they are identical in this case.
> [...]
> > > This exact same thing would happen with da9063-onkey and da9062-thermal also.
> > > For the ONKEY it is marginally confused by needing to support 63, but for 62 and 61
> > > it is the same thing. Only the name is different.
> > >
> [...]
> > > But, it is just my opinion to keep the "name" different.
> > > This will not be my decision if accepted into the Linux kernel, but I would like to
> > > at least be consistent for DA9061 and DA9062 so ... is this an issue?
> > 
> > 
> > Yes, for me it is. The driver is still the same, and I don't see the point
> > of increasing code size and making the driver less readable just to be able
> > to report a slightly different driver identification string. And each time
> > a similar HW is added we would go through the same effort, again for no
> > good reason.
> > 
> 
> My reason for doing this was to report the hardware identification, not the
> driver name. But, there would certainly be a lot less to do if I was to make
> DA9061 core use the DA9062 watchdog.
>  
> > FWIW the driver doesn't really need to be updated in the first place.
> > A compatible statement listing both da9061 and da9062 would do it.
> 
> I will make the changes you requested: deprecate the existing compatibility
> for da9062-watchdog and make a new compatibility string which combines both
> da9061 and da9062.
> 
That is not what I asked for.

Guenter
