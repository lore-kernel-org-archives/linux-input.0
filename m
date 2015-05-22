From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Thu, 21 May 2015 17:01:21 -0700
Message-ID: <20150522000121.GB39517@dtor-ws>
References: <1431049991-30129-1-git-send-email-marex@denx.de>
 <201505081147.39238.marex@denx.de>
 <20150508172228.GB38039@dtor-ws>
 <201505220158.34136.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33710 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbbEVAB0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 20:01:26 -0400
Received: by igbpi8 with SMTP id pi8so23957680igb.0
        for <linux-input@vger.kernel.org>; Thu, 21 May 2015 17:01:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201505220158.34136.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Vipul Kumar Samar <vipulkumar.samar@st.com>

On Fri, May 22, 2015 at 01:58:34AM +0200, Marek Vasut wrote:
> On Friday, May 08, 2015 at 07:22:28 PM, Dmitry Torokhov wrote:
> > On Fri, May 08, 2015 at 11:47:39AM +0200, Marek Vasut wrote:
> > > On Friday, May 08, 2015 at 07:28:20 AM, Dmitry Torokhov wrote:
> > > > On Fri, May 08, 2015 at 07:45:48AM +0530, Viresh Kumar wrote:
> > > > > On 8 May 2015 at 07:23, Marek Vasut <marex@denx.de> wrote:
> > > > > > Use msecs_to_jiffies(20) instead of plain (HZ / 50), as the
> > > > > > former is much more explicit about it's behavior. We want
> > > > > > to schedule the task 20 mS from now, so make it explicit in
> > > > > > the code.
> > > > > > 
> > > > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > > > Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > > > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > ---
> > > > > > 
> > > > > >  drivers/input/touchscreen/stmpe-ts.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > 
> > > > Applied both, thank you.
> > > 
> > > Thank you! Shall I submit them for -stable as well please ?
> > 
> > Please.
> 
> Hi,
> 
> these patches still didn't make it for Linus's tree. I cannot submit
> to -stable unless they hit Linus's tree to my knowledge. Shall I wait
> some more please ?

They are in -next. I guess I could get them in 4.1...

-- 
Dmitry
