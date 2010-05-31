From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch 2/2] input/tps6507x-ts: zero vs NULL
Date: Mon, 31 May 2010 23:07:48 +0200
Message-ID: <20100531210748.GB5483@bicker>
References: <20100531120215.GS5483@bicker> <20100531191029.GD30712@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:49130 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0EaVIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 May 2010 17:08:12 -0400
Content-Disposition: inline
In-Reply-To: <20100531191029.GD30712@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, May 31, 2010 at 12:10:29PM -0700, Dmitry Torokhov wrote:
> On Mon, May 31, 2010 at 02:02:15PM +0200, Dan Carpenter wrote:
> > --- a/drivers/input/touchscreen/tps6507x-ts.c
> > +++ b/drivers/input/touchscreen/tps6507x-ts.c
> > @@ -342,7 +342,7 @@ err2:
> >  	cancel_delayed_work(&tsc->work);
> >  	flush_workqueue(tsc->wq);
> >  	destroy_workqueue(tsc->wq);
> > -	tsc->wq = 0;
> > +	tsc->wq = NULL;
> >  	input_free_device(input_dev);
> >  err1:
> >  	kfree(tsc);
> > @@ -364,7 +364,7 @@ static int __devexit tps6507x_ts_remove(struct platform_device *pdev)
> >  	cancel_delayed_work(&tsc->work);
> >  	flush_workqueue(tsc->wq);
> 
> Why isn't it cancel_delayed_work_sync()?
> 

Good point.

> >  	destroy_workqueue(tsc->wq);
> > -	tsc->wq = 0;
> > +	tsc->wq = NULL;
> >  
> 
> Setting tsc to 0/NULL does not make much sense as it is being freed a
> couple of lines below.
> 

That's true.  I'll send an updated patch tomorrow.

regards,
dan carpenter
