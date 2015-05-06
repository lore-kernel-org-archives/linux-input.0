From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Wed, 6 May 2015 02:36:14 +0200
Message-ID: <201505060236.14358.marex@denx.de>
References: <1430869596-7044-1-git-send-email-marex@denx.de> <20150506000135.GA25707@dtor-ws>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:33871 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbEFAgR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 20:36:17 -0400
In-Reply-To: <20150506000135.GA25707@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Wednesday, May 06, 2015 at 02:01:35 AM, Dmitry Torokhov wrote:
> On Wed, May 06, 2015 at 01:46:36AM +0200, Marek Vasut wrote:
> > Use msecs_to_jiffies(50) instead of plain (HZ / 50) as the
> > former is independent of kernel HZ settings and provides
> > stable delay.
> > 
> > The delay here must be stable, otherwise we might start polling
> > for pen-up event too early. This would in turn render the
> > touchscreen unusable.

Hi!

> Doesn't jiffy "size" depend on HZ value? I'd expect the delay be
> "stable" regardless of the value of HZ.

I have to admit I am not sure, but this would make sense.

> I do not disagree with the
> patch, but I think you need better justification here (except I think
> the delay should be 20 msec, not 50, and we may use a constant instead
> of reevaluating it all the time).

Maybe I'm fixing two bugs here ? The problem I really had is that with
kernel HZ set to 250 and the original code, the work was scheduled and
executed too quickly, so my touchscreen was bouncing between pendown and
penup events back and forth, without doing any usaful work.

I tried changing the code to HZ/5 instead of HZ/50 and that fixes my
issue as well.

My impression is that using msec_to_jiffies() is clearer especially
if the code is to represent a constant delay. But maybe I should then
document why I changed the duration (because the original one was too
short) ?

Thanks for your help!

> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> >  drivers/input/touchscreen/stmpe-ts.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > NOTE: This applies all the way back to Linux ~2.6.36, so I should
> > 
> >       probably also submit this for -stable if acceptable ?
> 
> No, I do not think it needs to be in stable as it does not really fix
> any bug as far as I can see.
> 
> > diff --git a/drivers/input/touchscreen/stmpe-ts.c
> > b/drivers/input/touchscreen/stmpe-ts.c index 42ce31a..a8f5ea7 100644
> > --- a/drivers/input/touchscreen/stmpe-ts.c
> > +++ b/drivers/input/touchscreen/stmpe-ts.c
> > @@ -164,7 +164,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void
> > *data)
> > 
> >  			STMPE_TSC_CTRL_TSC_EN, STMPE_TSC_CTRL_TSC_EN);
> >  	
> >  	/* start polling for touch_det to detect release */
> > 
> > -	schedule_delayed_work(&ts->work, HZ / 50);
> > +	schedule_delayed_work(&ts->work, msecs_to_jiffies(50));
> > 
> >  	return IRQ_HANDLED;
> >  
> >  }
> 
> Thanks.

Best regards,
Marek Vasut
