From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Wed, 6 May 2015 16:59:28 -0700
Message-ID: <20150506235928.GG5580@dtor-ws>
References: <1430869596-7044-1-git-send-email-marex@denx.de>
 <20150506000135.GA25707@dtor-ws>
 <201505060236.14358.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34845 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbEFX7d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 19:59:33 -0400
Received: by igbyr2 with SMTP id yr2so145832862igb.0
        for <linux-input@vger.kernel.org>; Wed, 06 May 2015 16:59:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201505060236.14358.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-input@vger.kernel.org, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Wed, May 06, 2015 at 02:36:14AM +0200, Marek Vasut wrote:
> On Wednesday, May 06, 2015 at 02:01:35 AM, Dmitry Torokhov wrote:
> > On Wed, May 06, 2015 at 01:46:36AM +0200, Marek Vasut wrote:
> > > Use msecs_to_jiffies(50) instead of plain (HZ / 50) as the
> > > former is independent of kernel HZ settings and provides
> > > stable delay.
> > > 
> > > The delay here must be stable, otherwise we might start polling
> > > for pen-up event too early. This would in turn render the
> > > touchscreen unusable.
> 
> Hi!
> 
> > Doesn't jiffy "size" depend on HZ value? I'd expect the delay be
> > "stable" regardless of the value of HZ.
> 
> I have to admit I am not sure, but this would make sense.
> 
> > I do not disagree with the
> > patch, but I think you need better justification here (except I think
> > the delay should be 20 msec, not 50, and we may use a constant instead
> > of reevaluating it all the time).
> 
> Maybe I'm fixing two bugs here ? The problem I really had is that with
> kernel HZ set to 250 and the original code, the work was scheduled and
> executed too quickly, so my touchscreen was bouncing between pendown and
> penup events back and forth, without doing any usaful work.
> 
> I tried changing the code to HZ/5 instead of HZ/50 and that fixes my
> issue as well.
> 
> My impression is that using msec_to_jiffies() is clearer especially
> if the code is to represent a constant delay.

It is indeed clearer and I would not mind such conversion, we just need
to adjust the comment why we do that.

> But maybe I should then
> document why I changed the duration (because the original one was too
> short) ?

Please make a separate patch for that with separate justification.

Thanks!

-- 
Dmitry
