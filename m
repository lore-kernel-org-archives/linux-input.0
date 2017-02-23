From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] Input: tsc2007 - correctly report pressure and not
 resistance to user space
Date: Thu, 23 Feb 2017 00:45:31 -0800
Message-ID: <20170223084531.GM18639@dtor-ws>
References: <cover.1487609795.git.hns@goldelico.com>
 <9e249276be9e20aab1a74617373bf6587f1acd4b.1487609795.git.hns@goldelico.com>
 <20170221171332.w6dh7ccd2eyg5dgu@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170221171332.w6dh7ccd2eyg5dgu@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 21, 2017 at 06:13:32PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Feb 20, 2017 at 05:56:35PM +0100, H. Nikolaus Schaller wrote:
> > previously, tsc2007 will report as ABS_PRESSURE:
> > 0              for no pressure (resistance infinite)
> > high value     for soft pressure (high resistance)
> > low value      for firm pressure (lower resistance)
> > 
> > This does not matter for most applications (e.g. GUI, Menu, Scrolling
> > etc.) where the ABS_PRESSURE is ignored and only BTN_TOUCH is processed
> > to detect screen taps.
> > 
> > Only some special graphics applications read the pressure channel and
> > they will be mixed up by this non-monotonic relation.
> > 
> > So we fix it to become:
> > 0              for no pressure (resistance infinite)
> > low value      for soft pressure (high resistance)
> > high value     for firm pressure (lower resistance)
> > 
> > While this patch changes the values reported to userspace,
> > ABS_PRESSURE is used rarely by userspace. Most software only
> > relies on BTN_TOUCH (boolean), which is not affected by this
> > patch. Some graphics software makes use of the interface and
> > does not work correctly with the currently used inverted
> > behaviour.
> > 
> > Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> > ---
> >  drivers/input/touchscreen/tsc2007_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> > index 30b53ca..fc73849 100644
> > --- a/drivers/input/touchscreen/tsc2007_core.c
> > +++ b/drivers/input/touchscreen/tsc2007_core.c
> > @@ -141,6 +141,8 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
> >  				"DOWN point(%4d,%4d), resistance (%4u)\n",
> >  				tc.x, tc.y, rt);
> >  
> > +			rt = ts->max_rt - rt;
> > +
> >  			input_report_key(input, BTN_TOUCH, 1);
> >  			input_report_abs(input, ABS_X, tc.x);
> >  			input_report_abs(input, ABS_Y, tc.y);
> 
> Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Applied, thank you.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
