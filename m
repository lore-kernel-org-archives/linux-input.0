From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Wed, 6 May 2015 09:02:27 -0700
Message-ID: <20150506160227.GA28101@roeck-us.net>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B21924A-68WUHU125fLzLL1Oxlh9IgLouzNaz+3S@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 06, 2015 at 02:54:37PM +0000, Opensource [Steve Twiss] wrote:
> On 18 April 2015 16:53 Guenter Roeck wrote:
> 
> Hi Guenter,
> 
> Thanks for your comments.
> 
> > On 04/17/2015 07:23 AM, S Twiss wrote:
> > > From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> > >
> > > Add watchdog driver support for DA9062
> > >
> > > Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> > >
> > Hi Steve,
> > 
> > Key question here is if the da9062 is really so much different to the da9062
> > that you can not use the same driver.
> 
> The DA9062 watchdog driver does have some similarities with the DA9063 watchdog 
> base functionality -- however the watchdog component in the DA9062 chip has more
> features yet to be added in software. I do intend to add these other features ...
> however, if "not adding them here" is a problem I can drop the DA9062 watchdog
> driver from this patch-set until I have time to write in the newer changes.
> 
> > I am especially concerned about the added da9062_reset_watchdog_timer(),
> > given the delay it introduces.
> 
> After giving this some thought, I am going to remove this 300ms delay from the
> reset_watchdog_timer() function for my next submission attempt.  However
> I am adding a 300ms delay into the stop() and update_timeout_register() functions
> instead.
> 
> The DA9062 watchdog ping (register CONTROL_F) is "windowed" for protection
> against spurious writes -- i.e. the ping function cannot be called within a 250ms
> time limit or the PMIC will reset. This windowing protection also extends to altering
> the timeout scale in the CONTROL_D register -- in which case if the timeout
> register is altered and the ping() function is called within the 250ms limit, the
> PMIC will reset. The delay is there to stop that from happening.
> 
> I realised my previous patch was over-sanitised: by putting the time delay into the
> ping() function I was protecting CONTROL_D in stop() and  update_timeout_register(),
> but I was being too over-protective of the ping() function. Therefore if there was an 
> "incorrect trigger signal", the watchdog would not be allowed to fail because the
> driver would have filtered out the errors.
> 
Hi Steve,

>From your description, it sounds like the protection is only necessary if there
was a previous write to the same register(s). If so, it might make sense to
record the time of such writes, and only add the delay if necessary, and only
for the remainder of the time.

Would this be possible ?

Thanks,
Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
