From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Date: Wed, 24 May 2017 09:40:49 +0100
Message-ID: <20170524084049.iy4dlrbmkzsqjvav@dell>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
 <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D651@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD8D651-68WUHU125fLzLL1Oxlh9IgLouzNaz+3S@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 24 May 2017, Steve Twiss wrote:

> On 23 May 2017 18:17 Mark Brown
> > To: Steve Twiss
> > Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator driver
> > 
> > On Tue, May 23, 2017 at 02:40:45PM +0100, Steve Twiss wrote:
> > 
> > > This patch was Acked by Mark Brown, a long time ago, way back in Oct 2016
> > > (https://patchwork.kernel.org/patch/9397787/).
> > > I have kept Mark Brown's Ack attached because there have been no real
> > > code changes since then, but I have recently updated the copyright header
> > > slightly, rebased the code (no changes necessary) and compile tested it
> > > against x86_64.
> > 
> > > The MFD files which this patch depended on were accepted into linux-next
> > > by Lee Jones last week. If there is anything in the way of this patch
> > > acceptance, could you please let me know?
> > 
> > Given that I've acked this and it depends on the MFD changes I'd have
> > expected Lee to apply it.  If nothing else happens I can apply it after
> > the next merge window, otherwise either Lee needs to send me a pull
> > request for the MFD change so I've got the dependency or he needs to
> > apply this.
> 
> Hi Mark,
> 
> Thanks,
> No problem, just some minor administration.
> 
> @Lee
> Could you please send Mark a pull request for the regulator component to the
> DA9062/61 changes [PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
> driver.

That wasn't one of the options. ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
