From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/6] Input: ucb1400_ts - convert to use dev_pm_ops
Date: Sat, 31 Dec 2011 04:13:22 +0100
Message-ID: <201112310413.22654.marek.vasut@gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com> <201111141804.12519.marek.vasut@gmail.com> <20111230231754.GA4172@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57992 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab1LaDN0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Dec 2011 22:13:26 -0500
Received: by eekc4 with SMTP id c4so14039643eek.19
        for <linux-input@vger.kernel.org>; Fri, 30 Dec 2011 19:13:24 -0800 (PST)
In-Reply-To: <20111230231754.GA4172@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> On Mon, Nov 14, 2011 at 06:04:12PM +0100, Marek Vasut wrote:
> > > On Mon, Nov 14, 2011 at 11:39:17AM +0100, Marek Vasut wrote:
> > > > > Instead of using legacy PM interfaces switch to using dev_pm_ops.
> > > > > 
> > > > > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > > > > ---
> > > > > 
> > > > >  drivers/input/touchscreen/ucb1400_ts.c |   12 ++++++------
> > > > >  1 files changed, 6 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/input/touchscreen/ucb1400_ts.c
> > > > > b/drivers/input/touchscreen/ucb1400_ts.c index 3b5b5df..ead7123
> > > > > 100644 --- a/drivers/input/touchscreen/ucb1400_ts.c
> > > > > +++ b/drivers/input/touchscreen/ucb1400_ts.c
> > > > > @@ -428,10 +428,10 @@ static int ucb1400_ts_remove(struct
> > > > > platform_device *dev) return 0;
> > > > > 
> > > > >  }
> > > > > 
> > > > > -#ifdef CONFIG_PM
> > > > > -static int ucb1400_ts_resume(struct platform_device *dev)
> > > > > +#ifdef CONFIG_PM_SLEEP
> > > > > +static int ucb1400_ts_resume(struct device *dev)
> > > > > 
> > > > >  {
> > > > > 
> > > > > -	struct ucb1400_ts *ucb = dev->dev.platform_data;
> > > > > +	struct ucb1400_ts *ucb = dev->platform_data;
> > > > > 
> > > > >  	if (ucb->ts_task) {
> > > > >  	
> > > > >  		/*
> > > > > 
> > > > > @@ -444,16 +444,16 @@ static int ucb1400_ts_resume(struct
> > > > > platform_device *dev) }
> > > > > 
> > > > >  	return 0;
> > > > >  
> > > > >  }
> > > > > 
> > > > > -#else
> > > > > -#define ucb1400_ts_resume NULL
> > > > > 
> > > > >  #endif
> > > > > 
> > > > > +static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops, NULL,
> > > > > ucb1400_ts_resume); +
> > > > > 
> > > > >  static struct platform_driver ucb1400_ts_driver = {
> > > > >  
> > > > >  	.probe	= ucb1400_ts_probe,
> > > > >  	.remove	= ucb1400_ts_remove,
> > > > > 
> > > > > -	.resume	= ucb1400_ts_resume,
> > > > > 
> > > > >  	.driver	= {
> > > > >  	
> > > > >  		.name	= "ucb1400_ts",
> > > > > 
> > > > > +		.pm	= &ucb1400_ts_pm_ops,
> > > > > 
> > > > >  	},
> > > > >  
> > > > >  };
> > > > 
> > > > Hi,
> > > > 
> > > > I went through the patchset, but didn't test it. Though the changes
> > > > look reasonable. I'll have time to test this sometimes next week
> > > > MAYBE, or it MIGHT tell someone else to test, I can't promise
> > > > anything here though.
> > > > 
> > > > Please add to all patches my:
> > > > 
> > > > Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> > > 
> > > Thanks Marek. I have not tested these either so it would be nice to
> > > find someone who could. However there is no urgency as we have some
> > > time before 3.3 merge window opens.
> > 
> > I can, I have devices with this chip available ... just not now, real
> > life is haunting me :)
> 
> Hi Marek,
> 
> Any chance you will be able to try these patches before 3.3 merge window
> opens?
> 
> Thanks,

Hi Dmitry.

Honestly, reality is just crap. But, I'm fine with these, please add my:

Acked-by: Marek Vasut <marek.vasut@gmail.com>
