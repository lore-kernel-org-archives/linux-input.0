From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt
 driven touch detection
Date: Mon, 16 Sep 2013 08:28:46 -0700
Message-ID: <20130916152846.GC12105@core.coreip.homeip.net>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <1378887511-24530-6-git-send-email-jbe@pengutronix.de>
 <52359259.8010202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52359259.8010202-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, Sep 15, 2013 at 11:56:25AM +0100, Jonathan Cameron wrote:
> On 09/11/13 09:18, Juergen Beisert wrote:
> > For battery driven systems it is a very bad idea to collect the touchscreen
> > data within a kernel busy loop.
> > 
> > This change uses the features of the hardware to delay and accumulate samples in
> > hardware to avoid a high interrupt and CPU load.
> > 
> > Note: this is only tested on an i.MX23 SoC yet.
> > 
> > Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
> > CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> While this driver is placed in IIO within staging at the moment, these changes are definitely
> input related.  Hence I have cc'd Dmitry and the input list.
> 
> I am personaly a little uncomfortable that we have such a complex bit of input code sat
> within an IIO driver but such is life.
> 

...

> >  
> >  static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> > @@ -641,6 +1056,7 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> >  
> >  	cancel_work_sync(&lradc->ts_work);
> >  
> > +	mxs_lradc_disable_ts(lradc);
> >  	input_unregister_device(lradc->ts_input);
> >  }

This looks iffy... Normally you disable the device so that it does not
generate more interrupts, and then cancel outstanding work(s), otherwise
newly generated interrupts may cause more work to be scheduled. Or I
missed some of the context and this is not a concern here?

Thanks.

-- 
Dmitry
