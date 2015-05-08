From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Fri, 8 May 2015 10:22:28 -0700
Message-ID: <20150508172228.GB38039@dtor-ws>
References: <1431049991-30129-1-git-send-email-marex@denx.de>
 <CAKohpo=fr3tWEWwiMb25WQP6m=CpbdZCwRB3Zng5Q7tZ0RtPdw@mail.gmail.com>
 <20150508052820.GC18159@dtor-ws>
 <201505081147.39238.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35735 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932471AbbEHRWd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2015 13:22:33 -0400
Received: by ieczm2 with SMTP id zm2so68685353iec.2
        for <linux-input@vger.kernel.org>; Fri, 08 May 2015 10:22:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201505081147.39238.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Vipul Kumar Samar <vipulkumar.samar@st.com>

On Fri, May 08, 2015 at 11:47:39AM +0200, Marek Vasut wrote:
> On Friday, May 08, 2015 at 07:28:20 AM, Dmitry Torokhov wrote:
> > On Fri, May 08, 2015 at 07:45:48AM +0530, Viresh Kumar wrote:
> > > On 8 May 2015 at 07:23, Marek Vasut <marex@denx.de> wrote:
> > > > Use msecs_to_jiffies(20) instead of plain (HZ / 50), as the
> > > > former is much more explicit about it's behavior. We want
> > > > to schedule the task 20 mS from now, so make it explicit in
> > > > the code.
> > > > 
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/input/touchscreen/stmpe-ts.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Applied both, thank you.
> 
> Thank you! Shall I submit them for -stable as well please ?

Please.

-- 
Dmitry
