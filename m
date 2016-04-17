From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] device-tree: nexus7-flo: Remove power gpio key
 entry and use pmic8xxx-pwrkey
Date: Sun, 17 Apr 2016 05:24:18 -0700
Message-ID: <20160417122418.GC33215@dtor-ws>
References: <1460668031-12384-1-git-send-email-john.stultz@linaro.org>
 <20160415172212.GW391@tuxbot>
 <20160415185927.GN14441@codeaurora.org>
 <20160415220106.GZ391@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160415220106.GZ391@tuxbot>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 15, 2016 at 03:01:06PM -0700, Bjorn Andersson wrote:
> On Fri 15 Apr 11:59 PDT 2016, Stephen Boyd wrote:
> 
> [..]
> 
> > ----8<-----
> > From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Subject: [PATCH] Input: pmic8xxx-pwrkey: Fix algorithm for converting trigger
> >  delay
> > 
> > The trigger delay algorithm that converts from microseconds to
> > the register value looks incorrect. According to most of the PMIC
> > documentation, the equation is
> > 
> > 	delay (Seconds) = (1 / 1024) * 2 ^ (x + 4)
> > 
> > except for one case where the documentation looks to have a
> > formatting issue and the equation looks like
> > 
> > 	delay (Seconds) = (1 / 1024) * 2 x + 4
> > 
> > Most likely this driver was written with the improper
> > documentation to begin with. According to the downstream sources
> > the valid delays are from 2 seconds to 1/64 second, and the
> > latter equation just doesn't make sense for that. Let's fix the
> > algorithm and the range check to match the documentation and the
> > downstream sources.
> > 
> > Reported-by: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Acked-by: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied, thank you.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
