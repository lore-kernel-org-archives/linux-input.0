From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
Date: Tue, 4 Apr 2017 09:34:57 +0100
Message-ID: <20170404083457.bcpqw6gv6rzhevrp@dell>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
 <8987877cc54940358c5b7a65ca003cedc5586f0d.1490712213.git.stwiss.opensource@diasemi.com>
 <20170403141214.q6ndii6c47pqfqx6@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD6B183@SW-EX-MBX02.diasemi.com>
 <20170403143049.qyi4dagwi4cdenok@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD6B207@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD6B207-68WUHU125fLzLL1Oxlh9IgLouzNaz+3S@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 03 Apr 2017, Steve Twiss wrote:

> On 03 April 2017 15:31, Lee Jones wrote:
> 
> > Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
> > 
> > On Mon, 03 Apr 2017, Steve Twiss wrote:
> > > On 03 April 2017 15:12, Lee Jones wrote:
> > >
> > > > > @@ -475,7 +855,25 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >
> > > > > -	chip->regmap = devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> > > > > +	switch (chip->chip_type) {
> > > > > +	case(COMPAT_TYPE_DA9061):
> > > >
> > > > Brackets around the case value?
> > > >
> > > > That's a new one on me.
> > >
> > > Hm. Do you want me to resend it without braces?
> > 
> > Yes please.  And a space after the 'case'.
> 
> Hi Lee,
> 
> I have resent PATCH V7 to change "case(X):" to be "case X:".
> - Removed brackets surrounding case statements for
>     case COMPAT_TYPE_DA9061:
>     case COMPAT_TYPE_DA9062:

Okay, good.

> New patch is here:
> https://lkml.org/lkml/2017/4/3/462
> 
> The patch it is called by the same title "[PATCH V7 4/7] mfd: da9061: MFD core support".
> I've not updated the whole patch-set or changed the patch version number from V7.

I don't see it in my inbox?

You should always change the version, or things get confusing.

Even if it's a small change, you can differentiate by v7.1 or similar.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
