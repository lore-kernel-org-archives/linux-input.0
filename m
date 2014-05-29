From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen : Introduce the use of the managed
 version of kzalloc
Date: Thu, 29 May 2014 00:28:36 -0700
Message-ID: <20140529072836.GK11817@core.coreip.homeip.net>
References: <20140528180214.GA5957@himangi-Dell>
 <20140529071510.GF11817@core.coreip.homeip.net>
 <alpine.DEB.2.02.1405290919110.1996@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1405290919110.1996@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Himangi Saraogi <himangi774@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, May 29, 2014 at 09:20:20AM +0200, Julia Lawall wrote:
> > > @@ -618,39 +619,22 @@ static int mrstouch_probe(struct platform_device *pdev)
> > >  	input_set_abs_params(tsdev->input, ABS_PRESSURE,
> > >  			     MRST_PRESSURE_MIN, MRST_PRESSURE_MAX, 0, 0);
> > >  
> > > -	err = request_threaded_irq(tsdev->irq, NULL, mrstouch_pendet_irq,
> > > -				   IRQF_ONESHOT, "mrstouch", tsdev);
> > > +	err = devm_request_threaded_irq(&pdev->dev, tsdev->irq, NULL,
> > > +					mrstouch_pendet_irq, IRQF_ONESHOT,
> > > +					"mrstouch", tsdev);
> > >  	if (err) {
> > >  		dev_err(tsdev->dev, "unable to allocate irq\n");
> > > -		goto err_free_mem;
> > > +		return -ENOMEM;
> > 
> > This is bad conversion. We used to report 'err' returned by
> > request_threaded_irq, but now we always report -ENOMEM. I fixed it up
> > here and in other places and applied.
> 
> Sorry to have missed that.  I guess you got the one on the call to 
> mrstouch_adc_init as well?

Yeah, I fixed them all up.

Thanks.

-- 
Dmitry
